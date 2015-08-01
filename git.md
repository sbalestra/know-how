# Git cheat sheet

## Tutorials

- http://rypress.com/tutorials/git/index

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

    git config --global alias.lgb "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%n' --abbrev-commit --date=relative --branches"

    git lgb

(Source: http://stackoverflow.com/a/2421063 )

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

Show diff between working dirctory and the most recent commit:

    git diff HEAD

Show diff between two commits:

    git diff oldhash newhash

Show diff between an older commit and its parent:  

`git diff oldhash^!` (diff only) or `git show oldhash` (diff and commit message) (Source: https://stackoverflow.com/questions/436362/shorthand-for-diff-of-git-commit-with-its-parent )

Sources:

- http://git-scm.com/docs/git-diff
- http://www.gitguys.com/topics/git-diff/

### Diff options

Limit diff to single words: `--word-diff[=color]`

Specify what words look like: `--word-diff-regex=[^[:space:],]+`

## Getting information

Get a list of commits including which files were changed:  

    git log --stat

There are other commands as well, see http://stackoverflow.com/a/1230094

## Resetting

See http://git-scm.com/blog/2011/07/11/reset.html

## Stashing

See also http://git-scm.com/book/en/v1/Git-Tools-Stashing

##### Stash your work

    git stash

This will result in a clean working directory.

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
