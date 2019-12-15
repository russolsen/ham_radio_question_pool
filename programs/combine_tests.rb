#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'


# test = Quiz.json_load(q_in)
# Quiz.json_dump(wrong, wrong_out)

# ARGV.shift

result = []

ARGV.each do |a|
  test = Quiz.json_load(a)
  result += test
end

Quiz.json_dump(result, "out.json")
