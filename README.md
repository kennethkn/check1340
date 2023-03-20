# :star2: check1340

Automated tool for checking ENGG1340/COMP2113 assignment solutions against test cases

## :rocket: Quick Overview

* Designed for ENGG1340/COMP2113 (Class of 2026)
* Checks your answers against assignment test cases
* Tested up to ASM2
* Feel free to contribute

## :hammer_and_wrench: Requirement

The bash shell (duh)
  
> Tested to work on `GNU bash, version 5.2.15(1)-release (aarch64-apple-darwin22.1.0)`
>
> May or may not work on older versions of bash

## :zap: Setup

1. Download `check.sh` `sync.sh` and put them in a folder containing all assignments, as demostrated below:

   ```text
   your-asm-folder
   ├── A1_Files
   │   ├── Q1
   │   ├── Q2
   │   └── Q3
   ├── A2_Files
   │   ├── Q1
   │   ├── Q2
   │   └── Q3
   ├── check.sh
   └── sync.sh
   ```

   Using `curl` (navigate to your assignment folder first):

   ```bash
   curl -o check.sh https://raw.githubusercontent.com/kennethkn/check1340/main/check.sh
   curl -o sync.sh https://raw.githubusercontent.com/kennethkn/check1340/main/sync.sh
   ```

2. Grant permissions with:

   ```bash
   chmod u+x check.sh
   chmod u+x sync.sh
   ```

3. Run `sync.sh` to deploy `check.sh` to all valid subfolders:

    ```bash
    ./sync.sh
    ```

4. For programs that use arguments for input, enter the arguments for each test case accordingly in `check.sh`, as demostrated below:

   ```bash
   args=(
       "abc t1.txt t2.txt t3.txt"   # arguments for test case 1
       "ab t1.txt t2.txt t3.txt"    # arguments for test case 2
       "he t3.txt t4.txt t5.txt"    # arguments for test case 3
       ...
   )
   ```

## :computer: Usage

```bash
./check.sh [-v]

-v  OPTIONAL. Show the output of diff.
```

## :handshake: Contributing

Contributions to this script are welcome. If you find any bugs or have suggestions for improvement, please feel free to create a pull request.

 *p.s. I finally have a repo on my account, yay!*
