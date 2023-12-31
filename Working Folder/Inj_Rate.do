/*********************************************************
This do-file is a experimental creation for potential use. 
We have been sorting through our data and attempting to find the best variable to use to serve the needs of our hypothesis. 
In doing so I have created a new varibale called inj_rate which is the total_injuries/annual_average_employees.
This variable is much easier to view and analyze and could be used for our final project. 


Author of this Do-File: Anna Rupert

Date Created: November 15th, 2023
*********************************************************/

. clear
use "C:\Users\asrupert\OneDrive - Syracuse University\Accidents\Data.dta"

. gen inj_rate=total_injuries/annual_average_employees
. browse inj_rate total_injuries annual_average_employees
. summarize inj_rate
. scatter inj_rate total_deaths


