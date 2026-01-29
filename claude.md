# Claude Development Context - Client Database (Just CRM)

## Информация о проекте

**Название:** Комплексное обеспечение (Client Database / Just CRM)
**Тип:** Flutter Mobile Application (iOS + Android)
**Версия:** 1.0.1
**Backend:** Supabase (PostgreSQL BaaS)
**Дата последнего обновления:** 2026-01-29

---

## Стек технологий

### Frontend
- **Flutter:** 3.0+ (Dart 3.0.1+)
- **State Management:** Provider 6.1.1 (ChangeNotifier pattern)
- **Navigation:** go_router 13.0.0
- **UI Framework:** Material Design 3

### Backend
- **Database:** Supabase (PostgreSQL)
- **Authentication:** Custom RPC-based (phone + password, SHA-256)
- **API:** Supabase REST API + RPC functions

### Local Storage
- **Secure:** flutter_secure_storage 9.0.0 (iOS Keychain / Android KeyStore)
- **Cache:** hive 2.2.3 + hive_flutter 1.1.0
- **Preferences:** shared_preferences 2.2.2

### Notifications
- **Local Push:** flutter_local_notifications 17.0.0
- **Timezone:** timezone 0.9.2

### Utilities
- **Phone Formatting:** mask_text_input_formatter 2.9.0
- **Crypto:** crypto 3.0.3 (SHA-256)
- **URL Launcher:** url_launcher 6.2.5 (tel:// calls)
- **Internationalization:** intl 0.20.2 (Russian)
- **SVG Support:** flutter_svg 2.0.14

---

## Архитектура проекта

### Clean Architecture (3-Layer)

```
Domain Layer (Entities)
    ↓
Data Layer (Models + Repositories)
    ↓
Presentation Layer (Providers + UI)
```

**Папки:**
```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/           # Supabase, theme
│   ├── storage/          # SecureStorage, Hive
│   ├── utils/            # Validators, formatters, notification helper
│   └── widgets/          # Reusable UI components
├── features/
│   ├── auth/             # Аутентификация
│   ├── users/            # Управление пользователями (admin)
│   ├── companies/        # CRM - компании
│   ├── contacts/         # Контактные лица + история
│   ├── reminders/        # Напоминания
│   ├── notifications/    # Записи уведомлений
│   └── settings/         # Настройки профиля
└── routes/
    └── app_router.dart   # GoRouter конфигурация
```

### Provider Dependency Injection

```dart
MultiProvider
├── AuthProvider (root)
├── UserProvider (depends: AuthProvider)
├── CompanyProvider (depends: AuthProvider)
├── ContactPersonProvider
├── ContactRecordProvider
├── NotificationProvider
└── ReminderProvider (depends: AuthProvider + NotificationProvider)
```

**Паттерн:** `ChangeNotifierProxyProvider` для зависимостей между провайдерами.

---

## Сущности базы данных

### 1. Organizations (Организации)
```sql
id                UUID PRIMARY KEY
name              VARCHAR
created_at        TIMESTAMP
```
**Назначение:** Multi-tenancy, изоляция данных по организациям.

### 2. Users (Пользователи)
```sql
id                UUID PRIMARY KEY
phone             VARCHAR UNIQUE           -- Формат: +7 (###) ###-##-##
first_name        VARCHAR
last_name         VARCHAR
middle_name       VARCHAR
email             VARCHAR UNIQUE
role              ENUM('admin', 'regular') -- Роль пользователя
organization_id   UUID → organizations
password_hash     VARCHAR                  -- SHA-256
created_at        TIMESTAMP
updated_at        TIMESTAMP
```

**Роли:**
- `admin` - Администратор: видит все компании организации, управляет пользователями
- `regular` - Обычный пользователь: видит только свои компании

### 3. Companies (Компании)
```sql
id                UUID PRIMARY KEY
name              VARCHAR
phone             VARCHAR UNIQUE           -- Формат: +7 (###) ###-##-##
email             VARCHAR NULL
address           VARCHAR
status            ENUM('real', 'potential', 'lost')
content           TEXT NULL                -- Заметка
last_contact_date TIMESTAMP NULL           -- Авто-обновляется триггером
organization_id   UUID → organizations
created_by_user_id UUID → users            -- Кто создал компанию
created_at        TIMESTAMP

UNIQUE(organization_id, phone)
```

**Статусы:**
- `real` (Реальный) - зеленый бейдж
- `potential` (Потенциальный) - желтый бейдж
- `lost` (Потерянный) - красный бейдж

**ВАЖНО:** RLS политика учитывает роль:
- **Admin:** видит все компании организации
- **Regular:** видит только компании где `created_by_user_id = current_user_id`

### 4. ContactPersons (Контактные лица)
```sql
id                UUID PRIMARY KEY
company_id        UUID → companies
first_name        VARCHAR
last_name         VARCHAR
middle_name       VARCHAR
position          VARCHAR
phone             VARCHAR                  -- Кликабельный (tel://)
email             VARCHAR NULL
```

**Методы отображения:**
- `fullName`: Фамилия Имя Отчество
- `shortName`: Фамилия И.О.

### 5. ContactRecords (История контактов)
```sql
id                UUID PRIMARY KEY
company_id        UUID → companies
content           TEXT                     -- Заметка о контакте
created_at        TIMESTAMP AUTO           -- Автоматически DB
created_by_user_id UUID → users

TRIGGER: update_last_contact_date ON INSERT
```

**Отображение:** JOIN с users для показа имени создателя (Фамилия И.О.)

### 6. Reminders (Напоминания)
```sql
id                UUID PRIMARY KEY
company_id        UUID → companies
title             VARCHAR
description       TEXT NULL
scheduled_for     TIMESTAMP                -- UTC в БД, Local на клиенте
status            ENUM('pending', 'delivered', 'cancelled')
created_by_user_id UUID → users
created_at        TIMESTAMP

TRIGGER: Auto-update expired reminders
RPC: update_expired_reminders_rpc() - вызывается каждые 30 сек
```

**Возможности:**
- Удаление напоминания в любом статусе
- Автоматическая отмена локального уведомления при удалении

### 7. NotificationRecords (Записи уведомлений)
```sql
id                UUID PRIMARY KEY
reminder_id       UUID → reminders
company_id        UUID → companies
user_id           UUID → users
organization_id   UUID → organizations
title             VARCHAR
body              TEXT NULL
delivered_at      TIMESTAMP AUTO
is_read           BOOLEAN DEFAULT false
read_at           TIMESTAMP NULL
created_at        TIMESTAMP AUTO
companyName       VARCHAR                  -- Денормализовано

RLS: DISABLED (безопасность через FK к organizations)
```

**Назначение:**
- Аудит всех доставленных уведомлений
- Отслеживание прочитанных/непрочитанных
- Отображение в разделе "Уведомления"

---

## RLS (Row Level Security) политики

### Принцип изоляции
Все данные изолированы по `organization_id`. Пользователи видят только данные своей организации.

### Политики по таблицам

#### Organizations
- SELECT: только своя организация

#### Users
- SELECT: только пользователи своей организации
- INSERT/UPDATE/DELETE: только admin

#### Companies
**ВАЖНОЕ ИЗМЕНЕНИЕ:**
- SELECT:
  - Admin: все компании организации
  - Regular: только компании где `created_by_user_id = current_user_id`
- INSERT: создавать могут все
- UPDATE:
  - Admin: все компании организации
  - Regular: только свои
- DELETE:
  - Admin: все компании организации
  - Regular: только свои

#### ContactPersons, ContactRecords, Reminders
- Наследуют изоляцию через FK к companies
- Дополнительная проверка `organization_id`

#### NotificationRecords
- RLS отключен
- Безопасность через FK к organizations

---

## RPC Functions (Supabase)

### Authentication
- `authenticate_user(phone, password)` → {success, user, organization, token}
- `request_password_reset(phone)`
- `reset_password_with_code(phone, code, new_password)`

### Users
- `get_users(org_id)` - список пользователей
- `get_user_by_id(user_id)`
- `get_user_by_id_admin(user_id, org_id)` - admin
- `create_user_admin(...)` - admin
- `update_user_admin(...)` - admin
- `delete_user_admin(user_id, org_id)` - admin
- `search_users(org_id, query)`

### Companies
- `get_companies(org_id)` - список компаний
- `get_companies_filtered(org_id, status, sort_field, sort_dir)`
- `get_company_by_id(comp_id, org_id)`
- `create_company(...)`
- `update_company(...)`
- `delete_company(comp_id, org_id)`
- `search_companies(org_id, query)`

### Reminders
- `update_expired_reminders_rpc()` - авто-обновление истекших

---

## Основные функции

### 1. Аутентификация
- Вход по телефону + пароль
- Хранение токена в SecureStorage (зашифровано)
- Автоматическое восстановление сессии
- Сброс пароля через код подтверждения
- Роль-based доступ (admin / regular)

### 2. Управление компаниями (CRM)
- CRUD операции
- Статусы: Реальный, Потенциальный, Потерянный
- Поиск по названию, телефону, адресу
- Сортировка: имя, дата создания, последний контакт
- Pull-to-refresh для синхронизации
- Кликабельные телефоны (автозвонок через tel://)
- **Фильтрация по правам:** admin видит все, regular только свои

### 3. Контакты
- Множество контактных лиц на компанию
- История взаимодействий (contact records)
- Денормализация имен пользователей в истории
- Автообновление last_contact_date компании

### 4. Напоминания и уведомления
- Планирование напоминаний на будущее
- Локальные push-уведомления
- Автоматическая работа с таймзонами
- Три статуса: pending, delivered, cancelled
- Записи уведомлений для аудита
- Удаление в любом статусе
- Background обработка для iOS и Android

### 5. Управление пользователями (только admin)
- Создание новых пользователей
- Редактирование (телефон, имя, email, роль, пароль)
- Удаление (запрет самоудаления)
- Поиск по имени/телефону
- Назначение ролей (admin/regular)

### 6. Страница настроек
- Профиль пользователя (имя, телефон, роль)
- Аватар с иконкой person (80x80 круг)
- Меню администратора (управление пользователями)
- Выход с подтверждением

### 7. Страница уведомлений
- Список всех доставленных уведомлений
- Отметка прочитанных/непрочитанных
- Массовая отметка "прочитать все"
- Удаление уведомлений
- Удаление всех прочитанных
- Бейдж с количеством непрочитанных на bottom nav
- Переход к компании по тапу

---

## UI/UX Design System

### Цветовая палитра
```
Primary Pink:         #F53178
Secondary Blue:       #006FFD
Success Green:        #00C48C
Warning Yellow:       #FFBB54
Error Red:            #F53178
Text Primary:         #2F3036
Text Secondary:       #8F9098
Border Gray:          #C5C6CC
Background:           #FFFFFF
Surface:              #F5F6FA
```

### Типографика
- **Заголовки:** Sora, 600-800 weight
- **Тело/Метки:** Inter, 400-600 weight
- **Размер по умолчанию:** 14px (Inter)
- **Кнопки:** 16px, 600 weight

### Компоненты
- **Border Radius:** 12px (инпуты, кнопки, карточки)
- **Input Padding:** 16px horizontal, 12px vertical
- **Focus Border:** 2px, #006FFD
- **Buttons:** Rounded rectangles, padding 24x14

### Навигация
**Bottom Navigation Bar:**
- 3 вкладки: Уведомления, Компании, Настройки
- Выбранный: #006FFD (синий)
- Невыбранный: черный
- Шрифт: Inter, 12px
- Бейдж уведомлений: розовый круг с числом

### Responsive Design
- Использует расширения из `pix_adapted_screen.dart`
- `.w` (ширина), `.h` (высота), `.sp` (текст)
- Базовый размер: 375x812 (iPhone 11)

### Телефонные номера
- Формат отображения: +7 (###) ###-##-##
- Компонент: PhoneNumberLink widget
- Клик инициирует звонок через tel://
- Цвет: синий (#006FFD) с подчеркиванием

---

## Система уведомлений

### flutter_local_notifications

**Android:**
- NotificationChannel: 'reminders_channel', high importance
- Receivers в AndroidManifest.xml
- ProGuard правила для предотвращения обфускации TypeToken
- Permissions: POST_NOTIFICATIONS, SCHEDULE_EXACT_ALARM, WAKE_LOCK

**iOS:**
- DarwinInitializationSettings с запросом всех разрешений
- defaultPresentAlert/Badge/Sound = true

### Обработка таймзон
1. Определение timezone по имени (DateTime.now().timeZoneName)
2. Fallback на маппинг по offset (GMT±hours)
3. Дефолт UTC если не определилось
4. Маппинг включает 24 основные таймзоны

### Поток планирования
1. Вычисление миллисекунд до reminder.scheduledFor
2. Вызов _notifications.zonedSchedule() с tz.local
3. Срабатывание когда локальное время = scheduled_for

### События уведомлений
```
Система срабатывает уведомление
    ↓
onDidReceiveNotificationResponse callback
    ↓
Извлечение payload JSON {companyId, reminderId}
    ↓
Поиск и отметка уведомления как прочитанного
    ↓
Навигация на /notifications
```

---

## Android Configuration

### Permissions (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

### ProGuard Rules
**КРИТИЧЕСКИ ВАЖНО** для Release builds:
```proguard
-keep,allowobfuscation class com.dexterous.** { *; }
-keep class com.google.gson.** { *; }
-keep class com.google.gson.reflect.TypeToken { *; }
-keepattributes Signature
-keepattributes *Annotation*
-keep class * implements java.io.Serializable { *; }
```

**Без этих правил:** Release build крашится с Gson deserialization ошибками.

---

## Маршрутизация (GoRouter)

### Auth Routes
- `/login` → LoginPage
- `/password-reset` → PasswordResetPage

### Main Routes (с Bottom Nav)
- `/` → CompaniesListPage (home)
- `/notifications` → NotificationsPage
- `/companies` → CompaniesListPage
- `/settings` → SettingsPage

### Company Routes (без bottom nav)
- `/companies/:id` → CompanyDetailPage
- `/companies/:id/edit` → CompanyFormPage
- `/companies/create` → CompanyFormPage

### User Management (только admin)
- `/users` → UsersListPage
- `/users/create` → UserFormPage
- `/users/:id/edit` → UserFormPage

### Debug Routes
- `/debug/notifications` → NotificationDebugPage

**Guards:**
- Auth Guard: redirect на /login если не авторизован
- Admin Guard: redirect на /settings если не admin (для /users)

---

## Паттерны и Best Practices

### 1. Repository Pattern
Все операции с Supabase изолированы в repositories. Провайдеры вызывают методы репозиториев, не работают с Supabase напрямую.

### 2. Entity-Model Separation
- **Entity:** Чистые Dart классы (domain layer)
- **Model:** JSON serialization (data layer)
- Конвертация: `Model.fromEntity()`, `Model.toEntity()`

### 3. Error Handling
Все исключения конвертируются в русские сообщения и сохраняются в `_errorMessage` провайдера.

### 4. RLS Security
Все запросы автоматически фильтруются по `organization_id` через RLS политики Supabase.

### 5. Lazy Initialization
Провайдеры создаются только когда нужны через `ChangeNotifierProxyProvider`.

### 6. Timezone Awareness
Все timestamps конвертируются между UTC (БД) и local (UI).

### 7. Denormalization
Имена компаний, имена пользователей хранятся в joined таблицах для производительности.

### 8. Immutable Entities
Паттерн `copyWith()` для обновления состояния.

### 9. Responsive Design
Extension методы `.w`, `.h`, `.sp` для адаптивной верстки.

### 10. Pull-to-Refresh
Все списковые страницы поддерживают ручную синхронизацию данных.

---

## Deployment

### Build Release APK
```bash
cd flutter_ui
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Debug Run
```bash
cd flutter_ui
flutter run
```

### Update Dependencies
```bash
cd flutter_ui
flutter pub get
```

### Generate Hive Adapters
```bash
cd flutter_ui
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Release Notes

### v1.0.1 (Текущая версия)
**Название:** Notification section + Bug Fixing
- Добавлена полная система уведомлений
- Исправлены все проблемы с доставкой уведомлений
- Добавлен аудит-трейл записей уведомлений
- Исправлены проблемы с lifecycle провайдеров

### v1.0.0
**Название:** Initial Release
- Полный CRM функционал
- Управление компаниями (CRUD)
- Отслеживание контактов
- Управление пользователями (admin)
- Система напоминаний

---

## Известные проблемы и решения

### ✅ Решено: ProGuard/R8 TypeToken Error
**Проблема:** Release builds крашились с Gson deserialization ошибкой.
**Решение:** ProGuard правила в `android/app/proguard-rules.pro`.

### ✅ Решено: Форматирование телефонов
**Проблема:** Несогласованное форматирование номеров.
**Решение:** `mask_text_input_formatter` для +7 (###) ###-##-## везде.

### ✅ Решено: Timezone Handling
**Проблема:** Напоминания срабатывали в неправильное время.
**Решение:** Конвертация DateTime в ISO8601 с timezone offset перед отправкой в БД.

### ✅ Решено: Empty Reminder List After Creation
**Проблема:** Provider пересоздавался при notifyListeners() от NotificationProvider.
**Решение:** Reuse previous instance в ChangeNotifierProxyProvider2.

### ✅ Решено: Network Error Handling
**Проблема:** SocketException показывал технический текст.
**Решение:** Обработка "Нет подключения к интернету" в CompanyProvider.

---

## Ссылки

- **Дизайн:** https://pixso.net/app/design/5XjHdE-sNniE4bM8ZOtqgw
- **Supabase Dashboard:** https://supabase.com/dashboard/project/rcprdyenxwotgdanrycu
- **APK Location:** `flutter_ui/build/app/outputs/flutter-apk/app-release.apk`

---

## Текущая задача (2026-01-29)

### Разграничение прав доступа к компаниям

**Требование:**
- **Администратор организации** должен видеть ВСЕ компании организации
- **Обычный пользователь** должен видеть ТОЛЬКО свои компании (где он `created_by_user_id`)

**Что нужно изменить:**
1. RLS политики для таблицы `companies` в Supabase
2. Обновить `CompanyRepository` для поддержки новой логики
3. Протестировать с обеими ролями

**Статус:** В процессе реализации
