# Supabase RPC Functions для Authentication

Для завершения настройки аутентификации необходимо создать 3 RPC функции в Supabase.

## Инструкция по созданию

1. Откройте Supabase Dashboard: https://supabase.com/dashboard/project/rcprdyenxwotgdanrycu
2. Перейдите в SQL Editor (слева в меню)
3. Выполните следующие SQL команды по очереди

---

## 1. Функция authenticate_user

Проверяет телефон и пароль пользователя, возвращает успех/неуспех.

```sql
-- Функция для аутентификации пользователя по телефону и паролю
CREATE OR REPLACE FUNCTION authenticate_user(
  user_phone TEXT,
  user_password TEXT
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user RECORD;
  v_password_hash TEXT;
  v_token TEXT;
BEGIN
  -- Получить пользователя по телефону
  SELECT * INTO v_user
  FROM users
  WHERE phone = user_phone;

  -- Если пользователь не найден
  IF v_user.id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Пользователь не найден');
  END IF;

  -- Вычислить хеш введенного пароля (SHA-256)
  v_password_hash := encode(digest(user_password, 'sha256'), 'hex');

  -- Проверить совпадение хешей паролей
  IF v_user.password_hash != v_password_hash THEN
    RETURN json_build_object('success', false, 'message', 'Неверный пароль');
  END IF;

  -- Сгенерировать простой токен (в продакшене используйте JWT)
  v_token := encode(gen_random_bytes(32), 'base64');

  -- Вернуть успех с токеном
  RETURN json_build_object(
    'success', true,
    'token', v_token,
    'user_id', v_user.id,
    'organization_id', v_user.organization_id
  );
END;
$$;
```

---

## 2. Функция request_password_reset

Инициирует процесс сброса пароля (в реальном приложении отправляет SMS/Email).

```sql
-- Функция для запроса сброса пароля
CREATE OR REPLACE FUNCTION request_password_reset(
  user_phone TEXT
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_id UUID;
  v_reset_code TEXT;
BEGIN
  -- Проверить существование пользователя
  SELECT id INTO v_user_id
  FROM users
  WHERE phone = user_phone;

  -- Если пользователь не найден
  IF v_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Пользователь не найден');
  END IF;

  -- Сгенерировать 6-значный код сброса
  v_reset_code := LPAD(FLOOR(RANDOM() * 1000000)::TEXT, 6, '0');

  -- В продакшене здесь должна быть отправка SMS/Email
  -- Сейчас просто возвращаем код для тестирования
  RAISE NOTICE 'Reset code for %: %', user_phone, v_reset_code;

  RETURN json_build_object(
    'success', true,
    'message', 'Код сброса отправлен',
    'reset_code', v_reset_code  -- Только для тестирования!
  );
END;
$$;
```

---

## 3. Функция reset_password_with_code

Сбрасывает пароль с использованием кода подтверждения.

```sql
-- Функция для сброса пароля с кодом подтверждения
CREATE OR REPLACE FUNCTION reset_password_with_code(
  user_phone TEXT,
  verification_code TEXT,
  new_password TEXT
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_id UUID;
  v_new_password_hash TEXT;
BEGIN
  -- Проверить существование пользователя
  SELECT id INTO v_user_id
  FROM users
  WHERE phone = user_phone;

  -- Если пользователь не найден
  IF v_user_id IS NULL THEN
    RETURN json_build_object('success', false, 'message', 'Пользователь не найден');
  END IF;

  -- В продакшене здесь должна быть проверка verification_code
  -- Сейчас принимаем любой код для тестирования

  -- Вычислить хеш нового пароля
  v_new_password_hash := encode(digest(new_password, 'sha256'), 'hex');

  -- Обновить пароль
  UPDATE users
  SET password_hash = v_new_password_hash,
      updated_at = NOW()
  WHERE id = v_user_id;

  RETURN json_build_object('success', true, 'message', 'Пароль успешно изменен');
END;
$$;
```

---

## Проверка создания функций

После создания функций выполните:

```sql
-- Проверить что функции созданы
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN ('authenticate_user', 'request_password_reset', 'reset_password_with_code');
```

Вы должны увидеть 3 строки с типом FUNCTION.

---

## Тестирование функций

### Тест authenticate_user

```sql
-- Тестовый вызов (замените на ваш тестовый телефон и пароль)
SELECT authenticate_user('+79991234567', 'password123');
```

### Тест request_password_reset

```sql
SELECT request_password_reset('+79991234567');
```

### Тест reset_password_with_code

```sql
SELECT reset_password_with_code('+79991234567', '123456', 'newpassword123');
```

---

## Важные замечания

⚠️ **Безопасность:**
- Эти функции предназначены для разработки/тестирования
- В продакшене:
  - Используйте JWT токены вместо простых строк
  - Храните коды сброса в отдельной таблице с истечением
  - Интегрируйте SMS/Email сервисы для отправки кодов
  - Добавьте rate limiting для предотвращения брутфорса
  - Добавьте логирование попыток входа

⚠️ **Хеширование паролей:**
- Текущее решение использует SHA-256 согласно требованиям
- Пароли хешируются на стороне сервера
- Никогда не передавайте пароли в открытом виде через сеть в продакшене

---

## Что дальше?

После создания этих функций:
1. Выполните `flutter run` для запуска приложения
2. Попробуйте войти с тестовым пользователем
3. Проверьте работу сброса пароля

**Следующая фаза:** [Фаза 3: User Management](TASKS.md#-фаза-3-user-management---admin-неделя-3)
