# org

My simple bash based task manager.

Projects are managed by `todo.txt` files that can exist anywhere.  `org` provides two functions
- finding the `todo.txt` for a given project

```bash
$ org-find personal

/Users/adam/git/personal/todo.md
```

Finding all the `todo.txt` files:

```bash

$ org-show

finding project todo.md's ...

Projects
-----
energypy
personal
```

## Installation

```bash
source $HOME/git/org/org
```

## Usage

`org` is best used combined with other bash tools.

Open the `todo.txt` for the `personal` project in Vim:

```bash
vi $(org-find personal)
```

Open the project list in `less`:

```bash
org-show | less
```
