/*********************************************************
This is the Do-File for Will's (among others) datafix project 
Created November 8th, 2023

Inital Notes: 
This Do-File iterates off of Anna's do-file by originally taking its ability to import the .csv data, before adapting to the new .dta dataset
The intention of this do-file is to identify outliers within our variables so that we might be able to fix them.
*********************************************************/

. clear

. use "C:\Users\wmwaghor\Syracuse University\Anna Sophia Rupert - Accidents\Data.dta"
/*********************************************************
This is to identify the range, standard deviation, percentiles and other statistics on the variables. We can note that, as it stands, there are many variables with broken data.
*********************************************************/
. codebook annual_average_employees 
. codebook total_hours_worked 
. codebook no_injuries_illnesses 
. codebook total_deaths 
. codebook total_dafw_cases 
. codebook total_djtr_cases 
. codebook total_other_cases 
. codebook total_dafw_days 
. codebook total_djtr_days 
. codebook total_injuries 
. codebook total_poisonings 
. codebook total_respiratory_conditions 
. codebook total_skin_disorders 
. codebook total_hearing_loss 
. codebook total_other_illnesses 
. codebook establishment_id 
. codebook establishment_type size

