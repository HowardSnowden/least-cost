class PathCost

COST_LIMIT = 50
def initialize(lines)
	@grid = lines.map do |line|
		line.split(' ').map(&:to_i)
	end
	@path_list = []
	@min_cost_path = []
end 

def exec
   (@grid.count - 1).times do |i|
    traverse_paths(i, 0)
   end
   set_min_cost_path
end



def to_s 
	#puts @path_list.inspect
	"%s\n%s\n%s" % [complete?, min_cost, output_path] 
end



private 

def traverse_paths(y, x, path = [])
	path << y
	if (x == (@grid[0].count - 1 ))
		@path_list << path
		return 
    end
    
   calc_moves(y).each do |move|
   	unless invalid_move(path.dup, move)
     traverse_paths(move, x + 1, path.dup) 
    else
    	@path_list << path
    	return
    end
 
   end 
 
   
end

def calc_moves(y)
   [[y, :up], [y, :down]].map{|m| move(m[0], m[1])} + [y]
end
 
def invalid_move(path, next_move)
	next_move_path = path << next_move
	total_cost_over?(next_move_path)
end

def total_cost_over?(path)
	
	
	path_cost(path) >= COST_LIMIT
end

def path_cost(path)
    cost = 0
	path.each_with_index do |y, x|
	  cost += @grid[y][x] || 0
	end	
	cost
end

def move(y, dir=:up)
  new_y =  dir == :up ? y - 1 : y + 1 
  new_y = @grid.count - 1 if new_y < 0 #move to bottom row if out of bounds
  new_y = 0 if new_y > @grid.count - 1 #move to top if out of bounds
  new_y
end


def min_cost
	path_cost(@min_cost_path)
end

def output_path
  @min_cost_path.map{|m| m + 1}.join(' ')
end

def complete? 
  @min_cost_path.count == @grid[0].count ? 'Yes' : 'No'
end

def set_min_cost_path

   sorted_paths = @path_list.sort{|a,b| path_cost(a) <=> path_cost(b) }
   #get furthest path for incompletes
   @min_cost_path = sorted_paths.max_by(&:length)
end


end