---
marp: true
---

## AI DOC

### Topics:

- Learning the behind the scenes of the command line
- Game design principles

---

# The Command Line

---

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

---

# Game Design

---

Game design compiles psychology, storytelling, art, and systems thinking to engage players. Create a meaningful experience for the player.

---

## Principles

1. Player-Centered Design
   1. How should the player feel
   2. Is the game intuitive/confusing
   3. Is it fun/frustrating
   4. Playtesting is important
2. Create a Core Gameplay Loop
   1. Example: Action → Reward → Upgrade → Repeat
   2. Good loops keep players engaged
      1. simple, but fun to repeat

---

3. Balance
   1. An unfair game does not feel fun
   2. There is a difference between difficulty and unfairness
   3. Too easy created boredome
   4. Flow is a psychology concept about keeping players in between boredom frustration
4. Clear goals and Feedback
   1. It is important for a player to know what they can and should be doing
      1. How well they are doing
   2. Some Feedback examples are
      1. sound effects
      2. visual cues
      3. progress indicators

---

5. Meaningful choices
   1. trade-offs - gain one thing, lose another
   2. multiple strategies
   3. choices that affect the outcome

---

6. Progression and rewards
   1. Examples: Levels, skills, upgrades, better gear, narrative progression
7. simplicity
   1. easy to learn, but still has depth
8. Immersive
   1. cohesive theming

---

## Game Design tips I received:
1. Be wary of the user having to repeat commands
   1. This can become tedious to have to retype, especially if the command is fairly long
   2. Some solutions:  
      1. Scripts/Macros/Aliases to shorten user input. Also command history
      2. Make commands more expressive so that players have to think about them more
      3. Pressure: Enemies continue to move and mistyping a command can have consequences

---

2. Make the learning of the language feel like mastery of it
3. Reward for creative use of commands
4. Good Feedback
   1. Make sure to have visual and/or audible feeback
5. Add Variant loops
   1. Combat that focuses on fast decisions
   2. Exploration
   3. Puzzles
   4. Have reasource management

---

6. Make sure the story/narrative has reason for the command line
7. Decide whether the game should be fast or slow paced
8. Suggestion given: command chaining. Not sure if applicaple now, but may be interesting in the future.
   
---

## I asked about a way to make the combat to be more interesting:
1. change commands from move foreword or attack to dash foreword, lunge goblin, circle enemy, retreat west, guard
   1. decrease typing and increase meaning
2. Intent based combat 
   1. decision making instead of just typing fast

---

3. commands should persist, not be one off
   1. define behavior
   2. have commands last for a duration
   3. otherwise players will spam
4. Cooldown/commitment
5. Enemies should demand different commands to defeat

---