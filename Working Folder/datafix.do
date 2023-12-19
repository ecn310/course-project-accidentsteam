/*********************************************************
!!!WE ARE USING DATA.DTA
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

** 11/10/2023 Will - I think I'm shooting threes with this but basically I found that the initial standard deviation on the total_djtr_days var. was unacceptable (119972) with a range of [-54,70247620]. By using the code below I managed to marginally improve the variable (std dev 418.458, range [0,94903]). Other notable changes in mean (291.686 => 62.2916). I think this was a step in the right direction overall (https://www.bls.gov/iif/overview/soii-overview/days-of-job-transfer-or-restriction-collection.htm) 

. replace total_djtr_days = . if total_djtr_days>total_hours_worked | total_djtr_days<0 | total_djtr_days==total_hours_worked
. replace annual_average_employees = . if annual_average_employees>total_hours_worked | annual_average_employees<0 | annual_average_employees==total_hours_worked | annual_average_employees==123456 | annual_average_employees==123546
** ones below are what we will be using in the report. they are in good condition generally. only exception is annual_average_employees but we got it as good as we can
** 12/1/2023 Broadly speaking I think we have done the best we could to achieve the goals of the datafix project. Unless proven otherwise I think my work on this is finished
. codebook annual_average_employees
. codebook total_deaths 
. codebook total_injuries
. codebook total_poisonings
. codebook total_respiratory_conditions
. codebook total_skin_disorders
. codebook total_hearing_loss 
. codebook total_other_illnesses
