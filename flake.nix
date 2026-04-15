{
  description = "sakana fish l1npengtul nix system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    audio = {
      url = "github:polygon/audio.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #     lager-patch.url = "github:NixOS/nixpkgs?ref=pull/493363/head";

    reaper-patch.url = "github:NixOS/nixpkgs?ref=pull/509253/head";

    vhs-decode-nur-packages.url = "github:JuniorIsAJitterbug/nur-packages";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    nixpkgs-reaper-sws.url = "github:l1npengtul/nixpkgs/update-reaper-sws-extensions";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/284955ddb46db29437be321d28c169c76767954b";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    deploy-rs.url = "github:serokell/deploy-rs";

    reapkgs-known.url = "github:silvarc141/reapkgs-known/27487c09915f77cb8742936a1974897029055fee";
    reapkgs-extras.url = "github:l1npengtul/reapkgs-extras";

    # Additional Configuration Files

    plasma-overdose = {
      url = "github:olivertzeng/Plasma-Overdose";
      flake = false;
    };

    hatsune-miku-windows-linux-cursors = {
      url = "github:supermariofps/hatsune-miku-windows-linux-cursors";
      flake = false;
    };

    chicago95 = {
      url = "github:grassmunk/Chicago95";
      flake = false;
    };

    shhh = {
      url = "git+ssh://git@codeberg.org/l1npengtul/shhh.git?ref=senpai&shallow=1";
    };

    randomshit = {
      url = "git+ssh://git@github.com/l1npengtul/randomshit.git?ref=senpai&shallow=1";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-master,
      nixos-hardware,
      home-manager,
      plasma-manager,
      nix-flatpak,
      auto-cpufreq,
      musnix,
      audio,
      aagl,
      nix-index-database,
      vhs-decode-nur-packages,
      nix-minecraft,
      nixpkgs-reaper-sws,
      nix-vscode-extensions,
      disko,
      sops-nix,
      impermanence,
      deploy-rs,
      reapkgs-known,
      reapkgs-extras,
      plasma-overdose,
      hatsune-miku-windows-linux-cursors,
      chicago95,
      shhh,
      randomshit,
      reaper-patch,
      ...
    }@inputs:
    let
      username = "l1npengtul";
      system = "x86_64-linux";
      lib = nixpkgs.lib // home-manager.lib;

      reapersws-overlay = final: prev: {
        inherit (nixpkgs-reaper-sws.legacyPackages.${prev.system})
          reaper-sws-extension
          ;
      };

      commonArgs = {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          reapersws-overlay
          nix-vscode-extensions.overlays.default
          inputs.nix-minecraft.overlay
        ];
      };

      common-pc-modules = [
        nixos-hardware.nixosModules.common-pc-ssd

        nix-index-database.nixosModules.nix-index

        auto-cpufreq.nixosModules.default

        nix-flatpak.nixosModules.nix-flatpak

        sops-nix.nixosModules.sops
        {
        }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit
                inputs
                pkgs
                pkgs-stable
                pkgs-master
                ;
            };
            sharedModules = [
              plasma-manager.homeModules.plasma-manager
              sops-nix.homeManagerModules.sops
            ];
            users."${username}".imports = [
              ./home
            ];
          };
        }

        ./hosts/common
        ./hosts/common/personal-defaults.nix
        ./pkgs
        ./services
        ./services/syncthing.nix
        ./services/server/defaults/podman.nix
        ./configuration.nix
      ];

      common-server-modules = [
        nixos-hardware.nixosModules.common-pc-ssd

        disko.nixosModules.disko

        impermanence.nixosModules.impermanence

        sops-nix.nixosModules.sops
        {
        }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit
                inputs
                pkgs
                pkgs-stable
                pkgs-master
                ;
            };
            sharedModules = [
              sops-nix.homeManagerModules.sops
            ];
            users."${username}".imports = [
              ./home/shell.nix
              ./home/home.nix
            ];
          };
        }

        ./hosts/common/server
        ./services/tailscale.nix
        ./services/sshd.nix
        ./pkgs/minimal.nix
        ./configuration.nix
      ];

      pkgs = import nixpkgs commonArgs;
      pkgs-stable = import nixpkgs-stable commonArgs;
      pkgs-master = import nixpkgs-master commonArgs;
    in
    {
      inherit lib commonArgs;

      nixosConfigurations = {
        clubcyberia = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs-stable pkgs-master;
          };

          modules = [
            musnix.nixosModules.musnix
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-cpu-amd

            ./hosts/personal/clubcyberia
          ]
          ++ common-pc-modules;
        };
        pegrose512 = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs-stable pkgs-master;
          };

          modules = [
            musnix.nixosModules.musnix
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-hidpi

            ./hosts/personal/pegrose512
          ]
          ++ common-pc-modules;
        };
        oldhome = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs-stable pkgs-master;
          };

          modules = [
            nixos-hardware.nixosModules.common-pc-laptop-ssd
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-hidpi

            ./hosts/personal/oldhome
          ]
          ++ common-pc-modules;
        };
        wiltshire = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs-stable pkgs-master;
          };

          modules = [
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-cpu-intel

            ./hosts/servers/wiltshire

            ./services/server
            ./services

            # services
            ./services/syncthing.nix
            ./services/server/jellyfin.nix
            #./services/server/madamoiselle
            #./services/server/forgejo-worker.nix
            ./services/server/syncthing-persist.nix
          ]
          ++ common-server-modules;
        };
        omvdijan = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs-stable pkgs-master;
          };

          modules = [
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-cpu-intel

            nix-minecraft.nixosModules.minecraft-servers

            ./hosts/servers/omvdijan

            ./services/server
            ./services

            # services
            ./services/server/forgejo.nix
            #./services/server/atticd.nix
            ./services/server/caddy.nix
            ./services/server/madamoiselle
            ./services/server/fwdjellyfin.nix

            #./services/server/meinkraft
            #./services/server/meinkraft/obamna
          ]
          ++ common-server-modules;
        };
        garganta = lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs-stable pkgs-master;
          };

          modules = [
            nixos-hardware.nixosModules.common-cpu-amd

            nix-minecraft.nixosModules.minecraft-servers

            ./services/server

            ./hosts/servers/garganta

            ./services/server/caddy.nix
            ./services/server/meinkraft
            ./services/server/meinkraft/hc
          ]
          ++ common-server-modules;
        };
      };
    };
}
