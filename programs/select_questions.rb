#!/usr/bin/env ruby
#
require 'json'
require 'optparse'
require_relative 'quiz'

question_re = nil
answer_re = nil

OptionParser.new do |opts|
  opts.banner = "Usage: select_questions.rb -q <re> -a <re> <questions.json> <output.json>"

  opts.on("-q re", "Question regular expression") do |re|
    puts "re: #{re} #{re.class}"
    question_re  = Regexp.new(re)
  end

  opts.on("-a re", "Answer regular expression") do |re|
    answer_re  = Regexp.new(re)
  end
end.parse!

in_path = ARGV.shift
out_path = ARGV.shift

questions = Quiz.json_load(in_path)
result=[]

questions.each do |q|
  question = q[:question]
  answers = q[:answers]
  if question_re && question_re.match(question)
    result << q
  elsif answer_re
    answers.each do |a|
      if answer_re.match(a)
        result << q
        break
      end
    end
  end
end


Quiz.json_dump(result, out_path)





