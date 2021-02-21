#!/usr/bin/env sh
set -euo pipefail
stow .
cd ..

[ ! -f paperclip.jar ] && curl -o paperclip.jar "https://papermc.io/api/v1/paper/1.16.5/latest/download"
echo "eula=true" > eula.txt
[ ! -d plugins ] && mkdir plugins
cd plugins
[ ! -f LuckPerms.jar ] && curl -o LuckPerms.jar "https://ci.lucko.me/job/LuckPerms/1281/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.2.115.jar" \
    && mkdir LuckPerms
[ ! -f Vault.jar ] && wget "https://github.com/MilkBowl/Vault/releases/download/1.7.3/Vault.jar"
[ ! "$(echo EssentialsX*)" != 'EssentialsX*' ] && git clone https://github.com/EssentialsX/essentials.git \
    && cd essentials && ./gradlew build \
    && mv jars/* .. && cd .. && rm -rf essentials && rm EssentialsXXMP* EssentialsXGeoIP*
