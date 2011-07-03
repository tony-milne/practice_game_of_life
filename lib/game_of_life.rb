require "./lib/cell.rb"
#require "./lib/grid.rb"

class Life
  attr_accessor :grid
  
  def initialize(data)
    @grid = convert_to_grid_with_cells(data)
  end
  
  def tick
    # iterate through each cell
    #   if less than 2 neighbours, cell dies
    #   if more than 3 neighbours, cell dies
    #   if 3 neighbours, empty cell comes to life
    #   if 3 neighbours, live cell stays alive
    
    row_num = 0 # y
    @grid.each do |r|
      col_num = 0 # x
      r.each do |c|
        if c.alive?
          #check neighbours
          arr = check_num_of_alive_neighbours(col_num, row_num)#(x,y)
          num_alive_neighbours = arr[0]
          #dead_neighbours = arr[1]
          
          if num_alive_neighbours < 2 || num_alive_neighbours >= 4
            c.toggle #alive toggles to dead
          end
        end
        col_num += 1
      end
      row_num += 1
    end
  end
  
  def check_num_of_alive_neighbours(x,y)
    num_alive = 0
    #dead_cells = []
    if (x-1) >= 0
      c = @grid[y][x-1] 
      if c.alive?
        num_alive += 1
      else
        dead_cells << c
      end
      if (y-1) >= 0
        c = @grid[y-1][x-1] 
        if c.alive?
          num_alive += 1
        else
          dead_cells << c
        end
      end
      if (y+1) < @grid.length
        c = @grid[y+1][x-1] 
        if c.alive?
          num_alive += 1
        else
          dead_cells << c
        end
      end
    end
    
    if (y-1) >= 0
      c = @grid[y-1][x]
      if c.alive?
        num_alive += 1
      else
        dead_cells << c
      end
    end
    
    if (y+1) < @grid.length
      c = @grid[y+1][x]
      if c.alive?
        num_alive += 1
      else
        dead_cells << c
      end
    end
    
    if (x+1) < @grid[0].length
      c = @grid[y][x+1]
      if c.alive?
        num_alive += 1
      else
        dead_cells << c
      end
      if (y-1) >= 0
        c = @grid[y-1][x+1]
        if c.alive?
          num_alive += 1
        else
          dead_cells << c
        end
      end
      if (y+1) < @grid[0].length
        c = @grid[y+1][x+1]
        if c.alive?
          num_alive += 1
        else
          dead_cells << c
        end
      end
    end
    return num_alive#, dead_cells
  end
  
  def convert_to_grid_with_cells(data)
    grid = []
    data.each do |r|
      row = []
      r.each do |c|
        row << Cell.new(c)
      end
      grid << row
    end 
    return grid
  end
  
  # if grid array of cells cannot be compared, return grid
  # containing array of charaters (strings)
  def get_grid
    #TODO
  end
  
end
