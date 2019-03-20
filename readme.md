Simple task manager built in Bash & Python.

## Setup

Add to your `.bashrc` or `.bash_profile` 
- location of the source code
- where you to keep task and project data (below I use Google Drive):

```bash
export ORG_HOME="/Users/adam/org"
export ORG_DATA_HOME="/Users/adam/GoogleDrive/org-backup"
source $ORG_HOME/src/org.sh
```

## Usage

```bash
$ org-add 'my task' project1 project2
$ org-add 'my other task' project1 

$ org-show project1

2 tasks
------------
my task ['project1', 'project2']
my other task ['project1']

$ org-show 

{"name":"my task","projects": ["project1", "project2"]}
{"name":"my other task","projects": ["project1"]}
```
