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

Delete all lines matching a regex:  
`:g/theregex/d`

Delete all lines *not* matching a regex:  
`:g!/theregex/d`

Notes:  
- Get a preview of affected lines by removing `d`
- Increse speed by calling `d_` instead of `d`. (Source: http://vim.wikia.com/wiki/Power_of_g )

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
