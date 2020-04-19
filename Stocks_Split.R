rm(list=ls())
library(plyr)
library(dplyr)
library(readxl)

#Input Investment Amount Here
cash <- 10000

#Read Template 
setwd("C:/Users/Deon/Desktop/Investments")
stocks <- read_excel("stocks_split_template.xlsx","Covid-19")
colnames(stocks)[1] <- "Industry"
industry <- as.data.frame(unique(stocks$Industry))

#Find Number of Industry
industry <- nrow(industry)
#Divide the cash among all Industry
each_industry <- cash/industry

#Find the number of stocks in each Industry
Breakdown <- ddply(stocks,~Industry,summarise,Stocks_Count=length(unique(Stocks)))
#Find each amount for stocks
Breakdown$Amount <- each_industry/Breakdown$Stocks_Count

#Left Join to Main
Final_Stocks <- left_join(stocks,Breakdown, by = c("Industry"))
Final_Stocks$Amount <- round(Final_Stocks$Amount ,digit=2)
Final_Stocks$Stocks_Count <- NULL

write.csv(Final_Stocks, file = "Stocks_Amount_Breadkdown.csv",row.names = FALSE)
