#!/usr/bin/env sh
set -euo pipefail
stow .
installdir=$PWD/..
cd $installdir
echo "installing at: $installdir"
plugdir=$installdir/plugins

[ ! -f paperclip.jar ] && curl -o paperclip.jar "https://papermc.io/api/v1/paper/1.16.5/latest/download"
echo "eula=true" > eula.txt
[ ! -d $plugdir ] && mkdir $plugdir
cd $plugdir && pwd
[ ! -f $plugdir/LuckPerms.jar ] && curl -o $plugdir/LuckPerms.jar "https://ci.lucko.me/job/LuckPerms/1281/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.2.115.jar"
[ ! -f $plugdir/Vault.jar ] && wget -O $plugdir/Vault.jar "https://github.com/MilkBowl/Vault/releases/download/1.7.3/Vault.jar"
[ ! "$(echo EssentialsX*)" != 'EssentialsX*' ] && git clone https://github.com/EssentialsX/essentials.git \
    && cd $plugdir/essentials && ./gradlew build \
    && mv jars/* .. && cd $plugdir && rm -rf essentials && rm EssentialsXXMP* EssentialsXGeoIP*
