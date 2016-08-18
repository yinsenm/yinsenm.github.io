#### R Tutorial ####
## Author: Katherine Shoemaker, Rice University
## License: Beerware
## Date: August 21, 2015

#### Part 1 : The Basics ####

# To run a command, find the ">" in your console and try out a few math problems.
# The 'enter' key tells R to evaluate what you've typed, the answer will be returned below your command

# For problems beyond command-line equations, R stores values with the assignment command, '<-'
# Run the four simple lines below and see what happens
# (To run a command inside this editor, place your cursor on the line and then
#   press shift-enter (windows) or command-return (mac))

a <- 1
b <- 2
c <- a + b
c

# You can also highlight a selection and run multiple or partial lines at once. 

# a, b, and c above are 'objects', which are what R uses to do its computation.
# there are MANY kinds of objects, which is extremely useful (and can also be annoying if you're not careful)

# to remove an object from your workspace, use rm()

rm(a)
rm(b,c) #can do multiple!

# Vectors: Again, we use the assignment command. The 'c' stands for concatenate. 

v <- c(1,2,3,4,5,6,7,8,9,10)
v

# We can access elements of v by using square brackets

v[3]

# Datasets: We will begin to look at more complicated stuctures using built-in data

iris

# When you run this in the command line, it lets you view the data. 
# To find out more about this data (or about anything in R), use the 'help' feature
# You can search in the help panel, or preface the 

?iris

# We can store this into our own variable name if we want to.

mydata <- iris

# To access certain elements, you must specify the row and column in the object [r,c]
# Note: The row and column names that are printed out do not count as columns

mydata[1,4]

mydata[97,5]

# Here, there is an extra row in the result. 
# Because the content is a 'factor', R returns all possible levels, or results, there could be

# What if we want to access multiple lines at once?
# or create the same vector above with less effort?
# The ':' command tells R to create a string of numbers

v_2 <- c(1:10)
mydata_10 <- mydata[1:10,]
mydata_10

# Leaving the column blank tells R to take all of the columns
# Bonus Material: You can also use logicals to subset
# Look up the which command to see what's happening here

mydata_setosa <- mydata[,which(mydata$Species = 'setosa')]

# Note: Spelling is VERY important here

Mydata #returns nothing! (In my editor, the autocorrect even tries to help)




#### Part 2: Importing Data #### 
## make sure you have the example.csv and titanic.txt downloaded 

# If the data is in the same file as this script, you need only put the file name
# If the data is elsewhere on the computer, you need to tell R where to look
# Extra: You can even, if you want, tell R to pull data straight from the internet

# load in the csv data with 'read.csv'

smoking <- read.csv("example.csv", header = F, sep = ',')
head(smoking)

# head() prints the first few lines of an object
# Note that 'header = F' here, so when it gets printed out, R gives generic 'V#' names
# What if we know the headers but the data set didn't include them?
# add in headers with 'colnames

colnames(smoking) <- c("State", "Cigarette", "Bladder", "Lung", "Kidney", "Leukemia")

# so, the above data had no headers and was comma separated.
# our next dataset has headers and is tab separated, so we need to change our read.csv options
# Note: Above, the default 'sep' for read.csv is the comma, so we didn't NEED to put it there.
# Defaults can be found on the help page for each function

# load in the .txt data with 'read.csv'

titanic <- read.csv("titanic.txt", header = T, sep = '\t')




#### Part 3: Basic Statistics####

# data exploration
# let's look at the titanic data
names(titanic)
dim(titanic)
table(titanic$Survived)

# the dollar symbol tells R to look at a specific variable
# We can use our subsetting knowledge from before to make a dataset with just survivors

titanic_survived <- titanic[titanic$Survived == 1,]
titanic_survived[1:10,]

# creating a new variable

# back to the smoking example, what if we want to create a new variable?
# Let's say I've devised a metric that measures cancer by adding up all the cancer variables

names(smoking)
Rate <- smoking$Bladder + smoking$Lung + smoking$Kidney + smoking$Leukemia
Rate

# to attach this variable to our existing data set, we use 'cbind'
# (In the same manner, 'rbind' can be used to attach new records)

smoking <- cbind(smoking,Rate)
smoking

# Note that R has overwritten the object with this 'new' object, and gave you no warning. 
# for bigger projects, it's important to be careful with this
# it won't rewrite the FILE, tho, and you can always reload the object. 
# there are ways to write the file, but that's more advanced material than we're going over here

# let's look at the summary stats for this data

mean(smoking$LUNG)
median(smoking$LUNG)
var(smoking$LUNG)
min(smoking$LUNG)
max(smoking$LUNG)

# a nice way to get a simple overall picture is summary()
# Note: what summary returns can change depending on what you pass it

summary(smoking)

# t test
# let's run a t-test on the sepal length of two species

names(iris)
table(iris$Species)
v1 <- iris[iris$Species == 'setosa',1]
v2 <- iris[iris$Species == 'versicolor',1]

t.test(v1,v2)

# and hey, look, the data from the two different species of iris seem to have a difference in means!
# there are many such built-in tests in R


#### Part 4: Basic plotting ####

# start with making a boxplot with the titanic data
# boxplots need continuous split by discrete, and if that isn't met, R will give an error

names(titanic)
boxplot(Age ~ PClass, data = titanic)
boxplot(Age ~ Survived, data = titanic)

# histograms are another staple plot

hist(titanic$Age)

# Dr. Scott developed one of the bin algorithm options!

hist(titanic$Age, breaks = 'Scott')

# Note that the default title looks awful
# We can change that!

hist(titanic$Age, main = "Histogram of the Age of the Titanic Passengers", 
     xlab = "Passenger Age")

# (This command is on two lines. As long as you end with a not complete statement,
#   R will wait for the next line to come across)

# The package 'ggplot2' is an extremely useful tool for graphics, it will be covered in class




#### Part 5: Packages ####

# The basic installation of R has many of the things you will need, but you may
#   discover at some point that you need more than what is available

# R has 'packages' that can be installed and loaded to expand the library of available functions
# Regardless of want you need R to do, there is likely a package for it 
# If there isn't a package, write one! It's a good way to be 'published'

# We'll work with this next session, so lets install and load this package
# You need only install each package once. After that first instance, you only need to 'load'
#   it with 'library()'

install.packages('rmarkdown')
install.packages("ggplot2")
library(rmarkdown)
library(ggplot2)







