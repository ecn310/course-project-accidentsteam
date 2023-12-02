
/***************************************************************
'This is a do-file for the decile project we have been working on. 

created november 29th, 2023
************************************************/

use"C:\Users\asrupert\OneDrive - Syracuse University\Accidents\Data.dta"
_pctile annual_average_employees, p(10(10)90)
ret li
sum annual_average_employees, detail
gen decile = 10
replace decile = 9 if annual_average_employees < 243
replace decile = 8 if annual_average_employees < 134
replace decile = 7 if annual_average_employees < 89
replace decile = 6 if annual_average_employees < 64
replace decile = 5 if annual_average_employees < 46
replace decile = 4 if annual_average_employees < 34
replace decile = 3 if annual_average_employees < 25
replace decile = 2 if annual_average_employees < 19
replace decile = 1 if annual_average_employees < 8
tabstat annual_average_employees, by(decile) s(n sum mean)

