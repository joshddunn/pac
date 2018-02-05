# build game.p8

require "./lib/class/pac.rb"

case ARGV[0..1].join("_")
when "compile"
  PAC.new.compile
when "generate_mode"
  PAC.new.generate_mode(ARGV[2].downcase)
  puts "#{ARGV[2]} mode created."
when "destroy_mode"
  PAC.new.destroy_mode(ARGV[2].downcase)
  puts "#{ARGV[2]} mode destroyed."
else
  puts "That is not a valid PAC command."
end
