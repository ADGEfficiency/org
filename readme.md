Simple task manager built in Bash & Python.

## Setup

Add to your `.bashrc` or `.bash_profile`
`source path/to/org/src/org.sh`

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
