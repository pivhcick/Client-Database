-- Migration: Create notification_records table
-- Stores all notifications that were delivered to users

-- Create table
CREATE TABLE IF NOT EXISTS notification_records (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  reminder_id UUID NOT NULL REFERENCES reminders(id) ON DELETE CASCADE,
  company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,

  -- Notification content
  title TEXT NOT NULL,
  body TEXT,

  -- Delivery info
  delivered_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Read status
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  read_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_notification_records_user_id
  ON notification_records(user_id);

CREATE INDEX IF NOT EXISTS idx_notification_records_organization_id
  ON notification_records(organization_id);

CREATE INDEX IF NOT EXISTS idx_notification_records_is_read
  ON notification_records(is_read);

CREATE INDEX IF NOT EXISTS idx_notification_records_delivered_at
  ON notification_records(delivered_at DESC);

CREATE INDEX IF NOT EXISTS idx_notification_records_reminder_id
  ON notification_records(reminder_id);

-- Enable Row Level Security
ALTER TABLE notification_records ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Users can only see notifications from their organization
CREATE POLICY "Users can view notifications from their organization"
  ON notification_records
  FOR SELECT
  USING (
    organization_id IN (
      SELECT organization_id FROM users WHERE id = auth.uid()
    )
  );

CREATE POLICY "Users can update notifications from their organization"
  ON notification_records
  FOR UPDATE
  USING (
    organization_id IN (
      SELECT organization_id FROM users WHERE id = auth.uid()
    )
  );

CREATE POLICY "System can insert notifications"
  ON notification_records
  FOR INSERT
  WITH CHECK (
    organization_id IN (
      SELECT organization_id FROM users WHERE id = auth.uid()
    )
  );

-- Function to mark notification as read
CREATE OR REPLACE FUNCTION mark_notification_as_read(notification_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE notification_records
  SET
    is_read = TRUE,
    read_at = NOW()
  WHERE id = notification_id AND is_read = FALSE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission on function
GRANT EXECUTE ON FUNCTION mark_notification_as_read(UUID) TO authenticated;

COMMENT ON TABLE notification_records IS 'Stores delivered notifications for tracking read/unread status';
