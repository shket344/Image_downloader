# Image downloader script


## Install, run and testing

### Requirements:

- rvm or rbenv
- ruby 3.0.0
- bundler version 2.2.3

### Pre-run steps:


$ cd Image_Downloader/


### Usage

#### Grant permissions:


$ chmod +x bin/main

#### Running the script:

$ bin/main public/images/ public/links.txt


#### Running the tests:

$ rspec

## Folders

### Bin Folder:

- main - a written script for calling a class, to which I will pass the necessary classes as parameters. ARGV - array of arguments that we pass when running the script on the command line.

### Lib Folder:

- application.rb
- connection_validator.rb
- reader.rb 
- folder_validator.rb
- url_validator.rb
- image_downloader.rb
- performance.rb

### Public Folder:

- links.txt - the file with the sample of input data.

### Spec Folder:

#### Bin:

- Integration test for script

#### Lib:

- Unit tests for all files

#### Fixtures:

- empty.txt for test case with empty file
- test.txt for success cases