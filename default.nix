{ mkDerivation, amazonka, amazonka-core, amazonka-ec2
, amazonka-opsworks, base, stdenv
}:
mkDerivation {
  pname = "cloud";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    amazonka amazonka-core amazonka-ec2 amazonka-opsworks base
  ];
  executableHaskellDepends = [ base ];
  doHaddock = false;
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
