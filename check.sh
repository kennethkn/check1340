#!/usr/bin/env bash

# Author: kennethkn
# Last updated: 2023-04-15

# Description:
# - Run all test cases available for a problem with a single command.
# - For ENGG1340/COMP2113 students (22-23 semester 2).

# Usage: ./check.sh [-v]
# -v  OPTIONAL. Show the output of diff.

# IMPORTANT: If the problem uses arguments for input, please enter the arguments for each test case below.
# (If you got an error about missing arguments, here's where you fix it)
args=(
    # "test case 1 arguments"
    # "test case 2 arguments"
    # ...
    #
    # ASM2 Q2 Preset (Uncomment the below to use)
    # "abc t1.txt t2.txt t3.txt"
    # "ab t1.txt t2.txt t3.txt"
    # "he t3.txt t4.txt t5.txt"
)

# DO NOT EDIT ANYTHING BELOW

main() {
    if [[ $# -gt 1 || ($# == 1 && $1 != -v) ]]; then
        echo Usage: ./check.sh [-v]
        exit 1
    fi
    if ls -- *.c >/dev/null 2>&1; then
        ext=c
        compiler_var=CC
        flags_var=CFLAGS
        compiler=gcc
        std=c11
    elif ls -- *.cpp >/dev/null 2>&1; then
        ext=cpp
        compiler_var=CXX
        flags_var=CXXFLAGS
        compiler=g++
        std=c++11
    else
        echo Error: no .c or .cpp file found in the current directory. Wrong directory?
        exit 1
    fi

    # Verbose mode
    if [[ $1 == -v ]]; then vb=true; else vb=false; fi

    # Makefile generation & initialize $target for later use
    src_arr=(*."$ext")
    if [[ ${#src_arr[@]} == 1 ]]; then
        src="${src_arr[*]}"
        target=${src%."$ext"}
        echo "$compiler_var = $compiler
$flags_var = -pedantic-errors -std=$std

$target: $src
	\$($compiler_var) \$($flags_var) -o \$@ \$<

.PHONY: clean
clean:
	rm -f $target" >Makefile
    else
        src="${src_arr[*]}"
        src=${src//.$ext/.o}
        main_cpp=$(echo main*.$ext)
        target=${main_cpp%."$ext"}
        echo "$compiler_var = $compiler
$flags_var = -pedantic-errors -std=$std

$target: $src
	\$($compiler_var) \$($flags_var) -o \$@ \$^

.PHONY: clean
clean:
	rm -f $target *.o" >Makefile
    fi

    # Remake everything
    make clean
    make "$target" || {
        echo "Error: compilation failed. Script aborting..."
        exit 1
    }

    # Checking
    if ! ls input*.txt >/dev/null 2>&1; then
        if [[ ${#args[@]} == 0 ]]; then
            echo Error: no argument provided for "$target". Please copy input arguments from the test cases to this script.
            exit 1
        fi
        if [[ $vb == true ]]; then seperator; fi
        arg_mode__check "$target" $vb
    else
        if [[ $vb == true ]]; then seperator; fi
        stdin_mode__check "$target" $vb
    fi
}

# If input is via stdin
stdin_mode__check() {
    for i in input*.txt; do
        ./"$target" <"$i" >myoutput.txt
        id=${i/input/}
        dif=$(diff myoutput.txt "output$id")
        id=${id/.txt/}
        if [[ -z $dif ]]; then echo "check$id: passed"; else echo "check$id: failed"; fi
        if [[ $vb == true ]]; then
            echo
            echo "output of diff:"
            if [[ -z $dif ]]; then echo "(empty)"; else echo "$dif"; fi
            seperator
        fi
        rm -f myoutput.txt
    done
}

# If input is via arguments
# Run when no input file (e.g., input1_1.txt) is found
arg_mode__check() {
    target=$1
    vb=$2
    idx=0
    for i in "${args[@]}"; do
        # Do NOT add quotes around $i as it causes multiple arguments to be passed as one
        ./"$target" $i >myoutput.txt
        ((idx++))
        id=2_$idx.txt
        dif=$(diff myoutput.txt "output$id")
        id=${id/.txt/}
        if [[ -z $dif ]]; then echo "check$id: passed"; else echo "check$id: failed"; fi
        if [[ $vb == true ]]; then
            echo
            echo "output of diff:"
            if [[ -z $dif ]]; then echo "(empty)"; else echo "$dif"; fi
            seperator
        fi
        rm -f myoutput.txt
    done
}

seperator() {
    echo
    echo "========="
    echo
}

main "$@"
