#!/usr/bin/env bash

BOOKMARKFN=$HOME/.config/bash/apps/bookmarks

# list available bookmarks
function list() {
    if [ -f "$BOOKMARKFN" ]; then
        cat $BOOKMARKFN
    fi
}

# goto bookmark
function gobm() {
    [ -z "$1" ] && echo "please specify a bookmark" 
    if [ -f "$BOOKMARKFN" ]; then
        while IFS= read -r line
        do
            CURBM=$(echo $line | awk '{print $1}')
            CURPATH=$(echo $line | awk '{print $2}')
            if [ "$1" == "$CURBM" ]; then
                cd $CURPATH 
                return 0
            fi
        done < "$BOOKMARKFN"
    fi 
    echo "bookmark $1 not set"
}

# create a new bookmark
function bookmark() {
    [ -z "$1" ] && echo "please specify a bookmark"
    CURPATH=$(pwd)
    if [ ! -f "$BOOKMARKFN" ]; then
        touch $BOOKMARKFN
    fi
    # remove if bookmark already exist
    sed -i "/$1/d" $BOOKMARKFN
    echo "$1 $CURPATH" >> $BOOKMARKFN
}

# delete a bookmark
function delbm() {
    [ -z "$1" ] && echo "please sepcify a bookmark"
    if [ -f "$BOOKMARKFN" ]; then
        sed -i "/$1/d" $BOOKMARKFN
    fi
}
