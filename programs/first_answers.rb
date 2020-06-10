#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'
require 'set'

path = ARGV.shift

questions = Quiz.json_load(path)

correct_words = Set.new
incorrect_words = Set.new

questions.each do |q|
  puts q[:answers].first
end

