-- ============================================
-- 我们的时间 - Supabase Setup SQL
-- ============================================

-- 1. messages 表：存储留言
CREATE TABLE IF NOT EXISTS messages (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  content TEXT NOT NULL,
  photo_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  display_date TEXT DEFAULT TO_CHAR(NOW(), 'YYYY-MM-DD HH24:MI')
);

ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read messages"
  ON messages FOR SELECT USING (true);

CREATE POLICY "Anyone can insert messages"
  ON messages FOR INSERT WITH CHECK (true);

-- 2. settings 表：存储主题配置
CREATE TABLE IF NOT EXISTS settings (
  key TEXT PRIMARY KEY,
  value JSONB NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read settings"
  ON settings FOR SELECT USING (true);

CREATE POLICY "Anyone can insert settings"
  ON settings FOR INSERT WITH CHECK (true);

CREATE POLICY "Anyone can update settings"
  ON settings FOR UPDATE USING (true);

-- 插入默认主题
INSERT INTO settings (key, value)
VALUES ('theme', '{
  "bg_color": "#fbf5f3",
  "text_color": "#2d2327",
  "accent_color": "#d4a0a7",
  "timer_color": "#2d2327",
  "heart_color": "#d4a0a7"
}'::jsonb)
ON CONFLICT (key) DO NOTHING;
