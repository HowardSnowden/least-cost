require './path_cost.rb'

RSpec.describe PathCost  do 

  it "should have properly formatted output" do 
    lines = (0..4).map{|m| "0 0 0 0"}
    path = PathCost.new(lines)
    path.exec
    expect(path.to_s).to eq("Yes\n0\n1 1 1 1")

  end

  it "should be able to handle up to 10 rows and 100 columns" do
    cols = (0..99).map.to_a.map{|a| rand(2..50) }.join(' ') 
    lines = (0..9).map{|m| cols  } 

    path = PathCost.new(lines)
    path.exec
    expect(path.complete?).to eq("No")
  end

  it "should exit early when all rows are 0s" do
    cols = (0..99).map.to_a.map{|a| 0 }.join(' ') 
    lines = (0..9).map{|m| cols } 

    path = PathCost.new(lines)

    path.exec
    expect(path.complete?).to eq("Yes")
  end

  it "should exit early when all rows are composed of same integer" do
    cols = (0..99).map.to_a.map{|a| 20 }.join(' ') 
    lines = (0..9).map{|m| cols } 

    path = PathCost.new(lines)

    path.exec
    expect(path.complete?).to eq("No")
    expect(path.min_cost).to eq(40)
  end

  it "should be able to handle negative integers" do 
    lines  = (0..3).map{|m| "0 -1 12"}
    path = PathCost.new(lines)
    path.exec
    
    expect(path.output_path).to eq("3 3 3")
  end

  context "When initialized with test_file1" do 
  	it "should have a complete path" do 
      lines = File.readlines('test_files/test_file1.txt')
  		path = PathCost.new(lines)
      path.exec
  		expect(path.complete?).to eq('Yes')
  	end
   
  	it "should have a min cost of 16" do
  	  lines = File.readlines('test_files/test_file1.txt')
      path = PathCost.new(lines)
      path.exec
      expect(path.min_cost).to eq(16)
  	end

  it "should have a path of rows 1 2 3 4 4 5" do
      lines = File.readlines('test_files/test_file1.txt')
      path = PathCost.new(lines)
      path.exec
      expect(path.output_path).to eq('1 2 3 4 4 5')
    end
  end

   context "When initialized with test_file2" do 
    it "should have a complete path" do 
      lines = File.readlines('test_files/test_file2.txt')
      path = PathCost.new(lines)
      path.exec
      expect(path.complete?).to eq('Yes')
    end
   
    it "should have a min cost of 11" do
      lines = File.readlines('test_files/test_file2.txt')
      path = PathCost.new(lines)
      path.exec
      expect(path.min_cost).to eq(11)
    end

    it "should have a path of rows 1 2 1 5 4 5" do
      lines = File.readlines('test_files/test_file2.txt')
      path = PathCost.new(lines)
      path.exec
      expect(path.output_path).to eq('1 2 1 5 4 5')
    end  
  end

   context "When initialized with test_file3" do 
    it "should not have a complete path" do 
      lines = File.readlines('test_files/test_file3.txt')
      path = PathCost.new(lines)
      path.exec
      expect(path.complete?).to eq('No')
    end
   
    it "should have a min cost of 48" do
      lines = File.readlines('test_files/test_file3.txt')
      path = PathCost.new(lines)
      path.exec
      expect(path.min_cost).to eq(48)
    end

    it "should have a path of rows 1 1 1" do
      lines = File.readlines('test_files/test_file3.txt')
      path = PathCost.new(lines)
      path.exec
      expect(path.output_path).to eq('1 1 1')
    end  
  end
  

end