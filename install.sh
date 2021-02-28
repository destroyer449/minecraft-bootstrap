#!/usr/bin/env sh
set -euo pipefail
stow .
installdir=$PWD/..
cd $installdir
echo "installing at: $installdir"
plugdir=$installdir/plugins

# Install newest verison of paper
[ ! -f paperclip.jar ] && curl -o paperclip.jar "https://papermc.io/api/v1/paper/1.16.5/latest/download"
#
# Allow paper to run by agreeing to EULA
echo "eula=true" > eula.txt

# Installing plugins
[ ! -d $plugdir ] && mkdir $plugdir
cd $plugdir

# Plugins to install from SpiGet
# Each line specifies the plugin to download, in the format:
# NAME RESOURCE_NUMBER
# Resource numbers can be found from searching spiget, or in the spigot url for the plugin
# TODO Handling files in forms other than *.jar
# TODO Support BukGet
PKGS=(
    "Plugman 88135"
    "LuckPerms 28140"
    "Vault 34315"
    "Dynmap 274"
    "Dynmap-structures 39534"
    "LiveAtlas 86939"
    "FastChunkPregenerator 74429"

)

# TODO Optional build steps
for PKG in "${PKGS[@]}"; do
    [ ! -f $plugdir/"${PKG%% *}".jar ] && wget -O "${PKG%% *}".jar http://api.spiget.org/v2/resources/"${PKG##* }"/download
done

[ ! "$(echo EssentialsX*)" != 'EssentialsX*' ] && git clone https://github.com/EssentialsX/essentials.git \
    && cd $plugdir/essentials && ./gradlew build \
    && mv jars/* .. && cd $plugdir && rm -rf essentials && rm EssentialsXXMP* EssentialsXGeoIP*
