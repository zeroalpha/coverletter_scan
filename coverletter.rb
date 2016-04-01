require 'pry'

#search_rx = ARGV[1]

search_rx = case ARGV[1]
when /^\/(.*)\/([imx]*)$/
  rx_pattern = $~.captures[0]
  rx_options = 0
  $~.captures[1].each_char do |c|
    case c
    when "i"
      rx_options |= Regexp::IGNORECASE
    when "m"
      rx_options |= Regexp::MULTILINE
    when "x"
      rx_options |= Regexp::EXTENDED
    end
  end
  Regexp.new rx_pattern,rx_options
when /^\w+$/
  Regexp.new $~,Regexp::IGNORECASE
else
  raise "Invalid Pattern #{ARGV[1]}"
end

action_rx = /^\+\+(.*?)^\.GS/m
action_member = File.read ARGV[0]

actions = action_member.scan(action_rx).flatten

matches = actions.map{|a| [a,a.scan(search_rx)]}.select{|a| a[1].any?}


binding.pry
puts ""