# build game.p8

if ARGV[0] == "compile"
  file_header = "pico-8 cartridge // http://www.pico-8.com\nversion 16\n__lua__\n"

  files = [
    "./game/config.p8",
    "./game/functions/**/*.p8",
    "./game/sprites.p8",
    "./game/sounds.p8",
    "./game/globals.p8"
  ]

  pico8_tags = [
    "__gfx__",
    "__gff__",
    "__map__",
    "__sfx__",
    "__music__"
  ]

  pico8_data = ""
  print_line = false

  # find where pico8 game data starts and save it
  File.open("game.p8").each do |line|
    if print_line
      pico8_data += line
    else
      pico8_tags.each do |tag|
        print_line = true if line.include? tag
      end
    end
  end

  # grab modules from the PACFILE
  File.open("PACFILE").each do |line|
    files.insert 1, "./lib/#{line.strip}.p8"
  end

  # open our game file
  game_file = File.open("game.p8", "w")

  # write file header
  game_file.write(file_header)

  puts files
  # write our project structure 
  Dir.glob(files).each do |file|
    game_file.write File.open(file).read
  end

  # write from pico-8
  game_file.write(pico8_data)

  # close file
  game_file.close
elsif ARGV[0] == "generate"
  if ARGV[1] == "mode"
    mode_name = ARGV[2].downcase

    types = [
      "draw",
      "update"
    ]

    types.each do |type|
      path = "./game/functions/#{type}/#{type}_#{mode_name}.p8"
      if File.exists? path
        puts "#{type}_#{mode_name}.p8 already exists." 
      else
        File.open(path, "w").write "function #{type}.#{mode_name}()\nend"
      end
    end

    puts "#{mode_name} mode created."
  else
    puts "That is not a valid PAC command."
  end
elsif ARGV[0] == "destroy"
  if ARGV[1] == "mode"
    mode_name = ARGV[2].downcase

    types = [
      "draw",
      "update"
    ]

    types.each do |type|
      path = "./game/functions/#{type}/#{type}_#{mode_name}.p8"
      File.delete(path) if File.exists? path
    end

    puts "#{mode_name} mode destroyed."
  else
    puts "That is not a valid PAC command."
  end
else
    puts "That is not a valid PAC command."
end
