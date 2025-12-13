# Copyright (c) 2003-2025 Eelco Dolstra and the Nixpkgs/NixOS contributors
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/tools/security/proxmark3/default.nix

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
