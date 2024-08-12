{
  stdenv
  , pkgs
  , fetchzip
  , lib
}:

let
  owner = "structurizr";
  repo = "cli";
in

stdenv.mkDerivation rec {
  pname = "structurizr-cli";
  version = "2024.07.03";

  src = fetchzip {
    url = "https://github.com/${owner}/${repo}/releases/download/v${version}/${pname}.zip";
    sha256 = "sha256-DFwxYaVft4t+UKZHGSCV/8HAd/FpT1kkQhzAnFMH4sM=";
    stripRoot = false;
  };

  nativeBuildInputs = with pkgs; [makeBinaryWrapper];

  buildInputs = with pkgs; [jdk22_headless];

  installPhase = ''
    mkdir -p $out/bin
    makeBinaryWrapper $src/structurizr.sh $out/bin/structurizr
    cp -r $src/lib $out/bin/lib
  '';

  meta = with lib; {
    description = "Structurizr CLI for working with Structurizr models";
    homepage = "https://github.com/structurizr/cli";
    license = licenses.asl20;
    maintainers = [ maintainer.eelco ];
    platforms = platforms.all;
  };
}
