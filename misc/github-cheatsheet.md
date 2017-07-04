### Github Cheatsheet

Series of GitHub commands I've collected in one place, in no particular order.


Add a remote repo to the current repo

```markdown
    git remote add remote_alias remote_repo_url
```

Change the name of the remote repo

```markdown
    git remote rename remote_alias new_alias_name
```

Verify the change

```markdown
    git remote -v
```

List all remote branch names

```markdown
    git branch -r
```

List all branches(local and remote) - drop the -a option to view local branches

```markdown
    git branch -a
```

Setup remote branch Origin to track the local Master branch. If you set the -u option, there's no need to specify any arguments with either git push, or git pull commands

```markdown
    git push -u origin master
```

Pull all remote changes, and sync with the local repo

```markdown
    git pull origin master
```

Create a new branch and switch to it

```markdown
    git checkout -b branch_name
```

To create a new branch, but not switch

```markdown
    git checkout branch_name
```

Fetch changes to a remote branch, without incorporating into the local repo - fetches all changes, including branches not incorporated into the local repo

```markdown
    git fetch
```

To incorporate changes to remote changes where you have a local copy of the branch, just not up to date
 
```markdown
    get merge origin/master
``` 

Where 'origin' is the alias of the remote repo, and master the branch we're merging. Where you don't have a local copy of the remote branch, use the checkout command.

Git pull command combines the fetch and merge commands in one - pulls down updates and merges them into the branch. Git pull will fetch all changes both to existing branches and new branches. Changes to existing branches which are being tracked are automatically merged. New branches will need to be checked out.

To delete a local branch

```markdown
    git branch -d branch_name
```

Pull requests are used solely on Github. It is a request for the owner(s) of a repo to pull a change you've made to a fork of their repo, and merge it into the original - you're basically asking the repo owner to accept some changes you've made and combine them into the original repo. Through this process anyone can fork a repo, make some changes and then submit those changes.

To carry out a pull request, commit and push any changes you've made to the fork. On the Github page fot the fork, click on the 'New pull request' button. Set the base as the fork you cloned, and the head as the branch you changed. Then click on tht 'Create pull request' button.