---@brief
--- OmniSharp server based on Roslyn workspaces
--- For `go_to_definition` to work fully, extended `textDocument/definition` handler is needed, for example see [omnisharp-extended-lsp.nvim](https://github.com/Hoffs/omnisharp-extended-lsp.nvim)

local function root_pattern(...)
  local function flatten(tbl)
    local nvim_eleven = vim.fn.has('nvim-0.11') == 1
    --- @diagnostic disable-next-line: deprecated
    return nvim_eleven and vim.iter(tbl):flatten(math.huge):totable() or vim.tbl_flatten(tbl)
  end

  local function escape_wildcards(path)
    return path:gsub('([%[%]%?%*])', '\\%1')
  end

  local function strip_archive_subpath(path)
    path = vim.fn.substitute(path, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', '\\1', '')
    path = vim.fn.substitute(path, 'tarfile:\\(.\\{-}\\)::.*$', '\\1', '')
    return path
  end

  local function search_ancestors(startpath, func)
    if func(startpath) then
      return startpath
    end
    local guard = 100
    for path in vim.fs.parents(startpath) do
      guard = guard - 1
      if guard == 0 then
        return
      end
      if func(path) then
        return path
      end
    end
  end

  local patterns = flatten { ... }

  return function(startpath)
    startpath = strip_archive_subpath(startpath)
    for _, pattern in ipairs(patterns) do
      local match = search_ancestors(startpath, function(path)
        for _, p in ipairs(vim.fn.glob(escape_wildcards(path) .. '/' .. pattern, true, true)) do
          if vim.uv.fs_stat(p) then
            return path
          end
        end
      end)
      if match then
        return match
      end
    end
  end
end

return {
  cmd = {
		os.getenv('HOME') .. '/.local/share/nvim/mason/packages/omnisharp/libexec/Omnisharp',
    '-z', -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
    '--hostPID',
    tostring(vim.fn.getpid()),
    'DotNet:enablePackageRestore=false',
    '--encoding',
    'utf-8',
    '--languageserver',
  },
  filetypes = { 'cs', 'vb' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      root_pattern '*.sln'(fname)
        or root_pattern '*.csproj'(fname)
        or root_pattern 'omnisharp.json'(fname)
        or root_pattern 'function.json'(fname)
    )
  end,
  init_options = {},
  capabilities = {
    workspace = {
      workspaceFolders = false,
    },
  },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    RoslynExtensionsOptions = {
      -- Enables support for roslyn analyzers, code fixes and rulesets.
      EnableAnalyzersSupport = true,
      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      EnableImportCompletion = nil,
    },
    RenameOptions = {
      RenameInComments = nil,
      RenameOverloads = nil,
      RenameInStrings = nil,
    },
    Sdk = {
      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      IncludePrereleases = false,
    },
  },
}
