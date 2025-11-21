# For use with Proxmark3 Easy
{
  stdenv,
  fetchFromGitHub,
  gcc-arm-embedded,
  pkg-config,
  bzip2,
  lz4,
  openssl,
  readline,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "proxmark3";
  version = "4.20728";
  src = fetchFromGitHub {
    owner = "RfidResearchGroup";
    repo = "proxmark3";
    rev = "v${finalAttrs.version}";
    hash = "sha256-dmWPi5xOcXXdvUc45keXGUNhYmQEzAHbKexpDOwIHhE=";
  };
  nativeBuildInputs = [
    gcc-arm-embedded
    pkg-config
  ];
  buildInputs = [
    bzip2
    lz4
    openssl
    readline
  ];
  makeFlags = [
    "all"
    "PLATFORM=PM3GENERIC"
    "PREFIX=${placeholder "out"}"
    "UDEV_PREFIX=${placeholder "out"}/etc/udev/rules.d"
    "USE_BREW=0"
  ];
  enableParallelBuilding = true;
  doInstallCheck = true;
})
