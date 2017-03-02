{ pkgs ? import <nixpkgs> {}
, configuration ? <nixpkgs-config>
}:

let

  eval = pkgs.lib.evalModules {
    check = true;
    args.pkgs = pkgs;
    modules =
      [ configuration
        ./profile.nix
        ./theme
        ./programs/vim.nix
      ];
  };

in

{
  inherit (eval) options config;

  profile = eval.config.profile.build;
}
