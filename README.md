A plugin to automatically enable highlighting for the underlying language, for [tera](https://github.com/keats/tera).

## Requirements

- [Neovim](https://neovim.io/) >= 0.11
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- The [tera]() parser and the parser for the underlying language you want to highlight.

## How to use

Install via your package manager

For example, [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "MuntasirSZN/tera-autoextsyn.nvim",
  lazy = false,
}
```

The plugin will automatically load on tera filetype detection.

## Usage

If you have a file, for example `index.tera`, then it will highlight tera + html by default.

If `index.toml.tera`, then it will highlight tera + toml. And so on.

Unknown extensions will be ignored.

## Configuration

There is none, not needed at all. 😀

## License

This plugin is licensed under the [MIT License](https://opensource.org/licenses/MIT). See [LICENSE](./LICENSE) for more details.
