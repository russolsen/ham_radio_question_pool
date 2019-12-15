#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'
require 'set'

def parse_words(s)
  Set.new(s.downcase.split)
end

def count_word(m, w)
  m[w] = 0 unless m[w]
  m[w] += 1
end

path = ARGV.shift


questions = Quiz.json_load(path)

correct_map = {}
incorrect_words = Set.new

questions.each do |q|
  answers = q[:answers]
  correct = q[:correct]
  answers.count.times do |i|
    w = parse_words(answers[i])
    if i == correct
      w.each {|word| count_word(correct_map, word)}
    else
      incorrect_words = incorrect_words.union(w)
    end
  end
end

#p correct_words
#puts "==="
#p incorrect_words

correct_words = Set.new(correct_map.keys)
unique_words =  (correct_words - incorrect_words).to_a

for w in unique_words
  puts "#{w} #{correct_map[w]}"
end

