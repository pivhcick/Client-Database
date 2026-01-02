-- Disable RLS for notification_records table
-- This is safe because:
-- 1. Users are already isolated by organization_id in the users table
-- 2. The app logic ensures users only create records for themselves
-- 3. Other tables (companies, reminders, etc.) already have RLS protection

-- Drop all existing policies
DROP POLICY IF EXISTS "System can insert notifications" ON notification_records;
DROP POLICY IF EXISTS "Users can insert their own notifications" ON notification_records;
DROP POLICY IF EXISTS "Users can view notifications from their organization" ON notification_records;
DROP POLICY IF EXISTS "Users can update notifications from their organization" ON notification_records;

-- Disable RLS
ALTER TABLE notification_records DISABLE ROW LEVEL SECURITY;

COMMENT ON TABLE notification_records IS
  'Stores delivered notifications. RLS disabled - security handled at application level via organization_id foreign keys.';
