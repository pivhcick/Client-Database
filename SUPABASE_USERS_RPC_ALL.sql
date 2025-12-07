-- =====================================================
-- Скрипт для создания всех RPC функций для Users и Organizations
-- =====================================================

-- Удаление существующих функций
DROP FUNCTION IF EXISTS get_organization_by_id(UUID);
DROP FUNCTION IF EXISTS get_users(UUID);
DROP FUNCTION IF EXISTS get_user_by_id_admin(UUID, UUID);
DROP FUNCTION IF EXISTS create_user_admin(TEXT, TEXT, TEXT, TEXT, TEXT, TEXT, TEXT, UUID);
DROP FUNCTION IF EXISTS update_user_admin(UUID, UUID, TEXT, TEXT, TEXT, TEXT, TEXT);
DROP FUNCTION IF EXISTS delete_user_admin(UUID, UUID);
DROP FUNCTION IF EXISTS search_users(UUID, TEXT);

-- =====================================================
-- 1. Функция get_organization_by_id
-- =====================================================

CREATE OR REPLACE FUNCTION get_organization_by_id(
  org_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_organization RECORD;
BEGIN
  SELECT * INTO v_organization
  FROM organizations
  WHERE id = org_id;

  IF v_organization.id IS NULL THEN
    RETURN NULL;
  END IF;

  RETURN json_build_object(
    'id', v_organization.id,
    'name', v_organization.name,
    'created_at', v_organization.created_at
  );
END;
$$;

-- =====================================================
-- 2. Функция get_users
-- =====================================================

CREATE OR REPLACE FUNCTION get_users(
  org_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSON;
BEGIN
  SELECT json_agg(row_to_json(u))
  INTO result
  FROM (
    SELECT *
    FROM users
    WHERE organization_id = org_id
    ORDER BY created_at DESC
  ) u;

  RETURN COALESCE(result, '[]'::json);
END;
$$;

-- =====================================================
-- 3. Функция get_user_by_id_admin
-- =====================================================

CREATE OR REPLACE FUNCTION get_user_by_id_admin(
  user_id UUID,
  org_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSON;
BEGIN
  SELECT json_agg(row_to_json(u))
  INTO result
  FROM (
    SELECT *
    FROM users
    WHERE id = user_id AND organization_id = org_id
  ) u;

  RETURN COALESCE(result, '[]'::json);
END;
$$;

-- =====================================================
-- 4. Функция create_user_admin
-- =====================================================

CREATE OR REPLACE FUNCTION create_user_admin(
  user_phone TEXT,
  user_first_name TEXT,
  user_last_name TEXT,
  user_middle_name TEXT,
  user_email TEXT,
  user_password TEXT,
  user_role TEXT,
  org_id UUID
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  new_user_id UUID;
  result JSON;
  v_password_hash TEXT;
BEGIN
  -- Вычислить хеш пароля (SHA-256)
  v_password_hash := encode(digest(user_password, 'sha256'), 'hex');

  -- Создать пользователя
  INSERT INTO users (
    phone,
    first_name,
    last_name,
    middle_name,
    email,
    password_hash,
    role,
    organization_id
  )
  VALUES (
    user_phone,
    user_first_name,
    user_last_name,
    user_middle_name,
    user_email,
    v_password_hash,
    user_role,
    org_id
  )
  RETURNING id INTO new_user_id;

  -- Вернуть созданного пользователя
  SELECT json_agg(row_to_json(u))
  INTO result
  FROM (
    SELECT *
    FROM users
    WHERE id = new_user_id
  ) u;

  RETURN COALESCE(result, '[]'::json);
END;
$$;

-- =====================================================
-- 5. Функция update_user_admin
-- =====================================================

CREATE OR REPLACE FUNCTION update_user_admin(
  user_id UUID,
  org_id UUID,
  user_first_name TEXT DEFAULT NULL,
  user_last_name TEXT DEFAULT NULL,
  user_middle_name TEXT DEFAULT NULL,
  user_email TEXT DEFAULT NULL,
  user_role TEXT DEFAULT NULL
)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSON;
BEGIN
  UPDATE users
  SET
    first_name = COALESCE(user_first_name, users.first_name),
    last_name = COALESCE(user_last_name, users.last_name),
    middle_name = COALESCE(user_middle_name, users.middle_name),
    email = COALESCE(user_email, users.email),
    role = COALESCE(user_role, users.role),
    updated_at = NOW()
  WHERE users.id = user_id AND users.organization_id = org_id;

  SELECT json_agg(row_to_json(u))
  INTO result
  FROM (
    SELECT *
    FROM users
    WHERE id = user_id
  ) u;

  RETURN COALESCE(result, '[]'::json);
END;
$$;

-- =====================================================
-- 6. Функция delete_user_admin
-- =====================================================

CREATE OR REPLACE FUNCTION delete_user_admin(
  user_id UUID,
  org_id UUID
)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  deleted_count INTEGER;
BEGIN
  DELETE FROM users
  WHERE id = user_id AND organization_id = org_id;

  GET DIAGNOSTICS deleted_count = ROW_COUNT;

  RETURN deleted_count > 0;
END;
$$;

-- =====================================================
-- 7. Функция search_users
-- =====================================================

CREATE OR REPLACE FUNCTION search_users(
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
  SELECT json_agg(row_to_json(u))
  INTO result
  FROM (
    SELECT *
    FROM users
    WHERE organization_id = org_id
      AND (
        first_name ILIKE '%' || search_query || '%'
        OR last_name ILIKE '%' || search_query || '%'
        OR middle_name ILIKE '%' || search_query || '%'
        OR phone ILIKE '%' || search_query || '%'
      )
    ORDER BY created_at DESC
  ) u;

  RETURN COALESCE(result, '[]'::json);
END;
$$;

-- =====================================================
-- Проверка создания функций
-- =====================================================

SELECT
  routine_name,
  routine_type,
  'OK' as status
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_name IN (
    'get_organization_by_id',
    'get_users',
    'get_user_by_id_admin',
    'create_user_admin',
    'update_user_admin',
    'delete_user_admin',
    'search_users'
  )
ORDER BY routine_name;
