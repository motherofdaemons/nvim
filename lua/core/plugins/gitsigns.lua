local M = {
  "lewis6991/gitsigns.nvim",
}

function M.config()
  require("gitsigns").setup({
    on_attach = function()
      local gs = package.loaded.gitsigns
      local wk = require("which-key")

      -- Navigation
      wk.register({
        ["]"] = {
          c = { gs.next_hunk, "Next git hunk" },
        },
        ["["] = {
          c = { gs.prev_hunk, "Previous git hunk" },
        },
      })

      -- Actions
      wk.register({
        g = {
          name = "Git",
          s = {
            name = "Stage",
            h = { gs.stage_hunk, "Stage hunk" },
            b = { gs.stage_buffer, "Stage buffer" },
          },
          u = {
            name = "Unstage",
            h = { gs.undo_stage_hunk, "Unstage hunk" },
            b = { gs.undo_stage_buffer, "Unstage buffer" },
          },
          r = {
            name = "Reset",
            h = { gs.reset_hunk, "Reset hunk" },
            b = { gs.reset_buffer, "Reset buffer" },
          },
          b = {
            name = "Blame",
            b = { function() gs.blame_line(true) end, "Blame line" },
            t = { gs.toggle_current_line_blame, "Toggle blame" },
          },
          d = {
            name = "Preview",
            h = { gs.preview_hunk, "Preview hunk" },
            d = { gs.toggle_deleted, "Toggle deleted" },
            f = { gs.diffthis, "Diff this buffer" },
          }
        },
      }, { prefix = "<leader>" })
    end
  })
end

return M
