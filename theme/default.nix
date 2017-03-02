{ config, lib, pkgs, ... }:

with lib;

let

  base16-builder = (import ./base16-builder { inherit pkgs; }).base16-builder;

  theme-switch = 
    pkgs.stdenv.mkDerivation {
      name = "theme-switch";
      buildInputs = with pkgs; [ python3 ];
      buildCommand = ''
        mkdir -p $out/bin
        cp ${./theme-switch.py} $out/bin/theme-switch
        chmod +x $out/bin/theme-switch
        patchShebangs $out/bin/theme-switch
      '';
    };

in {

  options.theme  = {

    defaultBrightness = mkOption {
      type = types.enum [ "light" "dark" ];
      default = "";
    };

    schemes = mkOption {
      type = types.listOf types.str;
      default = [ "default" ];
    };

    templates = mkOption {
      type = types.listOf types.str;
      default = [];
    };

  };

  config = {

    profile.paths = [ theme-switch ];

  };

}
