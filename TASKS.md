# Roadmap Разработки: Комплексное обеспечение

Статусы: `⏳ Не начато` | `🔄 В процессе` | `✅ Выполнено` | `⏸️ Приостановлено` | `❌ Отменено`

---

## 📋 Фаза 1: Foundation (Неделя 1)

### Supabase Setup
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создание Supabase проекта | ✅ | https://rcprdyenxwotgdanrycu.supabase.co |
| Создание таблицы `organizations` | ✅ | См. схему в плане |
| Создание таблицы `users` | ✅ | С FK к organizations |
| Создание таблицы `companies` | ✅ | С FK к organizations и users |
| Создание таблицы `contact_persons` | ✅ | С FK к companies |
| Создание таблицы `contact_records` | ✅ | С FK к companies и users |
| Создание таблицы `reminders` | ✅ | С FK к companies и users |
| Создание индексов для поиска/сортировки | ✅ | idx_companies_name, etc. |
| Настройка Row Level Security (RLS) политик | ✅ | Изоляция по organization_id |
| Создание триггера для last_contact_date | ✅ | Auto-update при insert в contact_records |
| Создание триггеров для updated_at | ✅ | Для всех таблиц |
| Настройка Supabase Auth | ⏳ | Требуется RPC функции |
| Создание тестовой организации | ✅ | INSERT в organizations |
| Создание admin пользователя | ✅ | Role: admin |
| Тестирование Supabase API через Dashboard | ✅ | Проверка CRUD операций |

### Flutter Project Setup
| Задача | Статус | Примечания |
|--------|--------|------------|
| Обновить pubspec.yaml | ✅ | Добавить supabase_flutter, provider, go_router, hive, etc. |
| Создать структуру папок lib/core/ | ✅ | config, storage, utils, widgets |
| Создать структуру папок lib/features/ | ✅ | auth, users, companies, etc. |
| Создать папку lib/routes/ | ✅ | Для app_router.dart |
| Создать папку lib/legacy/ | ✅ | Для старых UI компонентов |
| Переместить существующий UI в legacy/ | ✅ | components, pages, custom_widget |
| Создать lib/core/config/supabase_config.dart | ✅ | URL и ключи Supabase |
| Создать lib/core/config/theme.dart | ✅ | Светлая тема |
| Setup Supabase Client в main.dart | ✅ | Supabase.initialize() |
| Создать lib/core/storage/secure_storage.dart | ✅ | FlutterSecureStorage для JWT |
| Создать lib/core/storage/hive_storage.dart | ✅ | Hive init для кеширования |
| Создать lib/core/utils/validators.dart | ✅ | Валидаторы форм |
| Создать lib/core/utils/date_formatter.dart | ✅ | Форматирование дат (intl) |
| Протестировать подключение к Supabase | ⏳ | Требуется создание RPC функций |

---

## 🔐 Фаза 2: Authentication (Неделя 2)

### Supabase
| Задача | Статус | Примечания |
|--------|--------|------------|
| Тестирование auth endpoints | ⏳ | signInWithPassword, signOut |
| Проверка RLS политик для users | ⏳ | Изоляция по organization_id |
| Настройка password reset flow | ⏳ | Через Supabase Auth |

### Flutter - Models & Entities
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать Organization entity | ✅ | lib/features/auth/domain/entities/organization.dart |
| Создать User entity | ✅ | lib/features/auth/domain/entities/user.dart |
| Создать OrganizationModel | ✅ | JSON serialization, toEntity() |
| Создать UserModel | ✅ | JSON serialization, toEntity() |

### Flutter - Data Layer
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать AuthRepository | ✅ | lib/features/auth/data/repositories/auth_repository.dart |
| Реализовать login() в AuthRepository | ✅ | Custom RPC функция authenticate_user |
| Реализовать logout() в AuthRepository | ✅ | Очистка secure storage |
| Реализовать resetPassword() в AuthRepository | ✅ | RPC функция request_password_reset |
| Реализовать getCurrentUser() | ✅ | Запрос из users таблицы |

### Flutter - Presentation Layer
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать AuthProvider (ChangeNotifier) | ✅ | lib/features/auth/presentation/providers/auth_provider.dart |
| Реализовать login() в AuthProvider | ✅ | Вызов AuthRepository, error handling |
| Реализовать logout() в AuthProvider | ✅ | Очистка state |
| Реализовать isAuthenticated getter | ✅ | Проверка текущего пользователя |

