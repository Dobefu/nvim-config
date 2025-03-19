local codecompanion = require("codecompanion")

codecompanion.setup({
  display = {
    chat = {
      show_header_separator = false,
      window = {
        layout = "vertical",
        position = "left",
        relative = "editor",
      },
    },
    action_palette = {
      width = 90,
      height = 10,
      prompt = "Prompt ",
      provider = "telescope",
      opts = {
        show_default_actions = true,
        show_default_prompt_library = true,
      },
    },
  },
  strategies = {
    chat = {
      adapter = "local_server",
      slash_commands = {
        codebase = require("vectorcode.integrations").codecompanion.chat.make_slash_command(),
      },
      tools = {
        vectorcode = {
          description = "Run VectorCode to retrieve the project context.",
          callback = require("vectorcode.integrations").codecompanion.chat.make_tool(),
        }
      },
    },
    inline = {
      adapter = "local_server",
    },
  },
  adapters = {
    local_server = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          url = "http://127.0.0.1:1234",
          chat_url = "/v1/chat/completions",
        },
      })
    end,
  },
})

vim.api.nvim_set_keymap(
  'n',
  '<leader>a',
  '<Cmd>CodeCompanionActions<CR>',
  { noremap = true, silent = true, desc = "Open a CodeCompanion chat window" }
)

vim.api.nvim_set_keymap(
  'n',
  '<leader>c',
  '<Cmd>CodeCompanionChat Toggle<CR>',
  { noremap = true, silent = true, desc = "Toggle a CodeCompanion window" }
)


-- Handle progress notifications.
local format = require("noice.text.format")
local message = require("noice.message")
local manager = require("noice.message.manager")
local router = require("noice.message.router")

local ThrottleTime = 200
local M = {}

M.handles = {}
function M.init()
  local group = vim.api.nvim_create_augroup("NoiceCompanionRequests", {})

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestStarted",
    group = group,
    callback = function(request)
      local handle = M.create_progress_message(request)
      M.store_progress_handle(request.data.id, handle)
      M.update(handle)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = "CodeCompanionRequestFinished",
    group = group,
    callback = function(request)
      local message = M.pop_progress_message(request.data.id)
      if message then
        message.opts.progress.message = M.report_exit_status(request)
        M.finish_progress_message(message)
      end
    end,
  })
end

function M.store_progress_handle(id, handle)
  M.handles[id] = handle
end

function M.pop_progress_message(id)
  local handle = M.handles[id]
  M.handles[id] = nil
  return handle
end

function M.create_progress_message(request)
  local msg = message("lsp", "progress")
  local id = request.data.id
  msg.opts.progress = {
    client_id = "client " .. id,
    client = M.llm_role_title(request.data.adapter),
    id = id,
    message = "Awaiting Response: ",
  }
  return msg
end

function M.update(message)
  if M.handles[message.opts.progress.id] then
    manager.add(format.format(message, "lsp_progress"))
    vim.defer_fn(function()
      M.update(message)
    end, ThrottleTime)
  end
end

function M.finish_progress_message(message)
  manager.add(format.format(message, "lsp_progress"))
  router.update()
  manager.remove(message)
end

function M.llm_role_title(adapter)
  local parts = {}
  table.insert(parts, adapter.formatted_name)
  if adapter.model and adapter.model ~= "" then
    table.insert(parts, "(" .. adapter.model .. ")")
  end
  return table.concat(parts, " ")
end

function M.report_exit_status(request)
  if request.data.status == "success" then
    return "Completed"
  elseif request.data.status == "error" then
    return " Error"
  else
    return "󰜺 Cancelled"
  end
end

M.init()
