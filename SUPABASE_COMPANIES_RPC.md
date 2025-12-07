# Supabase RPC Functions для Companies

Для избежания infinite recursion в RLS политиках создаем RPC функции для работы с компаниями.

## Инструкция по созданию

1. Откройте Supabase Dashboard: https://supabase.com/dashboard/project/rcprdyenxwotgdanrycu
2. Перейдите в SQL Editor (слева в меню)
3. Выполните следующие SQL команды по очереди

---

## 1. Функция get_companies

Получает все компании для указанной организации.

```sql
-- Функция для получения всех компаний организации
CREATE OR REPLACE FUNCTION get_companies(
  org_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSON;
BEGIN
  SELECT json_agg(row_to_json(c))
  INTO result
  FROM (
    SELECT *
    FROM companies
    WHERE organization_id = org_id
    ORDER BY created_at DESC
  ) c;

  RETURN COALESCE(result, '[]'::json);
END;
$$;
```

---

## 2. Функция get_company_by_id

Получает одну компанию по ID.

```sql
-- Функция для получения компании по ID
CREATE OR REPLACE FUNCTION get_company_by_id(
  comp_id UUID,
  org_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSON;
BEGIN
  SELECT json_agg(row_to_json(c))
  INTO result
  FROM (
    SELECT *
    FROM companies
    WHERE id = comp_id AND organization_id = org_id
  ) c;

  RETURN COALESCE(result, '[]'::json);
END;
$$;
```

---

## 3. Функция search_companies

Поиск компаний по имени, телефону или адресу.

```sql
-- Функция для поиска компаний
CREATE OR REPLACE FUNCTION search_companies(
  org_id UUID,
  search_query TEXT
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSON;
BEGIN
  SELECT json_agg(row_to_json(c))
  INTO result
  FROM (
    SELECT *
    FROM companies
    WHERE organization_id = org_id
      AND (
        name ILIKE '%' || search_query || '%'
        OR phone ILIKE '%' || search_query || '%'
        OR address ILIKE '%' || search_query || '%'
      )
    ORDER BY created_at DESC
  ) c;

  RETURN COALESCE(result, '[]'::json);
END;
$$;
```

---

## 4. Функция get_companies_filtered

Получает компании с фильтрацией по статусу и сортировкой.

```sql
-- Функция для получения компаний с фильтрами
CREATE OR REPLACE FUNCTION get_companies_filtered(
  org_id UUID,
  status_filter TEXT DEFAULT NULL,
  sort_field TEXT DEFAULT 'created_at',
  sort_direction TEXT DEFAULT 'desc'
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSON;
  query TEXT;
BEGIN
  query := 'SELECT json_agg(row_to_json(c)) FROM (' ||
           'SELECT * FROM companies WHERE organization_id = $1';

  IF status_filter IS NOT NULL THEN
    query := query || ' AND status = $2';
  END IF;

  query := query || ' ORDER BY ' || sort_field || ' ' || sort_direction || ') c';

  IF status_filter IS NOT NULL THEN
    EXECUTE query INTO result USING org_id, status_filter;
  ELSE
    EXECUTE query INTO result USING org_id;
  END IF;

  RETURN COALESCE(result, '[]'::json);
END;
$$;
```

---

## 5. Функция create_company

Создает новую компанию.

```sql
-- Функция для создания компании
CREATE OR REPLACE FUNCTION create_company(
  comp_name TEXT,
  comp_phone TEXT,
  comp_email TEXT,
  comp_address TEXT,
  comp_status TEXT,
  comp_content TEXT,
  org_id UUID,
  user_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  new_company_id UUID;
  result JSON;
BEGIN
  INSERT INTO companies (name, phone, email, address, status, content, organization_id, created_by_user_id)
  VALUES (comp_name, comp_phone, comp_email, comp_address, comp_status, comp_content, org_id, user_id)
  RETURNING id INTO new_company_id;

  SELECT json_agg(row_to_json(c))
  INTO result
  FROM (
    SELECT *
    FROM companies
    WHERE id = new_company_id
  ) c;

  RETURN COALESCE(result, '[]'::json);
END;
$$;
```

---

## 6. Функция update_company

Обновляет существующую компанию.

```sql
-- Функция для обновления компании
CREATE OR REPLACE FUNCTION update_company(
  comp_id UUID,
  org_id UUID,
  comp_name TEXT DEFAULT NULL,
  comp_phone TEXT DEFAULT NULL,
  comp_email TEXT DEFAULT NULL,
  comp_address TEXT DEFAULT NULL,
  comp_status TEXT DEFAULT NULL,
  comp_content TEXT DEFAULT NULL
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSON;
BEGIN
  UPDATE companies
  SET
    name = COALESCE(comp_name, companies.name),
    phone = COALESCE(comp_phone, companies.phone),
    email = COALESCE(comp_email, companies.email),
    address = COALESCE(comp_address, companies.address),
    status = COALESCE(comp_status, companies.status),
    content = COALESCE(comp_content, companies.content),
    updated_at = NOW()
  WHERE companies.id = comp_id AND companies.organization_id = org_id;

  SELECT json_agg(row_to_json(c))
  INTO result
  FROM (
    SELECT *
    FROM companies
    WHERE id = comp_id
  ) c;

  RETURN COALESCE(result, '[]'::json);
END;
$$;
```

---

## 7. Функция delete_company

Удаляет компанию.

```sql
-- Функция для удаления компании
CREATE OR REPLACE FUNCTION delete_company(
  comp_id UUID,
  org_id UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  deleted_count INTEGER;
BEGIN
  DELETE FROM companies
  WHERE id = comp_id AND organization_id = org_id;

  GET DIAGNOSTICS deleted_count = ROW_COUNT;

  RETURN deleted_count > 0;
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
  AND routine_name IN (
    'get_companies',
    'get_company_by_id',
    'search_companies',
    'get_companies_filtered',
    'create_company',
    'update_company',
    'delete_company'
  );
```

Вы должны увидеть 7 строк с типом FUNCTION.

---

## Тестирование функций

### Тест get_companies

```sql
-- Замените на ваш UUID организации
SELECT * FROM get_companies('362b2c74-912d-4ecc-9c97-09826972063a');
```

### Тест create_company

```sql
-- Замените на ваши UUID
SELECT * FROM create_company(
  'Тестовая компания',
  '+79991234567',
  'test@example.com',
  'Москва, ул. Тестовая, 1',
  'potential',
  'Тестовая заметка',
  '362b2c74-912d-4ecc-9c97-09826972063a',
  'YOUR_USER_ID'
);
```

---

## Что дальше?

После создания этих функций:
1. Обновите CompanyRepository для использования RPC функций
2. Запустите приложение и протестируйте CRUD операции
