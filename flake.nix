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

    vhs-decode-nur-packages.url = "github:JuniorIsAJitterbug/nur-packages";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    nixpkgs-reaper-sws.url = "github:l1npengtul/nixpkgs/update-reaper-sws-extensions";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/9622747080c8cb57eaecba1985e48fc1f0bd1feb";

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

    reapkgs-known.url = "github:silvarc141/reapkgs-known";
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
  };

  outputs = {
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
    ...
  } @ inputs: let
    username = "l1npengtul";
    system = "x86_64-linux";
    lib = nixpkgs.lib // home-manager.lib;

    common-modules = [
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
            inherit inputs pkgs;
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
      ./pkgs
      ./services
      ./services/syncthing.nix
      ./configuration.nix
    ];

    reapersws-overlay = final: prev: {
      inherit
        (nixpkgs-reaper-sws.legacyPackages.${prev.system})
        reaper-sws-extension
        ;
    };

    commonArgs = {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        reapersws-overlay
        nix-vscode-extensions.overlays.default
      ];
    };

    pkgs = import nixpkgs commonArgs;
    pkgs-stable = import nixpkgs-stable commonArgs;
    pkgs-master = import nixpkgs-master commonArgs;
  in {
    inherit lib commonArgs;

    nixosConfigurations = {
      clubcyberia = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit inputs pkgs-stable pkgs-master;
        };

        modules =
          [
            musnix.nixosModules.musnix
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-gpu-amd
            nixos-hardware.nixosModules.common-cpu-amd

            ./hosts/personal/clubcyberia
          ]
          ++ common-modules;
      };
      pegrose512 = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit inputs pkgs-stable pkgs-master;
        };

        modules =
          [
            musnix.nixosModules.musnix
            nixos-hardware.nixosModules.common-pc-laptop-ssd
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-hidpi

            ./hosts/personal/pegrose512
          ]
          ++ common-modules;
      };
      oldhome = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit inputs pkgs-stable pkgs-master;
        };

        modules =
          [
            nixos-hardware.nixosModules.common-pc-laptop-ssd
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-hidpi

            ./hosts/personal/oldhome
          ]
          ++ common-modules;
      };
      wiltshire = let
        pkgs = pkgs-stable;
        pkgs-unstable = import nixpkgs commonArgs;
      in
        lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs-unstable pkgs-master;
          };

          modules = [
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-pc-hdd
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-cpu-intel

            disko.nixosModules.disko

            sops-nix.nixosModules.sops
            {
            }

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs pkgs;
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

            ./pkgs
            ./services
            ./configuration.nix
            ./hosts/server/wiltshire
            ./hosts/common/server

            # services
            ./services/syncthing.nix
            ./services/server/jellyfin.nix
            #./services/server/forgejo-worker.nix
            ./services/server
          ];
        };
      omvdijan = let
        pkgs = pkgs-stable;
        pkgs-unstable = import nixpkgs commonArgs;
      in
        lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs pkgs-unstable pkgs-master;
          };

          modules = [
            nixos-hardware.nixosModules.common-pc-hdd
            nixos-hardware.nixosModules.common-gpu-intel
            nixos-hardware.nixosModules.common-cpu-intel

            disko.nixosModules.disko

            sops-nix.nixosModules.sops
            {
            }

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs pkgs;
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

            ./pkgs
            ./services
            ./configuration.nix
            ./hosts/server/omvdijan
            ./hosts/common/server

            # services
            ./services/syncthing.nix
            ./services/server/madamoiselle
            ./services/server/forgejo.nix
            ./services/server/atticd.nix
            ./services/server
          ];
        };
    };
  };
}
