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

. import delimited "C:\Users\asrupert\OneDrive - Syracuse University\Accidents\ITA Data CY 2022 submitted thru 7-31-2023.csv", encoding(UTF-8) 

. codebook total_injuries
. tabulate total_injuries 
. codebook total_poisonings
. codebook total_respiratory_conditions
. codebook total_skin_disorders
. codebook total_hearing_loss
.  graph bar total_poisonings total_respiratory_conditions total_skin_disorders total_hearing_loss total_injuries



