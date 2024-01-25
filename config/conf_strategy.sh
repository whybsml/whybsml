#! /bin/sh

export ALTERGO_VERSION=$(why3 config list-provers | grep -e "Alt-Ergo" | head -n 1 | sed "s/Alt-Ergo //")
export CVC4_VERSION=$(why3 config list-provers | grep -e "CVC4" | head -n 1 | sed "s/CVC4 //")
cat config/strategy.conf.generic | sed "s/ALTERGO_VERSION/$ALTERGO_VERSION/" | sed "s/CVC4_VERSION/$CVC4_VERSION/" > strategy.conf
    