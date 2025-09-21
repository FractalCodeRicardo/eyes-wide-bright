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
