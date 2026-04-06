#!/usr/bin/env python

import sys
import yaml
import csv
import json
from pprint import pprint as pp
from pushback_file import PushbackFile
from raw_parser import read_raw_questions

input_name = sys.argv[1]
output_name = sys.argv[2]
text_name = f"{output_name}.txt"
json_name = f"{output_name}.json"
yaml_name = f"{output_name}.yaml"
csv_name = f"{output_name}.csv"


print(f"reading {input_name}")

questions = read_raw_questions(input_name)

print(f"writing #{yaml_name}")
generic_maps = [q.to_generic_map() for q in questions]

with open(yaml_name, 'w') as f:
    yaml.dump(generic_maps, f, default_flow_style=False, sort_keys=False, explicit_start=True, allow_unicode=True)

with open(json_name, "w", encoding="utf-8") as f:
    json.dump(generic_maps, f, ensure_ascii=False, indent=2)

print(f"writing #{csv_name}")

csv_maps = [q.to_csv_map() for q in questions]

with open(csv_name, 'w', newline='') as f:
    fieldnames = csv_maps[0].keys()
    writer = csv.DictWriter(f, fieldnames=fieldnames)

    writer.writeheader()  # Write the top row
    writer.writerows(csv_maps) # Write the data

print(f"writing {text_name}")
with open(text_name, 'w') as f:
  for q in questions:
    #print(f"Question: [{q.question}]")
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
