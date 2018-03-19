#!/bin/bash -e

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

trap "rm -rf ~/.emacs.d/" EXIT

if [ "$USER" == "vagrant" ]; then
    dir=/vagrant
else
    dir="$PWD"
fi

pwd=`pwd`

if ! test -e /usr/local/bin/emacs; then
    {
        >&2 echo "--- installing deps ---"
        sudo apt-get update
        sudo apt-get -y install build-essential wget git mercurial
        sudo apt-get -y build-dep emacs23
        wget http://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.gz -O- | tar xz
        cd emacs-25.3
        >&2 echo "--- building emacs ---"
        ./configure &&\
            make &&\
            sudo make install
        sudo apt-get install -y -qq git
    } > /dev/null
fi

echo "--- running tests ---"

emacs --batch --eval "(setq travis-ci-dir \"$dir\")" --load $dir/ci/.emacs
rm -rf ~/.emacs.d/
