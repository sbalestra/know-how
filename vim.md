# Vim

## Basic editing

Delete a word:   
`diw` (inner word)  
`daw` (a/around word)

Delete a word and immediately change to insert mode:

    ciw

Delete something in parentheses:  
`di)` (without the parentheses)  
`da)` (including the parentheses)  
(works for different kinds of brackets and quotation marks)

Can be used on nested pairs of parentheses also:
`d2a)`
`2da)` (what is the difference?)

## Navigating

### Navigating between lines

Set a mark (e.g. named x):

    mx

Jump to a mark (e.g. named x):

    'a

### Navigating on the same line

Next word:

    w

Previous word:

    b

Beginning of first word:

    ^

Before the first word:

    0

## Entering insert mode

### Big movements

At end of line:

    A

At the beginning of the first word:

    I


### Small movements

Before (at) cursor:

    i

After cursor:

    a

At the end of the current word:

    ea



## Changing how the editor works

### Break lines

Automatic line break after a number of characters (e.g. for git commit messages):  
`:set textwidth=72` (from http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html )

### Change the language of syntax highlighting

For Markdown:  

    :set syntax=markdown
