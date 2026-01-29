-- Migration: Company Role-Based Access Control
-- Date: 2026-01-29
-- Description: Implement role-based access to companies
--   - Admins see ALL companies in their organization
--   - Regular users see ONLY their own companies (created_by_user_id)

-- ============================================================================
-- Step 1: Update RPC Functions to accept and use user_id and role
-- ============================================================================

-- Drop existing functions that need modification
DROP FUNCTION IF EXISTS get_companies(UUID);
DROP FUNCTION IF EXISTS get_companies_filtered(UUID, VARCHAR, VARCHAR, VARCHAR);
DROP FUNCTION IF EXISTS search_companies(UUID, TEXT);

-- ============================================================================
-- Function: get_companies
-- Description: Get all companies based on user role
-- Parameters:
--   - org_id: Organization ID
--   - user_id: Current user ID
--   - user_role: User role ('admin' or 'regular')
-- ============================================================================
CREATE OR REPLACE FUNCTION get_companies(
  org_id UUID,
  user_id UUID,
  user_role VARCHAR
)
RETURNS TABLE (
  id UUID,
  name VARCHAR,
  phone VARCHAR,
  email VARCHAR,
  address VARCHAR,
  status VARCHAR,
  content TEXT,
  last_contact_date TIMESTAMP,
  organization_id UUID,
  created_by_user_id UUID,
  created_at TIMESTAMP
) AS $$
BEGIN
  IF user_role = 'admin' THEN
    -- Admin sees ALL companies in organization
    RETURN QUERY
    SELECT
      c.id,
      c.name,
      c.phone,
      c.email,
      c.address,
      c.status,
      c.content,
      c.last_contact_date,
      c.organization_id,
      c.created_by_user_id,
      c.created_at
    FROM companies c
    WHERE c.organization_id = org_id
    ORDER BY c.created_at DESC;
  ELSE
    -- Regular user sees ONLY their own companies
    RETURN QUERY
    SELECT
      c.id,
      c.name,
      c.phone,
      c.email,
      c.address,
      c.status,
      c.content,
      c.last_contact_date,
      c.organization_id,
      c.created_by_user_id,
      c.created_at
    FROM companies c
    WHERE c.organization_id = org_id
      AND c.created_by_user_id = user_id
    ORDER BY c.created_at DESC;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- Function: get_companies_filtered
-- Description: Get companies with filters and sorting based on user role
-- Parameters:
--   - org_id: Organization ID
--   - user_id: Current user ID
--   - user_role: User role ('admin' or 'regular')
--   - status_filter: Filter by status (optional)
--   - sort_field: Field to sort by ('name', 'last_contact_date', 'created_at')
--   - sort_direction: Sort direction ('asc' or 'desc')
-- ============================================================================
CREATE OR REPLACE FUNCTION get_companies_filtered(
  org_id UUID,
  user_id UUID,
  user_role VARCHAR,
  status_filter VARCHAR DEFAULT NULL,
  sort_field VARCHAR DEFAULT 'created_at',
  sort_direction VARCHAR DEFAULT 'desc'
)
RETURNS TABLE (
  id UUID,
  name VARCHAR,
  phone VARCHAR,
  email VARCHAR,
  address VARCHAR,
  status VARCHAR,
  content TEXT,
  last_contact_date TIMESTAMP,
  organization_id UUID,
  created_by_user_id UUID,
  created_at TIMESTAMP
) AS $$
DECLARE
  query TEXT;
BEGIN
  -- Build base query based on role
  IF user_role = 'admin' THEN
    query := 'SELECT c.id, c.name, c.phone, c.email, c.address, c.status, c.content, ' ||
             'c.last_contact_date, c.organization_id, c.created_by_user_id, c.created_at ' ||
             'FROM companies c WHERE c.organization_id = $1';
  ELSE
    query := 'SELECT c.id, c.name, c.phone, c.email, c.address, c.status, c.content, ' ||
             'c.last_contact_date, c.organization_id, c.created_by_user_id, c.created_at ' ||
             'FROM companies c WHERE c.organization_id = $1 AND c.created_by_user_id = $2';
  END IF;

  -- Add status filter if provided
  IF status_filter IS NOT NULL THEN
    IF user_role = 'admin' THEN
      query := query || ' AND c.status = $2';
    ELSE
      query := query || ' AND c.status = $3';
    END IF;
  END IF;

  -- Add sorting
  query := query || ' ORDER BY c.' || sort_field || ' ' || sort_direction;

  -- Execute query based on role and parameters
  IF user_role = 'admin' THEN
    IF status_filter IS NOT NULL THEN
      RETURN QUERY EXECUTE query USING org_id, status_filter;
    ELSE
      RETURN QUERY EXECUTE query USING org_id;
    END IF;
  ELSE
    IF status_filter IS NOT NULL THEN
      RETURN QUERY EXECUTE query USING org_id, user_id, status_filter;
    ELSE
      RETURN QUERY EXECUTE query USING org_id, user_id;
    END IF;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- Function: search_companies
