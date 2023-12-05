/*********************************************************
Welcome to the Final-Do File for the Accidents Team Project.

This do-file is using DATA.DTA from OSHAS Accident Reports Data.

This Do-File hightlights a data fix to create the most accurate data set to analyze. 

Post Data fix this do-file creates several seperate bar graphs and box plots to highlight the relationship between or data and our hypothesis.  


Inital Notes: 
This Do-File iterates off of Anna's do-file by originally taking its ability to import the .csv data, before adapting to the new .dta dataset
The intention of this do-file is to identify outliers within our variables so that we might be able to fix them.
*********************************************************/
. use "C:\Users\asrupert\OneDrive - Syracuse University\Accidents\Data.dta"
/*********************************************************
This is to identify the range, standard deviation, percentiles and other statistics on the variables. We can note that, as it stands, there are many variables with broken data.
*********************************************************/
. codebook annual_average_employees 
. codebook total_hours_worked 
. codebook no_injuries_illnesses 
. codebook total_deaths 
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
*** After the data fix we have to create a couple new varibales to highlight our data. The First varibale will be entitled inj_rate and will be the quotient of total_injuries and annual_average_employees. This will give us the injury rate for each firm in our data set. 
*** The second variable we will be using is decile, this varibale is seprating annual_average_employees into deciles. 
*** We also created varibales to make the different type of injurires a rate similar to inj_rate 


. gen inj_rate=total_injuries/annual_average_employees
. summarize inj_rate
. _pctile annual_average_employees, p(10(10)90)
. ret li
. sum annual_average_employees, detail
. gen decile = 10
. replace decile = 9 if annual_average_employees < 243
. replace decile = 8 if annual_average_employees < 134
. replace decile = 7 if annual_average_employees < 89
. replace decile = 6 if annual_average_employees < 64
. replace decile = 5 if annual_average_employees < 46
. replace decile = 4 if annual_average_employees < 34
. replace decile = 3 if annual_average_employees < 25
. replace decile = 2 if annual_average_employees < 19
. replace decile = 1 if annual_average_employees < 8
. tabstat annual_average_employees, by(decile) s(n sum mean)

. gen total_respiratory_conditionsrate=total_respiratory_conditions/annual_average_employees
. gen total_poisonings_rate=total_poisonings/annual_average_employees
. gen total_skin_disordersrate=total_skin_disorders/annual_average_employees


** After creating all of the needed variables we can begin to create graphs based on our hypothesis. 

. graph bar total_respiratory_conditionsrate, over(decile) blabel(bar) b1title("Decile of annual_average_employees")

. graph bar total_poisonings_rate, over(decile) blabel(bar) b1title("Decile of annual_average_employees")

. graph bar total_skin_disordersrate, over(decile) blabel(bar) b1title("Decile of annual_average_employees")

. graph bar inj_rate, over(decile) blabel(bar) b1title(" Mean Inj_Rate Across Deciles")

. graph box decile, blabel(bar) b1title("Decile Distribution")






