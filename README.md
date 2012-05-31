Dotfiles
========

Repo. of my dotfiles.

Overview
=======

Seems that it's wise to only add the dotfiles specifically, ensuring that they're 
safe to share.


Process
=======

     $ cd
     $ git init
     $ echo "*" >> .git/info/exclude
     $ git status
     $ git add -f .vimrc 
     $ git remote add bitbucket-dotfiles git@bitbucket.org:sotapme/dotfiles.git
     $ git commit -m "Add .vimrc as start"
     $ git push -u bitbucket-dotfiles master

