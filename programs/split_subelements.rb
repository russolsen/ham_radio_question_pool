#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'


questions = Quiz.json_load(ARGV[0])

buckets = {}

questions.each do |q|
  se = Quiz.subelement(q)
  buckets[se] = [] unless buckets[se]
  buckets[se] << q
end

buckets.keys.each do |se|
  questions = buckets[se]
  Quiz.json_dump(questions, "#{se}.json")
end
