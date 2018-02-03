# build game.p8

file_header = %q(pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
pac = {}
)

modules = []
modules_include = []

pico8_tags = [
  "__gfx__",
  "__gff__",
  "__map__",
  "__sfx__",
  "__music__"
]
pico8_data = ""
print_line = false

File.open("game.p8").each do |line|
  if not print_line
    pico8_tags.each do |tag|
      print_line = true if line.include? tag
    end
  end

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

# file header
game_file.write(file_header)

# pac library
game_file.write(modules_include.join)

# function files
Dir.glob("./game/functions/**/*.p8").each do |file|
  the_file = File.open(file)
  game_file.write(the_file.read)
  the_file.close
end

# included files
globals_file = File.open("./game/globals.p8")
game_file.write(globals_file.read)
globals_file.close

# update function
update_file = File.open("./game/update.p8")
game_file.write(update_file.read)
update_file.close

# draw function
draw_file = File.open("./game/draw.p8")
game_file.write(draw_file.read)
draw_file.close

# data from pico-8
game_file.write(pico8_data)

game_file.close
