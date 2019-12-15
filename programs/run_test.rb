#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'

q_in = ARGV.shift
wrong_out = ARGV.shift

unless wrong_out
  dir = File.dirname(q_in)
  name = File.basename(q_in)
  wrong_out = "#{dir}/wrong_#{name}"
end

puts wrong_out

test = Quiz.json_load(q_in)

ARGV.shift

test.map! {|q| Quiz.randomize_question(q)}
test.shuffle!

results = Quiz.run_test(test)

wrong = Quiz.wrong_answers(results)

Quiz.json_dump(wrong, wrong_out)

p wrong
puts "questions: #{results.count} wrong: #{wrong.count}"



