#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'

srand(ARGV[0].to_i)

test = Quiz.make_random_test(ARGV[1])

Quiz.json_dump(test, ARGV[2])




