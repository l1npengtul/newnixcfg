{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  hcraft = inputs.shhh.services.minecraft.hcraft;
in
{
  services.minecraft-servers.servers."hcraft" = {
    enable = true;
    package = pkgs.fabricServers.fabric-1_21_11;
    jvmOpts = "-Xms6144M -Xmx6144M --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20";
    serverProperties = {
      server-port = hcraft.server;
      broadcast-console-to-ops = true;
      broadcast-rcon-to-ops = true;
      difficulty = 3;
      enable-rcon = true;
      "rcon.password" = hcraft.rcon.password;
      "rcon.port" = hcraft.rcon.port;
      motd = "Join Floor 1: discord.gg/hellocharlotte";
    };
    files = {
      "server-icon.png" = ./hcicon.png;
    };
    symlinks = {
      mods = pkgs.linkFarmFromDrvs "mods" (
        builtins.attrValues {
          Fabric-API = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/i5tSkVBH/fabric-api-0.141.3%2B1.21.11.jar";
            sha512 = "c20c017e23d6d2774690d0dd774cec84c16bfac5461da2d9345a1cd95eee495b1954333c421e3d1c66186284d24a433f6b0cced8021f62e0bfa617d2384d0471";
          };
          Spark = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/l6YH9Als/versions/1CB3cS0m/spark-1.10.156-fabric.jar";
            sha512 = "c17995968561761e0857445e28e9235f3c0ec5fc0695deda3b2ae408baf074348822f0a8671791032b32c6b2977edba1024a2cc3b4588b9274e7f131795af6e0";
          };
          Forge-Config-API-Port = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/ohNO6lps/versions/uXrWPsCu/ForgeConfigAPIPort-v21.11.1-mc1.21.11-Fabric.jar";
            sha512 = "28791c992d613da14b8685505d3ef632ed53b5f1e1d517f0b41677d10f8419f192dfbde991308df6cda5d0f113c0aa8fc18ecf4a0834029403b16d2f68dc52d6";
          };
          Open-Parties-and-Claims = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/gF3BGWvG/versions/xE2Whg8K/open-parties-and-claims-fabric-1.21.11-0.25.8.jar";
            sha512 = "4a1a225b446f2f9b605e73a6703f5b6427e45a130f87c15d3877533d191df01da20ea691c469dca74c9d2f2f09c5e7b9a2156e94c12cad1d856d1ff9eda6d2f3";
          };
          C2ME = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/VSNURh3q/versions/QdLiMUjx/c2me-fabric-mc1.21.11-0.3.7%2Balpha.0.7.jar";
            sha512 = "f9543febe2d649a82acd6d5b66189b6a3d820cf24aa503ba493fdb3bbd4e52e30912c4c763fe50006f9a46947ae8cd737d420838c61b93429542573ed67f958e";
          };
          Clumps = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/OgBE8Rz4/Clumps-fabric-1.21.11-29.0.0.1.jar";
            sha512 = "3cff3cd2d600a6d84030b38ce6244143d13774d5287627bb7312adae5edc7ae2d9151a2c9c39a00681c354d549b0a62ac48c0077ba586cc10c00d32f39e87f18";
          };
          Krypton = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
            sha512 = "4dcd7228d1890ddfc78c99ff284b45f9cf40aae77ef6359308e26d06fa0d938365255696af4cc12d524c46c4886cdcd19268c165a2bf0a2835202fe857da5cab";
          };
          Lithium = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/qvNsoO3l/lithium-fabric-0.21.3%2Bmc1.21.11.jar";
            sha512 = "2883739303f0bb602d3797cc601ed86ce6833e5ec313ddce675f3d6af3ee6a40b9b0a06dafe39d308d919669325e95c0aafd08d78c97acd976efde899c7810fd";
          };
          FerriteCore = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/uXXizFIs/versions/Ii0gP3D8/ferritecore-8.2.0-fabric.jar";
            sha512 = "3210926a82eb32efd9bcebabe2f6c053daf5c4337eebc6d5bacba96d283510afbde646e7e195751de795ec70a2ea44fef77cb54bf22c8e57bb832d6217418869";
          };
          NoChatReports = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/rhykGstm/NoChatReports-FABRIC-1.21.11-v2.18.0.jar";
            sha512 = "d2c35cc8d624616f441665aff67c0e366e4101dba243bad25ed3518170942c1a3c1a477b28805cd1a36c44513693b1c55e76bea627d3fced13927a3d67022ccc";
          };
          LuckPerms = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/Vebnzrzj/versions/CzCJJMuo/LuckPerms-Fabric-5.5.21.jar";
            sha512 = "5dc98d5b3acaab65e8de2873af6b42eced427360f4f50b136b82d2820602341a5fb3cf9f10c27d07e6c7cc556e9d30922492421cb6cc734fa05562e89554fa43";
          };
          Ledger = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/LVN9ygNV/versions/c1d39lju/ledger-1.3.19.jar";
            sha512 = "91c6cdd9d8bcb6fb57f3ec83c968217b157d7d763724ba19e6d21711bf14bdefdfe2a5b03226bce65c77a0988c6b1d336535de9c9bae4193902a95fac17152a0";
          };
          FabricLanguageKotlin = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/ViT4gucI/fabric-language-kotlin-1.13.9%2Bkotlin.2.3.10.jar";
            sha512 = "498672ee88cf703685026e74f82a85e30d980c62a1c8cc14744cb73add09a857db8d585b405e19f558ec490613642750eb00e09d8ef5a3c9578bc52b53568d51";
          };
          ScalableLux = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/Ps1zyz6x/versions/PV9KcrYQ/ScalableLux-0.1.6%2Bfabric.c25518a-all.jar";
            sha512 = "729515c1e75cf8d9cd704f12b3487ddb9664cf9928e7b85b12289c8fbbc7ed82d0211e1851375cbd5b385820b4fedbc3f617038fff5e30b302047b0937042ae7";
          };
          Carpet = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/HzPcczDK/fabric-carpet-1.21.11-1.4.194%2Bv251223.jar";
            sha512 = "1135807e44b34a628c89674a4df94d617120aea932c24c7d4a375410103884e94713b4252d29035d1722d149cc65465afef24eafbfc476c51bc64b6fffff57e0";
          };
          WorldEdit = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/1u6JkXh5/versions/o645q0Oo/worldedit-mod-7.4.0.jar";
            sha512 = "1ad3e994cd314e50e561281a77696107dbd7124fcec8e9e0c0d4043fa081840ef8087aaec99cacde6b6270ff283a8d3c7ea5c113558524468f8c58e5e13f9a4a";
          };
          Discord-Integration = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/rbJ7eS5V/versions/yGb7L3Am/dcintegration-fabric-MC1.21.11-3.1.0.2.jar";
            sha512 = "ebb5c6a7947eb02448cfde522d683181e81ef19af99bb20b4299347f0f966a4c0c14f5ca54dea3804f70925c289347267fa5c7efb9072922b025fbe2d3fbb24b";
          };
          Boids = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/2OckSy74/versions/TUt4OEVW/boids-2.0.0%2B1.21.11.jar";
            sha512 = "48d9650de0b43abbb5287a7f2a07dabb1956e5eb3f750b9130aa505da9ceafa2e174b6a756a40f0f5b478ec06de1dced91c73fcdc805ef55cc9573e5c644ab06";
          };
          Pl3xMap = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/34T8oVNY/versions/e7ry5uKb/Pl3xMap-1.21.11-540.jar";
            sha512 = "8ef090567dd9f1534f9c8c3ea271e4a60eca5d831212d3669af994b1582f0983ee804c3f782c1277c50f52b44ff2c94054b583430fba6d7d787a509cc31e62ea";
          };
          Camera-Obscura = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/RlBTYKIp/versions/dOH6U9gx/camera-obscura-1.2.2%2B1.21.11.jar";
            sha512 = "1750e1eeb3fc4f1f1d913b04425c42a14a854da5854436868edb20ce0b7502c4c4abe1d8e297f53750c076bc4edee103a07f0bb239b3da66c27f6d305015a902";
          };
          Nullscape = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/LPjGiSO4/versions/jFDyNQ0I/Nullscape_1.21.x_v1.2.16.jar";
            sha512 = "070b224e0c0946f28b330d9e11fc62230aee721619fced5085e277b3318a37497f061c22a2305b8aaea6cb9b99ecb603ac8320b57bd2c01dd7d1d2b636a46f45";
          };
          Incendium = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/BUigTHnK/Incendium_1.21.x_v5.4.10.jar";
            sha512 = "595d3f3cc0b037cd57506a9742fc85b7f980749ce2225c7e32e84801e6118362baa704e8291dc0267ee8e125a5c7309f2e148767fd3201a21ee901910b86c692";
          };
          Tectonic = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/7olSYFxL/tectonic-3.0.19-fabric-1.21.11.jar";
            sha512 = "ce0643d45aac7b5e3f3a32fc01928371d97612a9dc6e8df721bf215bf90afa021b8e8d7e19c0d00060c3c98591aec90d2ea51f594fdc0012051f20657fae85ef";
          };
          Terralith = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/TFW9ZxPQ/Terralith_1.21.x_v2.5.14.jar";
            sha512 = "98a1fea21ccbeacdc2572eca51d7f0d50a7bd41d1408b01eff8eb5eec1cd5c46ce90da589b0652d9e28dcb222abe35a3ce9709c6caab4e4185f9ee4706157c8e";
          };
        }
      );
    };
  };

  networking.firewall.allowedTCPPorts = [
    hcraft.server
  ];

  environment.persistence."/nix/persist".directories = [
    {
      directory = "/srv/minecraft/hcraft";
      user = "minecraft";
      group = "minecraft";
      mode = "u=rwx,g=rw,o=";
    }
  ];
}
