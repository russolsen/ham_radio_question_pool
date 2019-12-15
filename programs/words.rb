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
  answers.count.times do |i|
    w = parse_words(answers[i])
    if i == correct
      correct_words = correct_words.union(w)
    else
      incorrect_words = incorrect_words.union(w)
    end
  end
end

#p correct_words
#puts "==="
#p incorrect_words

p (correct_words - incorrect_words).to_a

