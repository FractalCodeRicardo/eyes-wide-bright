<div align="center">

# **Eyes wide bright**

</div>



<p align="center">
  <em>I simple neovim plugin to keep your eyes healthy</em>
</p>

<p align="center">
  <img width="450" height="210" alt="image" src="https://github.com/user-attachments/assets/9ed9fc02-99c0-4795-95be-cd878070aa62" />
</p>

## Usage

To use **Eyes Wide Bright** with [LazyVim](https://github.com/LazyVim/LazyVim), add the plugin to your plugin list and configure it like this:

```lua
{
    "FractalCodeRicardo/eyes-wide-bright",
    config = function()
        require("eyes-wide-bright").setup({
            mode = "normal"  -- options: "normal", "warm", "cold"
        })
    end
}
```

## Default Keymaps

The plugin comes with the following default keymaps:

- `<leader>m` – Increase brightness  
- `<leader>l` – Decrease brightness  
- `<leader>r` – Restore your current theme

## Commands

The plugin provides the following commands:

- `:EyesIncrease` – Increase brightness  
- `:EyesDecrease` – Decrease brightness  
- `:EyesReset` – Restore your theme  
- `:EyesMode <normal|warm|cold>` – Change the mode

## Customize Configuration

You can customize the plugin by passing your own settings to the `setup` method.  
Here’s an example:

```lua
return {
    "FractalCodeRicardo/eyes-wide-bright",
    config = function()
        require("eyes-wide-bright").setup({
            mode = 'normal',         -- options: "normal", "warm", "cold"
            increase_key = '<leader>m', -- keymap to increase brightness
            decrease_key = '<leader>l', -- keymap to decrease brightness
            reset_key = '<leader>r'     -- keymap to restore your theme
        })
    end
}
