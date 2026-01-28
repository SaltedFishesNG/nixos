# base64decode.org

# bWFnbmV0Oj94dD11cm46YnRpaDpjZTg2MzA2YTQxN2RkNjRmYWI4ZDI2YTQ5ODNhNTg0MTIwMDhh
# YTllJmRuPWlkYTkyJnRyPWh0dHAlM0ElMkYlMkZ0cmFja2VyLm15d2FpZnUuYmVzdCUzQTY5Njkl
# MkZhbm5vdW5jZSZ0cj11ZHAlM0ElMkYlMkZ0cmFja2VyLnF1LmF4JTNBNjk2OSUyRmFubm91bmNl
# JnRyPWh0dHAlM0ElMkYlMkZ0cmFja2VyLnJlbmZlaS5uZXQlM0E4MDgwJTJGYW5ub3VuY2UmdHI9
# aHR0cHMlM0ElMkYlMkZ0cmFja2VyLmJqdXQuanAlM0E0NDMlMkZhbm5vdW5jZSZ0cj1odHRwJTNB
# JTJGJTJGZmxlaXJhLm5vJTNBNjk2OSUyRmFubm91bmNl

##############################################################################

# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/id/ida-free/package.nix

# Copyright (c) 2003-2026 Eelco Dolstra and the Nixpkgs/NixOS contributors
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
{
  autoPatchelfHook,
  cairo,
  dbus,
  requireFile,
  fontconfig,
  freetype,
  glib,
  gtk3,
  lib,
  libdrm,
  libGL,
  libkrb5,
  libsecret,
  libunwind,
  libxkbcommon,
  makeWrapper,
  openssl,
  stdenv,
  xorg,
  zlib,
}:
stdenv.mkDerivation (finalAttrs: rec {
  pname = "ida-pro";
  version = "9.2";

  srcs = [
    (requireFile {
      name = "ida-pro_92_x64linux.run";
      url = "https://hex-rays.com/";
      hash = "sha256-qt0PiulyuE+U8ql0g0q/FhnzvZM7O02CdfnFAAjQWuE=";
    })
    (requireFile {
      name = "libida.so";
      url = "https://hex-rays.com/";
      sha256 = "sha256-LZr8z/i8fro4oD7yo6nRK2wK89a2NzpYkAgaIZv+BOk=";
    })
    (requireFile {
      name = "idapro.hexlic";
      url = "https://hex-rays.com/";
      sha256 = "sha256-5keOpggeMmd2yZ0GCWjI8JDf9nfMKF6Lv8bgFjZsSlo=";
    })
  ];
  dontUnpack = true;

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
  ];

  # Add everything to the RPATH, in case IDA decides to dlopen things.
  runtimeDependencies = [
    cairo
    dbus
    fontconfig
    freetype
    glib
    gtk3
    libdrm
    libGL
    libkrb5
    libsecret
    libunwind
    libxkbcommon
    openssl
    stdenv.cc.cc
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXau
    xorg.libxcb
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    xorg.xcbutilcursor
    zlib
  ];
  buildInputs = runtimeDependencies;

  # IDA comes with its own Qt6, some dependencies are missing in the installer.
  autoPatchelfIgnoreMissingDeps = [
    "libQt6Network.so.6"
    "libQt6EglFSDeviceIntegration.so.6"
    "libQt6WaylandEglClientHwIntegration.so.6"
    "libQt6WlShellIntegration.so.6"
    "libQt6WaylandCompositor.so.6"
  ];

  installPhase = ''
    runHook preInstall

    # IDA depends on quite some things extracted by the runfile, so first extract everything
    # into $out/opt, then remove the unnecessary files and directories.
    IDADIR=$out/opt/${finalAttrs.pname}-${finalAttrs.version}
    mkdir -p $out/bin $out/lib $IDADIR

    # The installer doesn't honor `--prefix` in all places,
    # thus needing to set `HOME` here.
    HOME=$out

    # Invoke the installer with the dynamic loader directly, avoiding the need
    # to copy it to fix permissions and patch the executable.
    $(cat $NIX_CC/nix-support/dynamic-linker) ${builtins.elemAt finalAttrs.srcs 0} \
      --mode unattended --prefix $IDADIR
    cp ${builtins.elemAt finalAttrs.srcs 1} $IDADIR/libida.so
    cp ${builtins.elemAt finalAttrs.srcs 2} $IDADIR/idapro.hexlic

    # Some libraries come with the installer.
    addAutoPatchelfSearchPath $IDADIR

    # Wrap the ida executable to set QT_PLUGIN_PATH
    wrapProgram $IDADIR/ida --prefix QT_PLUGIN_PATH : $IDADIR/plugins/platforms
    ln -s $IDADIR/ida $out/bin/ida

    # runtimeDependencies don't get added to non-executables, and openssl is needed
    # for cloud decompilation
    patchelf --add-needed libcrypto.so $IDADIR/libida.so

    mv $out/.local/share $out
    rm -r $out/.local

    runHook postInstall
  '';

  meta = {
    homepage = "https://hex-rays.com/";
    mainProgram = "ida";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
})
