""" Calculates task densities using .json data """
import json


def load_json(file_name):
    return [json.loads(line) for line in open(file_name, 'r')]


def update_densities(tasks, projects):
    for task in tasks:
        task['priorities'] = [float(projects[project]['priority'])
                              for project in task['projects']]
        task['density'] = sum(task['priorities']) / float(task['cost'])
    return tasks


def sort_tasks(tasks):
    tasks_dict = {task['name']: task for task in tasks}
    tasks = sorted(
        tasks_dict.items(), key=lambda tup: tup[1]['density'], reverse=True
    )
    return tasks


if __name__ == '__main__':
    tasks = load_json('tasks.json')
    projects = load_json('projects.json')

    projects = {project['name']: project for project in projects}

    tasks = update_densities(tasks, projects)

    tasks = sort_tasks(tasks)
