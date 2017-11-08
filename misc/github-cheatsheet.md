### Github Cheatsheet

Series of Github commands I've collected in one place, in no particular order. Git settings are saved in ~/.gitconfig.


*Add a remote repo to the current repo*

```bash
  git remote add remote_alias remote_repo_url
```

*Change the name of the remote repo*

```bash
  git remote rename remote_alias new_alias_name
```

*Verify the change*

```bash
  git remote -v
```

*List all remote branch names*

```bash
  git branch -r
```

*List all branches(local and remote) - drop the -a option to view local branches*

```bash
  git branch -a
```

*Setup remote branch Origin to track the local Master branch*

If you set the -u option, there's no need to specify any arguments with either git push, or git pull commands

```bash
  git push -u origin master
```

*Pull all remote changes, and sync with the local repo*

```bash
  git pull origin master
```

*Create a new branch and switch to it*

```bash
  git checkout -b branch_name
```

create a new branch, but not switch(replace 'checkout' with 'co')_

```bash
  git checkout branch_name
```

*Fetch changes to a remote branch, without incorporating into the local repo*

 - fetches all changes, including branches not incorporated into the local repo

```bash
  git fetch
```

To incorporate changes to remote changes where you have a local copy of the branch, just not up to date

```bash
  get merge origin/master
```

Where 'origin' is the alias of the remote repo, and master the branch we're merging. Where you don't have a local copy of the remote branch, use the checkout command.

Git pull command combines the fetch and merge commands in one - pulls down updates and merges them into the branch. Git pull will fetch all changes both to existing branches and new branches. Changes to existing branches which are being tracked are automatically merged. New branches will need to be checked out.

*To delete a local branch*

```bash
    git branch -d branch_name
```

Pull requests are used solely on Github. It is a request for the owner(s) of a repo to pull a change you've made to a fork of their repo, and merge it into the original - you're basically asking the repo owner to accept some changes you've made and combine them into the original repo. Through this process anyone can fork a repo, make some changes and then submit those changes.

To carry out a pull request, commit and push any changes you've made to the fork. On the Github page fot the fork, click on the 'New pull request' button. Set the base as the fork you cloned, and the head as the branch you changed. Then click on the 'Create pull request' button.


*Format log output*

```bash
  git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
```

--pretty="..." defines the format of the output.
  %h is the abbreviated hash of the commit
  %d are any decorations on that commit (e.g. branch heads or tags)
  %ad is the author date
  %s is the comment
  %an is the author name
  --graph informs git to display the commit tree in an ASCII graph layout
  --date=short keeps the date format nice and short

Other examples

```bash
git log --pretty=oneline --max-count=2
git log --pretty=oneline --since='5 minutes ago'
git log --pretty=oneline --until='5 minutes ago'
git log --pretty=oneline --author=<your name>
git log --pretty=oneline --all
```


*Common aliases*

Add the following to ~/.gitconfig

```bash
[alias]
  co = checkout
  ci = commit
  st = status
  br = branch
  hist = log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short
  type = cat-file -t
  dump = cat-file -p
```

Add the following aliases to ~/.bash_profile (linux) which are loaded into your shell(bash)

```bash
  # Git
  alias gcl="git clone"
  alias gst="git status"
  alias grt="get reset"
  alias gpl="git pull"
  alias gp="git push"
  alias gl="git log"
  alias gh="git hist"
  alias go="git checkout"
  alias gd="git diff | mate"
  alias ga="git add"
  alias gaa="git add ."
  alias gb="git branch"
  alias gba="git branch -a"
  alias gcm="git commit -m"
  alias gcam="git commit -am"
  alias gcu="git revert HEAD --no-edit"
  alias gc="git commit -v"
  alias gca="git commit -v -a"
  alias gbb="git branch -b"
```


*checkout previous versions using hashes*

Use the `git hist` command to list git history.

```bash
  $ git hist
  * a1189df 2014-10-25 | Added a comment (HEAD, master) [Jim Weirich]
  * 6083cb8 2014-10-25 | Added a default value [Jim Weirich]
  * b24f3ff 2014-10-25 | Using ARGV [Jim Weirich]
  * cf466b4 2014-10-25 | First Commit [Jim Weirich]
```

You can checkout a particular branch using it's hash code, 1st 7 chars are enough.

```bash
  $ git checkout b24f3ff
```

When you checkout a branch by name, `git checkout master`, you go to the latest version


*undoing local changes*

To a file that has been modified, in the 'working directory', but not 'staged'

```bash
  $ git checkout -- [file_name] .....
```

To a file that has been 'staged', but not 'committed'

```bash
  $ git reset HEAD [file_name] .....
```

To a file(s) that has been committed

Undo the last committed change by generating a commit that removes the changes the last commit added.

```bash
  $ git revert HEAD --no-edit
  # leave off the '--no-edit' opens the text editor so you can add a comment
```

Here we are undoing the very last commit made, so pass HEAD as the argument to revert. We can revert any arbitrary commit earlier in history by simply specifying its hash value instead.
