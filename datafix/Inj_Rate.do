. clear
use "C:\Users\asrupert\OneDrive - Syracuse University\Accidents\Data.dta"

. gen inj_rate=total_injuries/annual_average_employees
. browse inj_rate total_injuries annual_average_employees
. summarize inj_rate
. scatter inj_rate total_deaths


