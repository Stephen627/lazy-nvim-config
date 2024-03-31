return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        gdscript = {},
      },
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        gdscript = function(_, opts)
          local port = os.getenv("GDScript_Port") or "6005"
          local cmd = { "ncat", "127.0.0.1", port }
          local pipe = [[\\.\pipe\godot.pipe]]

          vim.lsp.start({
            name = "gdscript",
            cmd = cmd,
            root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
            on_attach = function(client, bufnr)
              vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])
            end,
          })
        end,
      },
    },
  },
}
