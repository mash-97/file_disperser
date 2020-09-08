# file_disperser
Disperse files into random folders.

## Purpose

I needed to test a program called `cprx` (copy files into a destination directory by matching against a specified regexp) from the `mashz` gem I'm currently playing with. 
Where `file_disperse` will disperese my files into a directory tree for random times, so that I can test `cprx` by checking if all those copied files are copied into 
the destination directory specified to the `cprx` program, Just For A Stand-Alone test inside the `mashz` gem test folder. 
It all was for just practice, fun and poking around so called `gem`. 
Well! I often happened to use these for my daily system tasks somehow.


## Description

Disperse/copy given files into the tree of a destination directory with random times.
It has an another class `FileDisperser::FolderGenerator` by which you can create random folders inside the destination directory with spceified depth-limit and disperse-range, 
means the depth-limit the generator can go to create folders and the disperse-range the generator can create folders inside a single folder. 
See into Example section to have idea of using this gem.


## Installation

Right now it can't be found on https://rubygems.org/, cause it's not uploaded there. So what you can do is
clone or fork it from here.

`git clone https://github.com/mash-97/file_disperser.git`

`cd` into file_disperser directory and run:

`bundler install`

for using the gem it requires.
Then to install the gem run:

`rake install:local`

or you can do it manually by:

`gem build file_disperser`

and 

`gem install --local file_disperser`



## Example/Usage

First let see how we can use to generate a tree of random folders inside a directory via `FileDisperser::FolderGenerator`:

```ruby
require 'file_disperser'

# Create an object of FileDisperser::FolderGenerator by giving a destination directory as it's argument.
random_folder_tree_generator = FileDisperser::FolderGenerator.new("/home/mash-97/test") 	# "/home/mash-97/test is my destination directory on my ubuntu


# Set the name_table list so the generator can pickup names from it. Otherwise it would go with random numbers.
# One thing to remember here is that if any of the name already exists in operating directory, the generator will find a uniq name by File::uniqFin method provided from mashz gem.
# Remember: generator takes them randomly.
random_folder_tree_generator.name_table = ["nangua", "ponkei", "genjis", "mozanzer", "hoyeo"] 	# Just some random folder names :D

# Set the limits, it take a hash with :disperse_range and :depth_limit.
random_folder_tree_generator.limits = {:disperse_range => (5..10), :depth_limit => 10}

# Now run the generator by calling gen_folders method
random_folder_tree_generator.gen_folders()
```


Now let's try the FileDisperser::FileDisperser.

```ruby
# Create an instance of FileDisperser::FileDisperser by feeding files as a list and a destination directory
# I have three files in my /home/mash-97 folder as: fenjo.jpg, nishen.rb, korkus.jpeg.
# Let's disperese 3 copy of each of the files into /home/mash-97/test directory tree randomly.
files = ["/home/mash/fenjo.jpg", "/home/mash/nishen.rb", "/home/mash/korkus.jpeg"]
destination_dir = "/home/mash/test"
copy_numbers = 3															# create 3 copy of each of the files
file_disperser = FileDisperser::FileDisperser.new(files, destination_dir)

# Run the disperser
file_disperser.run(copy_numbers)

```


That's it! the result would be different on each time, cause most of the operations is based on randomness.
Because I needed the RANDOMNESS!



## Clarifying

My naming is bad. May be I'll upgrade them oneday. But who knows?
But if you are eager to suggest anything, I'll definitely try yours.

