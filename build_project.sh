#!/bin/bash
# © 2013–2025 Matthias Peters (Masmblr)
# EDGE Modification for Tremulous GPP (1.2) build-script.

DIR=$(pwd)
OUTDIR="build"
TMP="$OUTDIR/tmp"
MODDIR="$OUTDIR/Tremulous/edge"
VERSION=$(<version)

echo -e "\e[0;36m -----------------------------------------------------------------------------------"
echo "EDGE Modification $VERSION"
echo "-----------------------------------------------------------------------------------"
echo -e "\e[0;36m Cleanup.."
rm -rf "$OUTDIR"
make clean
mkdir -p "$OUTDIR"
mkdir -p "$OUTDIR/Tremulous/base"
echo -e "\n Compiling.."
make release BUILD_SERVER=1 BUILD_GAME_QVM=1 BUILD_STANDALONE=1  > /dev/null 2>&1 -j$(nproc) || {
	echo -e "\e[0;31m Build failed..."
    exit 1
}
echo -e "\nPacking.."
mkdir -p "$MODDIR"
mkdir -p "$TMP/vm"
rsync -a assets/ "$TMP"
find "$OUTDIR"/release-*/base/vm/ -type f -name '*.qvm' -exec cp -v {} "$TMP/vm" \;
cd "$TMP"
zip -q -r "../../$MODDIR/edgemod_${VERSION}.pk3" .
cd -
find "$OUTDIR"/release-*/ -type f \( -name 'tremded*' -o -name 'tremulous*' \) -exec cp -v {} "$OUTDIR/Tremulous" \;
rsync -av misc/edge/ "$OUTDIR/Tremulous/"
rm -r "$TMP"
rm -rf "$OUTDIR"/release-*
echo -e "\e[0;36m -----------------------------------------------------------------------------------"
