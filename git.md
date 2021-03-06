# Git cheat sheet

## Initial settings

Set name and email address:

    git config --global user.name "John Doe"
    git config --global user.email johndoe@example.com

Make output colourful:

    git config --global color.ui "auto"

Prevent warnings when pushing (push only the current branch, not all):

    git config --global push.default simple

Set default text editor:

`git config --global core.editor "nano"` (for beginners)
`git config --global core.editor "vim"` (only if you know vim!)

Set displayed tab width to 4 (useful in projects where tabs and 4 spaces are used together):

    git config --global core.pager 'less -x1,5'

Check settings:

    git config --list

## Tutorials

- http://rypress.com/tutorials/git/index

## Amending

You use amending if you want to change an already committed commit. Preferably do this before pushing because this rewrites history.

### Fix commit message

This will open the editor to change your commit message:

`git commit --amend`

The commit date will stay the same.

## Branching

### Create a new local branch

Create a new local branch that will be visible only locally:

`git checkout -b newbranch` = `git branch newbranch ; git checkout newbranch`

Changes to the working directory are unaffected by this (see http://stackoverflow.com/a/2569513 ).

### Create a new local branch from a previous commit

    git checkout -b nameofbranch <hash>

(from http://stackoverflow.com/a/2816728)

### Merge changes from feature branch into master branch (locally)

    git checkout master
    git merge featurebranch

### Publish a local branch

    git push origin mybranch

or if the branch should have another name on the server:

    git push origin localbranch:remotebranch

To create a "tracking branch" (="upstream branch"):

    git push -u origin mybranch

To make a branch a tracking branch subsequently (after having created the branch):

    git branch -u origin/remotebranch [notthecurrentlocalbranch]

or

    git branch --set-upstream-to=origin/remotebranch localbranch

To remove the tracking information do (from http://stackoverflow.com/a/3046478 ):

    git branch --unset-upstream

### Checkout a remote branch / Create a tracking branch from a remote branch

    git checkout --track origin/remotebranch

(Note: `git checkout origin/remotebranch` would check out the branch in detached HEAD state.)

or

`git checkout remotebranch` (?)

Alternative if you want another local branch name:

    git branch localbranch origin/remotebranch

Discussion: See http://stackoverflow.com/q/10002239

### Verify tracking status of a branch

    git branch -vv

### Deleting a branch

Deleting a local branch:

    git branch -d localbranch

Deleting a remote branch:

`git push origin --delete remotebranch` = `git push origin :remotebranch`

### Showing all branches as tree

    git config --global alias.lgb "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%n' --abbrev-commit --date=relative --branches --full-history --all --author-date-order"

    git lgb

(Source: http://stackoverflow.com/a/2421063 with added

- `--all` (to see newly fetched commits, Source: http://stackoverflow.com/a/31179095 )
- `--full-history`
- `--author-date-order` : Source https://git-scm.com/docs/git-log#_commit_ordering
)

### Move branch pointer

If you are using a stable branch (`master`) and a development branch (`dev`), you occasionally want to forward the master branch pointer like this:

    # make working directory clean, e.g. by comitting all changes
    git checkout master
    git reset --hard dev # or use hash instead of dev

Or alternatively:

    git checkout dev
    git branch -f master dev # or use hash instead of dev

## Rebasing

The command

    git checkout sourcebranch
    git rebase targetbranch

or alternatively

    git rebase targetbranch sourcebranch

(Mnemonic: First I want the things from targetbranch happening, then things from sourcebranch. See also http://think-like-a-git.net/sections/rebase-from-the-ground-up/a-helpful-mnemonic-for-git-rebase-arguments.html )

does the following:  

- Search the common ancestor commit of targetbranch and the current branch (sourcebranch = HEAD)
- Memorize the commits between sourcebranch/HEAD and the common ancestor
- Replay these commits on top of targetbranch (the commit hashes will change)
- Move HEAD and the sourcebranch pointer at the end of the newly created changes

If there were no more pointers on the tip of the old (cut out) commits, they are now not easily reachable anymore.

Usually one will want to advance the targetbranch pointer by:

    git checkout targetbranch
    git merge sourcebranch

(which will do a fast-forward merge)

Maybe you want to delete the sourcebranch pointer as well:

    git branch -d sourcebranch

Changes that exist outside your local repository should not be rebased, i.e. the commits between sourcebranch and the common ancestor.

Sources:

- https://www.atlassian.com/git/tutorials/merging-vs-rebasing/conceptual-overview
- https://git-scm.herokuapp.com/book/en/v2/Git-Branching-Rebasing

## Diffing

Show diff between working directory and the index (=what could be added with `git add` but hasn't yet been added):

    git diff

Show diff between the index and the most recent commit:

`git diff --staged` = `git diff --cached`

Show diff between working directory and the most recent commit:

    git diff HEAD

Show diff between working directory and another commit (general form of the previous entry):

    git diff thecommit

Show difference between two commits (specify them using hashes or branch names):

`git diff oldhash newhash` = `git diff oldhash..newhash`

Show diff between an older commit and its parent:  

`git diff oldhash^!` (diff only) or `git show oldhash` (diff and commit message) (Source: https://stackoverflow.com/questions/436362/shorthand-for-diff-of-git-commit-with-its-parent )

Show diff between branch and the common ancestor of another branch:

    git diff otherbranch...thebranch

Show difference between two commits for a single file (or directory):

`git diff oldhash:thefile newhash:thefile`

or e.g.

`git diff oldhash:./ newhash:thefile:./`

Sources:

- http://git-scm.com/docs/git-diff
- http://www.gitguys.com/topics/git-diff/
- http://stackoverflow.com/a/7256391
- http://stackoverflow.com/a/5586435

### Don't diff renames

`diff -M` = `diff --find-renames`

(Not needed anymore with Git 2.9 and later.)

Source: https://stackoverflow.com/questions/5730460/how-to-do-a-git-diff-on-moved-renamed-file

### Diff options

Limit diff to single words: `--word-diff[=color]`

Specify what words look like: `--word-diff-regex=[^[:space:],]+`

### Invert diff direction

`diff -R`

## Getting information

### List of commits including names of changed files

Get a list of commits including which files were changed:  

    git log --stat

There are other commands as well, see http://stackoverflow.com/a/1230094

### Show which commits changed a file / changes to a single file over multiple commits

    git log [-p] --follow thefilename

The option `--follow` understands file renames.

The option `-p` (patch) shows the changes itself.

For looking at the history of a file in another branch:

    git log [-p] --follow thebranchname -- thefilename

Sources: http://stackoverflow.com/a/8808453, http://stackoverflow.com/a/5493663, http://stackoverflow.com/a/18830778

### Show which commits changed a directory

    git log --stat --after="2016-01-01" mydir1 mydir2

Shorter output:

    git log --stat --oneline --after="2016-01-01" mydir1 mydir2

Show changes to files:

    git log --stat -p --after="2016-01-01" mydir1 mydir2

Source: http://stackoverflow.com/a/16343950 , http://stackoverflow.com/a/4106051

### Show files changed by a single commit

Plumbing command (for scripts):

    git diff-tree --no-commit-id --name-only -r bd61ad98

Porcelain command (for human users):

    git show --pretty="" --name-only bd61ad98

Source: http://stackoverflow.com/a/424142

### List deleted files

    git log --no-renames --diff-filter=D --summary

Source: http://stackoverflow.com/a/6018043


## Ignoring

### Temporarily ignore an already commited file

Ignore the file:

    git update-index --assume-unchanged config.xml

Unignore the file:

    git update-index --no-assume-unchanged config.xml

See temporarily ignored files:

    git ls-files -v | grep ^h

Sources:

- http://blog.bfitz.us/?p=1811
- http://stackoverflow.com/a/26245961

## Reverting

### Revert a single file to a specific revision

Check what steps will be undone:

    git diff <commit> -- <file>

(`+` here means that you are going to remove this line)

Revert the single file:

    git checkout <commit> -- <file>

(This will also stage the change.)

## Resetting

See http://git-scm.com/blog/2011/07/11/reset.html

## Stashing

See also http://git-scm.com/book/en/v1/Git-Tools-Stashing

##### Stash your work

    git stash

This will result in a clean working directory.

To also stash new files, not yet known by Git use:

    git stash -u

You can also stash only parts using

    git stash -p

which works similar to `git add -p`.

##### See list of stored stashes

    git stash list

Newer entries are on top and have a lower number in `stash@{3}`. Dates of stashes can be seen using:

    git stash list --date=local

(Source: http://stackoverflow.com/q/15551618 )

##### Apply a stash

Get a preview what applying a stash will look like (from http://stackoverflow.com/q/7677736 ):

    git stash show -p stash@{0}

Apply the most recent stash:  

    git stash apply

Apply the most recent stash and re-stage files that were staged when stashing:  

    git stash apply --index

Apply the most recent stash and remove it from the stash stack:

    git stash pop

Apply an older stash:  

    git stash apply stash@{3}

##### Un-apply a stash

    git stash show -p stash@{3} | git apply -R

or shorter for the most recent stash:

    git stash show -p | git apply -R

##### Create a new branch from a stash

    git stash branch mynewbranch

This drops the stash.

##### Remove a stash from the list of stashes

    git stash drop stash@{2}

or shorter for the most recent stash:

    git stash drop

## Squashing

Source: https://ariejan.net/2011/07/05/git-squash-your-latests-commits-into-one/

Assumption: You have some local commits that you want to combine before pushing them to a shared repository. (Don't do this if the commits have already been published!)

Say you want to combine the latest 3 commits, then do:

    git rebase -i HEAD~3

The order is latest at the bottom, in contrast to `git log` where the latest commits are on top.

Change the word `pick` to `squash` on all lines except the first. Save the file and quit your editor.

A new editor window opens. Choose a commit message. Everything without `#` in front will be contained in the commit message.

##### Squash remote commits

If you really must squash remote commits, perform the local steps as described above.

Then force the upload by:

    git push origin +mybranch

If local and remote branches have different names:

    git push origin +localbranch:remotebranch

Sources:

- https://stackoverflow.com/questions/5667884/how-to-squash-commits-in-git-after-they-have-been-pushed
- http://git-scm.com/docs/git-push (see last example at the end of the document: `git push origin +dev:master`)

## Bisecting

### Normal bisecting

Bisecting can help you finding an error-introducing commit. For this you need to know two commits:

- One commit you know is fine
- Another (later) commit you know is buggy

Initialize the bisecting system: `git bisect start`

Tell git the good commit: `git bisect good <commit>`

Tell git the bad commit: `git bisect bad <commit>` (this will checkout another commit between the good and the bad commit)

Alternatively initialize and start with one command, which also tells git both a bad and one or multiple good commits: `git bisect start <badcommit> <goodcommit> <goodcommit>`

Repeatedly tell git if the currently checked out commit is good or bad: `git bisect good` or `git bisect bad`

In the end git will report:

    <commit> is the first bad commit
    ...

Reset the bisecting system: `git bisect reset` (you can also use this to abort a running bisection) This will reset your HEAD to its previous position.

### Background

The bisecting algorithm uses two rules:

1. Ancestors of bad commits are kept
2. Ancestors of good commits are removed

Source: http://events.linuxfoundation.org/sites/events/files/slides/Enjoy%20Fighting%20regressions%20with%20git%20bisect,%20LinuxCon%20EU%202013.pdf (page 29)

If you are looking for the commit where a function definition was erroneously removed, you must be careful to mark older commits (in other branches) where this function definition didn't yet exist as **good**.

### Bisecting on stereoids

You can automatically do the bisecting if you have a script that can decide if the current state is erroneous. The script should have an exit status 0 if the project is good or non-0 otherwise. Tell git the known good and bad commits, then run: `git bisect run test-for-error.sh`

Sources:
- https://kleinweby.de/2012/03/git-bisect-wer-hat-wann-was-kaputt-gespielt/
- https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git

## Complex use-cases

### Apply changes of a diverging branch (with confidential information in some files) into another branch

Given branches:  
- side (branch with partially confidential information)
- target (changes should be applied on top of this branch)

Steps:  

    git checkout side

Create new temporary branch and switch to it:  

    git checkout -b tmp

Combine the changes in the side branch into one commit (assumption: 5 commits were made in this branch and are to be comined into one):

    git rebase -i HEAD~5

(Choose `pick` for the first line and `squash` for the others then save and quit. In the next step choose a commit message.)

Change to the target branch:

    git checkout target

Cherry-pick from the new commit without automatically committing:

    git cherry-pick -n tmp

Resolve conflicts if necessary and remove the confidential information.

Add the files and do the commit.

    git add ...
    git commit -m "..."

Delete the temporary branch:

    git branch -D tmp

Source: http://stackoverflow.com/questions/5717026/how-to-git-cherry-pick-only-changes-to-certain-files

## Issues with tools

### git diff on Windows bash console shows angle brackets with numbers instead of umlauts

This might be due to MinTTY (default terminal of MSys2) having the wrong character set.

Determine the location of `.minttyrc`. Probably the same as that of `.gitconfig`:

    git config --global --edit

Change the character set from `Charset=CP1252` to `Charset=UTF-8`.
