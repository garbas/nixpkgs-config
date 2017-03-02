{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.program.vim;

  vimConfig = 
    { customRC = cfg.config;
      vam.pluginDictionaries = [
        { names = cfg.plugins; }
      ];
    };


  vimPackage =
    if cfg.config == ""
      then cfg.package
      else pkgs.stdenv.mkDerivation {
        name = "${cfg.package.name}-configured";
        inherit (cfg.package) meta;
        nativeBuildInputs = [ pkgs.makeWrapper ];
        buildCommand = ''
          mkdir -p $out/bin
          for item in ${cfg.package}/bin/*; do
            ln -s $item $out/bin/
            wrapProgram $out/bin/`basename $item` --add-flags "-u ${pkgs.vimUtils.vimrcFile vimConfig}"
          done
        '';
      };
in {

  options.program.vim = {

    enable = mkOption {
      type = types.bool;
      default = false;
    };

    package = mkOption {
      type = types.package;
      example = literalExample "pkgs.neovim";
      default = pkgs.vim;
    };

    config = mkOption {
      type = types.str;
      default = "";
    };

    plugins = mkOption {
      type = types.listOf types.str;
      default = [];
    };

  };

  config = mkIf cfg.enable {

    profile.paths = [ vimPackage ];

  };

}
