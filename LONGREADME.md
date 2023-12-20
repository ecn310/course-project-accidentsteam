# The Effect of Establishment Size on Work Place Accidents
## Data sources
The data are from OSHA’s annual collections through the Injury Tracking Application (ITA). OSHA public the data collected by the manual submissions via web forms, CSV files or API to the ITA  from establishments about their injury data. 

## Part 1: Access to the Data
1.	Go to the accidents team public repo found on at this website: https://github.com/ecn310/course-project-accidentsteam
2.	Go to Reproducibility Folder
3.	Inside the Data folder, press on file entitled “ITA-data-cy2023.2 (1).zip”. path: 
4.	Download or clone the file as a zip. This file will be a CSV file when unzipped. 
5.	Convert the CSV file into a DTA file. 
6.	Import the CSV file using the following code: import delimited "C:\Users\asrupert\OneDrive - Syracuse University\Accidents\ITA Data CY 2022 submitted thru 7-31-2023.csv", encoding(UTF-8). Make sure you change the path to where you download the file! 
7.	Then, use the following code to save the file as a STATA.dta file: save "Data.dta", replace
8.	(In MASTER.do, edit line 49) Change the directory of the data based on where you want any logs, graphs, or files saved.
9.	(In MASTER.do, run line 49-50) Finally, run the code to use the data in STATA. 

## Part 2: Data Fix
To begin we needed to see if there were any issues within the data that would skew our results. We used the codebook command to identify the range, standard deviation, percentiles and other statistics on the variables. We can note that, as it stands, there are many variables with broken data. We do not use all these variables, but a more holistic approach allowed us to fix as much as possible. 
1.	(In MASTER.do, run line 56-67) We found that the initial standard deviation on the total_djtr_days was unacceptable (119972) with a range of [-54,70247620].
2.	(In MASTER.do, run line 76-77) The code changes any physically impossible data points like above to NULL. In doing so we managed to marginally improve the variable (std dev 418.458, range [0,94903]) as well as a notable change mean (291.686 => 62.2916).
3.	(In MASTER.do, run line 88-95) Overall, the needed variables are in good condition now. There are no clear mistakes in the data that would promote an ethical exclusion. The only exception is annual_average_employees, there is outliers present but we cannot delete data points that are technically possible.

## Part 3: Creating new variables. 
To approach our hypothesis we need to create variables that make analysis more straight forward.
1.	(In MASTER.do, run line 114-115) Create the first variable entitled inj_rate. It will be the quotient of total_injuries and annual_average_employees. This new variable will display the injury rate for each establishment in the data set. 
2.	(In MASTER.do, run line 131-133) Replicate the gen command to create new variables of all the injury types we are analyzing: total_respiratory_conditions, and total_skin_disorders, total_poisonings, and get the mean rate of each illness. 
3.	(In MASTER.do, run line 116-129) Create a new variable called decile, which separates annual_average_employees into deciles based on percentiles. In doing so, we can see the injury rate for each level of establishment size instead of just across all firms. 

## Part 4: Analysis and Outputs

