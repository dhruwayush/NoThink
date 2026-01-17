-- Enable Row Level Security
alter default privileges revoke execute on functions from public;

-- DECISIONS TABLE
create table public.decisions (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) not null,
  title text not null,
  final_choice text not null,
  category text, -- food, work, study, lifestyle
  context_tags jsonb default '[]'::jsonb,
  time_of_day text,
  is_default boolean default false,
  reuse_count integer default 0,
  success_score numeric default 0.0,
  created_at timestamptz default now(),
  last_used_at timestamptz default now()
);

alter table public.decisions enable row level security;

create policy "Users can view their own decisions"
on public.decisions for select
using (auth.uid() = user_id);

create policy "Users can insert their own decisions"
on public.decisions for insert
with check (auth.uid() = user_id);

create policy "Users can update their own decisions"
on public.decisions for update
using (auth.uid() = user_id);

create policy "Users can delete their own decisions"
on public.decisions for delete
using (auth.uid() = user_id);

-- CONTEXT MEMORIES TABLE
create table public.context_memories (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) not null,
  entity_type text not null, -- person, place, thing
  entity_name text not null,
  memory text not null,
  tags jsonb default '[]'::jsonb,
  priority text default 'medium', -- low, medium, high
  last_triggered timestamptz default now(),
  created_at timestamptz default now()
);

alter table public.context_memories enable row level security;

create policy "Users can view their own memories"
on public.context_memories for select
using (auth.uid() = user_id);

create policy "Users can insert their own memories"
on public.context_memories for insert
with check (auth.uid() = user_id);

create policy "Users can update their own memories"
on public.context_memories for update
using (auth.uid() = user_id);

create policy "Users can delete their own memories"
on public.context_memories for delete
using (auth.uid() = user_id);

-- DECISION USAGE LOG
create table public.decision_usage_log (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users(id) not null,
  decision_id uuid references public.decisions(id) on delete cascade not null,
  used_at timestamptz default now()
);

alter table public.decision_usage_log enable row level security;

create policy "Users can view their own usage logs"
on public.decision_usage_log for select
using (auth.uid() = user_id);

create policy "Users can insert their own usage logs"
on public.decision_usage_log for insert
with check (auth.uid() = user_id);

-- INDEXES
create index idx_decisions_user_id on public.decisions(user_id);
create index idx_context_memories_user_id on public.context_memories(user_id);
create index idx_context_memories_entity_name on public.context_memories(entity_name);
