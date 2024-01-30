#! /bin/sh

if [ -z $(which alt-ergo) ]; then echo "Prover Alt-Ergo is missing"; exit 1; fi
if [ -z $(which cvc4) ]; then echo "Prover CVC4 is missing"; exit 2; fi

export ALTERGO_VERSION=$(why3 config list-provers | grep -e "Alt-Ergo" | head -n 1 | sed "s/Alt-Ergo //")
echo Alt-Ergo version $ALTERGO_VERSION
export CVC4_VERSION=$(why3 config list-provers | grep -e "CVC4" | head -n 1 | sed "s/CVC4 //")
echo CVC4 version $CVC4_VERSION

cat config/strategy.conf.generic | sed "s/ALTERGO_VERSION/$ALTERGO_VERSION/" | sed "s/CVC4_VERSION/$CVC4_VERSION/" > strategy.conf