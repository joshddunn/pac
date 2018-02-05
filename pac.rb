# build game.p8

require "./lib/class/pac.rb"

error = "That is not a valid PAC command."

if ARGV[0] == "compile"
  PAC.new.compile
elsif ARGV[0] == "generate"
  if ARGV[1] == "mode"
    PAC.new.generate_mode(ARGV[2].downcase)
    puts "#{ARGV[2]} mode created."
  else
    puts error
  end
elsif ARGV[0] == "destroy"
  if ARGV[1] == "mode"
    PAC.new.destroy_mode(ARGV[2].downcase)
    puts "#{ARGV[2]} mode destroyed."
  else
    puts error 
  end
else
    puts error 
end
