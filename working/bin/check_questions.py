#!/usr/bin/env python

import re
import sys
import yaml
import csv
import json
import os
from pprint import pprint as pp
from question import Question

FIG_RE = r"[Ff]igure ([a-zA-Z][0-9]?-\d+)"

def check_figure(q):
    figure = q['figure']
    question = q['question']
    in_question = re.search(r"\bfigure\b", question, flags=re.I)

    if in_question and (not figure):
        print(f'Figure mentioned in question but not in data.')
        print(f'**in_question: {in_question} figure {figure}')
        print(f'**question {question}')
        return False

    if figure and (not in_question):
        print(f'Figure mentioned in data but not in question.')
        print(f'** In_question: {in_question} Figure: {figure}')
        print(f'**question: {question}')
        return False

    if figure and (not os.path.exists(figure)):
        print(f'Figure {figure} not found.')
        return False

    return True

def check_question_text(q):
    #pp(q)
    question = q['question']
    if not re.match(r'.*\?', question):
        print(f"Question without ? {question}")
        return False
    return True

def check_answers(q):
    answers = q['answers']
    if len(answers) != 4:
        return False
    for a in answers:
        if re.match(r'^\s*$', a):
            return False
    return True

name = sys.argv[1]
text_name = f"{name}.txt"
json_name = f"{name}.json"
yaml_name = f"{name}.yaml"
csv_name = f"{name}.csv"

def check_question(q):
    if not check_question_text(q):
        print(f"Question {q} failed question text check\n\n")
    if not check_answers(q):
        print(f"Question {q} failed answers check\n\n")
    if not check_figure(q):
        print(f"Question {q} failed figure check\n\n")

q_json = None
with open(json_name, 'r') as file:
    q_json = json.load(file)
    for q in q_json:
        check_question(q)

q_yaml = None
with open(yaml_name, 'r') as file:
    q_yaml = yaml.safe_load(file)
    for q in q_yaml:
        check_question(q)

if len(q_json) != len(q_yaml):
    print("Number json questions differs from yaml questions.")

for i in range(len(q_json)):
    if q_json[i] != q_yaml[i]:
        print(f"questions differ {i}")

