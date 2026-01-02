-- Fix RLS policy for notification_records table
-- The INSERT policy needs to ensure user_id matches auth.uid()

-- Drop existing INSERT policy
DROP POLICY IF EXISTS "System can insert notifications" ON notification_records;

-- Create new INSERT policy that checks both organization_id AND user_id
CREATE POLICY "Users can insert their own notifications"
  ON notification_records
  FOR INSERT
  WITH CHECK (
    -- User must be inserting a record for themselves
    user_id = auth.uid()
    AND
    -- And the organization_id must match their organization
    organization_id IN (
      SELECT organization_id FROM users WHERE id = auth.uid()
    )
  );

COMMENT ON POLICY "Users can insert their own notifications" ON notification_records IS
  'Users can only insert notification records for themselves within their organization';
