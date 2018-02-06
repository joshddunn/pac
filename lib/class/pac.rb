module PAC

  class << self
    def compile
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

      # write our project structure 
      Dir.glob(files).each do |file|
        game_file.write File.open(file).read
      end

      # write from pico-8
      game_file.write(pico8_data)

      # close file
      game_file.close
    end
  end

  class Mode

    attr_reader :mode_types, :mode_name

    def initialize(mode_name)
      @mode_name = mode_name
      @mode_types = [
        "draw",
        "update"
      ]
    end

    def generate
      mode_types.each do |mode_type|
        path = "./game/functions/#{mode_type}/#{mode_type}_#{mode_name}.p8"
        if File.exists? path
          puts "#{mode_type}_#{mode_name}.p8 already exists." 
        else
          File.open(path, "w").write "function #{mode_type}.#{mode_name}()\nend"
        end
      end
    end

    def destroy
      mode_types.each do |mode_type|
        path = "./game/functions/#{mode_type}/#{mode_type}_#{mode_name}.p8"
        File.delete(path) if File.exists? path
      end
    end
  end
end
