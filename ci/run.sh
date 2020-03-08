#!/bin/bash -e

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

trap "rm -rf ~/.emacs.d/" EXIT

dir="$PWD"

echo "--- running tests ---"

${EMACS} --batch --eval "(defvar top-dir \"$dir\")" --load $dir/ci/.emacs
rm -rf ~/.emacs.d/
