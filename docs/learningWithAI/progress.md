---
marp: true
---

# Week 4

## Description

busy

---

# Week 5

## Description

busy

---

# Week 6

## Description

busy

---

# Week 7

## Introduction

3 pieces to a terminal

- terminal emulator
  - only handles text, input, colors, and scrolling
  - does not know what the commands mean
- Shell
  - reads and interprets the command given
- Operating System (Kernal)
  - The shell asks the OS to:
    - create processes, allocate memory, access files, and communicate with hardware
---

## Introduction (cont.)

Main operation loop: Input -> Interpret -> Execute -> Output

The terminal is very powerful because:
- All the commands give you precise control over the computer
- You can create scripts to automate processes
- Having no UI increases the speed
- Have access to SSH
This is where the terminal excells over gui's

---

## How Shells Parse Commands

The shell does not just split the command by spaces, it goes through multiple more phases:
1. Lexing or Tokenization
   1. tokens are separated by spaces, recognizes special characters, recognizes quotes

---

## How Shells Parse Commands (cont.)

2. Parsing
   1. In this step a syntax tree is made
   2. The grammer is seen as:
      1. command, pipeline, redirect, conditional execution, subshells
      2. ex:
        `
        redirect(
            pipeline(
                command(echo, $HOME),
                command(grep, user)
            ),
            out.txt
        )
        `
      3. This Structure is referred to an Abstract Syntax Tree

---

## How Shells Parse Commands (cont.)

3. Expansions
   1. The shell performs expansions before it executes in this order:
      1. brace expansion: `echo file{1..3}` -> echos files 1 - 3
      2. Tilde expansion: `echo ~` -> echo /home/you
      3. parameter expansion: `echo $HOME` -> echos the HOME variable
      4. command substitution: `echo $(date)` -> echos the result of the command date
      5. arithmetic expansion: `echo $((2 + 3))` -> echos 5
      6. Word Splitting: Splits words by spaces, unless quoted
      7. globbing, or filename expansion: `echo *.txt` echos all files that end in .txt
---

## How Shells Parse Commands (cont.) 

4. Redirections
   1. Before execution, the shell sets up file descriptors
5. Execution
   1. decides whether the command is a function, built-in, or external
   2. runs