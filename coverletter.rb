require 'pry'

action_rx = /^\+\+(.*?)^\.GS/m

action_member = File.read ARGV[0]

