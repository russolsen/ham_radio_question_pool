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

def question?(line)
  line =~ /E\d[A-Z]\d\d.*/
end

def read_text_block(io)
  text = ""
  while true
    line = readline(io)
    break if line.empty?
    print("line::: #{line}")
    text = "#{text}#{line} "
  end
  return text.strip
end

def skip_to_question(io)
  while not io.eof?
    line = io.readline
    print("line: #{line}")
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
  id = header[0,5]
  correct_char = header[7,1]
  extra = header[8,]
  correct = correct_char.ord - 'A'.ord
  [id, correct]
end

def read_header(io)
  text = readline(io)
  read_blank(io)
  #puts "Header #{text}"
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
  puts "\nquestion:"
  a=[]
  id, correct = read_header(io)
  puts "Id: #{id} Correct: #{correct}"
  question = read_text_block(io)
  puts "Question text: <<#{question}>>"
  answers = []
  answers << read_answer(io)
  puts answers
  answers << read_answer(io)
  puts answers
  answers << read_answer(io)
  puts answers
  answers << read_answer(io)
  puts "<<< #{answers} >>>"

  {id: id, correct: correct, question: question, answers: answers}
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
   h[:answers][3]]
end


name=ARGV[0]
text_name = "#{name}.txt"
json_name = "#{name}.json"
yaml_name = "#{name}.yaml"
csv_name = "#{name}.csv"


puts "reading #{text_name}"
#open(text_name) do |f| 
#  io = PushableFile.new(f)
#  #skip_to_question(io)
#  puts(read_questions(io))
#end

questions = nil
PushableFile.open(text_name) { |f| questions = read_questions(f) }

puts "writing #{json_name}"
open(json_name, 'w') {|f| f.puts(JSON.pretty_generate(questions))}

puts "writing #{yaml_name}"
open(yaml_name, 'w') {|f| f.puts(YAML.dump(questions))}

puts "writing #{csv_name}"
CSV.open(csv_name, 'w') do |csv|
  csv << ['id', 'correct', 'question', 'a', 'b', 'c', 'd']
  questions.each do |q|
    csv << hash_to_array(q)
  end
end

open("processed_#{text_name}", 'w') do |f|
  questions.each do |q|
    correct = ['A', 'B', 'C', 'D'][q[:correct]]
    f.puts("#{q[:id]} #{correct}")
    f.puts(q[:question])
    answer = q[:answers]
    f.puts("A. #{answer[0]}")
    f.puts("B. #{answer[1]}")
    f.puts("C. #{answer[2]}")
    f.puts("D. #{answer[3]}")
    f.puts
  end
end
