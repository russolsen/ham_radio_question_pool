#!/usr/bin/env ruby

require 'json'
require 'yaml'
require 'csv'

class PushableFile
  def initialize(io)
    @io = io
    @buffer = ''
  end

  def self.open(path, &block)
    File.open(path) do |f|
      pf = PushableFile.new(f)
      block.call(pf)
    end
  end

  def push_line(line)
    @buffer += line
  end

  def readline
    if @buffer.empty?
      return @io.readline
    else
      temp = @buffer
      @buffer = ''
      return temp
    end
  end

  def eof?
    if not @buffer.empty?()
      return false
    end
    return @io.eof?
  end
end

HEADER_RE = /^([GET]\d+[A-Z]\d+) *\(([ABCD])\)(.*)/

def question?(line)
  line =~ HEADER_RE
end

def read_text_block(io)
  text = ""
  while true
    line = readline(io)
    break if line.empty?
    #print("line::: #{line}")
    text = "#{text}#{line} "
  end
  return text.strip
end

def answer_line?(line)
  return line =~ /^[ABCD]\..*/
end

def term_line?(line)
  return line =~ /^~~.*/
end

def join_line(text, line)
  if text[-1] == '-'
    return "#{text}#{line}"
  end
  return "#{text} #{line}"
end

def read_text_block(io)
  text = readline(io).strip
  while true
    line = readline(io)
    if answer_line?(line) or term_line?(line)
      io.push_line(line)
      break
    end
    text = join_line(text, line.strip)
  end
  return text
end

def skip_to_question(io)
  while not io.eof?
    line = io.readline
    #print("skip: line: #{line}")
    if question?(line)
      io.push_line(line)
      return line
    end
  end
  return nil
end

def readline(io)
  text = io.readline.rstrip
  #puts("Read #{text}")
  text
end

def parse_header(header)
  m = HEADER_RE.match(header)
  id = m[1].strip
  correct_char = m[2].strip
  refs = m[3]
  refs = refs.strip if refs
  correct = correct_char.ord - 'A'.ord
  [id, correct, refs]
end

def read_header(io)
  text = readline(io)
  ###read_blank(io)
  puts "Header #{text}"
  parse_header(text)
end

def parse_answer(answer)
  answer.sub(/^.../, '').strip
end

def read_answer(io)
  text = read_text_block(io)
  parse_answer(text)
end

def read_blank(io)
  text = readline(io).strip
  raise "Expected blank line, not [#{text}]" unless text.empty?
  text
end
  
def read_question(io)
  #puts "\nquestion:"
  a=[]
  id, correct, refs = read_header(io)
  #puts "Id: #{id} Correct: #{correct}"
  question = read_text_block(io)
  #puts "Question text: <<#{question}>>"
  answers = []
  answers << read_answer(io)
  #puts answers
  answers << read_answer(io)
  #puts answers
  answers << read_answer(io)
  #puts answers
  answers << read_answer(io)
  #puts "<<< #{answers} >>>"

  {id: id, correct: correct, question: question, answers: answers}
  {id: id, correct: correct, refs: refs, question: question, answers: answers}
end

def read_questions(io)
  questions=[]
  skip_to_question(io)
  until(io.eof?) do
    questions << read_question(io)
    skip_to_question(io)
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
   h[:answers][3],
   h[:refs]]
end


input_name = ARGV[0]
output_name = ARGV[1]
text_name = "#{output_name}.txt"
json_name = "#{output_name}.json"
yaml_name = "#{output_name}.yaml"
csv_name = "#{output_name}.csv"


puts "reading #{input_name}"

questions = nil
PushableFile.open(input_name) { |f| questions = read_questions(f) }

puts "writing #{json_name}"
open(json_name, 'w') {|f| f.puts(JSON.pretty_generate(questions))}

puts "writing #{yaml_name}"
open(yaml_name, 'w') {|f| f.puts(YAML.dump(questions))}

puts "writing #{csv_name}"
CSV.open(csv_name, 'w') do |csv|
  csv << ['id', 'correct', 'question', 'a', 'b', 'c', 'd','refs']
  questions.each do |q|
    csv << hash_to_array(q)
  end
end

puts "writing #{text_name}"
open(text_name, 'w') do |f|
  questions.each do |q|
    #puts("question:", q)
    correct = ['A', 'B', 'C', 'D'][q[:correct]]
    f.print("#{q[:id]} (#{correct})")
    f.print(" #{q[:refs]}") if q[:refs] and (not q[:refs].empty?)
    f.puts
    f.puts(q[:question])
    answer = q[:answers]
    f.puts("A. #{answer[0]}")
    f.puts("B. #{answer[1]}")
    f.puts("C. #{answer[2]}")
    f.puts("D. #{answer[3]}")
    f.puts
  end
end
