#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'
require 'set'

def parse_words(s)
  Set.new(s.downcase.split)
end

path = ARGV.shift


questions = Quiz.json_load(path)

correct_words = Set.new
incorrect_words = Set.new

questions.each do |q|
  answers = q[:answers]
  correct = q[:correct]
  good_count = 0
  bad_count = 0
  right_long = true

  counts = answers.map {|t| parse_words(t).count}
  max_count = counts.max
  puts "#{counts[correct] == max_count} #{counts.count(max_count)} #{counts[correct]} #{max_count}"
end

#p correct_words
#puts "==="
#p incorrect_words

#p (correct_words - incorrect_words).to_a

