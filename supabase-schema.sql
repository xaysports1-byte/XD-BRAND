-- ============================================================
-- XD Brand jersey - Supabase Schema (รุ่นที่ 2 รองรับ lineItems)
-- รันใน Supabase Dashboard → SQL Editor → New query → Run
-- รันได้หลายครั้ง (idempotent — ไม่ลบของเก่า)
-- ============================================================

-- 1. ลูกค้า
create table if not exists customers (
  id text primary key,
  name text not null,
  phone text default '',
  address text default '',
  note text default '',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 2. ออเดอร์ผลิต (รองรับหลายรายการต่อออเดอร์)
create table if not exists orders (
  id text primary key,
  code text default '',
  status text not null default 'pending',
  date date,
  customer text default '',
  phone text default '',
  design_code text default '',
  line_items jsonb default '[]'::jsonb,
  deposit numeric default 0,
  factory_paid numeric default 0,
  factory_date date,
  note text default '',
  image text default '',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- ALTER สำหรับตารางที่สร้างจาก schema เก่า — เพิ่มคอลัมน์ที่ขาด
alter table orders add column if not exists phone text default '';
alter table orders add column if not exists design_code text default '';
alter table orders add column if not exists line_items jsonb default '[]'::jsonb;
alter table orders add column if not exists factory_date date;

-- 3. งานออกแบบ
create table if not exists designs (
  id text primary key,
  code text default '',
  status text not null default 'no_design',
  date date,
  customer text default '',
  contact text default '',
  name text default '',
  note text default '',
  image text default '',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 4. บัญชี
create table if not exists finance (
  id text primary key,
  type text not null,
  category text default '',
  date date,
  amount numeric default 0,
  description text default '',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- 5. ตั้งค่าร้าน
create table if not exists settings (
  id int primary key default 1,
  shop_name text default 'XD Brand jersey',
  phone text default '020 95618276',
  address text default '',
  currency text default 'THB',
  symbol text default '฿',
  logo text default '',
  updated_at timestamptz default now(),
  constraint only_one_settings check (id = 1)
);

insert into settings (id) values (1) on conflict (id) do nothing;

-- ============================================================
-- RLS Policies
-- ============================================================
alter table customers enable row level security;
alter table orders enable row level security;
alter table designs enable row level security;
alter table finance enable row level security;
alter table settings enable row level security;

drop policy if exists "public_all" on customers;
drop policy if exists "public_all" on orders;
drop policy if exists "public_all" on designs;
drop policy if exists "public_all" on finance;
drop policy if exists "public_all" on settings;

create policy "public_all" on customers for all using (true) with check (true);
create policy "public_all" on orders for all using (true) with check (true);
create policy "public_all" on designs for all using (true) with check (true);
create policy "public_all" on finance for all using (true) with check (true);
create policy "public_all" on settings for all using (true) with check (true);

-- ============================================================
-- Index
-- ============================================================
create index if not exists idx_orders_date on orders(date);
create index if not exists idx_orders_status on orders(status);
create index if not exists idx_orders_customer on orders(customer);
create index if not exists idx_designs_status on designs(status);
create index if not exists idx_finance_date on finance(date);
create index if not exists idx_finance_type on finance(type);
