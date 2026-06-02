vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Claude: review my diff
vim.keymap.set("n", "<leader>cg", function()
  local diff = vim.fn.system("git diff HEAD")
  if vim.v.shell_error ~= 0 or diff == "" then
    vim.notify("No diff to review", vim.log.levels.WARN)
    return
  end
  vim.notify("Asking Claude to review your changes…")
  local prompt = [[
Review my current uncommitted changes as a senior dev looking over my shoulder.
Be brief. Flag only: bugs, security issues, unidiomatic patterns, missing edge
cases, or things that violate CLAUDE.md conventions. If it looks fine, say
"LGTM" and stop. No praise, no restating what I did.
]]
  vim.system(
    { "claude", "-p", prompt },
    { stdin = diff, text = true },
    vim.schedule_wrap(function(obj)
      local output = obj.stdout or "(no output)"
      if obj.code ~= 0 then
        output = "Claude exited with code " .. obj.code .. "\n\n" .. (obj.stderr or "")
      end
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
      vim.bo[buf].filetype = "markdown"
      vim.bo[buf].modifiable = false
      local width = math.floor(vim.o.columns * 0.7)
      local height = math.floor(vim.o.lines * 0.7)
      vim.api.nvim_open_win(buf, true, {
        relative = "editor", width = width, height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        border = "rounded", title = " Claude review ", title_pos = "center",
      })
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
    end)
  )
end, { desc = "Claude: review my diff" })
