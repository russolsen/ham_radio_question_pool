#!/usr/bin/env python

import re
import sys
import yaml
import csv
import json
from pprint import pprint as pp
from question import Question
from pushback_file import PushbackFile

HEADER_RE = r"^([GET]\d+[A-Z]\d+) *\(([ABCD])\)(.*)"

def isempty(s):
    if not s:
        return True
    if s.isspace():
        return True
    return False

def isquestion(line):
  return re.match(HEADER_RE, line)

def isanswerline(line):
  return re.match(r"^[ABCD]\..*", line)

def istermline(line):
  return re.match(r"^~~.*", line)

def last_char(text):
    if not text:
        return ""
    return text[len(text)-1]

def join_line(text, line):
  c = last_char(text)
  if c == '-':
    return f"{text}{line}"
  return f"{text} {line}"

def read_text_block(io):
  text = readline(io).strip()
  while True:
    line = readline(io)
    if isanswerline(line) or istermline(line):
      io.pushback(line)
      break
    text = join_line(text, line.strip())
  return text.strip()

def skip_to_question(io):
  #print("skipping to question")
  while not io.iseof():
    line = io.readline()
    #print(f"skip: line: {line}")
    if isquestion(line):
      io.pushback(line)
      return line
  return None

def readline(io):
  text = io.readline().rstrip()
  #print(f"Read {text}")
  return text

def parse_header(header):
  m = re.match(HEADER_RE, header)
  id = m[1].strip()
  correct_char = m[2].strip()
  refs = m[3]
  if refs:
    refs = refs.strip()
  correct = ord(correct_char) - ord('A')
  return [id, correct, refs]


FIG_RE = r"[Ff]igure ([a-zA-Z][0-9]?-\d+)"

def extract_figure(question_text):
  m = re.search(FIG_RE, question_text, flags=re.I)
  if m:
    print("FIGURE Match! #{question_text}")
    return f"{m[1].lower()}.png"
  return ''

def read_header(io):
  text = readline(io)
  return parse_header(text)

def parse_answer(answer):
  return re.sub(r"^...", '', answer).strip()

def read_answer(io):
  text = read_text_block(io)
  return parse_answer(text)

def read_blank(io):
  text = readline(io).strip()
  if not isempty(text):
    raise f"Expected blank line, not [#{text}]"
  return text
  
def read_question(io):
  #print("\nquestion:"
  a=[]
  qid, correct, refs = read_header(io)
  #print("Id: #{id} Correct: #{correct}"
  question = read_text_block(io)
  print(f"Question text: <<{question}>>")
  figure = extract_figure(question)
  answers = []
  answers.append(read_answer(io))
  answers.append(read_answer(io))
  answers.append(read_answer(io))
  #pp(answers)
  answers.append(read_answer(io))
  #pp(answers)
  return Question(qid, correct, refs, question, answers, figure)


def read_questions(io):
  questions=[]
  skip_to_question(io)
  while not io.iseof():
    questions.append(read_question(io))
    skip_to_question(io)
  return questions

#def hash_to_array(h):
#  [h[:id],
#   h[:correct],
#   h[:question],
#   h[:answers][0],
#   h[:answers][1],
#   h[:answers][2],
#   h[:answers][3],
#   h[:refs],
#   h[:figure]]


input_name = sys.argv[1]
output_name = sys.argv[2]
text_name = f"{output_name}.txt"
json_name = f"{output_name}.json"
yaml_name = f"{output_name}.yaml"
csv_name = f"{output_name}.csv"


print(f"reading {input_name}")

questions = None
with PushbackFile(input_name) as f:
  questions = read_questions(f)

#print("writing #{json_name}"
#open(json_name, 'w') {|f| f.print(JSON.pretty_generate(questions))}

def to_generic_map(q):
    return {"id": q.id,
            "correct": q.correct,
            "refs": q.refs,
            "question": q.question,
            "answers": q.answers,
            "figure": q.figure,
            "correct_letter": q.correct_letter()}


print(f"writing #{yaml_name}")
generic_maps = [to_generic_map(q) for q in questions]

with open(yaml_name, 'w') as f:
    yaml.dump(generic_maps, f, default_flow_style=False, sort_keys=False, explicit_start=True, allow_unicode=True)

with open(json_name, "w", encoding="utf-8") as f:
    json.dump(generic_maps, f, ensure_ascii=False, indent=2)

print(f"writing #{csv_name}")

def to_csv_map(q):
    return {"id": q.id,
            "correct": q.correct,
            "question": q.question,
            "refs": q.refs,
            "a": q.answers[0],
            "b": q.answers[1],
            "c": q.answers[2],
            "d": q.answers[3],
            "figure": q.figure,
            "correct_letter": q.correct_letter()}

csv_maps = [to_csv_map(q) for q in questions]

with open(csv_name, 'w', newline='') as f:
    fieldnames = csv_maps[0].keys()
    writer = csv.DictWriter(f, fieldnames=fieldnames)

    writer.writeheader()  # Write the top row
    writer.writerows(csv_maps) # Write the data

print(f"writing {text_name}")
with open(text_name, 'w') as f:
  for q in questions:
    #pp(q)
    print(f"Question: [{q.question}]")
    correct = q.correct_letter()
    f.write(f"{q.id} ({correct})")
    if q.refs:
      f.write(f" {q.refs}")
    f.write("\n")
    f.write(f"{q.question}\n")
    answer = q.answers
    f.write(f"A. {answer[0]}\n")
    f.write(f"B. {answer[1]}\n")
    f.write(f"C. {answer[2]}\n")
    f.write(f"D. {answer[3]}\n")
    f.write("\n")
