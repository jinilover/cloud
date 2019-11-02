{ compiler ? "ghc865" }:

let
  bootstrap = import <nixpkgs> {};
  nixpkgs = builtins.fromJSON (builtins.readFile ./nixpkgs.json);
  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };
  pkgs = import src {};
  f = import ./default.nix;
  packageSet = pkgs.haskell.packages.${compiler};
  hspkgs = 
      packageSet.override {
        overrides = (self: super: {
          amazonka = pkgs.haskell.lib.doJailbreak super.amazonka;
          amazonka-core = pkgs.haskell.lib.doJailbreak super.amazonka-core;
          bloodhound = pkgs.haskell.lib.doJailbreak super.bloodhound;
          katip-elasticsearch = pkgs.haskell.lib.dontCheck super.katip-elasticsearch;
          ghc = super.ghc // { withPackages = super.ghc.withHoogle; };
          ghcWithPackages = self.ghc.withPackages;
        });
      };
  drv = hspkgs.callPackage f {};
in
  if pkgs.lib.inNixShell then drv.env else drv
