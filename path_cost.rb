class PathCost

  COST_LIMIT = 50
  attr_accessor :grid

  def initialize(lines)
  	@grid = lines.map do |line|
  		line.split(' ').map(&:to_i)
  	end
  	@path_list = []
  	@min_cost_path = []
  end

  def exec
    #large grids with all 0s will take a long time to complete...
    unless all_rows_the_same
    	(@grid.count - 1).times do |i|
      traverse_paths(i, 0)
     end
    else
      @path_list << manual_build_path
    end
     set_min_cost_path
  end
  
  def to_s
  	#puts @path_list.inspect
  	"%s\n%s\n%s" % [complete?, min_cost, output_path]
  end
  
  def min_cost
  	@min_cost_path[:cost]
  end

  def output_path
    @min_cost_path[:path].map{|m| m + 1}.join(' ')
  end

  def complete?
    @min_cost_path[:path].count == @grid[0].count ? 'Yes' : 'No'
  end

  private

  def all_rows_the_same
    return (@grid.uniq.count == 1) && (@grid[0].max == @grid[0].min)
  end

  def traverse_paths(y, x, path= {path: [], cost: 0})
    path[:cost] += @grid[y][x]
  	path[:path] << y
  	if (x == (@grid[0].count - 1 ))
  		@path_list << path
  		return
    end

     calc_moves(y).each do |move|
     	unless invalid_move(path[:cost], move, x + 1)
       traverse_paths(move, x + 1, Marshal.load(Marshal.dump(path)))
      else
      	@path_list << path
      	return
      end
     end
  end

  def manual_build_path
  	path = {cost: 0, path: [] }
    	i = 0
    	while (i <= @grid[0].length - 1)
    		break if (path[:cost] + @grid[0][i]) > COST_LIMIT
    		path[:cost] += @grid[0][i]
    		path[:path] << 0
     		i += 1
    	end
    	path
  end

  def calc_moves(y)
     [[y, :up], [y, :down]].map{|m| move(m[0], m[1])} + [y]
  end

  def invalid_move(cost, y, x)
  	#path[:path] << next_move
      #ext_move_path = path
      cost = cost + @grid[y][x]
  	total_cost_over?(cost)
  end

  def total_cost_over?(cost)
  	cost >= COST_LIMIT
  end

  def move(y, dir=:up)
    new_y =  dir == :up ? y - 1 : y + 1
    new_y = @grid.count - 1 if new_y < 0 #move to bottom row if out of bounds
    new_y = 0 if new_y > @grid.count - 1 #move to top if out of bounds
    new_y
  end
  
  def set_min_cost_path
    sorted_paths = @path_list.sort{|a,b| a[:cost] <=> b[:cost] }
     #get furthest path for incompletes
     @min_cost_path = sorted_paths.max_by{|a| a[:path].length }
  end

end
