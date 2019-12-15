#!/usr/bin/env ruby
#
require_relative 'quiz'

require 'json'

q_in = ARGV.shift

test = Quiz.json_load(q_in)

ARGV.shift

test.map! {|q| Quiz.randomize_question(q)}
test.shuffle!
Quiz.run_flash(test)




