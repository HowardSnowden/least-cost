#### Run tests
`bundle install`
`rspec` 

#### Run Program
`ruby main.rb  [your_input file]`

#### Details of my approach

I approached this problem from a Rails mindset, basically thinking in terms of how I would model the objects if I was working with a database, i.e a driver has many trips. Although the problem is pretty straightforward, abstracting the data into models helped with testing and stability. I was able to test the individual methods of the models with different inputs and I was able to easily describe in the tests some of the requirements of the problem, such as ignoring average speeds that were under 5 mph or over 100 mph. Although some of the instance methods in the models are pretty trivial, separating those out allow things to be more readable by combining the different methods, like in the total_average_speed method in the driver model. It also helped identify error points, such as dreaded divide by zero error and can be caught in individual tests for these instance methods. 

In addition, I like allowing objects and ruby niceties do a lot of the work me, such as when it comes time to output the results, I implemented a 'to_s' method on the driver model so that I simply had to loop through the sorted results and do a 'puts driver' to get the formatted results. 

The database model though process also informed how I retrieved input, since I think of the driver as the primary model we are concerned with, who owns many of the other model, it made sense to scan the input file to add all the drivers, before processing trips and attributing them appropriately.

Lastly, another good reason for abstracting things a bit more is for reusability. I originally had main.rb handle process the input but separated some of that logic out into app.rb. This reusability was useful for the unit tests, as I tested app model with the 'text_file.txt' file in the project and didn't need to worry about faking the input. 