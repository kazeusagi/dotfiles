{
  description = "My home configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-claude-code = {
      url = "github:ryoppippi/nix-claude-code";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-bun = {
      url = "github:ryoppippi/nix-bun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-claude-code, nix-bun, ... }:
    let
      lib = nixpkgs.lib;
      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfreePredicate =
          pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "claude" ];
        overlays = [
          nix-claude-code.overlays.default
          nix-bun.overlays.default
        ];
      };
      users = {
        "kazeusagi"   = { system = "x86_64-linux";   platform = "win"; homeDirectory = "/home/kazeusagi"; };
        "ito.toshiki" = { system = "aarch64-darwin"; platform = "mac"; homeDirectory = "/Users/ito.toshiki"; };
      };
    in
    {
      homeConfigurations = builtins.mapAttrs (username: cfg:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs cfg.system;
          extraSpecialArgs = {
            inherit username;
            inherit (cfg) platform homeDirectory;
          };
          modules = [ ./modules/common.nix ]
            ++ lib.optional (cfg.platform == "mac") ./modules/platform/mac.nix
            ++ lib.optional (cfg.platform == "win") ./modules/platform/win.nix
            ++ lib.optional (cfg.platform == "linux") ./modules/platform/linux.nix;
        }
      ) users;
    };
}
