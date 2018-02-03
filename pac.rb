# __gfx__

# File.extname

modules = []
modules_include = []

pico8_data = ""
print_line = false
File.open("game.p8").each do |line|
  print_line = true if line.include? "__gfx__"
  pico8_data += line if print_line
end

File.open("PACFILE").each do |line|
  modules.push(line.strip)
end

Dir.glob("./lib/*.p8").each do |file|
  if modules.include? File.basename(file, ".p8") 
    the_file = File.open(file)
    modules_include.push the_file.read
    the_file.close
  end
end

game_file = File.open("game.p8", "w")

# pac library
game_file.write("pac = {}\n" + modules_include.join)

# included files
game_file.write(File.open("./game/globals.p8").read)

# function files
Dir.glob("./game/functions/**/*.p8").each do |file|
  the_file = File.open(file)
  game_file.write(the_file.read)
  the_file.close
end

# update function
game_file.write(File.open("./game/update.p8").read)

# draw function
game_file.write(File.open("./game/draw.p8").read)

# data from pico-8
game_file.write(pico8_data)
