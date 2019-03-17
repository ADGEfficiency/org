""" shows infomation for a single project """
import argparse
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

    return tasks, projects


def show_project(tasks, projects, project_name):
    project_tasks = {task['name']: task for task in tasks
                     if project_name in task['projects']}
    import pdb; pdb.set_trace()

    print('')
    print('{} {} tasks'.format(len(project_tasks), project_name))
    print('------------')

    for task, task_info in project_tasks.items():
        print(task, task_info['projects'])


if __name__ == '__main__':
    tasks, projects = setup()

    parser = argparse.ArgumentParser(description='project_name')
    parser.add_argument('project_name', type=str)
    args = parser.parse_args()

    show_project(tasks, projects, args.project_name)
