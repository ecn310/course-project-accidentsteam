/*********************************************************
Welcome to the Master.Do-File for the Accidents Team Project.

Data Source: OSHA's Accident Reports Data, which can be found at https://www.osha.gov/Establishment-Specific-Injury-and-Illness-Data

Authors: Accidents Team Members, Anna, Yuhan, Tomoyoshi, and Will. Students at Syracuse University

Purpose: This do-file explores the data from OSHA from the perspective of our team's hypothesis. We are examining the effect of establishment size on workplace accidnets. The following infromation is seperated into 3 main parts. Examining the data, fxing any broken portion of the data, and analzying the data. 


Directions: READ BEFORE RUNNING DO FILE

Part 1: Opening the data.

1.  Go to the webstie above and press the link entitled CY 2022, this lettering should be blue. This will download a zip file of the data. 

2.  Go to your downloads and press the zip file. This will open the zip file in your downloads. This will not download as a Sata data file, it will download as a CSV file. 

3. Converting this CSV file into a a DTA file. 

3a. Open stata and use this change directory command: cd "C:\Path\To\Your\Folder". This will allow you to save the data to the folder of your choice.

3b. Then, use the following code to import the CSV file: import delimited "yourfile.csv". 

3c. Then, use the following code to save the file as a STATA date file: save "Data.dta", replace
We used the name data.dta and we reccomend you use the same name to limit any issues when running the do-file. 


4. Finally, change the directory of the data based on where you want any logs,graphs, or files saved. 

5. Follow the rest of the do-file, there are notes explaining each part!
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

Second, The code below changes any physically impossible data points to null. In doing so we managed to marginally improve the variable (std dev 418.458, range [0,94903]) as well as a notable change mean (291.686 => 62.2916). 

****************************************************************/

. replace total_djtr_days = . if total_djtr_days>total_hours_worked | total_djtr_days<0 | total_djtr_days==total_hours_worked
. replace annual_average_employees = . if annual_average_employees>total_hours_worked | annual_average_employees<0 | annual_average_employees==total_hours_worked | annual_average_employees==123456 | annual_average_employees==123546



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

2. We will replicate this new across all of the injury types we are analzying, total_respiratory_conditions, and total_skin_disorders, total_poisonings. 

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

. gen total_respiratory_conditionsrate=total_respiratory_conditions/annual_average_employees
. gen total_poisonings_rate=total_poisonings/annual_average_employees
. gen total_skin_disordersrate=total_skin_disorders/annual_average_employees


/** Part 4: Analysis

After creating all of the needed variables we can begin to created graphs using the mean rate for total injuries and the injury types over decile groups to test on our hypothesis. We would have used median but due to 0 being the common median aross variables most of the graphs were not helpful for further analysis. 

****/

. graph bar inj_rate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees") title("Mean Inj_Rate Across Deciles") 

. graph export Inj_RateDecileBar.png, replace 
 
. graph bar total_respiratory_conditionsrate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees") title("Mean Respiratory Conditions Rate across Deciles")

. graph export RespiratoryDecileBar.png, replace 

. graph bar total_poisonings_rate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees") title("Mean Poisoning Rate across Deciles")

. graph export PoisoningsDecileBar.png, replace 

. graph bar total_skin_disordersrate, over(decile) blabel(bar) b1title("Decile Groups For Annual Average Number of Employees")title("Mean Skin Disorder Rate across Deciles")

. graph export SkinDecileBar.png, replace 



** Part 4 continued: This section of the code aims to find any possible correlations between the variables above. Simple correlation testing.

. correlate decile total_skin_disordersrate
. correlate decile total_poisonings_rate
. correlate decile total_respiratory_conditionsrate
. correlate decile inj_rate

** Part 4 continued: We are also including sum with detail to understand the descriptive statistics behind each of the varibales we use. This way we can understand the mean, median, and standard deviation of all of our varibales. 

. sum inj_rate, detail 
. sum total_poisonings_rate, detail
. sum total_respiratory_conditionsrate, detail
. sum total_skin_disordersrate, detail
. sum decile, detail

/** 
For the variable total_poisonings_rate, the bar graph for the first decile looked very high compared to other decile groups.

We are including a check for potential outliers so we can better understand why the first decile was so large.

We also included a box plot to show the different outliers within each decile and the variance within each decile.
 
 ******/
. codebook total_poisonings_rate
. tab total_poisonings_rate
. graph box inj_rate, over(decile) title("Injury Rate Distribution by Decile")
. _pctile annual_average_employees, p(10(10)90)






