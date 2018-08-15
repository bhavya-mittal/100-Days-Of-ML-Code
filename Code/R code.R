
###############################################################################
############################# REGION - SAUDI ARABIA (2017) ###########################
###############################################################################
                      ####################################

## Creating the working directory 

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault")

##Installing required packages

install.packages("sqldf")
##install.packages("data.table")
library(sqldf)

##1. Reading the overall category level clean data

overall_data <- read.csv("Leads2017.csv",as.is = T)

##2. Data Cleaning and formats

############Changing Date format to date########

overall_data$created_date_new <- as.Date(overall_data$created_date, format = "%m/%d/%Y")
overall_data$closed_date_new <- as.Date(overall_data$closed_date, format = "%m/%d/%Y")

class(overall_data$created_date_new)
head(overall_data$created_date_new)

class(overall_data$closed_date_new)
head(overall_data$closed_date_new)

View(overall_data)

##test1.data<-data.frame(overall_data)


library(data.table)

agebreaks <- c(18,26,36,46,500)
agelabels <- c("18-25","26-35","36-45","46+")

setDT(overall_data)[ , agegroups := cut(Age, 
                                        breaks = agebreaks, 
                                        right = FALSE, 
                                        labels = agelabels)]


class(overall_data)




##3. Data Manipulation for Saudi Arabia

##(i) Lead Status