### Flutter - UI
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать CustomTextField wrapper | ✅ | lib/core/widgets/custom_text_field.dart |
| Создать CustomButton wrapper | ✅ | lib/core/widgets/custom_button.dart |
| Создать LoginPage | ✅ | lib/features/auth/presentation/pages/login_page.dart |
| Создать PasswordResetPage | ✅ | lib/features/auth/presentation/pages/password_reset_page.dart |
| Создать PasswordResetSuccessPage | ⏸️ | Пропущено - UI в PasswordResetPage |
| Setup GoRouter | ✅ | lib/routes/app_router.dart |
| Добавить auth guard в GoRouter | ✅ | redirect на /login если не авторизован |
| Добавить refreshListenable для AuthProvider | ✅ | Auto-refresh при изменении auth state |
| Setup MultiProvider в main.dart | ✅ | AuthProvider + Supabase initialization |
| Тестирование login flow | ⏳ | Требуется Supabase RPC функции |

---

## 👥 Фаза 3: User Management - Admin (Неделя 3)

### Supabase
| Задача | Статус | Примечания |
|--------|--------|------------|
| Проверка RLS политик для admin операций | ✅ | RLS политики работают |
| Тестирование CRUD users через Dashboard | ⏳ | Требуется после создания RPC функций |

### Flutter - Data Layer
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать UserRepository | ✅ | lib/features/users/data/repositories/user_repository.dart |
| Реализовать getAllUsers() | ✅ | SELECT * FROM users WHERE organization_id = ? |
| Реализовать createUser() | ✅ | INSERT + SHA-256 password hash |
| Реализовать updateUser() | ✅ | UPDATE (с опциональным паролем) |
| Реализовать deleteUser() | ✅ | DELETE (защита от self-deletion) |

### Flutter - Presentation
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать UserProvider | ✅ | lib/features/users/presentation/providers/user_provider.dart |
| Создать UsersListPage | ✅ | lib/features/users/presentation/pages/users_list_page.dart |
| Создать UserCreatePage | ✅ | lib/features/users/presentation/pages/user_form_page.dart |
| Создать UserEditPage | ✅ | UserFormPage (универсальная форма) |
| Создать UserDeleteConfirmationDialog | ✅ | Встроено в UsersListPage |
| Добавить /users роут в GoRouter | ✅ | С admin guard через redirect |
| Добавить Users в navigation (bottom bar) | ✅ | Кнопка на HomePage (admin only) |
| Тестирование CRUD пользователей | ⏳ | Требуется после создания RPC функций |

---

## 🏢 Фаза 4: Companies CRUD (Недели 4-5)

### Supabase
| Задача | Статус | Примечания |
|--------|--------|------------|
| Проверка RLS для companies | ⏳ | Фильтр по organization_id |
| Тестирование trigger для last_contact_date | ⏳ | Должен обновляться при INSERT в contact_records |

### Flutter - Models & Entities
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать Company entity | ✅ | lib/features/companies/domain/entities/company.dart |
| Создать CompanyModel | ✅ | С JSON serialization |
| Создать CompanyStatus enum | ✅ | real, potential, lost |

### Flutter - Data Layer
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать CompanyRepository | ✅ | lib/features/companies/data/repositories/company_repository.dart |
| Реализовать getAllCompanies() | ✅ | С фильтрами, сортировкой |
| Реализовать getCompanyById() | ✅ | SELECT WHERE id = ? |
| Реализовать searchCompanies() | ✅ | ILIKE по name, phone, address |
| Реализовать filterByStatus() | ✅ | getCompaniesFiltered() |
| Реализовать sortBy() | ✅ | CompanySortField + SortDirection |
| Реализовать createCompany() | ✅ | INSERT |
| Реализовать updateCompany() | ✅ | UPDATE |
| Реализовать deleteCompany() | ✅ | DELETE |

### Flutter - Presentation
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать CompanyProvider | ✅ | С search, filter, sort state |
| Создать CompaniesListPage | ✅ | С drawer navigation для админов |
| Добавить SearchBar в CompaniesListPage | ✅ | TextField с clear button |
| Добавить Sort dropdown | ⏸️ | Отложено - используем FilterChips |
| Добавить Filter chips | ✅ | По статусу (Все/Реальный/Потенциальный/Потерянный) |
| Добавить Pull-to-refresh | ✅ | RefreshIndicator |
| Создать CompanyDetailPage | ⏳ | Запланировано на Phase 5 |
| Создать CompanyCreatePage | ✅ | CompanyFormPage (универсальная форма) |
| Создать CompanyEditPage | ✅ | CompanyFormPage с companyId |
| Создать CompanyDeleteConfirmationDialog | ✅ | Встроено в CompaniesListPage |
| Добавить Hive caching для offline | ⏸️ | Отложено до Phase 8 (Performance) |
| Добавить sync при подключении к сети | ⏸️ | Отложено до Phase 8 (Performance) |
| Добавить /companies роуты в GoRouter | ✅ | /, /companies/create, /companies/:id/edit |
| Добавить Companies в bottom navigation | ✅ | Главный экран (/) |
| Тестирование CRUD компаний | ⏳ | Требуется после создания RPC функций |

