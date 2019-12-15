#!/usr/bin/env ruby

require 'json'
require 'yaml'
require 'csv'

def parse_header(header)
  id = header[0,5]
  correct_char = header[7,1]
  correct = correct_char.ord - 'A'.ord
  [id, correct]
end

def read_header(io)
  text = io.readline.rstrip
  #puts "Header #{text}"
  parse_header(text)
end

def parse_answer(answer)
  answer.sub(/^.../, '')
end

def read_answer(io)
  text = io.readline.rstrip
  #puts("answer text is #{text}")
  parse_answer(text)
end

def read_blank(io)
  text = io.readline.strip
  raise "Expected blank line, not [#{text}]" unless text.empty?
  text
end
  
def read_question(io)
  a=[]
  id, correct = read_header(io)
  #puts "Id: #{id} Correct: #{correct}"
  question = io.readline.rstrip
  #puts "Question: #{question}"
  answers = []
  answers << read_answer(io)
  answers << read_answer(io)
  answers << read_answer(io)
  answers << read_answer(io)
  read_blank(io)
  {id: id, correct: correct, question: question, answers: answers}
end

def read_questions(io)
  questions=[]
  until(io.eof?) do
    questions << read_question(io)
  end
  questions
end

def hash_to_array(h)
  [h[:id],
   h[:correct],
   h[:question],
   h[:answers][0],
   h[:answers][1],
   h[:answers][2],
   h[:answers][3]]
end


name=ARGV[0]
text_name = "#{name}.txt"
json_name = "#{name}.json"
yaml_name = "#{name}.yaml"
csv_name = "#{name}.csv"


puts "reading #{text_name}"

questions = nil
open(text_name) { |f| questions = read_questions(f) }

open(json_name, 'w') {|f| f.puts(JSON.pretty_generate(questions))}

open(yaml_name, 'w') {|f| f.puts(YAML.dump(questions))}

CSV.open(csv_name, 'w') do |csv|
  csv << ['id', 'correct', 'question', 'a', 'b', 'c', 'd']
  questions.each do |q|
    csv << hash_to_array(q)
  end
end