overall_data_saudi_arabia<-sqldf("select * from overall_data
                                 where Country='Saudi Arabia'
                                 ")


NV_data_saudi_Arabia<-sqldf("select * from overall_data_saudi_arabia
                            where Type_of_Request<>'Buy Used Car'
                            ")

#Country = Saudi Arabia
#type of request = all except used cars and buy used cars
#Lead status = sold in case of sold vehicles


Lead_Status_2017<-sqldf("select Lead_status, count(*) as count_status
                        from NV_data_saudi_Arabia
                        group by Lead_status
                        "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_Status_2017,"Lead_Status_2017.csv")

##(ii) Nationality

Lead_Nationality_2017<-sqldf("select Nationality, count(*) as count_nationality
                             from NV_data_saudi_Arabia
                             group by Nationality
                             order by count_nationality desc
                             "
)

Sold_Nationality_2017<-sqldf("select Nationality, count(*) as count_nationality
                             from NV_data_saudi_Arabia
                             where Lead_status='Sold'
                             group by Nationality
                             "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_Nationality_2017,"Lead_Nationality_2017.csv")
write.csv(Sold_Nationality_2017,"Sold_Nationality_2017.csv")

##(iii) Age

Lead_Age_2017<-sqldf("select agegroups, count(*) as count_agegroups
                             from NV_data_saudi_Arabia
                             group by agegroups
                             "
)

Sold_Age_2017<-sqldf("select agegroups, count(*) as count_agegroups
                             from NV_data_saudi_Arabia
                             where Lead_status='Sold'
                             group by agegroups
                             "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_Age_2017,"Lead_Age_2017.csv")
write.csv(Sold_Age_2017,"Sold_Age_2017.csv")

##(iv) Gender

Lead_Gender_2017<-sqldf("select Gender, count(*) as count_gender
                     from NV_data_saudi_Arabia
                     group by gender
                     "
)

Sold_Gender_2017<-sqldf("select Gender, count(*) as count_gender
                     from NV_data_saudi_Arabia
                     where Lead_status='Sold'
                     group by gender
                     "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_Gender_2017,"Lead_Gender_2017.csv")
write.csv(Sold_Gender_2017,"Sold_Gender_2017.csv")

##(v) Type of Request

Lead_type_of_request_2017<-sqldf("select Type_of_Request, count(*) as count_Type_of_Request
                        from NV_data_saudi_Arabia
                        group by Type_of_Request
                        order by count_Type_of_Request desc
                        "
)

Sold_type_of_request_2017<-sqldf("select Type_of_Request, count(*) as count_Type_of_Request
                        from NV_data_saudi_Arabia
                        where Lead_status='Sold'
                        group by Type_of_Request
                        
                        "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_type_of_request_2017,"Lead_type_of_request_2017.csv")
write.csv(Sold_type_of_request_2017,"Sold_type_of_request_2017.csv")

##(vi) Popular Renault Models

Lead_Renault_models_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Model_of_Interest_NV
                                 from NV_data_saudi_Arabia
                                 group by Model_of_Interest_NV
                                 order by count_Model_of_Interest_NV desc
                                 "
)

Sold_Renault_models_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Model_of_Interest_NV
                                 from NV_data_saudi_Arabia
                                 where Lead_status='Sold'
                                 group by Model_of_Interest_NV
                                 
                                 "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_Renault_models_2017,"Lead_Renault_models_2017.csv")
write.csv(Sold_Renault_models_2017,"Sold_Renault_models_2017.csv")



##(vii) Dealer/ Showroom

Lead_dealer_showroom_2017<-sqldf("select Select_your_nearest_Renault_branch, count(*) as count_dealer_showroom
                                from NV_data_saudi_Arabia
                                group by Select_your_nearest_Renault_branch
                                order by count_dealer_showroom desc
                                "
)

Sold_dealer_showroom_2017<-sqldf("select Select_your_nearest_Renault_branch, count(*) as count_dealer_showroom
                                from NV_data_saudi_Arabia
                                where Lead_status='Sold'
                                group by Select_your_nearest_Renault_branch
                                
                                "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_dealer_showroom_2017,"Lead_dealer_showroom_2017.csv")
write.csv(Sold_dealer_showroom_2017,"Sold_dealer_showroom_2017.csv")

##(viii) Currently Owned Car

Lead_current_Model_Brand_2017<-sqldf("select Clean_Model_Brand_updated, count(*) as count_Clean_Model_Brand
                                from NV_data_saudi_Arabia
                                 group by Clean_Model_Brand_updated
                                 order by count_Clean_Model_Brand desc
                                 "
)

Sold_current_Model_Brand_2017<-sqldf("select Clean_Model_Brand_updated, count(*) as count_Clean_Model_Brand
                                 from NV_data_saudi_Arabia
                                 where Lead_status='Sold'
                                 group by Clean_Model_Brand_updated
                                 "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_current_Model_Brand_2017,"Lead_current_Model_Brand_2017.csv")
write.csv(Sold_current_Model_Brand_2017,"Sold_current_Model_Brand_2017.csv")

##First TIme Buyers

Leads_First_Time_Buyers_2017<-sqldf("select * from NV_data_saudi_Arabia
                            where Clean_Model_Brand_updated='First Time Buyer'
                            ")

##Current owners - Renault

Leads_Renault_users_2017<-sqldf("select * from NV_data_saudi_Arabia
                            where Clean_Model_Brand_updated='Renault'
                                    ")

## Current owners - other brands

Leads_other_brand_2017<-sqldf("select * from NV_data_saudi_Arabia
                            where Clean_Model_Brand_updated='Other Brand'
                                    ")

#First TIme Buyers - NV Leads and sold

Lead_model_interest_first_time_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_first_time_buyers
                                from Leads_First_Time_Buyers_2017
                                     group by Model_of_Interest_NV
                                     order by count_Lead_first_time_buyers desc
                                     "
)

Sold_model_interest_first_time_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_first_time_buyers
                                     from Leads_First_Time_Buyers_2017
                                     where Lead_status='Sold'
                                     group by Model_of_Interest_NV
                                     "
)

write.csv(Lead_model_interest_first_time_2017,"Lead_model_interest_first_time_2017.csv")
write.csv(Sold_model_interest_first_time_2017,"Sold_model_interest_first_time_2017.csv")

#Renault owners - NV Leads and sold

Lead_model_interest_renault_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_renault_owners
                                           from Leads_Renault_users_2017
                                           group by Model_of_Interest_NV
                                           order by count_Lead_renault_owners desc
                                           "
)

Sold_model_interest_renault_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_renault_owners
                                           from Leads_Renault_users_2017
                                           where Lead_status='Sold'
                                           group by Model_of_Interest_NV
                                           "
)

write.csv(Lead_model_interest_renault_users_2017,"Lead_model_interest_renault_users_2017.csv")
write.csv(Sold_model_interest_renault_users_2017,"Sold_model_interest_renault_users_2017.csv")

#Other brand - NV Leads and sold

Lead_model_interest_oth_brand_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_oth_brand_owners
                                           from Leads_other_brand_2017
                                           group by Model_of_Interest_NV
                                           order by count_oth_brand_owners desc
                                           "
)

Sold_model_interest_oth_brand_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_oth_brand_owners
                                           from Leads_other_brand_2017
                                           where Lead_status='Sold'
                                           group by Model_of_Interest_NV
                                           "
)

write.csv(Lead_model_interest_oth_brand_users_2017,"Lead_model_interest_oth_brand_users_2017.csv")
write.csv(Sold_model_interest_oth_brand_users_2017,"Sold_model_interest_oth_brand_users_2017.csv")

##(ix) Trend over time

##Quarterly****************

Lead_quarterly_trend_2017<-sqldf("select Quarter, count(*) as count_Leads_quarter
                                     from NV_data_saudi_Arabia
                                     group by Quarter
                                     "
)

Sold_quarterly_trend_2017<-sqldf("select Quarter, count(*) as count_Sold_quarter
                                     from NV_data_saudi_Arabia
                                     where Lead_status='Sold'
                                     group by Quarter
                                     "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_quarterly_trend_2017,"Lead_quarterly_trend_2017.csv")
write.csv(Sold_quarterly_trend_2017,"Sold_quarterly_trend_2017.csv")

##Monthly****************

Lead_monthly_trend_2017<-sqldf("select Month, count(*) as count_Leads_Month
                                 from NV_data_saudi_Arabia
                                 group by Month
                                 "
)

Sold_monthly_trend_2017<-sqldf("select Month, count(*) as count_Sold_Month
                                 from NV_data_saudi_Arabia
                                 where Lead_status='Sold'
                                 group by Month
                                 "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Lead_monthly_trend_2017,"Lead_monthly_trend_2017.csv")
write.csv(Sold_monthly_trend_2017,"Sold_monthly_trend_2017.csv")

##(x) Process Time

##Sold Leads

Sold_process_time_2017<-sqldf("select Process_Time
                               from NV_data_saudi_Arabia
                               where Lead_status='Sold'
                               order by Process_Time
                               "
)

Lost_process_time_2017<-sqldf("select Process_Time
                               from NV_data_saudi_Arabia
                               where Lead_status='Lost'
                               order by Process_Time
                               "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Sold_process_time_2017,"Sold_process_time_2017.csv")
write.csv(Lost_process_time_2017,"Lost_process_time_2017.csv")

##(xi) Origin of Leads

Leads_origin_2017<-sqldf("select Origin, count(*) as count_Leads_Origin
                          from NV_data_saudi_Arabia
                          group by Origin
                          order by count_Leads_Origin desc
                          "
)

Sold_origin_2017<-sqldf("select Origin, count(*) as count_Sold_Origin
                               from NV_data_saudi_Arabia
                               where Lead_status='Sold'
                               group by Origin
                               order by count_Sold_Origin desc
                               "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Saudi Arabia")
write.csv(Leads_origin_2017,"Leads_origin_2017.csv")
write.csv(Sold_origin_2017,"Sold_origin_2017.csv")


###############################################################################
############################# REGION - Overall Market (2017)####################
###############################################################################
                          ####################################
## Close R Workspace and Reopen
## Creating the working directory 

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault")

##Installing required packages

install.packages("sqldf")
##install.packages("data.table")
library(sqldf)

##1. Reading the overall category level clean data

overall_data <- read.csv("Leads2017.csv",as.is = T)

##2. Data Cleaning and formats

############Changing Date format to date########

overall_data$created_date_new <- as.Date(overall_data$created_date, format = "%m/%d/%Y")
overall_data$closed_date_new <- as.Date(overall_data$closed_date, format = "%m/%d/%Y")

class(overall_data$created_date_new)
head(overall_data$created_date_new)

class(overall_data$closed_date_new)
head(overall_data$closed_date_new)

View(overall_data)

##test1.data<-data.frame(overall_data)


library(data.table)

agebreaks <- c(18,26,36,46,500)
agelabels <- c("18-25","26-35","36-45","46+")

setDT(overall_data)[ , agegroups := cut(Age, 
                                        breaks = agebreaks, 
                                        right = FALSE, 
                                        labels = agelabels)]


class(overall_data)




##3. Data Manipulation for Saudi Arabia

##(i) Subsetting NV Leads data


NV_data_overall_market<-sqldf("select * from overall_data
                            where Type_of_Request<>'Buy Used Car'
                            ")

##(ii) Nationality

Lead_Nationality_2017<-sqldf("select Nationality, count(*) as count_nationality
                             from NV_data_overall_market
                             group by Nationality
                             order by count_nationality desc
                             "
)

Sold_Nationality_2017<-sqldf("select Nationality, count(*) as count_nationality
                             from NV_data_overall_market
                             where Lead_status='Sold'
                             group by Nationality
                             "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Overall Market")
write.csv(Lead_Nationality_2017,"Lead_Nationality_2017.csv")
write.csv(Sold_Nationality_2017,"Sold_Nationality_2017.csv")

##(iii) Age

Lead_Age_2017<-sqldf("select agegroups, count(*) as count_agegroups
                     from NV_data_overall_market
                     group by agegroups
                     "
)

Sold_Age_2017<-sqldf("select agegroups, count(*) as count_agegroups
                     from NV_data_overall_market
                     where Lead_status='Sold'
                     group by agegroups
                     "
)

write.csv(Lead_Age_2017,"Lead_Age_2017.csv")
write.csv(Sold_Age_2017,"Sold_Age_2017.csv")

##(iv) Gender

Lead_Gender_2017<-sqldf("select Gender, count(*) as count_gender
                        from NV_data_overall_market
                        group by gender
                        "
)

Sold_Gender_2017<-sqldf("select Gender, count(*) as count_gender
                        from NV_data_overall_market
                        where Lead_status='Sold'
                        group by gender
                        "
)

write.csv(Lead_Gender_2017,"Lead_Gender_2017.csv")
write.csv(Sold_Gender_2017,"Sold_Gender_2017.csv")

##(v) Type of Request

Lead_type_of_request_2017<-sqldf("select Type_of_Request, count(*) as count_Type_of_Request
                                 from NV_data_overall_market
                                 group by Type_of_Request
                                 order by count_Type_of_Request desc
                                 "
)

Sold_type_of_request_2017<-sqldf("select Type_of_Request, count(*) as count_Type_of_Request
                                 from NV_data_overall_market
                                 where Lead_status='Sold'
                                 group by Type_of_Request
                                 
                                 "
)

write.csv(Lead_type_of_request_2017,"Lead_type_of_request_2017.csv")
write.csv(Sold_type_of_request_2017,"Sold_type_of_request_2017.csv")

##(vi) Popular Renault Models

Lead_Renault_models_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Model_of_Interest_NV
                                from NV_data_overall_market
                                group by Model_of_Interest_NV
                                order by count_Model_of_Interest_NV desc
                                "
)

Sold_Renault_models_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Model_of_Interest_NV
                                from NV_data_overall_market
                                where Lead_status='Sold'
                                group by Model_of_Interest_NV
                                
                                "
)

write.csv(Lead_Renault_models_2017,"Lead_Renault_models_2017.csv")
write.csv(Sold_Renault_models_2017,"Sold_Renault_models_2017.csv")



##(vii) Dealer/ Showroom

Lead_dealer_showroom_2017<-sqldf("select Select_your_nearest_Renault_branch, count(*) as count_dealer_showroom
                                 from NV_data_overall_market
                                 group by Select_your_nearest_Renault_branch
                                 order by count_dealer_showroom desc
                                 "
)

Sold_dealer_showroom_2017<-sqldf("select Select_your_nearest_Renault_branch, count(*) as count_dealer_showroom
                                 from NV_data_overall_market
                                 where Lead_status='Sold'
                                 group by Select_your_nearest_Renault_branch
                                 
                                 "
)

write.csv(Lead_dealer_showroom_2017,"Lead_dealer_showroom_2017.csv")
write.csv(Sold_dealer_showroom_2017,"Sold_dealer_showroom_2017.csv")

##(viii) Currently Owned Car

Lead_current_Model_Brand_2017<-sqldf("select Clean_Model_Brand_updated, count(*) as count_Clean_Model_Brand
                                     from NV_data_overall_market
                                     group by Clean_Model_Brand_updated
                                     order by count_Clean_Model_Brand desc
                                     "
)

Sold_current_Model_Brand_2017<-sqldf("select Clean_Model_Brand_updated, count(*) as count_Clean_Model_Brand
                                     from NV_data_overall_market
                                     where Lead_status='Sold'
                                     group by Clean_Model_Brand_updated
                                     "
)

write.csv(Lead_current_Model_Brand_2017,"Lead_current_Model_Brand_2017.csv")
write.csv(Sold_current_Model_Brand_2017,"Sold_current_Model_Brand_2017.csv")

##First TIme Buyers

Leads_First_Time_Buyers_2017<-sqldf("select * from NV_data_overall_market
                                    where Clean_Model_Brand_updated='First Time Buyer'
                                    ")

##Current owners - Renault

Leads_Renault_users_2017<-sqldf("select * from NV_data_overall_market
                                where Clean_Model_Brand_updated='Renault'
                                ")

## Current owners - other brands

Leads_other_brand_2017<-sqldf("select * from NV_data_overall_market
                              where Clean_Model_Brand_updated='Other Brand'
                              ")

#First TIme Buyers - NV Leads and sold

Lead_model_interest_first_time_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_first_time_buyers
                                           from Leads_First_Time_Buyers_2017
                                           group by Model_of_Interest_NV
                                           order by count_Lead_first_time_buyers desc
                                           "
)

Sold_model_interest_first_time_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_first_time_buyers
                                           from Leads_First_Time_Buyers_2017
                                           where Lead_status='Sold'
                                           group by Model_of_Interest_NV
                                           "
)

write.csv(Lead_model_interest_first_time_2017,"Lead_model_interest_first_time_2017.csv")
write.csv(Sold_model_interest_first_time_2017,"Sold_model_interest_first_time_2017.csv")

#Renault owners - NV Leads and sold

Lead_model_interest_renault_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_renault_owners
                                              from Leads_Renault_users_2017
                                              group by Model_of_Interest_NV
                                              order by count_Lead_renault_owners desc
                                              "
)

Sold_model_interest_renault_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_renault_owners
                                              from Leads_Renault_users_2017
                                              where Lead_status='Sold'
                                              group by Model_of_Interest_NV
                                              "
)

write.csv(Lead_model_interest_renault_users_2017,"Lead_model_interest_renault_users_2017.csv")
write.csv(Sold_model_interest_renault_users_2017,"Sold_model_interest_renault_users_2017.csv")

#Other brand - NV Leads and sold

Lead_model_interest_oth_brand_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_oth_brand_owners
                                                from Leads_other_brand_2017
                                                group by Model_of_Interest_NV
                                                order by count_oth_brand_owners desc
                                                "
)

Sold_model_interest_oth_brand_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_oth_brand_owners
                                                from Leads_other_brand_2017
                                                where Lead_status='Sold'
                                                group by Model_of_Interest_NV
                                                "
)

write.csv(Lead_model_interest_oth_brand_users_2017,"Lead_model_interest_oth_brand_users_2017.csv")
write.csv(Sold_model_interest_oth_brand_users_2017,"Sold_model_interest_oth_brand_users_2017.csv")

##(ix) Trend over time

##Quarterly****************

Lead_quarterly_trend_2017<-sqldf("select Quarter, count(*) as count_Leads_quarter
                                 from NV_data_overall_market
                                 group by Quarter
                                 "
)

Sold_quarterly_trend_2017<-sqldf("select Quarter, count(*) as count_Sold_quarter
                                 from NV_data_overall_market
                                 where Lead_status='Sold'
                                 group by Quarter
                                 "
)

write.csv(Lead_quarterly_trend_2017,"Lead_quarterly_trend_2017.csv")
write.csv(Sold_quarterly_trend_2017,"Sold_quarterly_trend_2017.csv")

##Monthly****************

Lead_monthly_trend_2017<-sqldf("select Month, count(*) as count_Leads_Month
                               from NV_data_overall_market
                               group by Month
                               "
)

Sold_monthly_trend_2017<-sqldf("select Month, count(*) as count_Sold_Month
                               from NV_data_overall_market
                               where Lead_status='Sold'
                               group by Month
                               "
)

write.csv(Lead_monthly_trend_2017,"Lead_monthly_trend_2017.csv")
write.csv(Sold_monthly_trend_2017,"Sold_monthly_trend_2017.csv")

##(x) Process Time

##Sold Leads

Sold_process_time_2017<-sqldf("select Process_Time
                              from NV_data_overall_market
                              where Lead_status='Sold'
                              order by Process_Time
                              "
)

Lost_process_time_2017<-sqldf("select Process_Time
                              from NV_data_overall_market
                              where Lead_status='Lost'
                              order by Process_Time
                              "
)

write.csv(Sold_process_time_2017,"Sold_process_time_2017.csv")
write.csv(Lost_process_time_2017,"Lost_process_time_2017.csv")

##(xi) Origin of Leads

Leads_origin_2017<-sqldf("select Origin, count(*) as count_Leads_Origin
                         from NV_data_overall_market
                         group by Origin
                         order by count_Leads_Origin desc
                         "
)

Sold_origin_2017<-sqldf("select Origin, count(*) as count_Sold_Origin
                        from NV_data_overall_market
                        where Lead_status='Sold'
                        group by Origin
                        order by count_Sold_Origin desc
                        "
)

write.csv(Leads_origin_2017,"Leads_origin_2017.csv")
write.csv(Sold_origin_2017,"Sold_origin_2017.csv")

###############################################################################
############################# REGION - Abu Dhabi (2017)###############################
###############################################################################
                        ####################################
## Close R Workspace and Reopen

## Creating the working directory 

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault")

##Installing required packages

install.packages("sqldf")
##install.packages("data.table")
library(sqldf)

##1. Reading the overall category level clean data

overall_data <- read.csv("Leads2017.csv",as.is = T)

##2. Data Cleaning and formats

############Changing Date format to date########

overall_data$created_date_new <- as.Date(overall_data$created_date, format = "%m/%d/%Y")
overall_data$closed_date_new <- as.Date(overall_data$closed_date, format = "%m/%d/%Y")

class(overall_data$created_date_new)
head(overall_data$created_date_new)

class(overall_data$closed_date_new)
head(overall_data$closed_date_new)

View(overall_data)

##test1.data<-data.frame(overall_data)


library(data.table)

agebreaks <- c(18,26,36,46,500)
agelabels <- c("18-25","26-35","36-45","46+")

setDT(overall_data)[ , agegroups := cut(Age, 
                                        breaks = agebreaks, 
                                        right = FALSE, 
                                        labels = agelabels)]


class(overall_data)




##3. Data Manipulation for Abu Dhabi

##(i) Lead Status

overall_data_Abu_Dhabi<-sqldf("select * from overall_data
                              where Country='Abu Dhabi'
                              ")


NV_data_Abu_Dhabi<-sqldf("select * from overall_data_Abu_Dhabi
                         where Type_of_Request<>'Buy Used Car'
                         ")

#Country = Saudi Arabia
#type of request = all except used cars and buy used cars
#Lead status = sold in case of sold vehicles


Lead_Status_2017<-sqldf("select Lead_status, count(*) as count_status
                        from NV_data_Abu_Dhabi
                        group by Lead_status
                        "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Abu Dhabi")
write.csv(Lead_Status_2017,"Lead_Status_2017.csv")

##(ii) Nationality

Lead_Nationality_2017<-sqldf("select Nationality, count(*) as count_nationality
                             from NV_data_Abu_Dhabi
                             group by Nationality
                             order by count_nationality desc
                             "
)

Sold_Nationality_2017<-sqldf("select Nationality, count(*) as count_nationality
                             from NV_data_Abu_Dhabi
                             where Lead_status='Sold'
                             group by Nationality
                             "
)

write.csv(Lead_Nationality_2017,"Lead_Nationality_2017.csv")
write.csv(Sold_Nationality_2017,"Sold_Nationality_2017.csv")

##(iii) Age

Lead_Age_2017<-sqldf("select agegroups, count(*) as count_agegroups
                     from NV_data_Abu_Dhabi
                     group by agegroups
                     "
)

Sold_Age_2017<-sqldf("select agegroups, count(*) as count_agegroups
                     from NV_data_Abu_Dhabi
                     where Lead_status='Sold'
                     group by agegroups
                     "
)

write.csv(Lead_Age_2017,"Lead_Age_2017.csv")
write.csv(Sold_Age_2017,"Sold_Age_2017.csv")

##(iv) Gender

Lead_Gender_2017<-sqldf("select Gender, count(*) as count_gender
                        from NV_data_Abu_Dhabi
                        group by gender
                        "
)

Sold_Gender_2017<-sqldf("select Gender, count(*) as count_gender
                        from NV_data_Abu_Dhabi
                        where Lead_status='Sold'
                        group by gender
                        "
)

write.csv(Lead_Gender_2017,"Lead_Gender_2017.csv")
write.csv(Sold_Gender_2017,"Sold_Gender_2017.csv")

##(v) Type of Request

Lead_type_of_request_2017<-sqldf("select Type_of_Request, count(*) as count_Type_of_Request
                                 from NV_data_Abu_Dhabi
                                 group by Type_of_Request
                                 order by count_Type_of_Request desc
                                 "
)

Sold_type_of_request_2017<-sqldf("select Type_of_Request, count(*) as count_Type_of_Request
                                 from NV_data_Abu_Dhabi
                                 where Lead_status='Sold'
                                 group by Type_of_Request
                                 
                                 "
)

write.csv(Lead_type_of_request_2017,"Lead_type_of_request_2017.csv")
write.csv(Sold_type_of_request_2017,"Sold_type_of_request_2017.csv")

##(vi) Popular Renault Models

Lead_Renault_models_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Model_of_Interest_NV
                                from NV_data_Abu_Dhabi
                                group by Model_of_Interest_NV
                                order by count_Model_of_Interest_NV desc
                                "
)

Sold_Renault_models_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Model_of_Interest_NV
                                from NV_data_Abu_Dhabi
                                where Lead_status='Sold'
                                group by Model_of_Interest_NV
                                
                                "
)

write.csv(Lead_Renault_models_2017,"Lead_Renault_models_2017.csv")
write.csv(Sold_Renault_models_2017,"Sold_Renault_models_2017.csv")



##(vii) Dealer/ Showroom

Lead_dealer_showroom_2017<-sqldf("select Select_your_nearest_Renault_branch, count(*) as count_dealer_showroom
                                 from NV_data_Abu_Dhabi
                                 group by Select_your_nearest_Renault_branch
                                 order by count_dealer_showroom desc
                                 "
)

Sold_dealer_showroom_2017<-sqldf("select Select_your_nearest_Renault_branch, count(*) as count_dealer_showroom
                                 from NV_data_Abu_Dhabi
                                 where Lead_status='Sold'
                                 group by Select_your_nearest_Renault_branch
                                 
                                 "
)

write.csv(Lead_dealer_showroom_2017,"Lead_dealer_showroom_2017.csv")
write.csv(Sold_dealer_showroom_2017,"Sold_dealer_showroom_2017.csv")

##(viii) Currently Owned Car

Lead_current_Model_Brand_2017<-sqldf("select Clean_Model_Brand_updated, count(*) as count_Clean_Model_Brand
                                     from NV_data_Abu_Dhabi
                                     group by Clean_Model_Brand_updated
                                     order by count_Clean_Model_Brand desc
                                     "
)

Sold_current_Model_Brand_2017<-sqldf("select Clean_Model_Brand_updated, count(*) as count_Clean_Model_Brand
                                     from NV_data_Abu_Dhabi
                                     where Lead_status='Sold'
                                     group by Clean_Model_Brand_updated
                                     "
)

write.csv(Lead_current_Model_Brand_2017,"Lead_current_Model_Brand_2017.csv")
write.csv(Sold_current_Model_Brand_2017,"Sold_current_Model_Brand_2017.csv")

##First TIme Buyers

Leads_First_Time_Buyers_2017<-sqldf("select * from NV_data_Abu_Dhabi
                                    where Clean_Model_Brand_updated='First Time Buyer'
                                    ")

##Current owners - Renault

Leads_Renault_users_2017<-sqldf("select * from NV_data_Abu_Dhabi
                                where Clean_Model_Brand_updated='Renault'
                                ")

## Current owners - other brands

Leads_other_brand_2017<-sqldf("select * from NV_data_Abu_Dhabi
                              where Clean_Model_Brand_updated='Other Brand'
                              ")

#First TIme Buyers - NV Leads and sold

Lead_model_interest_first_time_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_first_time_buyers
                                           from Leads_First_Time_Buyers_2017
                                           group by Model_of_Interest_NV
                                           order by count_Lead_first_time_buyers desc
                                           "
)

Sold_model_interest_first_time_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_first_time_buyers
                                           from Leads_First_Time_Buyers_2017
                                           where Lead_status='Sold'
                                           group by Model_of_Interest_NV
                                           "
)

write.csv(Lead_model_interest_first_time_2017,"Lead_model_interest_first_time_2017.csv")
write.csv(Sold_model_interest_first_time_2017,"Sold_model_interest_first_time_2017.csv")

#Renault owners - NV Leads and sold

Lead_model_interest_renault_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_renault_owners
                                              from Leads_Renault_users_2017
                                              group by Model_of_Interest_NV
                                              order by count_Lead_renault_owners desc
                                              "
)

Sold_model_interest_renault_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_renault_owners
                                              from Leads_Renault_users_2017
                                              where Lead_status='Sold'
                                              group by Model_of_Interest_NV
                                              "
)

write.csv(Lead_model_interest_renault_users_2017,"Lead_model_interest_renault_users_2017.csv")
write.csv(Sold_model_interest_renault_users_2017,"Sold_model_interest_renault_users_2017.csv")

#Other brand - NV Leads and sold

Lead_model_interest_oth_brand_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_oth_brand_owners
                                                from Leads_other_brand_2017
                                                group by Model_of_Interest_NV
                                                order by count_oth_brand_owners desc
                                                "
)

Sold_model_interest_oth_brand_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_oth_brand_owners
                                                from Leads_other_brand_2017
                                                where Lead_status='Sold'
                                                group by Model_of_Interest_NV
                                                "
)

write.csv(Lead_model_interest_oth_brand_users_2017,"Lead_model_interest_oth_brand_users_2017.csv")
write.csv(Sold_model_interest_oth_brand_users_2017,"Sold_model_interest_oth_brand_users_2017.csv")

##(ix) Trend over time

##Quarterly****************

Lead_quarterly_trend_2017<-sqldf("select Quarter, count(*) as count_Leads_quarter
                                 from NV_data_Abu_Dhabi
                                 group by Quarter
                                 "
)

Sold_quarterly_trend_2017<-sqldf("select Quarter, count(*) as count_Sold_quarter
                                 from NV_data_Abu_Dhabi
                                 where Lead_status='Sold'
                                 group by Quarter
                                 "
)

write.csv(Lead_quarterly_trend_2017,"Lead_quarterly_trend_2017.csv")
write.csv(Sold_quarterly_trend_2017,"Sold_quarterly_trend_2017.csv")

##Monthly****************

Lead_monthly_trend_2017<-sqldf("select Month, count(*) as count_Leads_Month
                               from NV_data_Abu_Dhabi
                               group by Month
                               "
)

Sold_monthly_trend_2017<-sqldf("select Month, count(*) as count_Sold_Month
                               from NV_data_Abu_Dhabi
                               where Lead_status='Sold'
                               group by Month
                               "
)

write.csv(Lead_monthly_trend_2017,"Lead_monthly_trend_2017.csv")
write.csv(Sold_monthly_trend_2017,"Sold_monthly_trend_2017.csv")

##(x) Process Time

##Sold Leads

Sold_process_time_2017<-sqldf("select Process_Time
                              from NV_data_Abu_Dhabi
                              where Lead_status='Sold'
                              order by Process_Time
                              "
)

Lost_process_time_2017<-sqldf("select Process_Time
                              from NV_data_Abu_Dhabi
                              where Lead_status='Lost'
                              order by Process_Time
                              "
)

write.csv(Sold_process_time_2017,"Sold_process_time_2017.csv")
write.csv(Lost_process_time_2017,"Lost_process_time_2017.csv")

##(xi) Origin of Leads

Leads_origin_2017<-sqldf("select Origin, count(*) as count_Leads_Origin
                         from NV_data_Abu_Dhabi
                         group by Origin
                         order by count_Leads_Origin desc
                         "
)

Sold_origin_2017<-sqldf("select Origin, count(*) as count_Sold_Origin
                        from NV_data_Abu_Dhabi
                        where Lead_status='Sold'
                        group by Origin
                        order by count_Sold_Origin desc
                        "
)

write.csv(Leads_origin_2017,"Leads_origin_2017.csv")
write.csv(Sold_origin_2017,"Sold_origin_2017.csv")


###############################################################################
############################# REGION - Dubai (2017)###############################
###############################################################################
####################################
## Close R Workspace and Reopen

## Creating the working directory 

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault")

##Installing required packages

install.packages("sqldf")
##install.packages("data.table")
library(sqldf)

##1. Reading the overall category level clean data

overall_data <- read.csv("Leads2017.csv",as.is = T)

##2. Data Cleaning and formats

############Changing Date format to date########

overall_data$created_date_new <- as.Date(overall_data$created_date, format = "%m/%d/%Y")
overall_data$closed_date_new <- as.Date(overall_data$closed_date, format = "%m/%d/%Y")

class(overall_data$created_date_new)
head(overall_data$created_date_new)

class(overall_data$closed_date_new)
head(overall_data$closed_date_new)

View(overall_data)

##test1.data<-data.frame(overall_data)


library(data.table)

agebreaks <- c(18,26,36,46,500)
agelabels <- c("18-25","26-35","36-45","46+")

setDT(overall_data)[ , agegroups := cut(Age, 
                                        breaks = agebreaks, 
                                        right = FALSE, 
                                        labels = agelabels)]


class(overall_data)




##3. Data Manipulation for Dubai

##(i) Lead Status

overall_data_Dubai<-sqldf("select * from overall_data
                          where Country='Dubai'
                          ")


NV_data_Dubai<-sqldf("select * from overall_data_Dubai
                     where Type_of_Request<>'Buy Used Car'
                     ")


Lead_Status_2017<-sqldf("select Lead_status, count(*) as count_status
                        from NV_data_Dubai
                        group by Lead_status
                        "
)

setwd("C:/Users/CHIRAG BANSAL/Desktop/Renault/R outputs/Dubai")
write.csv(Lead_Status_2017,"Lead_Status_2017.csv")

##(ii) Nationality

Lead_Nationality_2017<-sqldf("select Nationality, count(*) as count_nationality
                             from NV_data_Dubai
                             group by Nationality
                             order by count_nationality desc
                             "
)

Sold_Nationality_2017<-sqldf("select Nationality, count(*) as count_nationality
                             from NV_data_Dubai
                             where Lead_status='Sold'
                             group by Nationality
                             "
)

write.csv(Lead_Nationality_2017,"Lead_Nationality_2017.csv")
write.csv(Sold_Nationality_2017,"Sold_Nationality_2017.csv")

##(iii) Age

Lead_Age_2017<-sqldf("select agegroups, count(*) as count_agegroups
                     from NV_data_Dubai
                     group by agegroups
                     "
)

Sold_Age_2017<-sqldf("select agegroups, count(*) as count_agegroups
                     from NV_data_Dubai
                     where Lead_status='Sold'
                     group by agegroups
                     "
)

write.csv(Lead_Age_2017,"Lead_Age_2017.csv")
write.csv(Sold_Age_2017,"Sold_Age_2017.csv")

##(iv) Gender

Lead_Gender_2017<-sqldf("select Gender, count(*) as count_gender
                        from NV_data_Dubai
                        group by gender
                        "
)

Sold_Gender_2017<-sqldf("select Gender, count(*) as count_gender
                        from NV_data_Dubai
                        where Lead_status='Sold'
                        group by gender
                        "
)

write.csv(Lead_Gender_2017,"Lead_Gender_2017.csv")
write.csv(Sold_Gender_2017,"Sold_Gender_2017.csv")

##(v) Type of Request

Lead_type_of_request_2017<-sqldf("select Type_of_Request, count(*) as count_Type_of_Request
                                 from NV_data_Dubai
                                 group by Type_of_Request
                                 order by count_Type_of_Request desc
                                 "
)

Sold_type_of_request_2017<-sqldf("select Type_of_Request, count(*) as count_Type_of_Request
                                 from NV_data_Dubai
                                 where Lead_status='Sold'
                                 group by Type_of_Request
                                 
                                 "
)

write.csv(Lead_type_of_request_2017,"Lead_type_of_request_2017.csv")
write.csv(Sold_type_of_request_2017,"Sold_type_of_request_2017.csv")

##(vi) Popular Renault Models

Lead_Renault_models_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Model_of_Interest_NV
                                from NV_data_Dubai
                                group by Model_of_Interest_NV
                                order by count_Model_of_Interest_NV desc
                                "
)

Sold_Renault_models_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Model_of_Interest_NV
                                from NV_data_Dubai
                                where Lead_status='Sold'
                                group by Model_of_Interest_NV
                                
                                "
)

write.csv(Lead_Renault_models_2017,"Lead_Renault_models_2017.csv")
write.csv(Sold_Renault_models_2017,"Sold_Renault_models_2017.csv")



##(vii) Dealer/ Showroom

Lead_dealer_showroom_2017<-sqldf("select Select_your_nearest_Renault_branch, count(*) as count_dealer_showroom
                                 from NV_data_Dubai
                                 group by Select_your_nearest_Renault_branch
                                 order by count_dealer_showroom desc
                                 "
)

Sold_dealer_showroom_2017<-sqldf("select Select_your_nearest_Renault_branch, count(*) as count_dealer_showroom
                                 from NV_data_Dubai
                                 where Lead_status='Sold'
                                 group by Select_your_nearest_Renault_branch
                                 
                                 "
)

write.csv(Lead_dealer_showroom_2017,"Lead_dealer_showroom_2017.csv")
write.csv(Sold_dealer_showroom_2017,"Sold_dealer_showroom_2017.csv")

##(viii) Currently Owned Car

Lead_current_Model_Brand_2017<-sqldf("select Clean_Model_Brand_updated, count(*) as count_Clean_Model_Brand
                                     from NV_data_Dubai
                                     group by Clean_Model_Brand_updated
                                     order by count_Clean_Model_Brand desc
                                     "
)

Sold_current_Model_Brand_2017<-sqldf("select Clean_Model_Brand_updated, count(*) as count_Clean_Model_Brand
                                     from NV_data_Dubai
                                     where Lead_status='Sold'
                                     group by Clean_Model_Brand_updated
                                     "
)

write.csv(Lead_current_Model_Brand_2017,"Lead_current_Model_Brand_2017.csv")
write.csv(Sold_current_Model_Brand_2017,"Sold_current_Model_Brand_2017.csv")

##First TIme Buyers

Leads_First_Time_Buyers_2017<-sqldf("select * from NV_data_Dubai
                                    where Clean_Model_Brand_updated='First Time Buyer'
                                    ")

##Current owners - Renault

Leads_Renault_users_2017<-sqldf("select * from NV_data_Dubai
                                where Clean_Model_Brand_updated='Renault'
                                ")

## Current owners - other brands

Leads_other_brand_2017<-sqldf("select * from NV_data_Dubai
                              where Clean_Model_Brand_updated='Other Brand'
                              ")

#First TIme Buyers - NV Leads and sold

Lead_model_interest_first_time_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_first_time_buyers
                                           from Leads_First_Time_Buyers_2017
                                           group by Model_of_Interest_NV
                                           order by count_Lead_first_time_buyers desc
                                           "
)

Sold_model_interest_first_time_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_first_time_buyers
                                           from Leads_First_Time_Buyers_2017
                                           where Lead_status='Sold'
                                           group by Model_of_Interest_NV
                                           "
)

write.csv(Lead_model_interest_first_time_2017,"Lead_model_interest_first_time_2017.csv")
write.csv(Sold_model_interest_first_time_2017,"Sold_model_interest_first_time_2017.csv")

#Renault owners - NV Leads and sold

Lead_model_interest_renault_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_renault_owners
                                              from Leads_Renault_users_2017
                                              group by Model_of_Interest_NV
                                              order by count_Lead_renault_owners desc
                                              "
)

Sold_model_interest_renault_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_Lead_renault_owners
                                              from Leads_Renault_users_2017
                                              where Lead_status='Sold'
                                              group by Model_of_Interest_NV
                                              "
)

