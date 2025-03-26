/*********************************************************
Welcome to the Master.Do-File for the Accidents Team Project.

Data Source: OSHA's Accident Reports Data, which can be found at https://www.osha.gov/Establishment-Specific-Injury-and-Illness-Data

Authors: Accidents Team Members, Anna, Yuhan, Tomoyoshi, and Will. Students at Syracuse University

Purpose: This do-file explores the data from OSHA from the perspective of our team's hypothesis. We are examining the effect of establishment size on workplace accidnets. The following infromation is seperated into 3 main parts. Examining the data, fxing any broken portion of the data, and analzying the data. 


Directions: READ BEFORE RUNNING DO FILE

NOTE: We have a copy of the converted data linked in our team Read.Me if you would like to avoid this process. If you want to reproduce everything from scratch you must follow this process. 

Part 1: Opening the data.

1. Go to the accidents team public repo found on at this website: https://github.com/ecn310/course-project-accidentsteam

2. Go to Reproducibility Package Folder. 

3. Press on the Data Folder

4. Inside the Data folder press on the file entitled "ITA-data-cy2023.2 (1).zip"

5. Download the file as a zip. This file will be a CSV file when unzipped.

6. Now we are going to converting this CSV file into a a DTA file. 

6a. Open stata and make sure there is not data sets open, clear command. 

6b. Then, use the following code to import the CSV file: 

import delimited "C:\Users\asrupert\OneDrive - Syracuse University\Accidents\ITA Data CY 2022 submitted thru 7-31-2023.csv", encoding(UTF-8) 

MAKE SURE YOU CHANGE THE C TO WHERE YOU DOWNLOADED THE FILE!!!!

6c. Then, use the following code to save the file as a STATA date file: 

save "Data.dta", replace
We used the name data.dta and we reccomend you use the same name to limit any issues when running the do-file. 

6d. Clear! and then before running this file follow the next instructions. 


7. Finally, change the directory of the data based on where you want any logs,graphs, or files saved. 

8. Follow the rest of the do-file, there are notes explaining each part!
*********************************************************/
. cd "C:\Users\asrupert\OneDrive - Syracuse University\Accidents"
. use Data.dta
/*********************************************************
Part 2: Data Fix 

To begin we needed to see if there were any issues within the data that would skew our results. We used the codebook command to identify the range, standard deviation, percentiles and other statistics on the variables. We can note that, as it stands, there are many variables with broken data. We do not use all of these variables, but a more holistic approach allowed us to fix as much as possible.
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

/*********************************************************
First, we found that the initial standard deviation on the total_djtr_days var. was unacceptable (119972) with a range of [-54,70247620]. 


Second, The code below changes any physically impossible data points to null. In doing so we managed to marginally improve the variable (std dev 418.458, range [0,94903]) as well as a notable change mean (291.686 => 62.2916). This helps reduce the incorrectly entered data points. 

****************************************************************/

. replace total_djtr_days = . if total_djtr_days>total_hours_worked | total_djtr_days<0 | total_djtr_days==total_hours_worked

***** This step eliminates any impossible data points. 

. replace annual_average_employees = . if annual_average_employees>total_hours_worked | annual_average_employees<0 | annual_average_employees==total_hours_worked | annual_average_employees==123456 | annual_average_employees==123546

**** We used this step to eliminate the data points that would incorrectly skew our data. This points would not be possible and must be explained by a system error. 


/***********************
The following variables are the focus point of our report. Overall, they are in good condition generally. There are no clear mistakes in the data that would promote an ethical exclusion. 

The only exception is annual_average_employees, there is outliers present but we cannot delete data points that are technically possible. 
********/


. codebook annual_average_employees
. codebook total_deaths 
. codebook total_injuries
. codebook total_poisonings
. codebook total_respiratory_conditions
. codebook total_skin_disorders
. codebook total_hearing_loss 
. codebook total_other_illnesses


/*** 
Part 3: Creating new Variables. 

To approach our hypothesis we need to create variables that make analysis more straight forward. 

1. The first varibale created is entitled inj_rate and will be the quotient of total_injuries and annual_average_employees. This will give us the injury rate for each establishment in our data set. 

2. We will replicate this new across all of the injury types we are analzying, total_respiratory_conditions, and total_skin_disorders, total_poisonings, total_other_illnesses, and total_hearing_loss. 

3. The next variable we will be creating is entitled is decile, this varibale is seprating annual_average_employees into deciles based on percentiles. 

In doing this, we can now see the injury rate for each level of establishment size instead of just acorss all firms. This will make our analysis much easier to present.
 
***/


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

