#!/usr/bin/env python

"""
This file contains the code that parses the raw text file, which
is extracted from the original pdf.
"""

import re
from pprint import pprint as pp
from parser import skip_to_question, read_header, read_answer, read_text_block, extract_figure
from pushback_file import PushbackFile
from question import Question

def read_raw_question(io):
  a=[]
  qid, correct, refs = read_header(io)
  question = read_text_block(io)
  figure = extract_figure(question)
  answers = []
  answers.append(read_answer(io))
  answers.append(read_answer(io))
  answers.append(read_answer(io))
  answers.append(read_answer(io))
  return Question(qid, correct, refs, question, answers, figure)

def read_raw_questions(path):
  with PushbackFile(path) as io:
    questions=[]
    skip_to_question(io)
    while not io.iseof():
      questions.append(read_raw_question(io))
      skip_to_question(io)
    return questions