write.csv(Lead_model_interest_renault_users_2017,"Lead_model_interest_renault_users_2017.csv")
write.csv(Sold_model_interest_renault_users_2017,"Sold_model_interest_renault_users_2017.csv")

#Other brand - NV Leads and sold

Lead_model_interest_oth_brand_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_oth_brand_owners
                                                from Leads_other_brand_2017
                                                group by Model_of_Interest_NV
                                                order by count_oth_brand_owners desc
                                                "
)

Sold_model_interest_oth_brand_users_2017<-sqldf("select Model_of_Interest_NV, count(*) as count_oth_brand_owners
                                                from Leads_other_brand_2017
                                                where Lead_status='Sold'
                                                group by Model_of_Interest_NV
                                                "
)

write.csv(Lead_model_interest_oth_brand_users_2017,"Lead_model_interest_oth_brand_users_2017.csv")
write.csv(Sold_model_interest_oth_brand_users_2017,"Sold_model_interest_oth_brand_users_2017.csv")

##(ix) Trend over time

##Quarterly****************

Lead_quarterly_trend_2017<-sqldf("select Quarter, count(*) as count_Leads_quarter
                                 from NV_data_Dubai
                                 group by Quarter
                                 "
)

Sold_quarterly_trend_2017<-sqldf("select Quarter, count(*) as count_Sold_quarter
                                 from NV_data_Dubai
                                 where Lead_status='Sold'
                                 group by Quarter
                                 "
)

