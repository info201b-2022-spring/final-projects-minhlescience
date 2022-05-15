# Read file
text <- read.csv("/Users/m/documents/uw/info201/final-project/final-projects-minhlescience/data/Fires_2012_2015.csv")

# Select fires in California
state <- text[text$STATE == "CA",]
