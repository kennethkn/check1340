#!/usr/bin/env bash

for target in A*_Files/Q*; do
    case $target in
    A1_Files/Q1) ;;
    *)
        cp check.sh "$target"
        ;;
    esac
done