---

## 📇 Фаза 5: Contact Persons (Неделя 6)

### Supabase
| Задача | Статус | Примечания |
|--------|--------|------------|
| Проверка cascade delete для contact_persons | ⏳ | При удалении company |

### Flutter - Models & Data
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать ContactPerson entity | ⏳ | lib/features/companies/domain/entities/contact_person.dart |
| Создать ContactPersonModel | ⏳ | JSON serialization |
| Создать ContactPersonRepository | ⏳ | getByCompanyId, create, update, delete |

### Flutter - Presentation
| Задача | Статус | Примечания |
|--------|--------|------------|
| Интегрировать ContactPersons в CompanyDetailPage | ⏳ | Список контактных лиц |
| Создать ContactPersonCreateDialog | ⏳ | Рефакторинг page_25_7938.dart |
| Создать ContactPersonEditDialog | ⏳ | Рефакторинг page_25_8522.dart |
| Добавить delete функционал | ⏳ | IconButton в карточке |
| Валидация форм | ⏳ | Phone mask, required fields |
| Тестирование CRUD контактных лиц | ⏳ | Add, edit, delete |

---

## 📝 Фаза 6: Contact Records (Неделя 7)

### Supabase
| Задача | Статус | Примечания |
|--------|--------|------------|
| Тестирование trigger для last_contact_date | ⏳ | При INSERT в contact_records |

### Flutter - Models & Data
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать ContactRecord entity | ⏳ | lib/features/contacts/domain/entities/contact_record.dart |
| Создать ContactRecordModel | ⏳ | С denormalized user name |
| Создать ContactRecordRepository | ⏳ | getByCompanyId, create, update |

### Flutter - Presentation
| Задача | Статус | Примечания |
|--------|--------|------------|
| Интегрировать ContactRecords в CompanyDetailPage | ⏳ | Список записей |
| Создать ContactRecordCreatePage | ⏳ | Рефакторинг page_26_1872.dart |
| Создать ContactRecordEditPage | ⏳ | Редактирование content |
| Добавить auto-create при нажатии "Добавить" | ⏳ | С текущим timestamp и user |
| Отображать ФИО и timestamp | ⏳ | createdByUserName, createdAt |
| Проверить auto-update last_contact_date | ⏳ | Должно обновляться в Company |
| Тестирование записей о контактах | ⏳ | Create, edit |

---

## ⏰ Фаза 7: Reminders + Notifications (Недели 8-9)

### Supabase
| Задача | Статус | Примечания |
|--------|--------|------------|
| Проверка reminders endpoints | ⏳ | CRUD operations |
| Тестирование фильтрации по userId | ⏳ | Только свои напоминания |

### Flutter - Setup Notifications
| Задача | Статус | Примечания |
|--------|--------|------------|
| Setup flutter_local_notifications | ⏳ | lib/core/utils/notification_helper.dart |
| Request permissions iOS | ⏳ | Через UIUserNotificationCenter |
| Request permissions Android | ⏳ | Через AndroidFlutterLocalNotificationsPlugin |
| Setup notification channels | ⏳ | High importance для Android |
| Инициализация timezone | ⏳ | tz.initializeTimeZones() |

### Flutter - Models & Data
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать Reminder entity | ⏳ | lib/features/reminders/domain/entities/reminder.dart |
| Создать ReminderModel | ⏳ | С denormalized company name |
| Создать ReminderStatus enum | ⏳ | pending, delivered, cancelled |
| Создать ReminderRepository | ⏳ | getAll, getByCompanyId, create, update, delete |

