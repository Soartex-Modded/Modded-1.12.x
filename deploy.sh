set -x

PACK_VERSION=$TRAVIS_TAG

[[ -z $PACK_VERSION ]] && exit

SUFFIX=-$PACK_VERSION
DISPLAY_NAME=Soartex-Universal$SUFFIX
RELEASE_FILE=$DISPLAY_NAME.zip

PROJECTID=227770

VERSION_DATA=$(curl -X GET "https://minecraft.curseforge.com/api/game/versions" -H "X-Api-Token: $CURSEFORGE_INVICTUS_TOKEN")
#GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.7")) and (.gameVersionTypeID==5)) | .id]' <<< "$VERSION_DATA")
#GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.8")) and (.gameVersionTypeID==4)) | .id]' <<< "$VERSION_DATA")
#GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.10")) and (.gameVersionTypeID==572)) | .id]' <<< "$VERSION_DATA")
#GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.11")) and (.gameVersionTypeID==599)) | .id]' <<< "$VERSION_DATA")
GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.12")) and (.gameVersionTypeID==628)) | .id]' <<< "$VERSION_DATA")
#GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.15")) and (.gameVersionTypeID==68722)) | .id]' <<< "$VERSION_DATA")
#GAME_IDS=$(jq -rc '[.[] | select((.name | startswith("1.16")) and (.gameVersionTypeID==70886)) | .id]' <<< "$VERSION_DATA")

mkdir -p release
cp

zip -r "$RELEASE_FILE" .  -x "*/\__MACOSX" -x "\.*" -x "build.sh" -x "releases/*" -x "token.txt" -x "run_build.sh"

curl -X POST -H "X-Api-Token: $CURSEFORGE_INVICTUS_TOKEN" -F metadata="{\"changelog\":\"https://github.com/Soartex-Modded/Modded-1.12.x/commits/master\",\"changelogType\":\"text\",\"displayName\":\"$DISPLAY_NAME\",\"gameVersions\":$GAME_IDS,\"releaseType\":\"release\"}" -F file=@"$RELEASE_FILE" "https://minecraft.curseforge.com/api/projects/$PROJECTID/upload-file"