-- Description: Search companies based on user role
-- Parameters:
--   - org_id: Organization ID
--   - user_id: Current user ID
--   - user_role: User role ('admin' or 'regular')
--   - search_query: Search text
-- ============================================================================
CREATE OR REPLACE FUNCTION search_companies(
  org_id UUID,
  user_id UUID,
  user_role VARCHAR,
  search_query TEXT
)
RETURNS TABLE (
  id UUID,
  name VARCHAR,
  phone VARCHAR,
  email VARCHAR,
  address VARCHAR,
  status VARCHAR,
  content TEXT,
  last_contact_date TIMESTAMP,
  organization_id UUID,
  created_by_user_id UUID,
  created_at TIMESTAMP
) AS $$
BEGIN
  IF user_role = 'admin' THEN
    -- Admin searches ALL companies in organization
    RETURN QUERY
    SELECT
      c.id,
      c.name,
      c.phone,
      c.email,
      c.address,
      c.status,
      c.content,
      c.last_contact_date,
      c.organization_id,
      c.created_by_user_id,
      c.created_at
    FROM companies c
    WHERE c.organization_id = org_id
      AND (
        LOWER(c.name) LIKE LOWER('%' || search_query || '%')
        OR LOWER(c.phone) LIKE LOWER('%' || search_query || '%')
        OR LOWER(c.address) LIKE LOWER('%' || search_query || '%')
      )
    ORDER BY c.created_at DESC;
  ELSE
    -- Regular user searches ONLY their own companies
    RETURN QUERY
    SELECT
      c.id,
      c.name,
      c.phone,
      c.email,
      c.address,
      c.status,
      c.content,
      c.last_contact_date,
      c.organization_id,
      c.created_by_user_id,
      c.created_at
    FROM companies c
    WHERE c.organization_id = org_id
      AND c.created_by_user_id = user_id
      AND (
        LOWER(c.name) LIKE LOWER('%' || search_query || '%')
        OR LOWER(c.phone) LIKE LOWER('%' || search_query || '%')
        OR LOWER(c.address) LIKE LOWER('%' || search_query || '%')
      )
    ORDER BY c.created_at DESC;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- Function: get_company_by_id
-- Description: Get single company by ID with role-based access check
-- Parameters:
--   - comp_id: Company ID
--   - org_id: Organization ID
--   - user_id: Current user ID
--   - user_role: User role ('admin' or 'regular')
-- ============================================================================
DROP FUNCTION IF EXISTS get_company_by_id(UUID, UUID);

CREATE OR REPLACE FUNCTION get_company_by_id(
  comp_id UUID,
  org_id UUID,
  user_id UUID,
  user_role VARCHAR
)
RETURNS TABLE (
  id UUID,
  name VARCHAR,
  phone VARCHAR,
  email VARCHAR,
  address VARCHAR,
  status VARCHAR,
  content TEXT,
  last_contact_date TIMESTAMP,
  organization_id UUID,
  created_by_user_id UUID,
  created_at TIMESTAMP
) AS $$
BEGIN
  IF user_role = 'admin' THEN
    -- Admin can view any company in organization
    RETURN QUERY
    SELECT
      c.id,
      c.name,
      c.phone,
      c.email,
      c.address,
      c.status,
      c.content,
      c.last_contact_date,
      c.organization_id,
      c.created_by_user_id,
      c.created_at
    FROM companies c
    WHERE c.id = comp_id
      AND c.organization_id = org_id;
  ELSE
    -- Regular user can only view their own company
    RETURN QUERY
    SELECT
      c.id,
      c.name,
      c.phone,
      c.email,
      c.address,
      c.status,
      c.content,
      c.last_contact_date,
      c.organization_id,
      c.created_by_user_id,
      c.created_at
    FROM companies c
    WHERE c.id = comp_id
      AND c.organization_id = org_id
      AND c.created_by_user_id = user_id;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- Function: update_company
-- Description: Update company with role-based access check
-- Parameters:
--   - comp_id: Company ID
--   - org_id: Organization ID
--   - user_id: Current user ID
--   - user_role: User role ('admin' or 'regular')
--   - Other company fields to update
-- ============================================================================
DROP FUNCTION IF EXISTS update_company(UUID, UUID, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, TEXT);