** Now that we have created the decile groups for annual_average_employees, we can generate the variables used for the analysis. 

. gen total_respiratory_conditionsrate=total_respiratory_conditions/annual_average_employees
. gen total_poisonings_rate=total_poisonings/annual_average_employees
. gen total_skin_disordersrate=total_skin_disorders/annual_average_employees
. gen total_hearing_lossrate=total_hearing_loss/annual_average_employees
. gen total_other_illnessessrate=total_other_illnesses/annual_average_employees


/** Part 4: Analysis

After creating all of the needed variables we can begin to created graphs using the mean rate for total injuries and the injury types over decile groups to test on our hypothesis. We would have used median but due to 0 being the common median aross variables most of the graphs were not helpful for further analysis. We also include a summary statistics table to compare the important descriptive statistics for these varibales. 

****/

. graph bar inj_rate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees") title("Mean Injury Rate Across Deciles") ytitle ("Injury Rate")

. graph export Inj_RateDecileBar.png, replace 
 
. graph bar total_respiratory_conditionsrate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees") title("Mean Respiratory Conditions Rate across Deciles") ytitle ("Injury Rate")

. graph export RespiratoryDecileBar.png, replace 

. graph bar total_poisonings_rate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees") title("Mean Poisoning Rate across Deciles") ytitle ("Injury Rate")

. graph export PoisoningsDecileBar.png, replace 

. graph bar total_skin_disordersrate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees")title("Mean Skin Disorder Rate across Deciles") ytitle ("Injury Rate")

. graph export SkinDecileBar.png, replace 

. graph bar total_hearing_lossrate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees") title("Mean Hearing Loss Rate Across Deciles") ytitle ("Injury Rate") 

 graph export HearingDecileBar.png, replace
 
** The code below highlights an important aspect of comparing our data: The Summary Statistics Table. This table compares mean standard deviation coefficent of variation and quartiles. 
. tabstat total_skin_disordersrate total_poisonings_rate total_respiratory_conditionsrate total_hearing_lossrate total_other_illnessessrate, stat(n mean sd cv q) col(stat)
** The next step is to store this estimates using the estpost command, which also saves a bunch of info as e-class locals:
estpost tabstat total_skin_disordersrate total_poisonings_rate total_respiratory_conditionsrate total_hearing_lossrate total_other_illnessessrate, stat(n mean sd cv q) col(stat)
*** This code adds formatting
esttab, cells("mean sd cv(fmt(%6.2fc)) count") nonumber nomtitle nonote noobs label collabels( "Mean" "SD" "CV" "N")
** Now we must create the latex format for the table. 
 esttab using "table1.tex", replace cells("mean sd cv(fmt(%6.2fc)) count") nonumber nomtitle nonote noobs label collabels( "Mean" "SD" "CV" "N")
** Open the table in any application that Stata permits, we used Notepad and then put the code into Latex direclty. 


** Part 4 continued: This section of the code aims to find any possible correlations between the variables above. Simple correlation testing.

. correlate decile total_skin_disordersrate
. correlate decile total_poisonings_rate
. correlate decile total_respiratory_conditionsrate
. correlate decile inj_rate
. correlate decile total_hearing_lossrate
. correlate decile total_other_illnessessrate

** Part 4 continued: We are also including sum with detail to understand the descriptive statistics behind each of the varibales we use. This way we can understand the mean, median, and standard deviation of all of our varibales. 

. sum inj_rate, detail 
. sum total_poisonings_rate, detail
. sum total_respiratory_conditionsrate, detail
. sum total_skin_disordersrate, detail
. sum decile, detail
. sum total_hearing_lossrate, detail
. sum total_other_illnessessrate, detail 

/** 
For the variable total_poisonings_rate, the bar graph for the first decile looked very high compared to other decile groups.

We are including a check for potential outliers so we can better understand why the first decile was so large.

We also included a box plot to show the different outliers within each decile and the variance within each decile.
 
 ******/
. codebook total_poisonings_rate
. tab total_poisonings_rate
. graph box inj_rate, over(decile) title("Injury Rate Distribution by Decile") b1title("Decile Groups For Annual Average Number of Employees") ytitle ("Injury Rate") 

 graph export BoxInjury.png , replace
 
. _pctile annual_average_employees, p(10(10)90)








