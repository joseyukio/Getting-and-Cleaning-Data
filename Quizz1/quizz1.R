## Set the right dir
setwd("Quizz1/")

## Question 1

## Load library data.table
library(data.table)

################################
## Question 1

## Load the data table int variable temp
#temp <- read.table("quizz1_housing_idaho.csv", sep=",", header = TRUE)
#housing <- data.table(temp)
## Using fread
housing <- fread("quizz1_housing_idaho.csv")
## Check the dimension  
dim(housing)

## Check how many properties are worth $1,000,000 or more. The column name
## is VAL and according to the code book values above $1,000,000 are represented
## by value 24. The function sum returns the number of occurrences of 'TRUE'.
housing[ , sum(VAL == 24, na.rm = TRUE)]
## Answer
## > housing[ , sum(VAL >= 24, na.rm = TRUE)]
## [1] 53

## Another alternative is to user length. Any column ca be used as argument to length.
housing[VAL == 24, length(FES)]
## [1] 53

## or a third alternative, preferred. '.N' is a special in-built variable
## that holds the number of observations in the current group
housing[VAL == 24, .N]
##[1] 53

################################
## Question 2

#Answer: Tidy data has one variable per column.

################################
## Question 3

## For some reason rJava does not work when JAVA_HOME is set.
## http://stackoverflow.com/questions/7019912/using-the-rjava-package-on-win7-64-bit-with-r?rq=1
## XLXS is dependent on rJava
## an workaround is to unset it in R session:
if (Sys.getenv("JAVA_HOME")!="")
        Sys.setenv(JAVA_HOME="")

# and then load xlsx
library(xlsx)

## Read the Excel file.
## Read rows 18-23 and columns 7-15 into R and assign the result 
## to a variable called: dat
dat <- read.xlsx("quizz1_question_3_getdata-data-DATA.gov_NGAP.xlsx", sheetIndex=1,rowIndex=18:23, colIndex=7:15)

sum(dat$Zip*dat$Ext,na.rm=T)
## [1] 36534720

################################
## Question 4
## Read the XML data on Baltimore restaurants.
library(XML)
doc <- xmlTreeParse("quizz1_question4_getdata-data-restaurants.xml", useInternal = TRUE)
rootNode <-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
xmlSApply(rootNode, xmlValue)

## Get the values of tag name.
xpathApply(rootNode, "//name", xmlValue)
##get the values of tag zipcode
temp <- xpathApply(rootNode, "//zipcode", xmlValue)
## Transform the list into numeric
zipcodes <- as.numeric(temp)
## Transform the zipcodes list into a data table
zipcodesDT <- data.table(zipcodes)
## Obtain how many zip codes we have.
zipcodesDT[zipcodes==21231, .N]
[1] 127

################################
## Question 5

## Read the file into DT
DT <- fread("quizz1_question5_getdata-data-ss06pid.csv")

system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])
## More than one give the same result as shown below:
##But the question is about using 
## data table function. So this is the answer:
## system.time(DT[,mean(pwgtp15),by=SEX])


## Results:
> system.time(mean(DT[DT$SEX==1,]$pwgtp15) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
              + )
usuário   sistema decorrido 
0.09      0.00      0.09 
> system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
usuário   sistema decorrido 
0.04      0.00      0.04 
> system.time(mean(DT$pwgtp15,by=DT$SEX))
usuário   sistema decorrido 
0         0         0 
> system.time(rowMeans(DT)[DT$SEX==1]) + system.time(rowMeans(DT)[DT$SEX==2])
Error in rowMeans(DT) : 'x' must be numeric
Timing stopped at: 0.96 0.01 0.99 
> system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
usuário   sistema decorrido 
0         0         0 
> system.time(mean(DT[DT$SEX==1,]$pwgtp15)) + system.time(mean(DT[DT$SEX==2,]$pwgtp15))
usuário   sistema decorrido 
0.04      0.00      0.03 
> system.time(tapply(DT$pwgtp15,DT$SEX,mean))
usuário   sistema decorrido 
0         0         0 
> system.time(DT[,mean(pwgtp15),by=SEX])
usuário   sistema decorrido 
0         0         0 
> 

#### Quizz 1 questions #####

Question 1
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
        
        https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 

and load the data into R. The code book, describing the variable names is here: 
        
        https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

How many properties are worth $1,000,000 or more?
53
31
25
47
Question 2
Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?
Tidy data has one variable per column.
Tidy data has variable values that are internally consistent.
Numeric values in tidy data can not represent categories.
Tidy data has one observation per row.
Question 3
Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
        
        https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 

Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
        dat 
What is the value of:
        sum(dat$Zip*dat$Ext,na.rm=T) 
(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)
154339
36534720
NA
338924
Question 4
Read the XML data on Baltimore restaurants from here: 
        
        https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 

How many restaurants have zipcode 21231?
100
127
156
130
Question 5
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
        
        https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 

using the fread() command load the data into an R object
DT 
Which of the following is the fastest way to calculate the average value of the variable
pwgtp15 
broken down by sex using the data.table package?
mean(DT$pwgtp15,by=DT$SEX)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
sapply(split(DT$pwgtp15,DT$SEX),mean)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
tapply(DT$pwgtp15,DT$SEX,mean)
DT[,mean(pwgtp15),by=SEX]

