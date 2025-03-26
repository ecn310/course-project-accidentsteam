# Comprehensive ReadMe: The Effect of Establishment Size on Work Place Accidents
All the code below can be run from the [Master.do](https://github.com/ecn310/course-project-accidentsteam/blob/main/Reproducibility%20Package/Master.do) in STATA. 
## Data sources
The data being used for this research project is from the Occupational Safety and Health Administration (OSHA). OSHA, the Occupational Safety and Health Administration, collects data primarily from private sector employers, including those in construction, general industry, and maritime. The agency's coverage extends to federal government employees, excluding those in the United States Postal Service. OSHA's data collection focuses on workplace injuries and illnesses, aiding in the enforcement of safety regulations and the identification of areas for improvement in various industries.

## Part 1: Access to the Data
1.	Go to the accidents team public repo found on at this website: https://github.com/ecn310/course-project-accidentsteam 
2.	Select the Reproducibility Folder
3.	Inside the Data folder, press on file entitled “ITA-data-cy2023.2 (1).zip” 
4.	Press the Download button or clone the file as a zip, we recommend downloading the file.

## Part 2: Converting the File from CSV to DTA 
1. Find the CSV file in your downloads.
2.  Select "Extract All..." from the context menu. 
3. Choose the destination folder where you want to extract the contents.
Click "Extract." This will unzip the file. 
4. Import the CSV file into stata using the following code: import delimited "C:YOUR PATH\ITA Data CY 2022 submitted thru 7-31-2023.csv", encoding(UTF-8). Make sure you change the path to where you download the file! 
9.	Then, use the following code to save the file as a STATA.dta file: save "Data.dta" 

NOTE: You do not need to use the replace command because it is good practice to keep the original data source. 


## Important: The following is an explantion of our master do-file which can be found in the reproducibility folder. There is not need to follow these step by step because our master do.file will complete it all at once. However, feel free to follow the rest of the readME

To Skip the Following use stata to open the: [Master.do](https://github.com/ecn310/course-project-accidentsteam/blob/main/Reproducibility%20Package/Master.do)

## Part 3: Data Fix
To begin we needed to see if there were any issues within the data that would skew our results. We used the codebook command to identify the range, standard deviation, percentiles and other statistics on the variables. We can note that, as it stands, there are many variables with broken data. We do not use all these variables, but a more holistic approach allowed us to fix as much as possible. 
1.	`(In MASTER.do, run line 56-67)` We found that the initial standard deviation on the total_djtr_days was unacceptable (119972) with a range of [-54,70247620].
2.	`(In MASTER.do, run line 76-77)` The code changes any physically impossible data points like above to NULL. In doing so we managed to marginally improve the variable (std dev 418.458, range [0,94903]) as well as a notable change mean (291.686 => 62.2916).
3.	`(In MASTER.do, run line 88-95)` Overall, the needed variables are in good condition now. There are no clear mistakes in the data that would promote an ethical exclusion. The only exception is annual_average_employees, there is outliers present but we cannot delete data points that are technically possible.

## Part 4: Creating new variables. 
To approach our hypothesis we need to create variables that made analysis straight forward, meaning we needed per capita variables. 
1.	`(In MASTER.do, run line 114-115)` Create the first variable entitled inj_rate. Which is the quotient of total_injuries and annual_average_employees. This new variable will display the injury rate for each establishment in the data set. 
2.	`(In MASTER.do, run line 131-133)` Replicate the gen command to create new variables of all the injury types we are analyzing: total_respiratory_conditions, and total_skin_disorders, total_poisonings, and get the mean rate of each illness. 
3.	`(In MASTER.do, run line 116-129)` Create a new variable called decile, which separates annual_average_employees into deciles based on percentiles. In doing so, we can see the injury rate for each level of establishment size instead of just across all firms. 

## Part 5: Analysis and Outputs
After creating all the needed variables using the fixed data, we can start to perform analysis on data. All outputs are in the Final Project (2) folder on the repo home page. 
1.	`(In MASTER.do, run line 142-156)` Create graphs using the mean rate for total injuries and the injury types over decile groups to test on our hypothesis. We would have used median, but due to 0 being the common median across variables, most of the graphs were not helpful for further analysis.
2.	`(In MASTER.do, run line 162-165)` Simple correlation test to try to find any possible correlations between the essential variable. 
3.	`(In MASTER.do, run line 169-173)` Use sum command with detail to understand the descriptive statistics behind each of the variables we use. This way we can understand the mean, median, and standard deviation of all our variables. 
4.	`(In MASTER.do, run line 183-186)` The first decile on the bar graph of total_poisonings_rate looked very high compared to other decile groups. Additional check for potential outliers using codebook, tab, boxplot are needed so that we can better understand why the first decile was so large. 


