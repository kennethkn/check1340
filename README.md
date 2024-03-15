# check1340

Run all test cases available for a problem with a single command. For ENGG1340/COMP2113 students (22-23 semester 2).

Avoid the hassle of running each test case one by one and comparing the output with the expected output. This script does it all for you.

## Prerequisite

Any shell

> Tested to work on `zsh 5.9 (x86_64-apple-darwin23.0)`
>
> Should work on bash shell too

## Setup

1. Download `check.sh` `sync.sh` and put them in the folder containing all your assignments. The folder structure should look like this:

   ```text
   folder-containing-all-assignments
   ├── A1_files
   │   ├── Q1
   │   ├── Q2
   │   └── Q3
   ├── A2_files
   │   ├── Q1
   │   ├── Q2
   │   └── Q3
   ├── A3_files
   │   ├── Q1
   │   └── Q2
   ├── check.sh <- here
   └── sync.sh <- here
   ```

   Via `curl` (navigate to folder-containing-all-assignments first):

   ```bash
   curl -o check.sh https://raw.githubusercontent.com/kennethkn/check1340/main/check.sh
   curl -o sync.sh https://raw.githubusercontent.com/kennethkn/check1340/main/sync.sh
   ```

2. Grant permissions with:

   ```bash
   chmod u+x check.sh
   chmod u+x sync.sh
   ```

3. Run `sync.sh` to deploy `check.sh` to every problem folder

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

## Usage

```bash
./check.sh [-v]

-v  OPTIONAL. Show the output of diff.
```

## Contributing

Feel free to contribute by opening an issue or a pull request.

 *Fun fact: This is my first ever repo!*
