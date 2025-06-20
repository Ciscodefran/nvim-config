# 💤 LazyVim Configuration

Personal Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim).

## 🔧 Installed Plugins

### Core & UI
- **LazyVim** - Base configuration framework
- **Sonokai** - Color scheme (Shusia variant)
- **Lualine** - Status line
- **Bufferline** - Tab/buffer line
- **Neo-tree** - File explorer
- **Noice** - UI improvements for cmdline, popupmenu and messages
- **Which-key** - Keybinding hints

### LSP & Completion
- **Mason** - LSP server manager
- **nvim-lspconfig** - LSP configuration
- **Blink.cmp** - Completion engine
- **LuaSnip** - Snippet engine
- **Treesitter** - Syntax highlighting and parsing

### Database Tools
- **vim-dadbod** - Database interface
- **vim-dadbod-ui** - Database UI with floating windows
- **vim-dadbod-completion** - SQL completion
- **dotenv.nvim** - Environment variable loading

### Development Tools
- **Claude Code** - AI assistant integration (Ctrl+,)
- **Kulala** - HTTP/REST client for .http files
- **Gitsigns** - Git integration
- **Flash** - Enhanced navigation
- **Trouble** - Diagnostics panel
- **Todo-comments** - TODO highlighting
- **Conform** - Code formatting
- **nvim-lint** - Linting

### Language Support
- **Rustacean** - Enhanced Rust support
- **Crates** - Rust crate management
- **Markdown-preview** - Live markdown preview
- **ts-comments** - TypeScript comment handling

### Utilities
- **im-select** - Input method switching (macOS)
- **Persistence** - Session management
- **Mini.ai** - Text objects
- **Mini.pairs** - Auto pairs
- **Grug-far** - Search and replace

## ⚙️ Key Features

### Database Management
- Integrated database UI with floating windows
- SQL completion and syntax highlighting
- Environment variable support for connection strings

### HTTP/REST Testing
- Built-in HTTP client for `.http` files
- JSON/XML response formatting
- Environment-based request execution

### AI Integration
- Claude Code integration with `Ctrl+,` toggle
- Git-aware context and window management

### Input Method (macOS)
- Automatic switching to English in Normal/Visual mode
- Seamless Korean/English input handling

## 🚀 Getting Started

Refer to the [LazyVim documentation](https://lazyvim.github.io/installation) for basic setup.

### Custom Keybindings
- `Ctrl+,` - Toggle Claude Code assistant
- `<CR>` - Execute HTTP request (in .http files)
- `<leader>Rs` - Run single HTTP request
- `<leader>Ra` - Run all HTTP requests
- `<leader>Rb` - Open HTTP scratchpad
