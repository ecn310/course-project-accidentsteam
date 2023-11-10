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

/*********************************************************
I was originally trying to do the above manually. I'm sorry
. replace total_djtr_days = . if id=="2040601" 
. replace total_djtr_days = . if id=="1976791" 
. replace total_djtr_days = . if id=="1847833" 
. replace total_djtr_days = . if id=="2000027" 
. replace total_djtr_days = . if id=="1921464" 
. replace total_djtr_days = . if id=="2060267" 
. replace total_djtr_days = . if id=="2090780" 
. replace total_djtr_days = . if id=="1923684" 
. replace total_djtr_days = . if id=="1837940" 
. replace total_djtr_days = . if id=="1868463" 
. replace total_djtr_days = . if id=="1990656" 
. replace total_djtr_days = . if id=="2085560"
. replace total_djtr_days = . if id=="1813541"
. replace total_djtr_days = . if id=="1813528"
. replace total_djtr_days = . if id=="1813533"
. replace total_djtr_days = . if id=="2039223"
. replace total_djtr_days = . if id=="1928686"
. replace total_djtr_days = . if id=="2039122"
. replace total_djtr_days = . if id=="1842811"
. replace total_djtr_days = . if id=="1866166"
. replace total_djtr_days = . if id=="2039093"
. replace total_djtr_days = . if id=="1899429"
. replace total_djtr_days = . if id=="1989414"
. replace total_djtr_days = . if id=="2038989"
. replace total_djtr_days = . if id=="1899404"
. replace total_djtr_days = . if id=="1846381"
. replace total_djtr_days = . if id=="2039138"
. replace total_djtr_days = . if id=="2039011"
. replace total_djtr_days = . if id=="2038698"
. replace total_djtr_days = . if id=="1989409"
. replace total_djtr_days = . if id=="2038797"
. replace total_djtr_days = . if id=="2005191"
. replace total_djtr_days = . if id=="2038997"
. replace total_djtr_days = . if id=="2039099"
. replace total_djtr_days = . if id=="2038267"
. replace total_djtr_days = . if id=="2015133"
. replace total_djtr_days = . if id=="2038243"
. replace total_djtr_days = . if id=="2039169"
. replace total_djtr_days = . if id=="2038962"
. replace total_djtr_days = . if id=="2039190"
. replace total_djtr_days = . if id=="2039151"
. replace total_djtr_days = . if id=="2038783"
. replace total_djtr_days = . if id=="1928685"
. replace total_djtr_days = . if id=="1792026"
. replace total_djtr_days = . if id=="1961523"
. replace total_djtr_days = . if id=="1844950"
. replace total_djtr_days = . if id=="1936299"
. replace total_djtr_days = . if id=="2039078"
. replace total_djtr_days = . if id=="1928684"
. replace total_djtr_days = . if id=="2038272"
. replace total_djtr_days = . if id=="2039064"
. replace total_djtr_days = . if id=="2039246"
. replace total_djtr_days = . if id=="2039007"
. replace total_djtr_days = . if id=="1940455"
. replace total_djtr_days = . if id=="2080450"
. replace total_djtr_days = . if id=="1824204"
. replace total_djtr_days = . if id=="1790636"
. replace total_djtr_days = . if id=="1791526"
. replace total_djtr_days = . if id=="1964450"
. replace total_djtr_days = . if id=="1942096"

*********************************************************/