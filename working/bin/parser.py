#!/usr/bin/env python

"""
This file contains various parsing functions, used by both
the raw text parser and the parser that reads the resulting
<name>.txt file.
"""

import re
from pprint import pprint as pp
from question import Question

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
  #print("read txt block")
  text = readline(io).strip()
  while not io.iseof():
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
  
