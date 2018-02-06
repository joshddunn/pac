# build game.p8

require "./lib/class/pac.rb"

case ARGV[0..1].join("_")
when "compile"
  PAC.compile
when "generate_mode"
  PAC::Mode.new(ARGV[2].downcase).generate
  puts "#{ARGV[2]} mode created."
when "destroy_mode"
  PAC::Mode.new(ARGV[2].downcase).destroy
  puts "#{ARGV[2]} mode destroyed."
else
  puts "That is not a valid PAC command."
end
