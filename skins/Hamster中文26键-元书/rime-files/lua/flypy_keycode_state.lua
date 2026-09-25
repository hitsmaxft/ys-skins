-- 小鹤双拼动态键码：首码态显示 zh/ch/sh，次码态显示韵母。
local M = {}
local function set_option(ctx, name, value)
  if ctx:get_option(name) ~= value then ctx:set_option(name, value) end
end
local function sync(env)
  if env.syncing then return end
  env.syncing = true
  local ctx = env.engine.context
  local enabled = ctx:get_option('show_flypy_yunmu')
  local hidden, initial, final = not enabled, false, false
  if enabled then
    local input = ctx.input or ''
    local segment = input:match("([^ '%s]+)$") or ''
    segment = segment:match('^[^`]*') or segment
    segment = segment:gsub('[^A-Za-z]', '')
    final = (#segment % 2 == 1)
    initial = not final
  end
  set_option(ctx, 'flypy_keycode_hidden', hidden)
  set_option(ctx, 'flypy_keycode_initial', initial)
  set_option(ctx, 'flypy_keycode_final', final)
  env.syncing = false
end
function M.init(env)
  local ctx = env.engine.context
  env.update_conn = ctx.update_notifier:connect(function() sync(env) end)
  env.option_conn = ctx.option_update_notifier:connect(function(_, name)
    if name == 'show_flypy_yunmu' then sync(env) end
  end)
  env.commit_conn = ctx.commit_notifier:connect(function() sync(env) end)
  sync(env)
end
function M.func(_, env) sync(env); return 2 end
function M.fini(env)
  if env.update_conn then env.update_conn:disconnect() end
  if env.option_conn then env.option_conn:disconnect() end
  if env.commit_conn then env.commit_conn:disconnect() end
end
return M
