#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'

questions = Quiz.json_load(ARGV[0])
ARGV.shift

questions = Quiz.organize_by_id(questions)

test = []
ARGV.each do |id|
  test << questions[id]
end

ARGV.clear

Quiz.json_dump(test, "out.json")




