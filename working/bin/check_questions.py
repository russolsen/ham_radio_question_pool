#!/usr/bin/env python
"""
Given the basic name, like 'extra-2026-2028', this script
will read in the questions in the various formats and do some
basic sanity checks to make sure the data makes sense.
"""

import re
import sys
import yaml
import csv
import json
import os
from pprint import pprint as pp
from question import Question
from text_parser import read_formatted_questions

FIG_RE = r"[Ff]igure ([a-zA-Z][0-9]?-\d+)"

def check_figure(q):
    qid = q['id']
    figure = q['figure']
    question = q['question']
    in_question = re.search(r"\bfigure\b", question, flags=re.I)

    if in_question and (not figure):
        print(f'{qid}: Figure mentioned in question but not in data.')
        print(f'Question text: {question}\n')
        return False

    if figure and (not in_question):
        print(f'{qid}: Figure mentioned in data but not in question.')
        print(f'Question text: {question}\n')
        print(f'Figure: {figure}')
        return False

    if figure and (not os.path.exists(figure)):
        print(f'{qid}: Figure file {figure} not found.')
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
    check_question_text(q)
    check_answers(q)
    check_figure(q)

q_json = None
with open(json_name, 'r') as file:
    q_json = json.load(file)
    for q in q_json:
        check_question(q)

q_yaml = None
with open(yaml_name, 'r') as file:
    q_yaml = yaml.safe_load(file)

# Read in the CSV version of the qestions.
# Since DictReader reads the correct answer as a string,
# we need to convert it to an int to match all of the
# other formats.
q_csv = []
with open(csv_name, 'r') as file:
    csvFile = csv.DictReader(file)
    for q in csvFile:
        q['correct'] = int(q['correct'])
        q_csv.append(q)

questions = read_formatted_questions(text_name)
q_txt = [q.to_generic_map() for q in questions]

if len(q_json) != len(q_yaml):
    print("Number json questions differs from yaml questions.")

if len(q_json) != len(q_txt):
    print("Number json questions differs from txt questions.")

if len(q_json) != len(q_csv):
    print("Number json questions differs from csv questions.")

# JSON vs yaml and txt
for i in range(len(q_json)):
    if q_json[i] != q_yaml[i]:
        print(f"JSON/YAML questions differ {i}")
    if q_json[i] != q_txt[i]:
        print(f"JSON/TXT questions differ {i}")

# JSON vs CSV
for i in range(len(questions)):
    from_text = questions[i].to_csv_map()
    from_csv = q_csv[i]
    if from_text != from_csv:
        print(f"TXT/CSV questions differ {i}")