write.csv(Lead_quarterly_trend_2017,"Lead_quarterly_trend_2017.csv")
write.csv(Sold_quarterly_trend_2017,"Sold_quarterly_trend_2017.csv")

##Monthly****************

Lead_monthly_trend_2017<-sqldf("select Month, count(*) as count_Leads_Month
                               from NV_data_Dubai
                               group by Month
                               "
)

Sold_monthly_trend_2017<-sqldf("select Month, count(*) as count_Sold_Month
                               from NV_data_Dubai
                               where Lead_status='Sold'
                               group by Month
                               "
)

write.csv(Lead_monthly_trend_2017,"Lead_monthly_trend_2017.csv")
write.csv(Sold_monthly_trend_2017,"Sold_monthly_trend_2017.csv")

##(x) Process Time

##Sold Leads

Sold_process_time_2017<-sqldf("select Process_Time
                              from NV_data_Dubai
                              where Lead_status='Sold'
                              order by Process_Time
                              "
)

Lost_process_time_2017<-sqldf("select Process_Time
                              from NV_data_Dubai
                              where Lead_status='Lost'
                              order by Process_Time
                              "
)

write.csv(Sold_process_time_2017,"Sold_process_time_2017.csv")
write.csv(Lost_process_time_2017,"Lost_process_time_2017.csv")

##(xi) Origin of Leads

Leads_origin_2017<-sqldf("select Origin, count(*) as count_Leads_Origin
                         from NV_data_Dubai
                         group by Origin
                         order by count_Leads_Origin desc
                         "
)

Sold_origin_2017<-sqldf("select Origin, count(*) as count_Sold_Origin
                        from NV_data_Dubai
                        where Lead_status='Sold'
                        group by Origin
                        order by count_Sold_Origin desc
                        "
)

write.csv(Leads_origin_2017,"Leads_origin_2017.csv")
write.csv(Sold_origin_2017,"Sold_origin_2017.csv")

