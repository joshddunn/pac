# build game.p8

if ARGV[0] == "compile"
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

  # config
  config_file = File.open("./game/config.p8")
  game_file.write(config_file.read)
  config_file.close

  # pac library
  game_file.write(modules_include.join)

  # function files
  Dir.glob("./game/functions/**/*.p8").each do |file|
    the_file = File.open(file)
    game_file.write(the_file.read)
    the_file.close
  end

  # sounds
  sprites_file = File.open("./game/sprites.p8")
  game_file.write(sprites_file.read)
  sprites_file.close

  # sounds
  sounds_file = File.open("./game/sounds.p8")
  game_file.write(sounds_file.read)
  sounds_file.close

  # included files
  globals_file = File.open("./game/globals.p8")
  game_file.write(globals_file.read)
  globals_file.close

  # data from pico-8
  game_file.write(pico8_data)

  game_file.close
elsif ARGV[0] == "generate"
  if ARGV[1] == "mode"
    mode_name = ARGV[2].downcase
    draw_file = File.open("./game/functions/draw/draw_#{mode_name}.p8", "w")    
    draw_file.write "function draw.#{mode_name}()\nend"
    draw_file.close

    update_file = File.open("./game/functions/update/update_#{mode_name}.p8", "w")    
    update_file.write "function update.#{mode_name}()\nend"
    update_file.close

    puts "#{mode_name} mode created."
  else
    puts "That is not a valid PAC command."
  end
elsif ARGV[0] == "destroy"
  if ARGV[1] == "mode"
    mode_name = ARGV[2].downcase
    draw_path = "./game/functions/draw/draw_#{mode_name}.p8"
    File.delete(draw_path) if File.exists? draw_path
    update_path = "./game/functions/update/update_#{mode_name}.p8"
    File.delete(update_path) if File.exists? update_path

    puts "#{mode_name} mode destroyed."
  else
    puts "That is not a valid PAC command."
  end
else
    puts "That is not a valid PAC command."
end
