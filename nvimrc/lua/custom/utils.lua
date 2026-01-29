local M = {}

function M.map_event(...)
  -- Stash varargs to events
  local events = { ... }

  -- Return driver function
  return function(tbl)
    -- For every entry in tbl set the event
    for _, v in ipairs(tbl) do
      v.event = events
    end
    -- Return mutated table
    return tbl
  end
end

function M.map_ft(...)
  -- Stash varargs to events
  local ft = { ... }

  -- Return driver function
  return function(tbl)
    -- For every entry in tbl set the event
    for _, v in ipairs(tbl) do
      v.ft = ft
    end
    -- Return mutated table
    return tbl
  end
end

function M.string_starts_with(var, string)
  return var:sub(1, #string) == string
end

local rtp_paths = vim.api.nvim_list_runtime_paths()
function M.isMNWDevMode()
  for _, path in ipairs(rtp_paths) do
    if string.match(path, '%.nixnvim/nvimrc') then
      return true
    end
  end
  return false
end

-- Chains all functions provided.
function M.chain(...)
  local fns = { ... }
  return function(...)
    for _, fn in ipairs(fns) do
      if fn then
        fn(...)
      end
    end
  end
end

return M
