/*********************************************************
Welcome! This is the Do-File for the Accidents Group. 
Created November 7th, 2023

Inital Notes: 
This Do-File allows ones to insert and view the data as well as highlight 
some of the groups steps towards understanding the different varibales
within the data. 

Using codebook, sum, and other descriptive commands we can view the ins and outs 
of each varible and even attempt to graph the data. 

In this do-file we used the total_injuries variable and compared the total number of injuries to 
the different types of injuires recorded using a bar graph. 


*********************************************************/

. clear

. import delimited "C:\Users\wmwaghor\OneDrive - Syracuse University\ECN310\ITADATACY20227312023", encoding(UTF-8) 

. codebook total_hours_worked
. codebook annual_average_employees
. codebook total_dafw_cases
