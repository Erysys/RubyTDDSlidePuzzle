# Joel Balmes
# CIS 272 Final - Slider Puzzle
# March 2020

class Puzzle

  attr_reader :width, :height

  def initialize( width, height )
    @width = width
    @height = height
    @num_of_spaces = @width * @height
    @puzzle_grid = []
    @current_num = 0
    @height.times do
      @row = []
      @width.times do
        @current_num += 1
        if @current_num == @num_of_spaces
          @row.append( "_" )
        else
          @row.append( @current_num.to_s )
        end
      end
      @puzzle_grid.append( @row )
    end
  end

  def set_puzzle( string )
    @string_array = string.split(' ')
    if @string_array.count != @num_of_spaces
      return "Invalid configuration for #{@width} by #{@height} puzzle. Must include exactly #{@num_of_spaces} items"
    end
    if @string_array.count("_") != 1
      return "Invalid configuration. There must be exactly 1 empty space (\"_\") in the puzzle"
    end
    @count = 0
    @puzzle_grid.each_with_index do | row, i |
      row.each_with_index do | item, j |
        if @string_array[@count] == "_"
          @puzzle_grid[i][j] = @string_array[@count]
        else
          @puzzle_grid[i][j] = @string_array[@count].to_i
        end
        @count += 1
      end
    end
    return true
  end

  def get_puzzle
    @return_string = ""
    @puzzle_grid.each do | row |
      row.each do | x |
        @return_string += "#{x} "
      end
    end
    return @return_string.rstrip
  end

  def to_s
    @return_string = ""
    @puzzle_grid.each do | row |
      row.each do | x |
        @return_string += "#{x} "
      end
      @return_string += "\n"
    end
    return @return_string.rstrip
  end

  def move_up
    @pos = []
    @target = []
    @pos_found = false

    until @pos_found
      @puzzle_grid.each_with_index do | row, i |
        row.each_with_index do | item, j |
          if item == "_"
            @pos = [i, j]
            @target = [ i - 1, j]
            @pos_found = true
          end
        end
      end
    end

    if @target[0] >= 0 && @target[0] < @height
      @puzzle_grid[@pos[0]][@pos[1]] = @puzzle_grid[@target[0]][@target[1]]
      @puzzle_grid[@target[0]][@target[1]] = "_"
    end
  end

  def move_down
    @pos = []
    @target = []
    @pos_found = false

    until @pos_found
      @puzzle_grid.each_with_index do | row, i |
        row.each_with_index do | item, j |
          if item == "_"
            @pos = [i, j]
            @target = [ i + 1, j]
            @pos_found = true
          end
        end
      end
    end

    if @target[0] >= 0 && @target[0] < @height
      @puzzle_grid[@pos[0]][@pos[1]] = @puzzle_grid[@target[0]][@target[1]]
      @puzzle_grid[@target[0]][@target[1]] = "_"
    end
  end

  def move_right
    @pos = []
    @target = []
    @pos_found = false

    until @pos_found
      @puzzle_grid.each_with_index do | row, i |
        row.each_with_index do | item, j |
          if item == "_"
            @pos = [i, j]
            @target = [ i , j + 1]
            @pos_found = true
          end
        end
      end
    end

    if @target[1] >= 0 && @target[1] < @width
      @puzzle_grid[@pos[0]][@pos[1]] = @puzzle_grid[@target[0]][@target[1]]
      @puzzle_grid[@target[0]][@target[1]] = "_"
    end
  end

  def move_left
    @pos = []
    @target = []
    @pos_found = false

    until @pos_found
      @puzzle_grid.each_with_index do | row, i |
        row.each_with_index do | item, j |
          if item == "_"
            @pos = [i, j]
            @target = [ i , j - 1]
            @pos_found = true
          end
        end
      end
    end

    if @target[1] >= 0 && @target[1] < @width
      @puzzle_grid[@pos[0]][@pos[1]] = @puzzle_grid[@target[0]][@target[1]]
      @puzzle_grid[@target[0]][@target[1]] = "_"
    end
  end

  def scramble
    25.times do
      @rand = rand(1..4)
      case @rand
      when 1
        self.move_up
      when 2
        self.move_right
      when 3
        self.move_down
      when 4
        self.move_left
      else
        break
      end
    end
  end

  def solve
    puzzleStr = ""
    tiles = (@width * @height) - 1
    (1..tiles).each do |i|
      puzzleStr+= "#{i} "
    end
    puzzleStr += "_"
    self.set_puzzle(puzzleStr)
  end

  def run
    program_state = 0

    while program_state == 0
      puts("Welcome to the Slider Puzzle!")
      puts("Enter a command to get started:")
      puts("  u: Move space up")
      puts("  d: Move space down")
      puts("  l: Move space left")
      puts("  r: Move space right")
      puts("  s: Solve puzzle")
      puts("  x: Scramble puzzle")
      puts("  e: Exit program")

      program_state = 1

      while program_state == 1
        puts
        puts(self.to_s)
        puts
        puts("u,d,l,r (s,x,e): ")
        command = gets.chomp

        if command == "u"
          puts("moving up")
          self.move_up
        elsif command == "d"
          puts("moving down")
          self.move_down
        elsif command == "l"
          puts("moving left")
          self.move_left
        elsif command == "r"
          puts("moving right")
          self.move_right
        elsif command == "s"
          puts("puzzle solved")
          self.solve
        elsif command == "x"
          puts("puzzle shuffled")
          self.scramble
        elsif command == "e"
          puts("thanks for playing!")
          program_state = -1
        else
          puts("invalid command. Try again.")
        end

      end
    end
  end



end