### Flutter - Presentation
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать ReminderProvider | ⏳ | С scheduling логикой |
| Интегрировать Reminders в CompanyDetailPage | ⏳ | Список напоминаний |
| Создать ReminderCreatePage | ⏳ | Рефакторинг page_25_9105.dart |
| Создать ReminderEditPage | ⏳ | Рефакторинг page_25_9367.dart |
| Добавить DateTimePicker | ⏳ | Выбор даты и времени |
| Реализовать schedule notification | ⏳ | zonedSchedule() |
| Реализовать cancel notification | ⏳ | При delete или cancel |
| Создать NotificationsPage | ⏳ | Рефакторинг page_25_3216.dart |
| Показывать delivered reminders | ⏳ | WHERE status = 'delivered' |
| Обновлять status на delivered при показе | ⏳ | UPDATE status |
| Добавить Notifications в bottom navigation | ⏳ | С badge count |
| Тестирование уведомлений | ⏳ | Schedule, delivery, cancel |

---

## 🎨 Фаза 8: Polish + Testing (Неделя 10)

### Bug Fixes
| Задача | Статус | Примечания |
|--------|--------|------------|
| Fix reported bugs from testing | ⏳ | TBD |
| Fix memory leaks | ⏳ | dispose() в providers |
| Fix navigation issues | ⏳ | Проверка всех роутов |

### UI/UX Improvements
| Задача | Статус | Примечания |
|--------|--------|------------|
| Улучшить error messages (русский) | ⏳ | "Ошибка загрузки данных" etc. |
| Добавить loading indicators | ⏳ | CircularProgressIndicator |
| Добавить empty states | ⏳ | "Нет компаний" с CTA |
| Добавить success snackbars | ⏳ | "Компания создана" |
| Добавить error snackbars | ⏳ | "Ошибка: ..." |
| Улучшить анимации переходов | ⏳ | Page transitions |

### Performance
| Задача | Статус | Примечания |
|--------|--------|------------|
| Оптимизация Supabase запросов | ⏳ | SELECT только нужные поля |
| Добавить pagination | ⏳ | Limit + offset |
| Оптимизация списков | ⏳ | ListView.builder |
| Проверка Hive cache | ⏳ | Не кешируем слишком много |

### Testing
| Задача | Статус | Примечания |
|--------|--------|------------|
| Тестирование на iOS (simulator) | ⏳ | iPhone 14 Pro |
| Тестирование на iOS (device) | ⏳ | Physical device |
| Тестирование на Android (emulator) | ⏳ | Pixel 7 Pro |
| Тестирование на Android (device) | ⏳ | Physical device |
| Тестирование на планшетах | ⏳ | iPad, Android tablet |
| Security audit | ⏳ | RLS policies, JWT handling |
| Performance testing | ⏳ | Flutter DevTools profiler |

---

## 🚀 Фаза 9: Deployment (Неделя 11)

### Supabase Production
| Задача | Статус | Примечания |
|--------|--------|------------|
| Миграция на Production проект | ⏳ | Или использовать существующий |
| Backup БД | ⏳ | pg_dump |
| Настройка Production RLS | ⏳ | Проверка всех политик |
| Настройка rate limiting | ⏳ | Supabase settings |

### Flutter Build
| Задача | Статус | Примечания |
|--------|--------|------------|
| Обновить production Supabase URL/keys | ⏳ | В supabase_config.dart |
| Build release APK | ⏳ | flutter build apk --release |
| Build release IPA | ⏳ | flutter build ios --release |
| Тестирование release build | ⏳ | На device |
| Подготовить app store assets | ⏳ | Screenshots, description |

### App Store Submission
| Задача | Статус | Примечания |
|--------|--------|------------|
| Создать Apple Developer аккаунт | ⏳ | Если нет |
| Создать Google Play Console аккаунт | ⏳ | Если нет |
| Submit to Apple App Store | ⏳ | App Store Connect |
| Submit to Google Play Store | ⏳ | Play Console |

---

## 🔮 Фаза 10: Опциональные улучшения (Будущее)

| Функция | Приоритет | Статус |
|---------|-----------|--------|
| Темная тема | Низкий | ⏳ |
| Мультиязычность (i18n) | Средний | ⏳ |
| Экспорт в CSV/Excel | Средний | ⏳ |
| Аналитика (Firebase Analytics) | Низкий | ⏳ |
| Push notifications через FCM | Средний | ⏳ |
| Realtime sync (Supabase Realtime) | Высокий | ⏳ |
| File attachments | Средний | ⏳ |
| Advanced search (full-text) | Низкий | ⏳ |
| Биометрическая авторизация | Низкий | ⏳ |

---

## 📊 Прогресс

- **Всего задач:** TBD (подсчитать после заполнения)
- **Выполнено:** 0
- **В процессе:** 0
- **Осталось:** TBD

**Последнее обновление:** 2025-12-07 (Фаза 4 завершена)