CREATE OR REPLACE FUNCTION update_company(
  comp_id UUID,
  org_id UUID,
  user_id UUID,
  user_role VARCHAR,
  comp_name VARCHAR DEFAULT NULL,
  comp_phone VARCHAR DEFAULT NULL,
  comp_email VARCHAR DEFAULT NULL,
  comp_address VARCHAR DEFAULT NULL,
  comp_status VARCHAR DEFAULT NULL,
  comp_content TEXT DEFAULT NULL
)
RETURNS TABLE (
  id UUID,
  name VARCHAR,
  phone VARCHAR,
  email VARCHAR,
  address VARCHAR,
  status VARCHAR,
  content TEXT,
  last_contact_date TIMESTAMP,
  organization_id UUID,
  created_by_user_id UUID,
  created_at TIMESTAMP
) AS $$
DECLARE
  can_update BOOLEAN;
BEGIN
  -- Check if user can update this company
  IF user_role = 'admin' THEN
    -- Admin can update any company in organization
    SELECT EXISTS(
      SELECT 1 FROM companies
      WHERE companies.id = comp_id
        AND companies.organization_id = org_id
    ) INTO can_update;
  ELSE
    -- Regular user can only update their own company
    SELECT EXISTS(
      SELECT 1 FROM companies
      WHERE companies.id = comp_id
        AND companies.organization_id = org_id
        AND companies.created_by_user_id = user_id
    ) INTO can_update;
  END IF;

  IF NOT can_update THEN
    RAISE EXCEPTION 'Company not found or access denied';
  END IF;

  -- Update company
  UPDATE companies
  SET
    name = COALESCE(comp_name, companies.name),
    phone = COALESCE(comp_phone, companies.phone),
    email = COALESCE(comp_email, companies.email),
    address = COALESCE(comp_address, companies.address),
    status = COALESCE(comp_status, companies.status),
    content = COALESCE(comp_content, companies.content)
  WHERE companies.id = comp_id;

  -- Return updated company
  RETURN QUERY
  SELECT
    c.id,
    c.name,
    c.phone,
    c.email,
    c.address,
    c.status,
    c.content,
    c.last_contact_date,
    c.organization_id,
    c.created_by_user_id,
    c.created_at
  FROM companies c
  WHERE c.id = comp_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- Function: delete_company
-- Description: Delete company with role-based access check
-- Parameters:
--   - comp_id: Company ID
--   - org_id: Organization ID
--   - user_id: Current user ID
--   - user_role: User role ('admin' or 'regular')
-- ============================================================================
DROP FUNCTION IF EXISTS delete_company(UUID, UUID);

CREATE OR REPLACE FUNCTION delete_company(
  comp_id UUID,
  org_id UUID,
  user_id UUID,
  user_role VARCHAR
)
RETURNS BOOLEAN AS $$
DECLARE
  can_delete BOOLEAN;
  deleted_count INTEGER;
BEGIN
  -- Check if user can delete this company
  IF user_role = 'admin' THEN
    -- Admin can delete any company in organization
    SELECT EXISTS(
      SELECT 1 FROM companies
      WHERE companies.id = comp_id
        AND companies.organization_id = org_id
    ) INTO can_delete;
  ELSE
    -- Regular user can only delete their own company
    SELECT EXISTS(
      SELECT 1 FROM companies
      WHERE companies.id = comp_id
        AND companies.organization_id = org_id
        AND companies.created_by_user_id = user_id
    ) INTO can_delete;
  END IF;

  IF NOT can_delete THEN
    RETURN FALSE;
  END IF;

  -- Delete company (cascade will handle related records)
  DELETE FROM companies
  WHERE companies.id = comp_id;

  GET DIAGNOSTICS deleted_count = ROW_COUNT;

  RETURN deleted_count > 0;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- Grant execute permissions
-- ============================================================================
GRANT EXECUTE ON FUNCTION get_companies(UUID, UUID, VARCHAR) TO authenticated;
GRANT EXECUTE ON FUNCTION get_companies_filtered(UUID, UUID, VARCHAR, VARCHAR, VARCHAR, VARCHAR) TO authenticated;
GRANT EXECUTE ON FUNCTION search_companies(UUID, UUID, VARCHAR, TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION get_company_by_id(UUID, UUID, UUID, VARCHAR) TO authenticated;
GRANT EXECUTE ON FUNCTION update_company(UUID, UUID, UUID, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, VARCHAR, TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION delete_company(UUID, UUID, UUID, VARCHAR) TO authenticated;

-- ============================================================================
-- Migration complete
-- ============================================================================
-- Next steps:
-- 1. Execute this migration in Supabase SQL Editor
-- 2. Update CompanyRepository to pass user_id and user_role to RPC functions
-- 3. Test with both admin and regular user roles
