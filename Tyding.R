## HEADER ####
## Who: <William Banda>
## What: C7090 Masters Research Project (MRP)
## Last edited: 2024-05-05
####

## CONTENTS ####
## 00 Setup
## 01 Import Data
## 02 Data Tidying
## 03 Exploratory Data Analysis

## 00 Setup
# Get working directory
getwd() # Prints working directory in Console

## Set working directory
setwd("C:/Users/WilliamBanda1/Documents/MRP")

# Install and load necessary packages
# Install reshape2 package if not already installed
install.packages("reshape2")
install.packages(c("writexl", "shiny", "ggplot2"))
library(readr)
library(tidyverse)
library(dplyr)
library(openxlsx)
library(readxl)
library(ggplot2)
library(shiny)
library(writexl)
library(plotly)
library(reshape2)

# Read the Excel file
Dairy <- read_xlsx("C:/Users/WilliamBanda1/Documents/MRP/dairy.xlsx")

# Display column types
glimpse(Dairy)

## 02 Data Tidying
summary(Dairy)

# Rename the columns of the dataframe
Dairy <- Dairy %>%
  rename(
    date = Date,  
    cows_in_milk = `Cows in Milk`,  
    cows_in_tank = `Cows in Tank`,  
    milk_produced = `Milk produced`, 
    milk_per_cow = `Milk/Cow`,   
    straw_yard = `Straw Yard`,  
    highs = Highs,   
    trial1 = `Trial 1`,  
    trial2 = `Trial 2`,
    low = Low,  
    hscc = HSCC,  
    scc = SCC, 
    bs = BS,  
    fat = Fat, 
    protein = Protein
  )

# Convert date column to Date format
Dairy$date <- as.Date(Dairy$date, format = "%d/%m/%Y")

# Convert all character variables to numeric
Dairy <- Dairy %>%
  mutate(across(where(is.character), as.numeric))

# Save modified 'Data' dataframe to a new Excel file
write.xlsx(Dairy, "modified.xlsx", rowNames = FALSE)

# Load the original Excel file
original_wb <- "C:/Users/WilliamBanda1/Documents/MRP/dairy.xlsx"

# Extract the "Dictionary" sheet
dictionary_sheet <- read_excel(original_wb, sheet = "Dictionary")

# Create a new Excel file
new_wb <- createWorkbook()

# Add the "tidy_data" dataframe as the first sheet
addWorksheet(new_wb, "Tidy_Data")
writeData(new_wb, "Tidy_Data", Dairy)

# Add the "Dictionary" sheet as the second sheet
addWorksheet(new_wb, "Dictionary")
writeData(new_wb, "Dictionary", dictionary_sheet)

# Save the new Excel file
saveWorkbook(new_wb, "tidy_data.xlsx")

