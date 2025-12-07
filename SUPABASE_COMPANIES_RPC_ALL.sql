-- =====================================================
-- Скрипт для пересоздания всех RPC функций для Companies
-- =====================================================

-- Удаление существующих функций
DROP FUNCTION IF EXISTS get_companies(UUID);
DROP FUNCTION IF EXISTS get_company_by_id(UUID, UUID);
DROP FUNCTION IF EXISTS search_companies(UUID, TEXT);
DROP FUNCTION IF EXISTS get_companies_filtered(UUID, TEXT, TEXT, TEXT);
DROP FUNCTION IF EXISTS create_company(TEXT, TEXT, TEXT, TEXT, TEXT, TEXT, UUID, UUID);
DROP FUNCTION IF EXISTS update_company(UUID, UUID, TEXT, TEXT, TEXT, TEXT, TEXT, TEXT);
DROP FUNCTION IF EXISTS delete_company(UUID, UUID);

-- =====================================================
-- 1. Функция get_companies
-- =====================================================

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

-- =====================================================
-- 2. Функция get_company_by_id
-- =====================================================

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

-- =====================================================
-- 3. Функция search_companies
-- =====================================================

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

-- =====================================================
-- 4. Функция get_companies_filtered
-- =====================================================

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

-- =====================================================
-- 5. Функция create_company
-- =====================================================

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

-- =====================================================
-- 6. Функция update_company
-- =====================================================

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

-- =====================================================
-- 7. Функция delete_company
-- =====================================================

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
    'get_companies',
    'get_company_by_id',
    'search_companies',
    'get_companies_filtered',
    'create_company',
    'update_company',
    'delete_company'
  )
ORDER BY routine_name;
