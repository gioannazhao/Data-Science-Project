# Load packages
install.packages("janitor")
library(janitor)
library(tidyverse)
library(psych)
library(table1)
library(rties)
library(readr)
library(lubridate)



#Set WD
setwd("~/Desktop/PSEA")

#Read in Data
solar_data <- read.csv("Qualified_Facilities_Report.csv", stringsAsFactors = T)

# Check Data loaded in correctly
str(solar_data)
head(solar_data)

# Rename columns manually
colnames(solar_data) <- c("PA_certification","Facility_Name", "Total_NPC_MW_DC", "Total_NPC_MW_AC", 
                          "Fuel_Type", "County", "State", "Zip_Code", "Certification_Date")

# Check if renaming worked
print(colnames(solar_data))


# Clean column names using janitor
clean_solar_data <- solar_data %>% clean_names()
head(clean_solar_data)

# Remove the first and second row from solar_data_clean
clean_solar_data <- clean_solar_data %>% slice(-c(1,2))

# Convert certification_date to Date format and extract the year
clean_solar_data <- clean_solar_data %>%
  mutate(Year = year(mdy(certification_date))) 


# Extract the last 4 characters (year) from certification_date
clean_solar_data$Year <- as.numeric(substr(clean_solar_data$certification_date, nchar(clean_solar_data$certification_date)-3, nchar(clean_solar_data$certification_date)))


# Display the updated dataset
head(clean_solar_data)
print(colnames(clean_solar_data))
str(clean_solar_data)


# Filter data for Pennsylvania (PA) and years 2004-2025
pa_data <- clean_solar_data %>%
  filter(state == "PA" & Year >= 2004 & Year <= 2025)

# Convert total_npc_mw_ac from factor to numeric
clean_solar_data <- clean_solar_data %>%
  mutate(total_npc_mw_ac = as.numeric(as.character(total_npc_mw_ac)))  # Convert factor → character → numeric

clean_solar_data <- clean_solar_data %>%
  mutate(total_npc_mw_dc = as.numeric(as.character(total_npc_mw_dc)))  # Convert factor → character → numeric


# Group by year and summarize AC
annual_totals_ac <- clean_solar_data %>%
  group_by(Year) %>%
  summarize(Total_NPC_MW_AC = sum(total_npc_mw_ac, na.rm = TRUE))

# Print the cleaned data
print(annual_totals_ac)

# Create bar chart using ggplot2
ggplot(annual_totals_ac, aes(x = factor(Year), y = Total_NPC_MW_AC)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Total NPC MW AC in Pennsylvania (2004-2025)",
       x = "Year",
       y = "Total NPC MW AC") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Line chart for AC
ggplot(annual_totals_ac, aes(x = Year, y = Total_NPC_MW_AC)) +
  geom_line(color = "steelblue", size = 1.2) + 
  geom_point(color = "red", size = 2) +         
  labs(title = "Total NPC MW AC in Pennsylvania (2004-2025)",
       x = "Year",
       y = "Total NPC MW AC") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  


# Group by year and summarize DC
annual_totals_dc <- clean_solar_data %>%
  group_by(Year) %>%
  summarize(Total_NPC_MW_DC = sum(total_npc_mw_dc, na.rm = TRUE))

# Create bar chart using ggplot2
ggplot(annual_totals_dc, aes(x = factor(Year), y = Total_NPC_MW_DC)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Total NPC MW DC in Pennsylvania (2004-2025)",
       x = "Year",
       y = "Total NPC MW DC") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Line chart for DC
ggplot(annual_totals_dc, aes(x = Year, y = Total_NPC_MW_DC)) +
  geom_line(color = "steelblue", size = 1.2) +  
  geom_point(color = "red", size = 2) +       
  labs(title = "Total NPC MW DC in Pennsylvania (2004-2025)",
       x = "Year",
       y = "Total NPC MW DC") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))







