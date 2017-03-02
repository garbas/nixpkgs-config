{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.profile;

in {
  options = {

    profile.build = mkOption {
      internal = true;
      default = {};
      description = ''
      '';
    };

    profile.name = mkOption {
      type = types.str;
      default = "nixpkgs-config";
    };

    profile.version = mkOption {
      type = types.str;
      default = pkgs.lib.nixpkgsVersion;
    };

    profile.paths = mkOption {
      type = types.listOf types.package;
      default = [];
      description = ''
      '';
    };

  };

  config = {

    profile.build = pkgs.buildEnv {
      name = "${cfg.name}-${cfg.version}";
      paths = cfg.paths;
    };

  };
}
