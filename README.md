#### Run tests
`bundle install`
-`rspec` 

#### Run Program
`ruby main.rb  [your_input file]`

#### Details of my approach

My solution involved recursively building up a list of paths across a 2d array via the traverse_paths method on the PathCost class and terminating a recursive stack by either reaching the length of the grid or seeing that the next move would result in going over the cost limit constant. An early problem I had ran into is that since the traverse method passes in an array, expecting each method call to have its own local scope, the recursive calls actually ended up modifying the same array. So to remedy this I end up passing a copy of the path array via the .dup method (and later via Marshal.load(Marshal.dump(arr))...more on this later). With the list built up, I simply sort by least cost and then also select the path with the max length in order to get the furtherst path in the event no path was able to reach the end. 

Another consideration was that the paths could basically always move in all three directions unless the move would result in being over cost, or the move would reach the length of the grid. So for this, I just added a method that would flip the y index to the top row or bottom row depending on the position.

When running my test cases, the case that involved testing a path through a 10x100 grid of 0s ended up hanging. Thinking my algorithm needed severe tuning for speed, I ended up having the path argument for the traverse method being a hash, so I could add the cost as I went, rather than summing the array on the fly, which is what led to using  Marshal.load(Marshal.dump(arr)). Seeing that the test past quickly with a 10x100 grid of random integers, I added a check to see if all the rows were composed of the same integer, in order to exit early, which solved the issue.

I though of going back and refactoring to have the traverse method use a string to keep track of the path that I would later parse to see about eliminating some of the object copying business but since my cases were all running and passing quickly, I decided against it. 

All in all, a fun problem to work on!