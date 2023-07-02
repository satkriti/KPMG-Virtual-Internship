tdata = read.csv("/Users/satkritisumedha/Desktop/transaction_data.csv")
c_demo = read.csv("/Users/satkritisumedha/Desktop/cust_demo.csv", skip = 1)
c_add = read.csv("/Users/satkritisumedha/Desktop/cust_add.csv", skip = 1)

##############TRANSACTION DATA################
head(tdata)

#remove last col
tdata = tdata[, -14]
#check for empty values
apply(tdata,2,function(x) sum(is.na(x)))  #empty values in each column

#remove empty values
tdata <- tdata[complete.cases(tdata), ]

#extract month from transaction date
library(lubridate)
tdata$month = month(tdata$transaction_date, label =TRUE) #LABEL = TRUE gives month names instead of numeric values

#create a profit field
tdata$standard_cost <- (gsub("\\$", "", tdata$standard_cost)) #remove $ sign
tdata$standard_cost <- (gsub("\\,", "", tdata$standard_cost)) #remove , from 1K values
tdata$standard_cost <- as.numeric(tdata$standard_cost) #change standard cost to numeric field

tdata$profit = tdata$list_price - tdata$standard_cost

########################CUSTOMER DEMO##############

apply(c_demo,2,function(x) sum(is.na(x)))
#check for empty vaues
sum(is.na(c_demo))
#remove empty values
c_demo <- c_demo[complete.cases(c_demo), ]

# Edit gender column to have only 3 columns
c_demo$gender <- gsub("(f|fema|female|Femalel)", "Female", c_demo$gender, ignore.case = TRUE)
c_demo$gender<- gsub("m|ma|male|M|Maleale", "Male", c_demo$gender, ignore.case = TRUE)

c_demo1 = unique(c_demo$gender)

#delete all y values
c_demo<- c_demo[c_demo$deceased_indicator != "Y", ]

#Delete the 11th col
c_demo = c_demo[, -11]

##############CUSTOMER ADDRESS##############

sum(is.na(c_add))

apply(c_add,2,function(x) sum(is.na(x)))


#change column
c_add$state <- gsub("(New South Wales)", "NSW", c_add$state, ignore.case = TRUE)
c_add$state <- gsub("(Victoria)", "VIC", c_add$state, ignore.case = TRUE)




############SAVE FILES

write.csv(tdata, file = "/Users/satkritisumedha/Desktop/transaction_data_new.csv", row.names = FALSE)
write.csv(c_demo, file = "/Users/satkritisumedha/Desktop/customer_demgraphics_new.csv", row.names = FALSE)
write.csv(c_add, file = "/Users/satkritisumedha/Desktop/cust_address_new.csv", row.names = FALSE)



######


