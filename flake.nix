{
  description = "spitfire";

  inputs = {
    beam-flakes.url = "github:shanesveller/nix-beam-flakes";
    beam-flakes.inputs.flake-parts.follows = "flake-parts";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs @ {
    beam-flakes,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [beam-flakes.flakeModule];

      systems = ["aarch64-darwin" "x86_64-darwin" "x86_64-linux"];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        beamWorkspace = {
          enable = true;
          devShell.languageServers.elixir = false;
          devShell.languageServers.erlang = false;
          flakePackages = true;
          versions = {
            elixir = "1.16.1";
            erlang = "26.2.2";
          };
        };
      };
    };
}

