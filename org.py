import json


def load_json(file_name):
    tweets = []
    for line in open(file_name, 'r'):
        tweets.append(json.loads(line))
    return tweets

tasks = load_json('tasks.json')
projects = load_json('projects.json')

