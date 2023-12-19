
/***************************************************************
'This is a do-file for the bar graph based on the decile.do 

created december 3rd, 2023
************************************************/

use"C:\Users\ywang399\OneDrive - Syracuse University\Desktop\ECN310\Data.dta"
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

** use bar charts to show the average or median of injuries for each decile
** or try box plot 
gen inj_rate = total_injuries / annual_average_employees

graph bar total_injuries, ///
over(decile) ///
blabel(bar) ///
b1title("Decile of annual_average_employees")


graph bar total_respiratory_conditions, ///
over(decile) ///
blabel(bar) ///
b1title("Decile of annual_average_employees")


graph bar total_poisoning, ///
over(decile) ///
blabel(bar) ///
b1title("Decile of annual_average_employees")

graph bar total_skin_disorders, ///
over(decile) ///
blabel(bar) ///
b1title("Decile of annual_average_employees")
