#!/usr/bin/env python
"""
This file contains the code to read the generated, formatted
text file. It's similar to the code that parses the raw text
files, but is simpler because we can rely on the questions and
answers to be on a single line.
"""

from pprint import pprint as pp
from question import Question
from pushback_file import PushbackFile
import parser
 
def read_formatted_question(io):
  a=[]
  qid, correct, refs = parser.read_header(io)
  question = io.readline().rstrip()
  figure = parser.extract_figure(question)
  answers = []
  answers.append(parser.parse_answer(io.readline()))
  answers.append(parser.parse_answer(io.readline()))
  answers.append(parser.parse_answer(io.readline()))
  answers.append(parser.parse_answer(io.readline()))
  return Question(qid, correct, refs, question, answers, figure)

def read_formatted_questions(path):
  with PushbackFile(path) as io:
    questions=[]
    parser.skip_to_question(io)
    while not io.iseof():
      questions.append(read_formatted_question(io))
      parser.skip_to_question(io)
    return questions
