{
  inputs,
  pkgs,
  config,
  ...
}:
let
  shhh = builtins.toString inputs.shhh;
  obamnacraft = inputs.shhh.services.minecraft.obamnacraft;
  obamnafile = builtins.toString inputs.randomshit;
  forgeServers = pkgs.callPackage ./forge-servers { };
in
{
  services.minecraft-servers.servers."obamnacraft" = {
    enable = true;
    package = forgeServers.forge-1_20_1.override {
      loaderVersion = "47.3.12";
      jre_headless = pkgs.graalvmPackages.graalvm-oracle_17;
    };
    jvmOpts = "-Xms8G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=130 -XX:ConcGCThreads=2 -XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=3 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs/ -XX:UseAVX=3 -XX:+UseStringDeduplication -XX:+UseFastUnorderedTimeStamps -XX:+UseAES -XX:+UseFMA -XX:+UseAESIntrinsics -XX:UseSSE=4 -XX:AllocatePrefetchStyle=1 -XX:+UseLoopPredicate -XX:+RangeCheckElimination -XX:+EliminateLocks -XX:+DoEscapeAnalysis -XX:+UseCodeCacheFlushing -XX:+UseFastJNIAccessors -XX:+OptimizeStringConcat -XX:+UseCompressedOops -XX:+UseThreadPriorities -XX:+OmitStackTraceInFastThrow -XX:+TrustFinalNonStaticFields -XX:ThreadPriorityPolicy=1 -XX:+UseInlineCaches -XX:+RewriteBytecodes -XX:+RewriteFrequentPairs -XX:+UseNUMA -XX:-DontCompileHugeMethods -XX:+UseCMoveUnconditionally -XX:+UseFPUForSpilling -XX:+UseNewLongLShift -XX:+UseVectorCmov -XX:+UseXMMForArrayCopy -XX:+UseXmmI2D -XX:+UseXmmI2F -XX:+UseXmmLoadAndClearUpper -XX:+UseXmmRegToRegMoveAll -Dgraal.TuneInlinerExploration=1 -Dgraal.CompilerConfiguration=enterprise -Dgraal.UsePriorityInlining=true -Dgraal.Vectorization=true -Dgraal.OptDuplication=true -Dgraal.DetectInvertedLoopsAsCounted=true -Dgraal.LoopInversion=true -Dgraal.VectorizeHashes=true -Dgraal.EnterprisePartialUnroll=true -Dgraal.VectorizeSIMD=true -Dgraal.StripMineNonCountedLoops=true -Dgraal.SpeculativeGuardMovement=true -Dgraal.InfeasiblePathCorrelation=true -DPlazma.disableConfigOptimization -Dfile.encoding=UTF-8 -Xlog:async -Djava.security.egd=file:/dev/urandom --add-modules=jdk.incubator.vector";
    serverProperties = {
      server-port = obamnacraft.server;
      broadcast-console-to-ops = true;
      broadcast-rcon-to-ops = true;
      difficulty = 3;
      enable-rcon = true;
      "rcon.password" = obamnacraft.rcon.password;
      "rcon.port" = obamnacraft.rcon.port;
      enforce-whitelist = true;
      motd = "only goobing allowed in obamnacraft";
    };
    files = {
      "server-icon.png" = "${obamnafile}/obamna/server_icon.png";
      "config/Discord-Integration.toml" = config.sops.secrets."Discord-Integration-obamna.toml".path;
      "mods/dcintegration.jar" = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/rbJ7eS5V/versions/ILJrSvYW/dcintegration-forge-3.0.7.1-1.20.1.jar";
        sha512 = "a4bcef59ff48059595fbcb50891b4561db8fdfe6e30ad4a6277eb0506bac519a3d69431aa691969d8894b93e5dc055b94cb0a9c09a1e3066eb5cbde411d2e483";
      };
    };
    whitelist = obamnacraft.whitelist;
    operators = obamnacraft.ops;
    autoStart = false;
    restart = "no";
  };

  networking.firewall.allowedTCPPorts = [
    obamnacraft.server
  ];

  sops.secrets."Discord-Integration-obamna.toml" = {
    sopsFile = "${shhh}/mc-configs/obamna/Discord-Integration.toml";
    format = "binary";
    owner = "minecraft";
  };

  environment.persistence."/nix/persist".directories = [
    {
      directory = "/srv/minecraft/obamnacraft";
      user = "minecraft";
      group = "minecraft";
      mode = "u=rwx,g=rw,o=";
    }
  ];
}
