{ config, pkgs, lib, ... }:

{

  theme.defaultBrightness = "dark";
  theme.schemes = [
    "default"
  ];
  theme.templates = [
    "vim"
  ];

  program.vim.enable = true;
  program.vim.package = pkgs.neovim;
  program.vim.plugins = [];
  program.vim.config = ''
    " Easy buffer navigation
    noremap <C-h>  <C-w>h
    noremap <C-j>  <C-w>j
    noremap <C-k>  <C-w>k
    noremap <C-l>  <C-w>l
    noremap <leader>v <c-w>v
  '';

}
