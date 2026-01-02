# Claude Development Context

## Проект: Комплексное обеспечение (Client Database)
**Тип:** Flutter mobile app (iOS + Android)
**Backend:** Supabase (BaaS)
**State Management:** Provider + ChangeNotifier
**Навигация:** go_router
**Версия:** 1.0.1

---

## Ключевые решения по архитектуре

### Модели данных

#### 1. Organization
- `id` (UUID)
- `name` (String)
- `created_at` (DateTime)

#### 2. User
- `id` (UUID)
- `phone` (String) - формат: +7 (###) ###-##-##
- `first_name`, `last_name`, `middle_name` (String)
- `email` (String)
- `role` (admin | regular) - с displayName getter для отображения на русском
- `organization_id` (UUID) - FK к organizations
- `password_hash` (String) - SHA-256

#### 3. Company
- `id` (UUID)
- `name` (String)
- `phone` (String) - кликабельный с возможностью звонка
- `email` (String, nullable)
- `address` (String)
- `status` (real | potential | lost) - "Реальный", "Потенциальный", "Потерянный"
- `content` (String, nullable) - заметка
- `last_contact_date` (DateTime, nullable) - auto-updated триггером при создании contact_record
- `organization_id` (UUID) - FK к organizations
- `created_by_user_id` (UUID) - FK к users

#### 4. ContactPerson
- `id` (UUID)
- `company_id` (UUID) - FK к companies
- `first_name`, `last_name`, `middle_name` (String)
- `position` (String)
- `phone` (String) - кликабельный с возможностью звонка
- `email` (String, nullable)

#### 5. ContactRecord
- `id` (UUID)
- `company_id` (UUID) - FK к companies
- `content` (String) - заметка о контакте
- `created_at` (DateTime) - автоматически
- `created_by_user_id` (UUID) - FK к users

#### 6. Reminder
- `id` (UUID)
- `company_id` (UUID) - FK к companies
- `title` (String)
- `description` (String, nullable)
- `scheduled_for` (DateTime)
- `status` (pending | delivered | cancelled)
- `created_by_user_id` (UUID) - FK к users
- **Возможность удаления** для всех статусов (pending, delivered, cancelled)

### Изоляция данных

**Row Level Security (RLS):**
- Пользователи видят только данные своей организации
- Фильтрация через `organization_id`
- RLS политики применяются автоматически в Supabase

### Структура проекта

```
flutter_ui/lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/
│   │   ├── supabase_config.dart
│   │   └── theme.dart
│   ├── storage/
│   │   ├── secure_storage.dart
│   │   └── hive_storage.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── date_formatter.dart
│   │   ├── notification_helper.dart
│   │   └── pix_adapted_screen.dart  # Responsive sizing
│   └── widgets/
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       ├── loading_indicator.dart
│       ├── phone_number_link.dart    # Кликабельный номер телефона
│       └── main_scaffold.dart        # Bottom Navigation Bar wrapper
├── features/
│   ├── auth/
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       ├── user.dart
│   │   │       └── organization.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── organization_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_provider.dart
│   │       └── pages/
│   │           ├── login_page.dart
│   │           └── password_reset_page.dart
│   ├── users/
│   │   ├── data/repositories/
│   │   │   └── user_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── user_provider.dart
│   │       └── pages/
│   │           ├── users_list_page.dart
│   │           └── user_form_page.dart
│   ├── companies/
│   │   ├── domain/entities/
│   │   │   └── company.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── company_model.dart
│   │   │   └── repositories/
│   │   │       └── company_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── company_provider.dart
│   │       └── pages/
│   │           ├── companies_list_page.dart
│   │           ├── company_form_page.dart
│   │           └── company_detail_page.dart
│   ├── contacts/
│   │   ├── domain/entities/
│   │   │   ├── contact_person.dart
│   │   │   └── contact_record.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── contact_person_model.dart
│   │   │   │   └── contact_record_model.dart
│   │   │   └── repositories/
│   │   │       ├── contact_person_repository.dart
│   │   │       └── contact_record_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── contact_person_provider.dart
│   │       │   └── contact_record_provider.dart
│   │       └── widgets/
│   │           ├── contact_person_form_dialog.dart
│   │           └── contact_record_form_dialog.dart
│   ├── reminders/
│   │   ├── domain/entities/
│   │   │   ├── reminder.dart
│   │   │   └── reminder_status.dart
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── reminder_model.dart
│   │   │   └── repositories/
│   │   │       └── reminder_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── reminder_provider.dart
│   │       └── widgets/
│   │           └── reminder_form_dialog.dart
│   ├── settings/
│   │   └── presentation/pages/
│   │       └── settings_page.dart
│   └── debug/
│       └── notification_debug_page.dart  # Отладка уведомлений
├── routes/
│   └── app_router.dart
```

### Ключевые зависимости

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Backend
  supabase_flutter: ^2.5.0

  # State Management
  provider: ^6.1.1

  # Navigation
  go_router: ^13.0.0

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0
  shared_preferences: ^2.2.2

  # Notifications
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.2

  # Forms & Validation
  mask_text_input_formatter: ^2.9.0

  # Utilities
  intl: ^0.20.2
  crypto: ^3.0.3
  url_launcher: ^6.2.5  # Для звонков по номеру телефона

  # UI
  cupertino_icons: ^1.0.2
  flutter_svg: ^2.0.14
```

### Android Configuration

#### Permissions (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
<uses-permission android:name="android.permission.USE_EXACT_ALARM" />
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
```

#### ProGuard Rules
**Критически важно:** Для работы flutter_local_notifications с Gson в release builds необходимы специальные ProGuard правила (см. `android/app/proguard-rules.pro`):
- Сохранение всех классов flutter_local_notifications
- Сохранение Gson и TypeToken
- Сохранение generic signatures (Signature attribute)
- Предотвращение обфускации аннотаций

### UI/UX Features

#### Navigation
- **Bottom Navigation Bar** (MainScaffold):
  - Компании (business icon) - главный экран
  - Настройки (settings icon) - профиль и управление
  - Выбранный элемент: синий (#006FFD)
  - Неактивный: черный
  - Font: Inter, размеры 12px

#### Settings Page
- **Для всех пользователей:**
  - Аватар пользователя (круг 80x80, иконка person)
  - ФИО (Фамилия Имя Отчество)
  - Номер телефона
  - Бейдж роли (Администратор/Пользователь)
  - Кнопка "Выйти" с подтверждением

- **Дополнительно для админов:**
  - Раздел "Управление"
  - Пункт "Пользователи" → переход к списку пользователей

#### Phone Number Links
- Кликабельные номера телефонов с автоматическим звонком
- Используется `url_launcher` с `tel:` URI scheme
- Компонент: `PhoneNumberLink` widget

#### Dropdowns
- Высота выпадающих списков = высоте инпутов (vertical padding: 12)
- Font: Inter, размер 14px, цвет #2F3036
- Текст центрирован по вертикали и горизонтали
- Border radius: 12px, border color: #C5C6CC

#### Text Fields
- Font: Inter, размер 14px
- Padding: horizontal 16px, vertical 12px
- Border radius: 12px
- Focus border: синий #006FFD (width: 2px)
- Error border: розовый #F53178

#### Companies List
- Расстояние между названием компании и телефоном: 4px (SizedBox)
- Статус компании: цветной бейдж (реальный=зеленый, потенциальный=желтый, потерянный=красный)
- Pull-to-refresh для обновления списка
- Поиск по названию, телефону, адресу

#### Reminders
- Локальные уведомления через flutter_local_notifications
- Три статуса: pending (ожидает), delivered (доставлено), cancelled (отменено)
- Возможность удаления напоминания в любом статусе
- Автоматическая отмена уведомления при удалении

### Supabase Configuration

**Файл:** `lib/core/config/supabase_config.dart`

```dart
class SupabaseConfig {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
}
```

**Инициализация в main.dart:**

```dart
await Supabase.initialize(
  url: SupabaseConfig.supabaseUrl,
  anonKey: SupabaseConfig.supabaseAnonKey,
);
```

### Важные паттерны

#### Работа с Supabase

```dart
// Получить данные
final data = await supabase
    .from('companies')
    .select()
    .eq('organization_id', organizationId);

// Вставить
await supabase.from('companies').insert({...});

// Обновить
await supabase.from('companies').update({...}).eq('id', id);

// Удалить
await supabase.from('companies').delete().eq('id', id);
```

#### Provider Pattern

```dart
class CompanyProvider extends ChangeNotifier {
  List<Company> _companies = [];
  bool _isLoading = false;
  String? _error;

  Future<void> loadCompanies() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _repository.getCompanies();
      _companies = data;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

#### Routing with Bottom Navigation

```dart
// Основные маршруты обернуты в MainScaffold
GoRoute(
  path: '/companies',
  builder: (context, state) => const MainScaffold(
    currentIndex: 0,
    child: CompaniesListPage(),
  ),
),

GoRoute(
  path: '/settings',
  builder: (context, state) => const MainScaffold(
    currentIndex: 1,
    child: SettingsPage(),
  ),
),

// Вложенные страницы (детали компании, формы) без MainScaffold
GoRoute(
  path: '/companies/:id',
  builder: (context, state) => CompanyDetailPage(
    companyId: state.pathParameters['id']!,
  ),
),
```

### Конвенции кодирования

**Именование:**
- Entities: `User`, `Company`, `ContactPerson`, `Reminder`
- Models: `UserModel`, `CompanyModel`, `ReminderModel`
- Providers: `AuthProvider`, `CompanyProvider`, `ReminderProvider`
- Repositories: `AuthRepository`, `CompanyRepository`, `ReminderRepository`
- Pages: `LoginPage`, `CompaniesListPage`, `CompanyDetailPage`
- Widgets: `PhoneNumberLink`, `MainScaffold`, `CustomTextField`

**Форматирование:**
- 2 пробела для отступов
- Использовать `.w`, `.h`, `.sp` для responsive sizing (pix_adapted_screen.dart)
- Enums в lowercase_with_underscores

**Цветовая палитра:**
- Primary Blue: `#006FFD`
- Primary Pink/Red: `#F53178`
- Dark Text: `#2F3036`
- Gray Text: `#8F9098`
- Border Gray: `#C5C6CC`
- Success Green: `#00C48C`
- Warning Yellow: `#FFBB54`

---

## Выполненные задачи

### ✅ Базовая функциональность
- [x] Аутентификация (логин, выход, сброс пароля)
- [x] Управление пользователями (создание, редактирование, удаление - только admin)
- [x] Управление компаниями (CRUD операции)
- [x] Контактные лица компаний (добавление, редактирование, удаление)
- [x] История контактов (запись взаимодействий с компаниями)
- [x] Напоминания с локальными уведомлениями
- [x] RLS (Row Level Security) для изоляции данных организаций

### ✅ UI/UX улучшения
- [x] Bottom Navigation Bar вместо drawer menu
- [x] Страница настроек с профилем пользователя
- [x] Кликабельные номера телефонов с автозвонком
- [x] Единообразные стили для dropdown и input (высота, шрифты)
- [x] Центрирование текста в dropdown компонентах
- [x] Сокращенные отступы в списке компаний
- [x] Удаление напоминаний для всех статусов

### ✅ Исправленные баги
- [x] ProGuard/R8 TypeToken error в release builds
- [x] Форматирование номеров телефонов
- [x] Разрешения для звонков и уведомлений
- [x] Высота dropdown элементов

---

## Текущие известные проблемы

Нет известных критических проблем. Приложение стабильно работает в production.

---

## Ссылки

- **Дизайн:** https://pixso.net/app/design/5XjHdE-sNniE4bM8ZOtqgw
- **Supabase Dashboard:** https://supabase.com/dashboard/project/rcprdyenxwotgdanrycu
- **APK Location:** `flutter_ui/build/app/outputs/flutter-apk/app-release.apk`

---

## Инструкции для разработки

### Сборка Release APK
```bash
cd flutter_ui
flutter build apk --release
```

### Запуск в режиме отладки
```bash
cd flutter_ui
flutter run
```

### Обновление зависимостей
```bash
cd flutter_ui
flutter pub get
```

### Генерация кода (для Hive)
```bash
cd flutter_ui
flutter pub run build_runner build --delete-conflicting-outputs
```
