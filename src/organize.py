""" Calculates task densities using .json data """
import json
import os


def load_json(file_name):
    return [json.loads(line) for line in open(file_name, 'r')]


def setup():
    """
    returns
        tasks (list of dicts)
        projects (dictionary)
    """

    org_data_home = os.environ['ORG_DATA_HOME']
    tasks = load_json('{}/tasks.json'.format(org_data_home))
    projects = load_json('{}/projects.json'.format(org_data_home))

    projects = {project['name']: project for project in projects}
    for name, info in projects.items():
        info['priority'] = float(info['priority'])

    tasks = {task['name']: task for task in tasks}
    for name, info in tasks.items():
        info['cost'] = float(info['cost'])

    return tasks, projects


def update_densities(tasks, projects):
    """
    returns
        tasks (list of dicts)
    """
    for name, info in tasks.items():
        info['priorities'] = [projects[project]['priority']
                              for project in info['projects']]
        info['density'] = sum(info['priorities']) / info['cost']
    return tasks


def sort_tasks(tasks, key='density', reverse=True):
    """
    returns
        tasks (list of tuples of dicts)
    """
    tasks = sorted(
        tasks.items(), key=lambda tup: tup[1][key], reverse=reverse
    )
    return tasks

def organize(tasks, projects):
    updated_tasks = update_densities(tasks, projects)
    sorted_tasks = sort_tasks(updated_tasks)

    print('sorted tasks')
    print('------------')

    for task in sorted_tasks:
        print('{:.1f} {} {}'.format(
            task[1]['density'], task[1]['name'], task[1]['projects']
        ))
    return sorted_tasks


if __name__ == '__main__':
    tasks, projects = setup()
    sorted_tasks = organize(tasks, projects)

