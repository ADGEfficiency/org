""" shows infomation for a single project """
import argparse
from org import setup, sort_tasks


def show_project(tasks, projects, project_name):
    project_tasks = {name: info for name, info in tasks.items()
                     if project_name in info['projects']}

    sorted_tasks = sort_tasks(project_tasks, key='cost', reverse=False)

    print('{} {} tasks'.format(len(sorted_tasks), project_name))

    print('------------')

    for task_tuple in sorted_tasks:
        print('{} {}'.format(
            task_tuple[1]['name'], task_tuple[1]['cost']
        ))


if __name__ == '__main__':
    tasks, projects = setup()

    parser = argparse.ArgumentParser(description='project_name')
    parser.add_argument('project_name', type=str)
    args = parser.parse_args()

    show_project(tasks, projects, args.project_name)
