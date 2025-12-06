# Claude Development Context

## Проект: Комплексное обеспечение
**Тип:** Flutter mobile app (iOS + Android)
**Backend:** Supabase (BaaS)
**State Management:** Provider + ChangeNotifier
**Навигация:** go_router

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
- `role` (admin | regular)
- `organization_id` (UUID) - FK к organizations
- `password_hash` (String) - SHA-256

#### 3. Company
- `id` (UUID)
- `name` (String)
- `phone` (String)
- `email` (String, nullable)
- `address` (String)
- `status` (real | potential | lost) - "Реальный", "Потенциальный", "Потерянный"
- `content` (String, nullable) - заметка
- `last_contact_date` (DateTime, nullable) - auto-updated триггером
- `organization_id` (UUID) - FK к organizations
- `created_by_user_id` (UUID) - FK к users

#### 4. ContactPerson
- `id` (UUID)
- `company_id` (UUID) - FK к companies
- `first_name`, `last_name`, `middle_name` (String)
- `position` (String)
- `phone` (String)
- `email` (String, nullable)

#### 5. ContactRecord
- `id` (UUID)
- `company_id` (UUID) - FK к companies
- `content` (String) - заметка
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

### Изоляция данных

**Row Level Security (RLS):**
- Пользователи видят только данные своей организации
- Фильтрация через `organization_id`
- RLS политики применяются автоматически в Supabase

### Структура проекта

```
lib/
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
│   │   └── notification_helper.dart
│   └── widgets/
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       └── loading_indicator.dart
├── features/
│   ├── auth/
│   │   ├── domain/entities/
│   │   ├── data/models/
│   │   ├── data/repositories/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── pages/
│   │       └── widgets/
│   ├── users/
│   ├── companies/
│   ├── contacts/
│   ├── reminders/
│   └── notifications/
├── routes/
│   └── app_router.dart
└── legacy/
    ├── components/
    ├── pages/
    └── utils/
```

### Ключевые зависимости

```yaml
dependencies:
  flutter:
    sdk: flutter
  supabase_flutter: ^2.5.0
  provider: ^6.1.1
  go_router: ^13.0.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0
  shared_preferences: ^2.2.2
  intl: ^0.19.0
  mask_text_input_formatter: ^2.9.0
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.2
```

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
      // Supabase call
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

### Миграция существующего UI

**Legacy компоненты:**
- `flutter_ui/lib/components/Component_2_441.dart` → CustomTextField wrapper
- `flutter_ui/lib/components/Component_2_491.dart` → CustomButton wrapper
- `flutter_ui/lib/utils/pix_adapted_screen.dart` → ScreenUtil (.w, .h, .sp) - KEEP

**Рефакторинг страниц:**
- `page_2_391.dart` → LoginPage
- `page_2_825.dart` → UserCreatePage
- `page_25_4312.dart` → CompaniesListPage
- `page_25_5214.dart` → CompanyCreatePage
- `page_26_1872.dart` → ContactRecordCreatePage
- `page_25_9367.dart` → ReminderEditPage

### Конвенции кодирования

**Именование:**
- Entities: `User`, `Company`, `ContactPerson`
- Models: `UserModel`, `CompanyModel`
- Providers: `AuthProvider`, `CompanyProvider`
- Repositories: `AuthRepository`, `CompanyRepository`
- Pages: `LoginPage`, `CompaniesListPage`

**Форматирование:**
- 2 пробела для отступов
- Использовать `.w`, `.h`, `.sp` для responsive sizing
- Enums в lowercase_with_underscores

---

## Текущий статус

См. файл [TASKS.md](TASKS.md) для детального roadmap и статусов задач.

## Ссылки

- **Дизайн:** https://pixso.net/app/design/5XjHdE-sNniE4bM8ZOtqgw
- **Supabase Dashboard:** [Добавить после создания проекта]
- **Детальный план:** `.claude/plans/synthetic-forging-gray.md`
