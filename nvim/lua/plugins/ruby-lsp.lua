return {
  name = "ruby-lsp-config",
  dir = vim.fn.stdpath("config"),
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "ruby",
      callback = function()
        vim.lsp.start({
          name = "ruby-lsp",
          cmd = { "bundle", "exec", "ruby-lsp" },
          cmd_env = { BUNDLE_GEMFILE = vim.fn.expand("~/environment/dotfiles/ruby/ruby-lsp/Gemfile") },
          root_dir = vim.fs.root(0, { "Gemfile", ".git" }),
        })
      end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "ruby-lsp" then
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end
      end,
    })
  end,
}
