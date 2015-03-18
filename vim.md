# Vim cheat sheet

## Basic editing

(Well, maybe not so basic if you are completely new to Vim... Vim has also a nice tutorial which can be started using `vimtutor`)

Delete a word:   
`diw` (inner word)  
`daw` (a/around word)

Delete a word and immediately change to insert mode:  
`ciw`

Delete something in parentheses:  
`di)` (without the parentheses)  
`da)` (including the parentheses)  
(works for different kinds of brackets and quotation marks)

Can be used on nested pairs of parentheses also:  
`d2a)`  
`2da)` (what is the difference?)

Delete all characters up to the next X:  
`dfX` (deletes X)  
`dtX` (keeps X)  
(Source: http://askubuntu.com/questions/64833/vi-shortcut-to-delete-until-the-next-x-character)

Delete a whole sentence:  
`das`

Copy a word an overwrite another word with it:  
`yiw`  
`viwp`  
(works only once unfortunately)

## Navigating

### Navigating between lines

Set a mark (e.g. named x):  
`mx`

Jump to a mark (e.g. named x):  
`'x`

Go to previously visited location:  
`Ctrl-O`

Go to next visited location:  
`Ctrl-I` or `Tab`

Move cursor to (without scrolling the page):  
- the top line: `H` ("high")
- the middle line: `M`
- the bottom line: `L` ("low")

Move the line where the cursor is to:  
- the top: `zt` or `z<Enter>`
- the middle: `zz`or `z.`
- the bottom: `zb`

### Navigating on the same line

Next word:  
`w`

Previous word:  
`b`

Beginning of first word:  
`^`

Before the first word:  
`0`

## Entering insert mode

### Big movements

At end of line:  
`A`

At the beginning of the first word:  
`I`


### Small movements

Before (at) cursor:  
`i`

After cursor:  
`a`

At the end of the current word:  
`ea`

## Advanced editing

### Insert text at the beginning of multiple visually selected lines

1. Use `Ctrl-v` to select the first column of text in the lines to edit
2. `Shift-i`
3. Type text to be inserted
4. `Esc` (and wait 1s)

(from https://stackoverflow.com/questions/253380/how-do-i-insert-text-at-beginning-of-a-multi-line-selection-in-vi-vim )

### Recording / applying / showing macros

Start recording into register x (could be any from a to z):  
`qx`

Then type everything you want to record.

Stop recording:  
`q`

Apply the recorded command from register x:  
`@x`

Apply it 5 times:  
`5@x`

Repeat execution of the last macro:  
`@@`

Show the content of register x:  
`:reg x`

Built-in help:  
`:help recording`

## Window Splits

Split horizontally (`-`):  
`:split` (short: `:sp`)

Split vertically (`|`):  
`:vsplit` (short: `:vs`)

Navigate between splits:  
`Ctrl-W` and on of these: `h, j, k, l`

Make split:  
- higher: `Ctrl-w, +`  
- lower: `Ctrl-w, -`  
- wider, narrower: `Ctrl-w, <` and `Ctrl-w, >`

Make all splits equal size (horizontally and vertically):  
`Ctrl-W, =` or `:winc=`

### Open multiple files in splitted mode

Horizontally (`-`):  
`vim -o file1 file2 file3`

Vertically (`|`):  
`vim -O file1 file2 file3`

## Searching and Replacing

### Delete certain lines

Delete all lines matching a regex:  
`:g/theregex/d`

Delete all lines *not* matching a regex:  
`:g!/theregex/d`

Notes:  
- Get a preview of affected lines by removing `d`
- Increse speed by calling `d_` instead of `d`. (Source: http://vim.wikia.com/wiki/Power_of_g )

### Replace pattern only on lines matching another pattern

Replace `old`with `new` only on lines matching `condition`:  

`:g/condition/s/old/new` 

Replace `old`with `new` only on lines NOT matching `condition`:  

`:g!/condition/s/old/new` 

(Source: https://stackoverflow.com/questions/12010308/how-can-i-replace-a-pattern-only-on-lines-that-do-or-do-not-contain-another-patt )

### Word counting

Count the number of words:  
mark the words with visual mode, then `g`, then `Ctrl-g` (from http://vim.wikia.com/wiki/Word_count )

## Changing how the editor works

### Break lines

Automatic line break after a number of characters (e.g. for git commit messages):  
`:set textwidth=72` (from http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html )

### Change the language of syntax highlighting

For Markdown:   
`:set syntax=markdown`

Or specifically for Markdown better force Markdown on all `*.md` files by adding the following to vimrc:  
`autocmd BufNewFile,BufReadPost *.md set filetype=markdown`  
(as described at https://github.com/tpope/vim-markdown )

## Misc

### Get the name of the current file

Only the filename:  
`Ctrl-g`

The full path:  
`1 Ctrl-g`


## vimdiff

Compare two files:  
`vimdiff file1 file2`

### Show/hide identical lines

Show all lines:  
`zR`

Fold all identical sections:  
`zM`

Open the current fold:  
`zo`

Close the current fold:  
`zc`
