local utils = require('custom.utils')

local M = {}

function M.has_missing_key(provider)
  if provider == 'claude' and vim.env.ANTHROPIC_API_KEY ~= nil then
    return false
  end
  if provider == 'openai' and vim.env.OPENAI_API_KEY ~= nil then
    return false
  end
  if utils.string_starts_with(provider, 'gemini') and vim.env.GEMINI_API_KEY ~= nil then
    return false
  end

  return true
end

return M
