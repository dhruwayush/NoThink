-- DATA TABLES (MVP Version - No Foreign Keys to auth.users for easier prototyping)

-- 1. DECISIONS
create table public.decisions (
  id uuid default gen_random_uuid() primary key,
  user_id text not null, -- Changed from uuid references auth.users to text
  title text not null,
  final_choice text not null,
  category text,
  context_tags jsonb default '[]'::jsonb,
  time_of_day text,
  is_default boolean default false,
  reuse_count integer default 0,
  success_score numeric default 0.0,
  created_at timestamptz default now(),
  last_used_at timestamptz default now()
);

-- 2. MEMORIES
create table public.context_memories (
  id uuid default gen_random_uuid() primary key,
  user_id text not null, -- Changed to text
  entity_type text not null,
  entity_name text not null,
  memory text not null,
  tags jsonb default '[]'::jsonb,
  priority text default 'medium',
  last_triggered timestamptz default now(),
  created_at timestamptz default now()
);

-- 3. USAGE LOG
create table public.decision_usage_log (
  id uuid default gen_random_uuid() primary key,
  user_id text not null, -- Changed to text
  decision_id uuid references public.decisions(id) on delete cascade not null,
  used_at timestamptz default now()
);

-- DISABLE RLS for MVP (Simplest for prototyping without Login screen)
alter table public.decisions disable row level security;
alter table public.context_memories disable row level security;
alter table public.decision_usage_log disable row level security;

-- INDEXES
create index idx_decisions_user_id on public.decisions(user_id);
create index idx_context_memories_user_id on public.context_memories(user_id);
create index idx_context_memories_entity_name on public.context_memories(entity_name);
