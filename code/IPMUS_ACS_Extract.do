
/*--------------------------------------------------
IPMUS supplementary code for ACS data extraction (edited)

					Edit history
	11-16-2025: Change import & export directory
	11-27-2025: Updated for new raw data
----------------------------------------------------*/

//================== Set Direcotry =======================//
global folder "C:\Projects\DMP"
cd "$folder"
global raw "$folder/raw"
global output "$folder/output"

/*
cap mkdir "$folder/output"
cap mkdir "$folder/output/tables"
cap mkdir "$folder/output/graphs"
cap mkdir "$folder/output/cleandata"
*/

global tables "$output/tables"
global graphs "$output/graphs"
global data "$output/data"


set more off
///////////////////////////////////////////////////////////



clear
quietly infix                  ///
  int     year        1-4      ///
  long    sample      5-10     ///
  double  serial      11-18    ///
  double  cbserial    19-31    ///
  double  hhwt        32-41    ///
  double  cluster     42-54    ///
  byte    region      55-56    ///
  byte    stateicp    57-58    ///
  byte    statefip    59-60    ///
  int     countyicp   61-64    ///
  int     countyfip   65-67    ///
  long    puma        68-72    ///
  int     cpuma0010   73-76    ///
  double  density     77-83    ///
  byte    metro       84-84    ///
  double  pctmetro    85-89    ///
  long    met2013     90-94    ///
  byte    met2013err  95-95    ///
  long    met2023     96-100   ///
  byte    met2023err  101-101  ///
  double  metpop10    102-109  ///
  double  metpop20    110-117  ///
  int     city        118-121  ///
  byte    cityerr     122-122  ///
  long    citypop     123-129  ///
  byte    homeland    130-130  ///
  double  strata      131-142  ///
  int     cntry       143-145  ///
  byte    gq          146-146  ///
  int     pernum      147-150  ///
  double  perwt       151-160  ///
  byte    relate      161-162  ///
  int     related     163-166  ///
  byte    sex         167-167  ///
  int     age         168-170  ///
  byte    birthqtr    171-171  ///
  byte    marst       172-172  ///
  int     birthyr     173-176  ///
  byte    marrno      177-177  ///
  byte    marrinyr    178-178  ///
  int     yrmarr      179-182  ///
  byte    divinyr     183-183  ///
  byte    widinyr     184-184  ///
  byte    fertyr      185-185  ///
  byte    race        186-186  ///
  int     raced       187-189  ///
  byte    hispan      190-190  ///
  int     hispand     191-193  ///
  int     bpl         194-196  ///
  long    bpld        197-201  ///
  int     ancestr1    202-204  ///
  int     ancestr1d   205-208  ///
  int     ancestr2    209-211  ///
  int     ancestr2d   212-215  ///
  byte    citizen     216-216  ///
  int     yrnatur     217-220  ///
  int     yrimmig     221-224  ///
  byte    yrsusa1     225-226  ///
  byte    yrsusa2     227-227  ///
  byte    language    228-229  ///
  int     languaged   230-233  ///
  byte    speakeng    234-234  ///
  int     tribe       235-238  ///
  long    tribed      239-244  ///
  byte    racamind    245-245  ///
  byte    racasian    246-246  ///
  byte    racblk      247-247  ///
  byte    racpacis    248-248  ///
  byte    racwht      249-249  ///
  byte    racother    250-250  ///
  byte    racnum      251-251  ///
  byte    school      252-252  ///
  byte    educ        253-254  ///
  int     educd       255-257  ///
  byte    gradeatt    258-258  ///
  byte    gradeattd   259-260  ///
  byte    schltype    261-261  ///
  byte    degfield    262-263  ///
  int     degfieldd   264-267  ///
  byte    degfield2   268-269  ///
  int     degfield2d  270-273  ///
  byte    empstat     274-274  ///
  byte    empstatd    275-276  ///
  byte    labforce    277-277  ///
  byte    classwkr    278-278  ///
  byte    classwkrd   279-280  ///
  int     occ         281-284  ///
  int     occ1950     285-287  ///
  int     occ1990     288-290  ///
  int     occ2010     291-294  ///
  str     occsoc      295-300  ///
  int     ind         301-304  ///
  int     ind1950     305-307  ///
  int     ind1990     308-310  ///
  str     indnaics    311-318  ///
  byte    wkswork1    319-320  ///
  byte    wkswork2    321-321  ///
  byte    uhrswork    322-323  ///
  byte    wrklstwk    324-324  ///
  byte    absent      325-325  ///
  byte    looking     326-326  ///
  byte    availble    327-327  ///
  byte    wrkrecal    328-328  ///
  byte    workedyr    329-329  ///
  long    inctot      330-336  ///
  long    ftotinc     337-343  ///
  long    incwage     344-349  ///
  long    incbus00    350-355  ///
  long    incss       356-360  ///
  long    incwelfr    361-365  ///
  long    incinvst    366-371  ///
  long    incretir    372-377  ///
  long    incsupp     378-382  ///
  long    incother    383-387  ///
  long    incearn     388-394  ///
  int     poverty     395-397  ///
  int     cbpoverty   398-400  ///
  byte    vetdisab    401-401  ///
  byte    diffrem     402-402  ///
  byte    diffphys    403-403  ///
  byte    diffmob     404-404  ///
  byte    diffcare    405-405  ///
  byte    diffsens    406-406  ///
  byte    diffeye     407-407  ///
  byte    diffhear    408-408  ///
  using `"$raw\IPMUS ACS\ACS18-23_Nov27.dat"'

replace hhwt       = hhwt       / 100
replace density    = density    / 10
replace pctmetro   = pctmetro   / 100
replace perwt      = perwt      / 100

format serial     %8.0f
format cbserial   %13.0f
format hhwt       %10.2f
format cluster    %13.0f
format density    %7.1f
format pctmetro   %5.2f
format metpop10   %8.0f
format metpop20   %8.0f
format strata     %12.0f
format perwt      %10.2f

label var year       `"Census year"'
label var sample     `"IPUMS sample identifier"'
label var serial     `"Household serial number"'
label var cbserial   `"Original Census Bureau household serial number"'
label var hhwt       `"Household weight"'
label var cluster    `"Household cluster for variance estimation"'
label var region     `"Census region and division"'
label var stateicp   `"State (ICPSR code)"'
label var statefip   `"State (FIPS code)"'
label var countyicp  `"County (ICPSR code, identifiable counties only)"'
label var countyfip  `"County (FIPS code, identifiable counties only)"'
label var puma       `"Public Use Microdata Area"'
label var cpuma0010  `"Consistent PUMA, 2000-2010"'
label var density    `"Population-weighted density of PUMA"'
label var metro      `"Metropolitan status (where determinable)"'
label var pctmetro   `"Percent of PUMA population living in metro area"'
label var met2013    `"Metropolitan area (2013 delineations, identifiable areas only)"'
label var met2013err `"Coverage error in MET2013 variable"'
label var met2023    `"Metropolitan area (2023 delineations, identifiable areas only)"'
label var met2023err `"Coverage error in MET2023 variable"'
label var metpop10   `"Average 2010 population of 2013 metro/micro areas in PUMA"'
label var metpop20   `"Average 2020 population of 2023 metro/micro areas in PUMA"'
label var city       `"City (identifiable cities only)"'
label var cityerr    `"Coverage error in CITY variable"'
label var citypop    `"City population (identifiable cities only)"'
label var homeland   `"American Indian, Alaska Native, or Native Hawaiian homeland area"'
label var strata     `"Household strata for variance estimation"'
label var cntry      `"Country"'
label var gq         `"Group quarters status"'
label var pernum     `"Person number in sample unit"'
label var perwt      `"Person weight"'
label var relate     `"Relationship to household head [general version]"'
label var related    `"Relationship to household head [detailed version]"'
label var sex        `"Sex"'
label var age        `"Age"'
label var birthqtr   `"Quarter of birth"'
label var marst      `"Marital status"'
label var birthyr    `"Year of birth"'
label var marrno     `"Times married"'
label var marrinyr   `"Married within the past year"'
label var yrmarr     `"Year married"'
label var divinyr    `"Divorced in the past year"'
label var widinyr    `"Widowed in the past year"'
label var fertyr     `"Children born within the last year"'
label var race       `"Race [general version]"'
label var raced      `"Race [detailed version]"'
label var hispan     `"Hispanic origin [general version]"'
label var hispand    `"Hispanic origin [detailed version]"'
label var bpl        `"Birthplace [general version]"'
label var bpld       `"Birthplace [detailed version]"'
label var ancestr1   `"Ancestry, first response [general version]"'
label var ancestr1d  `"Ancestry, first response [detailed version]"'
label var ancestr2   `"Ancestry, second response [general version]"'
label var ancestr2d  `"Ancestry, second response [detailed version]"'
label var citizen    `"Citizenship status"'
label var yrnatur    `"Year naturalized"'
label var yrimmig    `"Year of immigration"'
label var yrsusa1    `"Years in the United States"'
label var yrsusa2    `"Years in the United States, intervalled"'
label var language   `"Language spoken [general version]"'
label var languaged  `"Language spoken [detailed version]"'
label var speakeng   `"Speaks English"'
label var tribe      `"Tribe [general version]"'
label var tribed     `"Tribe [detailed version]"'
label var racamind   `"Race: American Indian or Alaska Native"'
label var racasian   `"Race: Asian"'
label var racblk     `"Race: black or African American"'
label var racpacis   `"Race: Pacific Islander"'
label var racwht     `"Race: white"'
label var racother   `"Race: some other race"'
label var racnum     `"Number of major race groups"'
label var school     `"School attendance"'
label var educ       `"Educational attainment [general version]"'
label var educd      `"Educational attainment [detailed version]"'
label var gradeatt   `"Grade level attending [general version]"'
label var gradeattd  `"Grade level attending [detailed version]"'
label var schltype   `"Public or private school"'
label var degfield   `"Field of degree [general version]"'
label var degfieldd  `"Field of degree [detailed version]"'
label var degfield2  `"Field of degree (2) [general version]"'
label var degfield2d `"Field of degree (2) [detailed version]"'
label var empstat    `"Employment status [general version]"'
label var empstatd   `"Employment status [detailed version]"'
label var labforce   `"Labor force status"'
label var classwkr   `"Class of worker [general version]"'
label var classwkrd  `"Class of worker [detailed version]"'
label var occ        `"Occupation"'
label var occ1950    `"Occupation, 1950 basis"'
label var occ1990    `"Occupation, 1990 basis"'
label var occ2010    `"Occupation, 2010 basis"'
label var occsoc     `"Occupation, SOC classification"'
label var ind        `"Industry"'
label var ind1950    `"Industry, 1950 basis"'
label var ind1990    `"Industry, 1990 basis"'
label var indnaics   `"Industry, NAICS classification"'
label var wkswork1   `"Weeks worked last year"'
label var wkswork2   `"Weeks worked last year, intervalled"'
label var uhrswork   `"Usual hours worked per week"'
label var wrklstwk   `"Worked last week"'
label var absent     `"Absent from work last week"'
label var looking    `"Looking for work"'
label var availble   `"Available for work"'
label var wrkrecal   `"Informed of work recall"'
label var workedyr   `"Worked last year"'
label var inctot     `"Total personal income"'
label var ftotinc    `"Total family income"'
label var incwage    `"Wage and salary income"'
label var incbus00   `"Business and farm income, 2000"'
label var incss      `"Social Security income"'
label var incwelfr   `"Welfare (public assistance) income"'
label var incinvst   `"Interest, dividend, and rental income"'
label var incretir   `"Retirement income"'
label var incsupp    `"Supplementary Security Income"'
label var incother   `"Other income"'
label var incearn    `"Total personal earned income"'
label var poverty    `"Poverty status"'
label var cbpoverty  `"Poverty status (original Census Bureau calculation)"'
label var vetdisab   `"VA service-connected disability rating"'
label var diffrem    `"Cognitive difficulty"'
label var diffphys   `"Ambulatory difficulty"'
label var diffmob    `"Independent living difficulty"'
label var diffcare   `"Self-care difficulty"'
label var diffsens   `"Vision or hearing difficulty"'
label var diffeye    `"Vision difficulty"'
label var diffhear   `"Hearing difficulty"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label define year_lbl 2016 `"2016"', add
label define year_lbl 2017 `"2017"', add
label define year_lbl 2018 `"2018"', add
label define year_lbl 2019 `"2019"', add
label define year_lbl 2020 `"2020"', add
label define year_lbl 2021 `"2021"', add
label define year_lbl 2022 `"2022"', add
label define year_lbl 2023 `"2023"', add
label values year year_lbl

label define sample_lbl 202304 `"2019-2023, PRCS 5-year"'
label define sample_lbl 202303 `"2019-2023, ACS 5-year"', add
label define sample_lbl 202302 `"2023 PRCS"', add
label define sample_lbl 202301 `"2023 ACS"', add
label define sample_lbl 202204 `"2018-2022, PRCS 5-year"', add
label define sample_lbl 202203 `"2018-2022, ACS 5-year"', add
label define sample_lbl 202202 `"2022 PRCS"', add
label define sample_lbl 202201 `"2022 ACS"', add
label define sample_lbl 202104 `"2017-2021, PRCS 5-year"', add
label define sample_lbl 202103 `"2017-2021, ACS 5-year"', add
label define sample_lbl 202102 `"2021 PRCS"', add
label define sample_lbl 202101 `"2021 ACS"', add
label define sample_lbl 202004 `"2016-2020, PRCS 5-year"', add
label define sample_lbl 202003 `"2016-2020, ACS 5-year"', add
label define sample_lbl 202001 `"2020 ACS"', add
label define sample_lbl 201904 `"2015-2019, PRCS 5-year"', add
label define sample_lbl 201903 `"2015-2019, ACS 5-year"', add
label define sample_lbl 201902 `"2019 PRCS"', add
label define sample_lbl 201901 `"2019 ACS"', add
label define sample_lbl 201804 `"2014-2018, PRCS 5-year"', add
label define sample_lbl 201803 `"2014-2018, ACS 5-year"', add
label define sample_lbl 201802 `"2018 PRCS"', add
label define sample_lbl 201801 `"2018 ACS"', add
label define sample_lbl 201704 `"2013-2017, PRCS 5-year"', add
label define sample_lbl 201703 `"2013-2017, ACS 5-year"', add
label define sample_lbl 201702 `"2017 PRCS"', add
label define sample_lbl 201701 `"2017 ACS"', add
label define sample_lbl 201604 `"2012-2016, PRCS 5-year"', add
label define sample_lbl 201603 `"2012-2016, ACS 5-year"', add
label define sample_lbl 201602 `"2016 PRCS"', add
label define sample_lbl 201601 `"2016 ACS"', add
label define sample_lbl 201504 `"2011-2015, PRCS 5-year"', add
label define sample_lbl 201503 `"2011-2015, ACS 5-year"', add
label define sample_lbl 201502 `"2015 PRCS"', add
label define sample_lbl 201501 `"2015 ACS"', add
label define sample_lbl 201404 `"2010-2014, PRCS 5-year"', add
label define sample_lbl 201403 `"2010-2014, ACS 5-year"', add
label define sample_lbl 201402 `"2014 PRCS"', add
label define sample_lbl 201401 `"2014 ACS"', add
label define sample_lbl 201306 `"2009-2013, PRCS 5-year"', add
label define sample_lbl 201305 `"2009-2013, ACS 5-year"', add
label define sample_lbl 201304 `"2011-2013, PRCS 3-year"', add
label define sample_lbl 201303 `"2011-2013, ACS 3-year"', add
label define sample_lbl 201302 `"2013 PRCS"', add
label define sample_lbl 201301 `"2013 ACS"', add
label define sample_lbl 201206 `"2008-2012, PRCS 5-year"', add
label define sample_lbl 201205 `"2008-2012, ACS 5-year"', add
label define sample_lbl 201204 `"2010-2012, PRCS 3-year"', add
label define sample_lbl 201203 `"2010-2012, ACS 3-year"', add
label define sample_lbl 201202 `"2012 PRCS"', add
label define sample_lbl 201201 `"2012 ACS"', add
label define sample_lbl 201106 `"2007-2011, PRCS 5-year"', add
label define sample_lbl 201105 `"2007-2011, ACS 5-year"', add
label define sample_lbl 201104 `"2009-2011, PRCS 3-year"', add
label define sample_lbl 201103 `"2009-2011, ACS 3-year"', add
label define sample_lbl 201102 `"2011 PRCS"', add
label define sample_lbl 201101 `"2011 ACS"', add
label define sample_lbl 201008 `"2010 Puerto Rico 10%"', add
label define sample_lbl 201007 `"2010 10%"', add
label define sample_lbl 201006 `"2006-2010, PRCS 5-year"', add
label define sample_lbl 201005 `"2006-2010, ACS 5-year"', add
label define sample_lbl 201004 `"2008-2010, PRCS 3-year"', add
label define sample_lbl 201003 `"2008-2010, ACS 3-year"', add
label define sample_lbl 201002 `"2010 PRCS"', add
label define sample_lbl 201001 `"2010 ACS"', add
label define sample_lbl 200906 `"2005-2009, PRCS 5-year"', add
label define sample_lbl 200905 `"2005-2009, ACS 5-year"', add
label define sample_lbl 200904 `"2007-2009, PRCS 3-year"', add
label define sample_lbl 200903 `"2007-2009, ACS 3-year"', add
label define sample_lbl 200902 `"2009 PRCS"', add
label define sample_lbl 200901 `"2009 ACS"', add
label define sample_lbl 200804 `"2006-2008, PRCS 3-year"', add
label define sample_lbl 200803 `"2006-2008, ACS 3-year"', add
label define sample_lbl 200802 `"2008 PRCS"', add
label define sample_lbl 200801 `"2008 ACS"', add
label define sample_lbl 200704 `"2005-2007, PRCS 3-year"', add
label define sample_lbl 200703 `"2005-2007, ACS 3-year"', add
label define sample_lbl 200702 `"2007 PRCS"', add
label define sample_lbl 200701 `"2007 ACS"', add
label define sample_lbl 200602 `"2006 PRCS"', add
label define sample_lbl 200601 `"2006 ACS"', add
label define sample_lbl 200502 `"2005 PRCS"', add
label define sample_lbl 200501 `"2005 ACS"', add
label define sample_lbl 200401 `"2004 ACS"', add
label define sample_lbl 200301 `"2003 ACS"', add
label define sample_lbl 200201 `"2002 ACS"', add
label define sample_lbl 200101 `"2001 ACS"', add
label define sample_lbl 200008 `"2000 Puerto Rico 1%"', add
label define sample_lbl 200007 `"2000 1%"', add
label define sample_lbl 200006 `"2000 Puerto Rico 1% sample (old version)"', add
label define sample_lbl 200005 `"2000 Puerto Rico 5%"', add
label define sample_lbl 200004 `"2000 ACS"', add
label define sample_lbl 200003 `"2000 Unweighted 1%"', add
label define sample_lbl 200002 `"2000 1% sample (old version)"', add
label define sample_lbl 200001 `"2000 5%"', add
label define sample_lbl 199007 `"1990 Puerto Rico 1%"', add
label define sample_lbl 199006 `"1990 Puerto Rico 5%"', add
label define sample_lbl 199005 `"1990 Labor Market Area"', add
label define sample_lbl 199004 `"1990 Elderly"', add
label define sample_lbl 199003 `"1990 Unweighted 1%"', add
label define sample_lbl 199002 `"1990 1%"', add
label define sample_lbl 199001 `"1990 5%"', add
label define sample_lbl 198007 `"1980 Puerto Rico 1%"', add
label define sample_lbl 198006 `"1980 Puerto Rico 5%"', add
label define sample_lbl 198005 `"1980 Detailed metro/non-metro"', add
label define sample_lbl 198004 `"1980 Labor Market Area"', add
label define sample_lbl 198003 `"1980 Urban/Rural"', add
label define sample_lbl 198002 `"1980 1%"', add
label define sample_lbl 198001 `"1980 5%"', add
label define sample_lbl 197009 `"1970 Puerto Rico Neighborhood"', add
label define sample_lbl 197008 `"1970 Puerto Rico Municipio"', add
label define sample_lbl 197007 `"1970 Puerto Rico State"', add
label define sample_lbl 197006 `"1970 Form 2 Neighborhood"', add
label define sample_lbl 197005 `"1970 Form 1 Neighborhood"', add
label define sample_lbl 197004 `"1970 Form 2 Metro"', add
label define sample_lbl 197003 `"1970 Form 1 Metro"', add
label define sample_lbl 197002 `"1970 Form 2 State"', add
label define sample_lbl 197001 `"1970 Form 1 State"', add
label define sample_lbl 196002 `"1960 5%"', add
label define sample_lbl 196001 `"1960 1%"', add
label define sample_lbl 195002 `"1950 100% database"', add
label define sample_lbl 195001 `"1950 1%"', add
label define sample_lbl 194002 `"1940 100% database"', add
label define sample_lbl 194001 `"1940 1%"', add
label define sample_lbl 193004 `"1930 100% database"', add
label define sample_lbl 193003 `"1930 Puerto Rico"', add
label define sample_lbl 193002 `"1930 5%"', add
label define sample_lbl 193001 `"1930 1%"', add
label define sample_lbl 192003 `"1920 100% database"', add
label define sample_lbl 192002 `"1920 Puerto Rico sample"', add
label define sample_lbl 192001 `"1920 1%"', add
label define sample_lbl 191004 `"1910 100% database"', add
label define sample_lbl 191003 `"1910 1.4% sample with oversamples"', add
label define sample_lbl 191002 `"1910 1%"', add
label define sample_lbl 191001 `"1910 Puerto Rico"', add
label define sample_lbl 190004 `"1900 100% database"', add
label define sample_lbl 190003 `"1900 1% sample with oversamples"', add
label define sample_lbl 190002 `"1900 1%"', add
label define sample_lbl 190001 `"1900 5%"', add
label define sample_lbl 188003 `"1880 100% database"', add
label define sample_lbl 188002 `"1880 10%"', add
label define sample_lbl 188001 `"1880 1%"', add
label define sample_lbl 187003 `"1870 100% database"', add
label define sample_lbl 187002 `"1870 1% sample with black oversample"', add
label define sample_lbl 187001 `"1870 1%"', add
label define sample_lbl 186003 `"1860 100% database"', add
label define sample_lbl 186002 `"1860 1% sample with black oversample"', add
label define sample_lbl 186001 `"1860 1%"', add
label define sample_lbl 185002 `"1850 100% database"', add
label define sample_lbl 185001 `"1850 1%"', add
label values sample sample_lbl

label define region_lbl 11 `"New England Division"'
label define region_lbl 12 `"Middle Atlantic Division"', add
label define region_lbl 13 `"Mixed Northeast Divisions (1970 Metro)"', add
label define region_lbl 21 `"East North Central Div."', add
label define region_lbl 22 `"West North Central Div."', add
label define region_lbl 23 `"Mixed Midwest Divisions (1970 Metro)"', add
label define region_lbl 31 `"South Atlantic Division"', add
label define region_lbl 32 `"East South Central Div."', add
label define region_lbl 33 `"West South Central Div."', add
label define region_lbl 34 `"Mixed Southern Divisions (1970 Metro)"', add
label define region_lbl 41 `"Mountain Division"', add
label define region_lbl 42 `"Pacific Division"', add
label define region_lbl 43 `"Mixed Western Divisions (1970 Metro)"', add
label define region_lbl 91 `"Military/Military reservations"', add
label define region_lbl 92 `"PUMA boundaries cross state lines-1% sample"', add
label define region_lbl 97 `"State not identified"', add
label define region_lbl 99 `"Not identified"', add
label values region region_lbl

label define stateicp_lbl 01 `"Connecticut"'
label define stateicp_lbl 02 `"Maine"', add
label define stateicp_lbl 03 `"Massachusetts"', add
label define stateicp_lbl 04 `"New Hampshire"', add
label define stateicp_lbl 05 `"Rhode Island"', add
label define stateicp_lbl 06 `"Vermont"', add
label define stateicp_lbl 11 `"Delaware"', add
label define stateicp_lbl 12 `"New Jersey"', add
label define stateicp_lbl 13 `"New York"', add
label define stateicp_lbl 14 `"Pennsylvania"', add
label define stateicp_lbl 21 `"Illinois"', add
label define stateicp_lbl 22 `"Indiana"', add
label define stateicp_lbl 23 `"Michigan"', add
label define stateicp_lbl 24 `"Ohio"', add
label define stateicp_lbl 25 `"Wisconsin"', add
label define stateicp_lbl 31 `"Iowa"', add
label define stateicp_lbl 32 `"Kansas"', add
label define stateicp_lbl 33 `"Minnesota"', add
label define stateicp_lbl 34 `"Missouri"', add
label define stateicp_lbl 35 `"Nebraska"', add
label define stateicp_lbl 36 `"North Dakota"', add
label define stateicp_lbl 37 `"South Dakota"', add
label define stateicp_lbl 40 `"Virginia"', add
label define stateicp_lbl 41 `"Alabama"', add
label define stateicp_lbl 42 `"Arkansas"', add
label define stateicp_lbl 43 `"Florida"', add
label define stateicp_lbl 44 `"Georgia"', add
label define stateicp_lbl 45 `"Louisiana"', add
label define stateicp_lbl 46 `"Mississippi"', add
label define stateicp_lbl 47 `"North Carolina"', add
label define stateicp_lbl 48 `"South Carolina"', add
label define stateicp_lbl 49 `"Texas"', add
label define stateicp_lbl 51 `"Kentucky"', add
label define stateicp_lbl 52 `"Maryland"', add
label define stateicp_lbl 53 `"Oklahoma"', add
label define stateicp_lbl 54 `"Tennessee"', add
label define stateicp_lbl 56 `"West Virginia"', add
label define stateicp_lbl 61 `"Arizona"', add
label define stateicp_lbl 62 `"Colorado"', add
label define stateicp_lbl 63 `"Idaho"', add
label define stateicp_lbl 64 `"Montana"', add
label define stateicp_lbl 65 `"Nevada"', add
label define stateicp_lbl 66 `"New Mexico"', add
label define stateicp_lbl 67 `"Utah"', add
label define stateicp_lbl 68 `"Wyoming"', add
label define stateicp_lbl 71 `"California"', add
label define stateicp_lbl 72 `"Oregon"', add
label define stateicp_lbl 73 `"Washington"', add
label define stateicp_lbl 81 `"Alaska"', add
label define stateicp_lbl 82 `"Hawaii"', add
label define stateicp_lbl 83 `"Puerto Rico"', add
label define stateicp_lbl 96 `"State groupings (1980 Urban/rural sample)"', add
label define stateicp_lbl 97 `"Military/Mil. Reservations"', add
label define stateicp_lbl 98 `"District of Columbia"', add
label define stateicp_lbl 99 `"State not identified"', add
label values stateicp stateicp_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefip_lbl 62 `"Massachusetts-Rhode Island"', add
label define statefip_lbl 63 `"Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota"', add
label define statefip_lbl 64 `"Maryland-Delaware"', add
label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
label define statefip_lbl 66 `"Utah-Nevada"', add
label define statefip_lbl 67 `"Arizona-New Mexico"', add
label define statefip_lbl 68 `"Alaska-Hawaii"', add
label define statefip_lbl 72 `"Puerto Rico"', add
label define statefip_lbl 97 `"Military/Mil. Reservation"', add
label define statefip_lbl 99 `"State not identified"', add
label values statefip statefip_lbl

label define countyicp_lbl 0010 `"0010"'
label define countyicp_lbl 0030 `"0030"', add
label define countyicp_lbl 0050 `"0050"', add
label define countyicp_lbl 0070 `"0070"', add
label define countyicp_lbl 0090 `"0090"', add
label define countyicp_lbl 0110 `"0110"', add
label define countyicp_lbl 0130 `"0130"', add
label define countyicp_lbl 0150 `"0150"', add
label define countyicp_lbl 0170 `"0170"', add
label define countyicp_lbl 0190 `"0190"', add
label define countyicp_lbl 0200 `"0200"', add
label define countyicp_lbl 0205 `"0205"', add
label define countyicp_lbl 0210 `"0210"', add
label define countyicp_lbl 0230 `"0230"', add
label define countyicp_lbl 0250 `"0250"', add
label define countyicp_lbl 0270 `"0270"', add
label define countyicp_lbl 0290 `"0290"', add
label define countyicp_lbl 0310 `"0310"', add
label define countyicp_lbl 0330 `"0330"', add
label define countyicp_lbl 0350 `"0350"', add
label define countyicp_lbl 0360 `"0360"', add
label define countyicp_lbl 0370 `"0370"', add
label define countyicp_lbl 0390 `"0390"', add
label define countyicp_lbl 0410 `"0410"', add
label define countyicp_lbl 0430 `"0430"', add
label define countyicp_lbl 0450 `"0450"', add
label define countyicp_lbl 0455 `"0455"', add
label define countyicp_lbl 0470 `"0470"', add
label define countyicp_lbl 0490 `"0490"', add
label define countyicp_lbl 0510 `"0510"', add
label define countyicp_lbl 0530 `"0530"', add
label define countyicp_lbl 0550 `"0550"', add
label define countyicp_lbl 0570 `"0570"', add
label define countyicp_lbl 0590 `"0590"', add
label define countyicp_lbl 0605 `"0605"', add
label define countyicp_lbl 0610 `"0610"', add
label define countyicp_lbl 0630 `"0630"', add
label define countyicp_lbl 0650 `"0650"', add
label define countyicp_lbl 0670 `"0670"', add
label define countyicp_lbl 0690 `"0690"', add
label define countyicp_lbl 0710 `"0710"', add
label define countyicp_lbl 0730 `"0730"', add
label define countyicp_lbl 0750 `"0750"', add
label define countyicp_lbl 0770 `"0770"', add
label define countyicp_lbl 0790 `"0790"', add
label define countyicp_lbl 0810 `"0810"', add
label define countyicp_lbl 0830 `"0830"', add
label define countyicp_lbl 0850 `"0850"', add
label define countyicp_lbl 0870 `"0870"', add
label define countyicp_lbl 0890 `"0890"', add
label define countyicp_lbl 0910 `"0910"', add
label define countyicp_lbl 0930 `"0930"', add
label define countyicp_lbl 0950 `"0950"', add
label define countyicp_lbl 0970 `"0970"', add
label define countyicp_lbl 0990 `"0990"', add
label define countyicp_lbl 1010 `"1010"', add
label define countyicp_lbl 1030 `"1030"', add
label define countyicp_lbl 1050 `"1050"', add
label define countyicp_lbl 1070 `"1070"', add
label define countyicp_lbl 1090 `"1090"', add
label define countyicp_lbl 1110 `"1110"', add
label define countyicp_lbl 1130 `"1130"', add
label define countyicp_lbl 1150 `"1150"', add
label define countyicp_lbl 1170 `"1170"', add
label define countyicp_lbl 1190 `"1190"', add
label define countyicp_lbl 1210 `"1210"', add
label define countyicp_lbl 1230 `"1230"', add
label define countyicp_lbl 1250 `"1250"', add
label define countyicp_lbl 1270 `"1270"', add
label define countyicp_lbl 1290 `"1290"', add
label define countyicp_lbl 1310 `"1310"', add
label define countyicp_lbl 1330 `"1330"', add
label define countyicp_lbl 1350 `"1350"', add
label define countyicp_lbl 1370 `"1370"', add
label define countyicp_lbl 1390 `"1390"', add
label define countyicp_lbl 1410 `"1410"', add
label define countyicp_lbl 1430 `"1430"', add
label define countyicp_lbl 1450 `"1450"', add
label define countyicp_lbl 1470 `"1470"', add
label define countyicp_lbl 1490 `"1490"', add
label define countyicp_lbl 1510 `"1510"', add
label define countyicp_lbl 1530 `"1530"', add
label define countyicp_lbl 1550 `"1550"', add
label define countyicp_lbl 1570 `"1570"', add
label define countyicp_lbl 1590 `"1590"', add
label define countyicp_lbl 1610 `"1610"', add
label define countyicp_lbl 1630 `"1630"', add
label define countyicp_lbl 1650 `"1650"', add
label define countyicp_lbl 1670 `"1670"', add
label define countyicp_lbl 1690 `"1690"', add
label define countyicp_lbl 1710 `"1710"', add
label define countyicp_lbl 1730 `"1730"', add
label define countyicp_lbl 1750 `"1750"', add
label define countyicp_lbl 1770 `"1770"', add
label define countyicp_lbl 1790 `"1790"', add
label define countyicp_lbl 1810 `"1810"', add
label define countyicp_lbl 1830 `"1830"', add
label define countyicp_lbl 1850 `"1850"', add
label define countyicp_lbl 1870 `"1870"', add
label define countyicp_lbl 1875 `"1875"', add
label define countyicp_lbl 1890 `"1890"', add
label define countyicp_lbl 1910 `"1910"', add
label define countyicp_lbl 1930 `"1930"', add
label define countyicp_lbl 1950 `"1950"', add
label define countyicp_lbl 1970 `"1970"', add
label define countyicp_lbl 1990 `"1990"', add
label define countyicp_lbl 2010 `"2010"', add
label define countyicp_lbl 2030 `"2030"', add
label define countyicp_lbl 2050 `"2050"', add
label define countyicp_lbl 2070 `"2070"', add
label define countyicp_lbl 2090 `"2090"', add
label define countyicp_lbl 2110 `"2110"', add
label define countyicp_lbl 2130 `"2130"', add
label define countyicp_lbl 2150 `"2150"', add
label define countyicp_lbl 2170 `"2170"', add
label define countyicp_lbl 2190 `"2190"', add
label define countyicp_lbl 2210 `"2210"', add
label define countyicp_lbl 2230 `"2230"', add
label define countyicp_lbl 2250 `"2250"', add
label define countyicp_lbl 2270 `"2270"', add
label define countyicp_lbl 2290 `"2290"', add
label define countyicp_lbl 2310 `"2310"', add
label define countyicp_lbl 2330 `"2330"', add
label define countyicp_lbl 2350 `"2350"', add
label define countyicp_lbl 2370 `"2370"', add
label define countyicp_lbl 2390 `"2390"', add
label define countyicp_lbl 2410 `"2410"', add
label define countyicp_lbl 2430 `"2430"', add
label define countyicp_lbl 2450 `"2450"', add
label define countyicp_lbl 2470 `"2470"', add
label define countyicp_lbl 2490 `"2490"', add
label define countyicp_lbl 2510 `"2510"', add
label define countyicp_lbl 2530 `"2530"', add
label define countyicp_lbl 2550 `"2550"', add
label define countyicp_lbl 2570 `"2570"', add
label define countyicp_lbl 2590 `"2590"', add
label define countyicp_lbl 2610 `"2610"', add
label define countyicp_lbl 2630 `"2630"', add
label define countyicp_lbl 2650 `"2650"', add
label define countyicp_lbl 2670 `"2670"', add
label define countyicp_lbl 2690 `"2690"', add
label define countyicp_lbl 2710 `"2710"', add
label define countyicp_lbl 2730 `"2730"', add
label define countyicp_lbl 2750 `"2750"', add
label define countyicp_lbl 2770 `"2770"', add
label define countyicp_lbl 2790 `"2790"', add
label define countyicp_lbl 2810 `"2810"', add
label define countyicp_lbl 2830 `"2830"', add
label define countyicp_lbl 2850 `"2850"', add
label define countyicp_lbl 2870 `"2870"', add
label define countyicp_lbl 2890 `"2890"', add
label define countyicp_lbl 2910 `"2910"', add
label define countyicp_lbl 2930 `"2930"', add
label define countyicp_lbl 2950 `"2950"', add
label define countyicp_lbl 2970 `"2970"', add
label define countyicp_lbl 2990 `"2990"', add
label define countyicp_lbl 3010 `"3010"', add
label define countyicp_lbl 3030 `"3030"', add
label define countyicp_lbl 3050 `"3050"', add
label define countyicp_lbl 3070 `"3070"', add
label define countyicp_lbl 3090 `"3090"', add
label define countyicp_lbl 3110 `"3110"', add
label define countyicp_lbl 3130 `"3130"', add
label define countyicp_lbl 3150 `"3150"', add
label define countyicp_lbl 3170 `"3170"', add
label define countyicp_lbl 3190 `"3190"', add
label define countyicp_lbl 3210 `"3210"', add
label define countyicp_lbl 3230 `"3230"', add
label define countyicp_lbl 3250 `"3250"', add
label define countyicp_lbl 3270 `"3270"', add
label define countyicp_lbl 3290 `"3290"', add
label define countyicp_lbl 3310 `"3310"', add
label define countyicp_lbl 3330 `"3330"', add
label define countyicp_lbl 3350 `"3350"', add
label define countyicp_lbl 3370 `"3370"', add
label define countyicp_lbl 3390 `"3390"', add
label define countyicp_lbl 3410 `"3410"', add
label define countyicp_lbl 3430 `"3430"', add
label define countyicp_lbl 3450 `"3450"', add
label define countyicp_lbl 3470 `"3470"', add
label define countyicp_lbl 3490 `"3490"', add
label define countyicp_lbl 3510 `"3510"', add
label define countyicp_lbl 3530 `"3530"', add
label define countyicp_lbl 3550 `"3550"', add
label define countyicp_lbl 3570 `"3570"', add
label define countyicp_lbl 3590 `"3590"', add
label define countyicp_lbl 3610 `"3610"', add
label define countyicp_lbl 3630 `"3630"', add
label define countyicp_lbl 3650 `"3650"', add
label define countyicp_lbl 3670 `"3670"', add
label define countyicp_lbl 3690 `"3690"', add
label define countyicp_lbl 3710 `"3710"', add
label define countyicp_lbl 3730 `"3730"', add
label define countyicp_lbl 3750 `"3750"', add
label define countyicp_lbl 3770 `"3770"', add
label define countyicp_lbl 3790 `"3790"', add
label define countyicp_lbl 3810 `"3810"', add
label define countyicp_lbl 3830 `"3830"', add
label define countyicp_lbl 3850 `"3850"', add
label define countyicp_lbl 3870 `"3870"', add
label define countyicp_lbl 3890 `"3890"', add
label define countyicp_lbl 3910 `"3910"', add
label define countyicp_lbl 3930 `"3930"', add
label define countyicp_lbl 3950 `"3950"', add
label define countyicp_lbl 3970 `"3970"', add
label define countyicp_lbl 3990 `"3990"', add
label define countyicp_lbl 4010 `"4010"', add
label define countyicp_lbl 4030 `"4030"', add
label define countyicp_lbl 4050 `"4050"', add
label define countyicp_lbl 4070 `"4070"', add
label define countyicp_lbl 4090 `"4090"', add
label define countyicp_lbl 4110 `"4110"', add
label define countyicp_lbl 4130 `"4130"', add
label define countyicp_lbl 4150 `"4150"', add
label define countyicp_lbl 4170 `"4170"', add
label define countyicp_lbl 4190 `"4190"', add
label define countyicp_lbl 4210 `"4210"', add
label define countyicp_lbl 4230 `"4230"', add
label define countyicp_lbl 4250 `"4250"', add
label define countyicp_lbl 4270 `"4270"', add
label define countyicp_lbl 4290 `"4290"', add
label define countyicp_lbl 4310 `"4310"', add
label define countyicp_lbl 4330 `"4330"', add
label define countyicp_lbl 4350 `"4350"', add
label define countyicp_lbl 4370 `"4370"', add
label define countyicp_lbl 4390 `"4390"', add
label define countyicp_lbl 4410 `"4410"', add
label define countyicp_lbl 4430 `"4430"', add
label define countyicp_lbl 4450 `"4450"', add
label define countyicp_lbl 4470 `"4470"', add
label define countyicp_lbl 4490 `"4490"', add
label define countyicp_lbl 4510 `"4510"', add
label define countyicp_lbl 4530 `"4530"', add
label define countyicp_lbl 4550 `"4550"', add
label define countyicp_lbl 4570 `"4570"', add
label define countyicp_lbl 4590 `"4590"', add
label define countyicp_lbl 4610 `"4610"', add
label define countyicp_lbl 4630 `"4630"', add
label define countyicp_lbl 4650 `"4650"', add
label define countyicp_lbl 4670 `"4670"', add
label define countyicp_lbl 4690 `"4690"', add
label define countyicp_lbl 4710 `"4710"', add
label define countyicp_lbl 4730 `"4730"', add
label define countyicp_lbl 4750 `"4750"', add
label define countyicp_lbl 4770 `"4770"', add
label define countyicp_lbl 4790 `"4790"', add
label define countyicp_lbl 4810 `"4810"', add
label define countyicp_lbl 4830 `"4830"', add
label define countyicp_lbl 4850 `"4850"', add
label define countyicp_lbl 4870 `"4870"', add
label define countyicp_lbl 4890 `"4890"', add
label define countyicp_lbl 4910 `"4910"', add
label define countyicp_lbl 4930 `"4930"', add
label define countyicp_lbl 4950 `"4950"', add
label define countyicp_lbl 4970 `"4970"', add
label define countyicp_lbl 4990 `"4990"', add
label define countyicp_lbl 5010 `"5010"', add
label define countyicp_lbl 5030 `"5030"', add
label define countyicp_lbl 5050 `"5050"', add
label define countyicp_lbl 5070 `"5070"', add
label define countyicp_lbl 5100 `"5100"', add
label define countyicp_lbl 5200 `"5200"', add
label define countyicp_lbl 5300 `"5300"', add
label define countyicp_lbl 5400 `"5400"', add
label define countyicp_lbl 5500 `"5500"', add
label define countyicp_lbl 5600 `"5600"', add
label define countyicp_lbl 5700 `"5700"', add
label define countyicp_lbl 5800 `"5800"', add
label define countyicp_lbl 5900 `"5900"', add
label define countyicp_lbl 6100 `"6100"', add
label define countyicp_lbl 6300 `"6300"', add
label define countyicp_lbl 6400 `"6400"', add
label define countyicp_lbl 6500 `"6500"', add
label define countyicp_lbl 6600 `"6600"', add
label define countyicp_lbl 6700 `"6700"', add
label define countyicp_lbl 6800 `"6800"', add
label define countyicp_lbl 6900 `"6900"', add
label define countyicp_lbl 7000 `"7000"', add
label define countyicp_lbl 7100 `"7100"', add
label define countyicp_lbl 7200 `"7200"', add
label define countyicp_lbl 7300 `"7300"', add
label define countyicp_lbl 7400 `"7400"', add
label define countyicp_lbl 7500 `"7500"', add
label define countyicp_lbl 7600 `"7600"', add
label define countyicp_lbl 7700 `"7700"', add
label define countyicp_lbl 7800 `"7800"', add
label define countyicp_lbl 7850 `"7850"', add
label define countyicp_lbl 7900 `"7900"', add
label define countyicp_lbl 8000 `"8000"', add
label define countyicp_lbl 8100 `"8100"', add
label define countyicp_lbl 8200 `"8200"', add
label define countyicp_lbl 8300 `"8300"', add
label define countyicp_lbl 8400 `"8400"', add
label values countyicp countyicp_lbl

label define cpuma0010_lbl 0001 `"0001"'
label define cpuma0010_lbl 0002 `"0002"', add
label define cpuma0010_lbl 0003 `"0003"', add
label define cpuma0010_lbl 0004 `"0004"', add
label define cpuma0010_lbl 0005 `"0005"', add
label define cpuma0010_lbl 0006 `"0006"', add
label define cpuma0010_lbl 0007 `"0007"', add
label define cpuma0010_lbl 0008 `"0008"', add
label define cpuma0010_lbl 0009 `"0009"', add
label define cpuma0010_lbl 0010 `"0010"', add
label define cpuma0010_lbl 0011 `"0011"', add
label define cpuma0010_lbl 0012 `"0012"', add
label define cpuma0010_lbl 0013 `"0013"', add
label define cpuma0010_lbl 0014 `"0014"', add
label define cpuma0010_lbl 0015 `"0015"', add
label define cpuma0010_lbl 0016 `"0016"', add
label define cpuma0010_lbl 0017 `"0017"', add
label define cpuma0010_lbl 0018 `"0018"', add
label define cpuma0010_lbl 0019 `"0019"', add
label define cpuma0010_lbl 0020 `"0020"', add
label define cpuma0010_lbl 0021 `"0021"', add
label define cpuma0010_lbl 0022 `"0022"', add
label define cpuma0010_lbl 0023 `"0023"', add
label define cpuma0010_lbl 0024 `"0024"', add
label define cpuma0010_lbl 0025 `"0025"', add
label define cpuma0010_lbl 0026 `"0026"', add
label define cpuma0010_lbl 0027 `"0027"', add
label define cpuma0010_lbl 0028 `"0028"', add
label define cpuma0010_lbl 0029 `"0029"', add
label define cpuma0010_lbl 0030 `"0030"', add
label define cpuma0010_lbl 0031 `"0031"', add
label define cpuma0010_lbl 0032 `"0032"', add
label define cpuma0010_lbl 0033 `"0033"', add
label define cpuma0010_lbl 0034 `"0034"', add
label define cpuma0010_lbl 0035 `"0035"', add
label define cpuma0010_lbl 0036 `"0036"', add
label define cpuma0010_lbl 0037 `"0037"', add
label define cpuma0010_lbl 0038 `"0038"', add
label define cpuma0010_lbl 0039 `"0039"', add
label define cpuma0010_lbl 0040 `"0040"', add
label define cpuma0010_lbl 0041 `"0041"', add
label define cpuma0010_lbl 0042 `"0042"', add
label define cpuma0010_lbl 0043 `"0043"', add
label define cpuma0010_lbl 0044 `"0044"', add
label define cpuma0010_lbl 0045 `"0045"', add
label define cpuma0010_lbl 0046 `"0046"', add
label define cpuma0010_lbl 0047 `"0047"', add
label define cpuma0010_lbl 0048 `"0048"', add
label define cpuma0010_lbl 0049 `"0049"', add
label define cpuma0010_lbl 0050 `"0050"', add
label define cpuma0010_lbl 0051 `"0051"', add
label define cpuma0010_lbl 0052 `"0052"', add
label define cpuma0010_lbl 0053 `"0053"', add
label define cpuma0010_lbl 0054 `"0054"', add
label define cpuma0010_lbl 0055 `"0055"', add
label define cpuma0010_lbl 0056 `"0056"', add
label define cpuma0010_lbl 0057 `"0057"', add
label define cpuma0010_lbl 0058 `"0058"', add
label define cpuma0010_lbl 0059 `"0059"', add
label define cpuma0010_lbl 0060 `"0060"', add
label define cpuma0010_lbl 0061 `"0061"', add
label define cpuma0010_lbl 0062 `"0062"', add
label define cpuma0010_lbl 0063 `"0063"', add
label define cpuma0010_lbl 0064 `"0064"', add
label define cpuma0010_lbl 0065 `"0065"', add
label define cpuma0010_lbl 0066 `"0066"', add
label define cpuma0010_lbl 0067 `"0067"', add
label define cpuma0010_lbl 0068 `"0068"', add
label define cpuma0010_lbl 0069 `"0069"', add
label define cpuma0010_lbl 0070 `"0070"', add
label define cpuma0010_lbl 0071 `"0071"', add
label define cpuma0010_lbl 0072 `"0072"', add
label define cpuma0010_lbl 0073 `"0073"', add
label define cpuma0010_lbl 0074 `"0074"', add
label define cpuma0010_lbl 0075 `"0075"', add
label define cpuma0010_lbl 0076 `"0076"', add
label define cpuma0010_lbl 0077 `"0077"', add
label define cpuma0010_lbl 0078 `"0078"', add
label define cpuma0010_lbl 0079 `"0079"', add
label define cpuma0010_lbl 0080 `"0080"', add
label define cpuma0010_lbl 0081 `"0081"', add
label define cpuma0010_lbl 0082 `"0082"', add
label define cpuma0010_lbl 0083 `"0083"', add
label define cpuma0010_lbl 0084 `"0084"', add
label define cpuma0010_lbl 0085 `"0085"', add
label define cpuma0010_lbl 0086 `"0086"', add
label define cpuma0010_lbl 0087 `"0087"', add
label define cpuma0010_lbl 0088 `"0088"', add
label define cpuma0010_lbl 0089 `"0089"', add
label define cpuma0010_lbl 0090 `"0090"', add
label define cpuma0010_lbl 0091 `"0091"', add
label define cpuma0010_lbl 0092 `"0092"', add
label define cpuma0010_lbl 0093 `"0093"', add
label define cpuma0010_lbl 0094 `"0094"', add
label define cpuma0010_lbl 0095 `"0095"', add
label define cpuma0010_lbl 0096 `"0096"', add
label define cpuma0010_lbl 0097 `"0097"', add
label define cpuma0010_lbl 0098 `"0098"', add
label define cpuma0010_lbl 0099 `"0099"', add
label define cpuma0010_lbl 0100 `"0100"', add
label define cpuma0010_lbl 0101 `"0101"', add
label define cpuma0010_lbl 0102 `"0102"', add
label define cpuma0010_lbl 0103 `"0103"', add
label define cpuma0010_lbl 0104 `"0104"', add
label define cpuma0010_lbl 0105 `"0105"', add
label define cpuma0010_lbl 0106 `"0106"', add
label define cpuma0010_lbl 0107 `"0107"', add
label define cpuma0010_lbl 0108 `"0108"', add
label define cpuma0010_lbl 0109 `"0109"', add
label define cpuma0010_lbl 0110 `"0110"', add
label define cpuma0010_lbl 0111 `"0111"', add
label define cpuma0010_lbl 0112 `"0112"', add
label define cpuma0010_lbl 0113 `"0113"', add
label define cpuma0010_lbl 0114 `"0114"', add
label define cpuma0010_lbl 0115 `"0115"', add
label define cpuma0010_lbl 0116 `"0116"', add
label define cpuma0010_lbl 0117 `"0117"', add
label define cpuma0010_lbl 0118 `"0118"', add
label define cpuma0010_lbl 0119 `"0119"', add
label define cpuma0010_lbl 0120 `"0120"', add
label define cpuma0010_lbl 0121 `"0121"', add
label define cpuma0010_lbl 0122 `"0122"', add
label define cpuma0010_lbl 0123 `"0123"', add
label define cpuma0010_lbl 0124 `"0124"', add
label define cpuma0010_lbl 0125 `"0125"', add
label define cpuma0010_lbl 0126 `"0126"', add
label define cpuma0010_lbl 0127 `"0127"', add
label define cpuma0010_lbl 0128 `"0128"', add
label define cpuma0010_lbl 0129 `"0129"', add
label define cpuma0010_lbl 0130 `"0130"', add
label define cpuma0010_lbl 0131 `"0131"', add
label define cpuma0010_lbl 0132 `"0132"', add
label define cpuma0010_lbl 0133 `"0133"', add
label define cpuma0010_lbl 0134 `"0134"', add
label define cpuma0010_lbl 0135 `"0135"', add
label define cpuma0010_lbl 0136 `"0136"', add
label define cpuma0010_lbl 0137 `"0137"', add
label define cpuma0010_lbl 0138 `"0138"', add
label define cpuma0010_lbl 0139 `"0139"', add
label define cpuma0010_lbl 0140 `"0140"', add
label define cpuma0010_lbl 0141 `"0141"', add
label define cpuma0010_lbl 0142 `"0142"', add
label define cpuma0010_lbl 0143 `"0143"', add
label define cpuma0010_lbl 0144 `"0144"', add
label define cpuma0010_lbl 0145 `"0145"', add
label define cpuma0010_lbl 0146 `"0146"', add
label define cpuma0010_lbl 0147 `"0147"', add
label define cpuma0010_lbl 0148 `"0148"', add
label define cpuma0010_lbl 0149 `"0149"', add
label define cpuma0010_lbl 0150 `"0150"', add
label define cpuma0010_lbl 0151 `"0151"', add
label define cpuma0010_lbl 0152 `"0152"', add
label define cpuma0010_lbl 0153 `"0153"', add
label define cpuma0010_lbl 0154 `"0154"', add
label define cpuma0010_lbl 0155 `"0155"', add
label define cpuma0010_lbl 0156 `"0156"', add
label define cpuma0010_lbl 0157 `"0157"', add
label define cpuma0010_lbl 0158 `"0158"', add
label define cpuma0010_lbl 0159 `"0159"', add
label define cpuma0010_lbl 0160 `"0160"', add
label define cpuma0010_lbl 0161 `"0161"', add
label define cpuma0010_lbl 0162 `"0162"', add
label define cpuma0010_lbl 0163 `"0163"', add
label define cpuma0010_lbl 0164 `"0164"', add
label define cpuma0010_lbl 0165 `"0165"', add
label define cpuma0010_lbl 0166 `"0166"', add
label define cpuma0010_lbl 0167 `"0167"', add
label define cpuma0010_lbl 0168 `"0168"', add
label define cpuma0010_lbl 0169 `"0169"', add
label define cpuma0010_lbl 0170 `"0170"', add
label define cpuma0010_lbl 0171 `"0171"', add
label define cpuma0010_lbl 0172 `"0172"', add
label define cpuma0010_lbl 0173 `"0173"', add
label define cpuma0010_lbl 0174 `"0174"', add
label define cpuma0010_lbl 0175 `"0175"', add
label define cpuma0010_lbl 0176 `"0176"', add
label define cpuma0010_lbl 0177 `"0177"', add
label define cpuma0010_lbl 0178 `"0178"', add
label define cpuma0010_lbl 0179 `"0179"', add
label define cpuma0010_lbl 0180 `"0180"', add
label define cpuma0010_lbl 0181 `"0181"', add
label define cpuma0010_lbl 0182 `"0182"', add
label define cpuma0010_lbl 0183 `"0183"', add
label define cpuma0010_lbl 0184 `"0184"', add
label define cpuma0010_lbl 0185 `"0185"', add
label define cpuma0010_lbl 0186 `"0186"', add
label define cpuma0010_lbl 0187 `"0187"', add
label define cpuma0010_lbl 0188 `"0188"', add
label define cpuma0010_lbl 0189 `"0189"', add
label define cpuma0010_lbl 0190 `"0190"', add
label define cpuma0010_lbl 0191 `"0191"', add
label define cpuma0010_lbl 0192 `"0192"', add
label define cpuma0010_lbl 0193 `"0193"', add
label define cpuma0010_lbl 0194 `"0194"', add
label define cpuma0010_lbl 0195 `"0195"', add
label define cpuma0010_lbl 0196 `"0196"', add
label define cpuma0010_lbl 0197 `"0197"', add
label define cpuma0010_lbl 0198 `"0198"', add
label define cpuma0010_lbl 0199 `"0199"', add
label define cpuma0010_lbl 0200 `"0200"', add
label define cpuma0010_lbl 0201 `"0201"', add
label define cpuma0010_lbl 0202 `"0202"', add
label define cpuma0010_lbl 0203 `"0203"', add
label define cpuma0010_lbl 0204 `"0204"', add
label define cpuma0010_lbl 0205 `"0205"', add
label define cpuma0010_lbl 0206 `"0206"', add
label define cpuma0010_lbl 0207 `"0207"', add
label define cpuma0010_lbl 0208 `"0208"', add
label define cpuma0010_lbl 0209 `"0209"', add
label define cpuma0010_lbl 0210 `"0210"', add
label define cpuma0010_lbl 0211 `"0211"', add
label define cpuma0010_lbl 0212 `"0212"', add
label define cpuma0010_lbl 0213 `"0213"', add
label define cpuma0010_lbl 0214 `"0214"', add
label define cpuma0010_lbl 0215 `"0215"', add
label define cpuma0010_lbl 0216 `"0216"', add
label define cpuma0010_lbl 0217 `"0217"', add
label define cpuma0010_lbl 0218 `"0218"', add
label define cpuma0010_lbl 0219 `"0219"', add
label define cpuma0010_lbl 0220 `"0220"', add
label define cpuma0010_lbl 0221 `"0221"', add
label define cpuma0010_lbl 0222 `"0222"', add
label define cpuma0010_lbl 0223 `"0223"', add
label define cpuma0010_lbl 0224 `"0224"', add
label define cpuma0010_lbl 0225 `"0225"', add
label define cpuma0010_lbl 0226 `"0226"', add
label define cpuma0010_lbl 0227 `"0227"', add
label define cpuma0010_lbl 0228 `"0228"', add
label define cpuma0010_lbl 0229 `"0229"', add
label define cpuma0010_lbl 0230 `"0230"', add
label define cpuma0010_lbl 0231 `"0231"', add
label define cpuma0010_lbl 0232 `"0232"', add
label define cpuma0010_lbl 0233 `"0233"', add
label define cpuma0010_lbl 0234 `"0234"', add
label define cpuma0010_lbl 0235 `"0235"', add
label define cpuma0010_lbl 0236 `"0236"', add
label define cpuma0010_lbl 0237 `"0237"', add
label define cpuma0010_lbl 0238 `"0238"', add
label define cpuma0010_lbl 0239 `"0239"', add
label define cpuma0010_lbl 0240 `"0240"', add
label define cpuma0010_lbl 0241 `"0241"', add
label define cpuma0010_lbl 0242 `"0242"', add
label define cpuma0010_lbl 0243 `"0243"', add
label define cpuma0010_lbl 0244 `"0244"', add
label define cpuma0010_lbl 0245 `"0245"', add
label define cpuma0010_lbl 0246 `"0246"', add
label define cpuma0010_lbl 0247 `"0247"', add
label define cpuma0010_lbl 0248 `"0248"', add
label define cpuma0010_lbl 0249 `"0249"', add
label define cpuma0010_lbl 0250 `"0250"', add
label define cpuma0010_lbl 0251 `"0251"', add
label define cpuma0010_lbl 0252 `"0252"', add
label define cpuma0010_lbl 0253 `"0253"', add
label define cpuma0010_lbl 0254 `"0254"', add
label define cpuma0010_lbl 0255 `"0255"', add
label define cpuma0010_lbl 0256 `"0256"', add
label define cpuma0010_lbl 0257 `"0257"', add
label define cpuma0010_lbl 0258 `"0258"', add
label define cpuma0010_lbl 0259 `"0259"', add
label define cpuma0010_lbl 0260 `"0260"', add
label define cpuma0010_lbl 0261 `"0261"', add
label define cpuma0010_lbl 0262 `"0262"', add
label define cpuma0010_lbl 0263 `"0263"', add
label define cpuma0010_lbl 0264 `"0264"', add
label define cpuma0010_lbl 0265 `"0265"', add
label define cpuma0010_lbl 0266 `"0266"', add
label define cpuma0010_lbl 0267 `"0267"', add
label define cpuma0010_lbl 0268 `"0268"', add
label define cpuma0010_lbl 0269 `"0269"', add
label define cpuma0010_lbl 0270 `"0270"', add
label define cpuma0010_lbl 0271 `"0271"', add
label define cpuma0010_lbl 0272 `"0272"', add
label define cpuma0010_lbl 0273 `"0273"', add
label define cpuma0010_lbl 0274 `"0274"', add
label define cpuma0010_lbl 0275 `"0275"', add
label define cpuma0010_lbl 0276 `"0276"', add
label define cpuma0010_lbl 0277 `"0277"', add
label define cpuma0010_lbl 0278 `"0278"', add
label define cpuma0010_lbl 0279 `"0279"', add
label define cpuma0010_lbl 0280 `"0280"', add
label define cpuma0010_lbl 0281 `"0281"', add
label define cpuma0010_lbl 0282 `"0282"', add
label define cpuma0010_lbl 0283 `"0283"', add
label define cpuma0010_lbl 0284 `"0284"', add
label define cpuma0010_lbl 0285 `"0285"', add
label define cpuma0010_lbl 0286 `"0286"', add
label define cpuma0010_lbl 0287 `"0287"', add
label define cpuma0010_lbl 0288 `"0288"', add
label define cpuma0010_lbl 0289 `"0289"', add
label define cpuma0010_lbl 0290 `"0290"', add
label define cpuma0010_lbl 0291 `"0291"', add
label define cpuma0010_lbl 0292 `"0292"', add
label define cpuma0010_lbl 0293 `"0293"', add
label define cpuma0010_lbl 0294 `"0294"', add
label define cpuma0010_lbl 0295 `"0295"', add
label define cpuma0010_lbl 0296 `"0296"', add
label define cpuma0010_lbl 0297 `"0297"', add
label define cpuma0010_lbl 0298 `"0298"', add
label define cpuma0010_lbl 0299 `"0299"', add
label define cpuma0010_lbl 0300 `"0300"', add
label define cpuma0010_lbl 0301 `"0301"', add
label define cpuma0010_lbl 0302 `"0302"', add
label define cpuma0010_lbl 0303 `"0303"', add
label define cpuma0010_lbl 0304 `"0304"', add
label define cpuma0010_lbl 0305 `"0305"', add
label define cpuma0010_lbl 0306 `"0306"', add
label define cpuma0010_lbl 0307 `"0307"', add
label define cpuma0010_lbl 0308 `"0308"', add
label define cpuma0010_lbl 0309 `"0309"', add
label define cpuma0010_lbl 0310 `"0310"', add
label define cpuma0010_lbl 0311 `"0311"', add
label define cpuma0010_lbl 0312 `"0312"', add
label define cpuma0010_lbl 0313 `"0313"', add
label define cpuma0010_lbl 0314 `"0314"', add
label define cpuma0010_lbl 0315 `"0315"', add
label define cpuma0010_lbl 0316 `"0316"', add
label define cpuma0010_lbl 0317 `"0317"', add
label define cpuma0010_lbl 0318 `"0318"', add
label define cpuma0010_lbl 0319 `"0319"', add
label define cpuma0010_lbl 0320 `"0320"', add
label define cpuma0010_lbl 0321 `"0321"', add
label define cpuma0010_lbl 0322 `"0322"', add
label define cpuma0010_lbl 0323 `"0323"', add
label define cpuma0010_lbl 0324 `"0324"', add
label define cpuma0010_lbl 0325 `"0325"', add
label define cpuma0010_lbl 0326 `"0326"', add
label define cpuma0010_lbl 0327 `"0327"', add
label define cpuma0010_lbl 0328 `"0328"', add
label define cpuma0010_lbl 0329 `"0329"', add
label define cpuma0010_lbl 0330 `"0330"', add
label define cpuma0010_lbl 0331 `"0331"', add
label define cpuma0010_lbl 0332 `"0332"', add
label define cpuma0010_lbl 0333 `"0333"', add
label define cpuma0010_lbl 0334 `"0334"', add
label define cpuma0010_lbl 0335 `"0335"', add
label define cpuma0010_lbl 0336 `"0336"', add
label define cpuma0010_lbl 0337 `"0337"', add
label define cpuma0010_lbl 0338 `"0338"', add
label define cpuma0010_lbl 0339 `"0339"', add
label define cpuma0010_lbl 0340 `"0340"', add
label define cpuma0010_lbl 0341 `"0341"', add
label define cpuma0010_lbl 0342 `"0342"', add
label define cpuma0010_lbl 0343 `"0343"', add
label define cpuma0010_lbl 0344 `"0344"', add
label define cpuma0010_lbl 0345 `"0345"', add
label define cpuma0010_lbl 0346 `"0346"', add
label define cpuma0010_lbl 0347 `"0347"', add
label define cpuma0010_lbl 0348 `"0348"', add
label define cpuma0010_lbl 0349 `"0349"', add
label define cpuma0010_lbl 0350 `"0350"', add
label define cpuma0010_lbl 0351 `"0351"', add
label define cpuma0010_lbl 0352 `"0352"', add
label define cpuma0010_lbl 0353 `"0353"', add
label define cpuma0010_lbl 0354 `"0354"', add
label define cpuma0010_lbl 0355 `"0355"', add
label define cpuma0010_lbl 0356 `"0356"', add
label define cpuma0010_lbl 0357 `"0357"', add
label define cpuma0010_lbl 0358 `"0358"', add
label define cpuma0010_lbl 0359 `"0359"', add
label define cpuma0010_lbl 0360 `"0360"', add
label define cpuma0010_lbl 0361 `"0361"', add
label define cpuma0010_lbl 0362 `"0362"', add
label define cpuma0010_lbl 0363 `"0363"', add
label define cpuma0010_lbl 0364 `"0364"', add
label define cpuma0010_lbl 0365 `"0365"', add
label define cpuma0010_lbl 0366 `"0366"', add
label define cpuma0010_lbl 0367 `"0367"', add
label define cpuma0010_lbl 0368 `"0368"', add
label define cpuma0010_lbl 0369 `"0369"', add
label define cpuma0010_lbl 0370 `"0370"', add
label define cpuma0010_lbl 0371 `"0371"', add
label define cpuma0010_lbl 0372 `"0372"', add
label define cpuma0010_lbl 0373 `"0373"', add
label define cpuma0010_lbl 0374 `"0374"', add
label define cpuma0010_lbl 0375 `"0375"', add
label define cpuma0010_lbl 0376 `"0376"', add
label define cpuma0010_lbl 0377 `"0377"', add
label define cpuma0010_lbl 0378 `"0378"', add
label define cpuma0010_lbl 0379 `"0379"', add
label define cpuma0010_lbl 0380 `"0380"', add
label define cpuma0010_lbl 0381 `"0381"', add
label define cpuma0010_lbl 0382 `"0382"', add
label define cpuma0010_lbl 0383 `"0383"', add
label define cpuma0010_lbl 0384 `"0384"', add
label define cpuma0010_lbl 0385 `"0385"', add
label define cpuma0010_lbl 0386 `"0386"', add
label define cpuma0010_lbl 0387 `"0387"', add
label define cpuma0010_lbl 0388 `"0388"', add
label define cpuma0010_lbl 0389 `"0389"', add
label define cpuma0010_lbl 0390 `"0390"', add
label define cpuma0010_lbl 0391 `"0391"', add
label define cpuma0010_lbl 0392 `"0392"', add
label define cpuma0010_lbl 0393 `"0393"', add
label define cpuma0010_lbl 0394 `"0394"', add
label define cpuma0010_lbl 0395 `"0395"', add
label define cpuma0010_lbl 0396 `"0396"', add
label define cpuma0010_lbl 0397 `"0397"', add
label define cpuma0010_lbl 0398 `"0398"', add
label define cpuma0010_lbl 0399 `"0399"', add
label define cpuma0010_lbl 0400 `"0400"', add
label define cpuma0010_lbl 0401 `"0401"', add
label define cpuma0010_lbl 0402 `"0402"', add
label define cpuma0010_lbl 0403 `"0403"', add
label define cpuma0010_lbl 0404 `"0404"', add
label define cpuma0010_lbl 0405 `"0405"', add
label define cpuma0010_lbl 0406 `"0406"', add
label define cpuma0010_lbl 0407 `"0407"', add
label define cpuma0010_lbl 0408 `"0408"', add
label define cpuma0010_lbl 0409 `"0409"', add
label define cpuma0010_lbl 0410 `"0410"', add
label define cpuma0010_lbl 0411 `"0411"', add
label define cpuma0010_lbl 0412 `"0412"', add
label define cpuma0010_lbl 0413 `"0413"', add
label define cpuma0010_lbl 0414 `"0414"', add
label define cpuma0010_lbl 0415 `"0415"', add
label define cpuma0010_lbl 0416 `"0416"', add
label define cpuma0010_lbl 0417 `"0417"', add
label define cpuma0010_lbl 0418 `"0418"', add
label define cpuma0010_lbl 0419 `"0419"', add
label define cpuma0010_lbl 0420 `"0420"', add
label define cpuma0010_lbl 0421 `"0421"', add
label define cpuma0010_lbl 0422 `"0422"', add
label define cpuma0010_lbl 0423 `"0423"', add
label define cpuma0010_lbl 0424 `"0424"', add
label define cpuma0010_lbl 0425 `"0425"', add
label define cpuma0010_lbl 0426 `"0426"', add
label define cpuma0010_lbl 0427 `"0427"', add
label define cpuma0010_lbl 0428 `"0428"', add
label define cpuma0010_lbl 0429 `"0429"', add
label define cpuma0010_lbl 0430 `"0430"', add
label define cpuma0010_lbl 0431 `"0431"', add
label define cpuma0010_lbl 0432 `"0432"', add
label define cpuma0010_lbl 0433 `"0433"', add
label define cpuma0010_lbl 0434 `"0434"', add
label define cpuma0010_lbl 0435 `"0435"', add
label define cpuma0010_lbl 0436 `"0436"', add
label define cpuma0010_lbl 0437 `"0437"', add
label define cpuma0010_lbl 0438 `"0438"', add
label define cpuma0010_lbl 0439 `"0439"', add
label define cpuma0010_lbl 0440 `"0440"', add
label define cpuma0010_lbl 0441 `"0441"', add
label define cpuma0010_lbl 0442 `"0442"', add
label define cpuma0010_lbl 0443 `"0443"', add
label define cpuma0010_lbl 0444 `"0444"', add
label define cpuma0010_lbl 0445 `"0445"', add
label define cpuma0010_lbl 0446 `"0446"', add
label define cpuma0010_lbl 0447 `"0447"', add
label define cpuma0010_lbl 0448 `"0448"', add
label define cpuma0010_lbl 0449 `"0449"', add
label define cpuma0010_lbl 0450 `"0450"', add
label define cpuma0010_lbl 0451 `"0451"', add
label define cpuma0010_lbl 0452 `"0452"', add
label define cpuma0010_lbl 0453 `"0453"', add
label define cpuma0010_lbl 0454 `"0454"', add
label define cpuma0010_lbl 0455 `"0455"', add
label define cpuma0010_lbl 0456 `"0456"', add
label define cpuma0010_lbl 0457 `"0457"', add
label define cpuma0010_lbl 0458 `"0458"', add
label define cpuma0010_lbl 0459 `"0459"', add
label define cpuma0010_lbl 0460 `"0460"', add
label define cpuma0010_lbl 0461 `"0461"', add
label define cpuma0010_lbl 0462 `"0462"', add
label define cpuma0010_lbl 0463 `"0463"', add
label define cpuma0010_lbl 0464 `"0464"', add
label define cpuma0010_lbl 0465 `"0465"', add
label define cpuma0010_lbl 0466 `"0466"', add
label define cpuma0010_lbl 0467 `"0467"', add
label define cpuma0010_lbl 0468 `"0468"', add
label define cpuma0010_lbl 0469 `"0469"', add
label define cpuma0010_lbl 0470 `"0470"', add
label define cpuma0010_lbl 0471 `"0471"', add
label define cpuma0010_lbl 0472 `"0472"', add
label define cpuma0010_lbl 0473 `"0473"', add
label define cpuma0010_lbl 0474 `"0474"', add
label define cpuma0010_lbl 0475 `"0475"', add
label define cpuma0010_lbl 0476 `"0476"', add
label define cpuma0010_lbl 0477 `"0477"', add
label define cpuma0010_lbl 0478 `"0478"', add
label define cpuma0010_lbl 0479 `"0479"', add
label define cpuma0010_lbl 0480 `"0480"', add
label define cpuma0010_lbl 0481 `"0481"', add
label define cpuma0010_lbl 0482 `"0482"', add
label define cpuma0010_lbl 0483 `"0483"', add
label define cpuma0010_lbl 0484 `"0484"', add
label define cpuma0010_lbl 0485 `"0485"', add
label define cpuma0010_lbl 0486 `"0486"', add
label define cpuma0010_lbl 0487 `"0487"', add
label define cpuma0010_lbl 0488 `"0488"', add
label define cpuma0010_lbl 0489 `"0489"', add
label define cpuma0010_lbl 0490 `"0490"', add
label define cpuma0010_lbl 0491 `"0491"', add
label define cpuma0010_lbl 0492 `"0492"', add
label define cpuma0010_lbl 0493 `"0493"', add
label define cpuma0010_lbl 0494 `"0494"', add
label define cpuma0010_lbl 0495 `"0495"', add
label define cpuma0010_lbl 0496 `"0496"', add
label define cpuma0010_lbl 0497 `"0497"', add
label define cpuma0010_lbl 0498 `"0498"', add
label define cpuma0010_lbl 0499 `"0499"', add
label define cpuma0010_lbl 0500 `"0500"', add
label define cpuma0010_lbl 0501 `"0501"', add
label define cpuma0010_lbl 0502 `"0502"', add
label define cpuma0010_lbl 0503 `"0503"', add
label define cpuma0010_lbl 0504 `"0504"', add
label define cpuma0010_lbl 0505 `"0505"', add
label define cpuma0010_lbl 0506 `"0506"', add
label define cpuma0010_lbl 0507 `"0507"', add
label define cpuma0010_lbl 0508 `"0508"', add
label define cpuma0010_lbl 0509 `"0509"', add
label define cpuma0010_lbl 0510 `"0510"', add
label define cpuma0010_lbl 0511 `"0511"', add
label define cpuma0010_lbl 0512 `"0512"', add
label define cpuma0010_lbl 0513 `"0513"', add
label define cpuma0010_lbl 0514 `"0514"', add
label define cpuma0010_lbl 0515 `"0515"', add
label define cpuma0010_lbl 0516 `"0516"', add
label define cpuma0010_lbl 0517 `"0517"', add
label define cpuma0010_lbl 0518 `"0518"', add
label define cpuma0010_lbl 0519 `"0519"', add
label define cpuma0010_lbl 0520 `"0520"', add
label define cpuma0010_lbl 0521 `"0521"', add
label define cpuma0010_lbl 0522 `"0522"', add
label define cpuma0010_lbl 0523 `"0523"', add
label define cpuma0010_lbl 0524 `"0524"', add
label define cpuma0010_lbl 0525 `"0525"', add
label define cpuma0010_lbl 0526 `"0526"', add
label define cpuma0010_lbl 0527 `"0527"', add
label define cpuma0010_lbl 0528 `"0528"', add
label define cpuma0010_lbl 0529 `"0529"', add
label define cpuma0010_lbl 0530 `"0530"', add
label define cpuma0010_lbl 0531 `"0531"', add
label define cpuma0010_lbl 0532 `"0532"', add
label define cpuma0010_lbl 0533 `"0533"', add
label define cpuma0010_lbl 0534 `"0534"', add
label define cpuma0010_lbl 0535 `"0535"', add
label define cpuma0010_lbl 0536 `"0536"', add
label define cpuma0010_lbl 0537 `"0537"', add
label define cpuma0010_lbl 0538 `"0538"', add
label define cpuma0010_lbl 0539 `"0539"', add
label define cpuma0010_lbl 0540 `"0540"', add
label define cpuma0010_lbl 0541 `"0541"', add
label define cpuma0010_lbl 0542 `"0542"', add
label define cpuma0010_lbl 0543 `"0543"', add
label define cpuma0010_lbl 0544 `"0544"', add
label define cpuma0010_lbl 0545 `"0545"', add
label define cpuma0010_lbl 0546 `"0546"', add
label define cpuma0010_lbl 0547 `"0547"', add
label define cpuma0010_lbl 0548 `"0548"', add
label define cpuma0010_lbl 0549 `"0549"', add
label define cpuma0010_lbl 0550 `"0550"', add
label define cpuma0010_lbl 0551 `"0551"', add
label define cpuma0010_lbl 0552 `"0552"', add
label define cpuma0010_lbl 0553 `"0553"', add
label define cpuma0010_lbl 0554 `"0554"', add
label define cpuma0010_lbl 0555 `"0555"', add
label define cpuma0010_lbl 0556 `"0556"', add
label define cpuma0010_lbl 0557 `"0557"', add
label define cpuma0010_lbl 0558 `"0558"', add
label define cpuma0010_lbl 0559 `"0559"', add
label define cpuma0010_lbl 0560 `"0560"', add
label define cpuma0010_lbl 0561 `"0561"', add
label define cpuma0010_lbl 0562 `"0562"', add
label define cpuma0010_lbl 0563 `"0563"', add
label define cpuma0010_lbl 0564 `"0564"', add
label define cpuma0010_lbl 0565 `"0565"', add
label define cpuma0010_lbl 0566 `"0566"', add
label define cpuma0010_lbl 0567 `"0567"', add
label define cpuma0010_lbl 0568 `"0568"', add
label define cpuma0010_lbl 0569 `"0569"', add
label define cpuma0010_lbl 0570 `"0570"', add
label define cpuma0010_lbl 0571 `"0571"', add
label define cpuma0010_lbl 0572 `"0572"', add
label define cpuma0010_lbl 0573 `"0573"', add
label define cpuma0010_lbl 0574 `"0574"', add
label define cpuma0010_lbl 0575 `"0575"', add
label define cpuma0010_lbl 0576 `"0576"', add
label define cpuma0010_lbl 0577 `"0577"', add
label define cpuma0010_lbl 0578 `"0578"', add
label define cpuma0010_lbl 0579 `"0579"', add
label define cpuma0010_lbl 0580 `"0580"', add
label define cpuma0010_lbl 0581 `"0581"', add
label define cpuma0010_lbl 0582 `"0582"', add
label define cpuma0010_lbl 0583 `"0583"', add
label define cpuma0010_lbl 0584 `"0584"', add
label define cpuma0010_lbl 0585 `"0585"', add
label define cpuma0010_lbl 0586 `"0586"', add
label define cpuma0010_lbl 0587 `"0587"', add
label define cpuma0010_lbl 0588 `"0588"', add
label define cpuma0010_lbl 0589 `"0589"', add
label define cpuma0010_lbl 0590 `"0590"', add
label define cpuma0010_lbl 0591 `"0591"', add
label define cpuma0010_lbl 0592 `"0592"', add
label define cpuma0010_lbl 0593 `"0593"', add
label define cpuma0010_lbl 0594 `"0594"', add
label define cpuma0010_lbl 0595 `"0595"', add
label define cpuma0010_lbl 0596 `"0596"', add
label define cpuma0010_lbl 0597 `"0597"', add
label define cpuma0010_lbl 0598 `"0598"', add
label define cpuma0010_lbl 0599 `"0599"', add
label define cpuma0010_lbl 0600 `"0600"', add
label define cpuma0010_lbl 0601 `"0601"', add
label define cpuma0010_lbl 0602 `"0602"', add
label define cpuma0010_lbl 0603 `"0603"', add
label define cpuma0010_lbl 0604 `"0604"', add
label define cpuma0010_lbl 0605 `"0605"', add
label define cpuma0010_lbl 0606 `"0606"', add
label define cpuma0010_lbl 0607 `"0607"', add
label define cpuma0010_lbl 0608 `"0608"', add
label define cpuma0010_lbl 0609 `"0609"', add
label define cpuma0010_lbl 0610 `"0610"', add
label define cpuma0010_lbl 0611 `"0611"', add
label define cpuma0010_lbl 0612 `"0612"', add
label define cpuma0010_lbl 0613 `"0613"', add
label define cpuma0010_lbl 0614 `"0614"', add
label define cpuma0010_lbl 0615 `"0615"', add
label define cpuma0010_lbl 0616 `"0616"', add
label define cpuma0010_lbl 0617 `"0617"', add
label define cpuma0010_lbl 0618 `"0618"', add
label define cpuma0010_lbl 0619 `"0619"', add
label define cpuma0010_lbl 0620 `"0620"', add
label define cpuma0010_lbl 0621 `"0621"', add
label define cpuma0010_lbl 0622 `"0622"', add
label define cpuma0010_lbl 0623 `"0623"', add
label define cpuma0010_lbl 0624 `"0624"', add
label define cpuma0010_lbl 0625 `"0625"', add
label define cpuma0010_lbl 0626 `"0626"', add
label define cpuma0010_lbl 0627 `"0627"', add
label define cpuma0010_lbl 0628 `"0628"', add
label define cpuma0010_lbl 0629 `"0629"', add
label define cpuma0010_lbl 0630 `"0630"', add
label define cpuma0010_lbl 0631 `"0631"', add
label define cpuma0010_lbl 0632 `"0632"', add
label define cpuma0010_lbl 0633 `"0633"', add
label define cpuma0010_lbl 0634 `"0634"', add
label define cpuma0010_lbl 0635 `"0635"', add
label define cpuma0010_lbl 0636 `"0636"', add
label define cpuma0010_lbl 0637 `"0637"', add
label define cpuma0010_lbl 0638 `"0638"', add
label define cpuma0010_lbl 0639 `"0639"', add
label define cpuma0010_lbl 0640 `"0640"', add
label define cpuma0010_lbl 0641 `"0641"', add
label define cpuma0010_lbl 0642 `"0642"', add
label define cpuma0010_lbl 0643 `"0643"', add
label define cpuma0010_lbl 0644 `"0644"', add
label define cpuma0010_lbl 0645 `"0645"', add
label define cpuma0010_lbl 0646 `"0646"', add
label define cpuma0010_lbl 0647 `"0647"', add
label define cpuma0010_lbl 0648 `"0648"', add
label define cpuma0010_lbl 0649 `"0649"', add
label define cpuma0010_lbl 0650 `"0650"', add
label define cpuma0010_lbl 0651 `"0651"', add
label define cpuma0010_lbl 0652 `"0652"', add
label define cpuma0010_lbl 0653 `"0653"', add
label define cpuma0010_lbl 0654 `"0654"', add
label define cpuma0010_lbl 0655 `"0655"', add
label define cpuma0010_lbl 0656 `"0656"', add
label define cpuma0010_lbl 0657 `"0657"', add
label define cpuma0010_lbl 0658 `"0658"', add
label define cpuma0010_lbl 0659 `"0659"', add
label define cpuma0010_lbl 0660 `"0660"', add
label define cpuma0010_lbl 0661 `"0661"', add
label define cpuma0010_lbl 0662 `"0662"', add
label define cpuma0010_lbl 0663 `"0663"', add
label define cpuma0010_lbl 0664 `"0664"', add
label define cpuma0010_lbl 0665 `"0665"', add
label define cpuma0010_lbl 0666 `"0666"', add
label define cpuma0010_lbl 0667 `"0667"', add
label define cpuma0010_lbl 0668 `"0668"', add
label define cpuma0010_lbl 0669 `"0669"', add
label define cpuma0010_lbl 0670 `"0670"', add
label define cpuma0010_lbl 0671 `"0671"', add
label define cpuma0010_lbl 0672 `"0672"', add
label define cpuma0010_lbl 0673 `"0673"', add
label define cpuma0010_lbl 0674 `"0674"', add
label define cpuma0010_lbl 0675 `"0675"', add
label define cpuma0010_lbl 0676 `"0676"', add
label define cpuma0010_lbl 0677 `"0677"', add
label define cpuma0010_lbl 0678 `"0678"', add
label define cpuma0010_lbl 0679 `"0679"', add
label define cpuma0010_lbl 0680 `"0680"', add
label define cpuma0010_lbl 0681 `"0681"', add
label define cpuma0010_lbl 0682 `"0682"', add
label define cpuma0010_lbl 0683 `"0683"', add
label define cpuma0010_lbl 0684 `"0684"', add
label define cpuma0010_lbl 0685 `"0685"', add
label define cpuma0010_lbl 0686 `"0686"', add
label define cpuma0010_lbl 0687 `"0687"', add
label define cpuma0010_lbl 0688 `"0688"', add
label define cpuma0010_lbl 0689 `"0689"', add
label define cpuma0010_lbl 0690 `"0690"', add
label define cpuma0010_lbl 0691 `"0691"', add
label define cpuma0010_lbl 0692 `"0692"', add
label define cpuma0010_lbl 0693 `"0693"', add
label define cpuma0010_lbl 0694 `"0694"', add
label define cpuma0010_lbl 0695 `"0695"', add
label define cpuma0010_lbl 0696 `"0696"', add
label define cpuma0010_lbl 0697 `"0697"', add
label define cpuma0010_lbl 0698 `"0698"', add
label define cpuma0010_lbl 0699 `"0699"', add
label define cpuma0010_lbl 0700 `"0700"', add
label define cpuma0010_lbl 0701 `"0701"', add
label define cpuma0010_lbl 0702 `"0702"', add
label define cpuma0010_lbl 0703 `"0703"', add
label define cpuma0010_lbl 0704 `"0704"', add
label define cpuma0010_lbl 0705 `"0705"', add
label define cpuma0010_lbl 0706 `"0706"', add
label define cpuma0010_lbl 0707 `"0707"', add
label define cpuma0010_lbl 0708 `"0708"', add
label define cpuma0010_lbl 0709 `"0709"', add
label define cpuma0010_lbl 0710 `"0710"', add
label define cpuma0010_lbl 0711 `"0711"', add
label define cpuma0010_lbl 0712 `"0712"', add
label define cpuma0010_lbl 0713 `"0713"', add
label define cpuma0010_lbl 0714 `"0714"', add
label define cpuma0010_lbl 0715 `"0715"', add
label define cpuma0010_lbl 0716 `"0716"', add
label define cpuma0010_lbl 0717 `"0717"', add
label define cpuma0010_lbl 0718 `"0718"', add
label define cpuma0010_lbl 0719 `"0719"', add
label define cpuma0010_lbl 0720 `"0720"', add
label define cpuma0010_lbl 0721 `"0721"', add
label define cpuma0010_lbl 0722 `"0722"', add
label define cpuma0010_lbl 0723 `"0723"', add
label define cpuma0010_lbl 0724 `"0724"', add
label define cpuma0010_lbl 0725 `"0725"', add
label define cpuma0010_lbl 0726 `"0726"', add
label define cpuma0010_lbl 0727 `"0727"', add
label define cpuma0010_lbl 0728 `"0728"', add
label define cpuma0010_lbl 0729 `"0729"', add
label define cpuma0010_lbl 0730 `"0730"', add
label define cpuma0010_lbl 0731 `"0731"', add
label define cpuma0010_lbl 0732 `"0732"', add
label define cpuma0010_lbl 0733 `"0733"', add
label define cpuma0010_lbl 0734 `"0734"', add
label define cpuma0010_lbl 0735 `"0735"', add
label define cpuma0010_lbl 0736 `"0736"', add
label define cpuma0010_lbl 0737 `"0737"', add
label define cpuma0010_lbl 0738 `"0738"', add
label define cpuma0010_lbl 0739 `"0739"', add
label define cpuma0010_lbl 0740 `"0740"', add
label define cpuma0010_lbl 0741 `"0741"', add
label define cpuma0010_lbl 0742 `"0742"', add
label define cpuma0010_lbl 0743 `"0743"', add
label define cpuma0010_lbl 0744 `"0744"', add
label define cpuma0010_lbl 0745 `"0745"', add
label define cpuma0010_lbl 0746 `"0746"', add
label define cpuma0010_lbl 0747 `"0747"', add
label define cpuma0010_lbl 0748 `"0748"', add
label define cpuma0010_lbl 0749 `"0749"', add
label define cpuma0010_lbl 0750 `"0750"', add
label define cpuma0010_lbl 0751 `"0751"', add
label define cpuma0010_lbl 0752 `"0752"', add
label define cpuma0010_lbl 0753 `"0753"', add
label define cpuma0010_lbl 0754 `"0754"', add
label define cpuma0010_lbl 0755 `"0755"', add
label define cpuma0010_lbl 0756 `"0756"', add
label define cpuma0010_lbl 0757 `"0757"', add
label define cpuma0010_lbl 0758 `"0758"', add
label define cpuma0010_lbl 0759 `"0759"', add
label define cpuma0010_lbl 0760 `"0760"', add
label define cpuma0010_lbl 0761 `"0761"', add
label define cpuma0010_lbl 0762 `"0762"', add
label define cpuma0010_lbl 0763 `"0763"', add
label define cpuma0010_lbl 0764 `"0764"', add
label define cpuma0010_lbl 0765 `"0765"', add
label define cpuma0010_lbl 0766 `"0766"', add
label define cpuma0010_lbl 0767 `"0767"', add
label define cpuma0010_lbl 0768 `"0768"', add
label define cpuma0010_lbl 0769 `"0769"', add
label define cpuma0010_lbl 0770 `"0770"', add
label define cpuma0010_lbl 0771 `"0771"', add
label define cpuma0010_lbl 0772 `"0772"', add
label define cpuma0010_lbl 0773 `"0773"', add
label define cpuma0010_lbl 0774 `"0774"', add
label define cpuma0010_lbl 0775 `"0775"', add
label define cpuma0010_lbl 0776 `"0776"', add
label define cpuma0010_lbl 0777 `"0777"', add
label define cpuma0010_lbl 0778 `"0778"', add
label define cpuma0010_lbl 0779 `"0779"', add
label define cpuma0010_lbl 0780 `"0780"', add
label define cpuma0010_lbl 0781 `"0781"', add
label define cpuma0010_lbl 0782 `"0782"', add
label define cpuma0010_lbl 0783 `"0783"', add
label define cpuma0010_lbl 0784 `"0784"', add
label define cpuma0010_lbl 0785 `"0785"', add
label define cpuma0010_lbl 0786 `"0786"', add
label define cpuma0010_lbl 0787 `"0787"', add
label define cpuma0010_lbl 0788 `"0788"', add
label define cpuma0010_lbl 0789 `"0789"', add
label define cpuma0010_lbl 0790 `"0790"', add
label define cpuma0010_lbl 0791 `"0791"', add
label define cpuma0010_lbl 0792 `"0792"', add
label define cpuma0010_lbl 0793 `"0793"', add
label define cpuma0010_lbl 0794 `"0794"', add
label define cpuma0010_lbl 0795 `"0795"', add
label define cpuma0010_lbl 0796 `"0796"', add
label define cpuma0010_lbl 0797 `"0797"', add
label define cpuma0010_lbl 0798 `"0798"', add
label define cpuma0010_lbl 0799 `"0799"', add
label define cpuma0010_lbl 0800 `"0800"', add
label define cpuma0010_lbl 0801 `"0801"', add
label define cpuma0010_lbl 0802 `"0802"', add
label define cpuma0010_lbl 0803 `"0803"', add
label define cpuma0010_lbl 0804 `"0804"', add
label define cpuma0010_lbl 0805 `"0805"', add
label define cpuma0010_lbl 0806 `"0806"', add
label define cpuma0010_lbl 0807 `"0807"', add
label define cpuma0010_lbl 0808 `"0808"', add
label define cpuma0010_lbl 0809 `"0809"', add
label define cpuma0010_lbl 0810 `"0810"', add
label define cpuma0010_lbl 0811 `"0811"', add
label define cpuma0010_lbl 0812 `"0812"', add
label define cpuma0010_lbl 0813 `"0813"', add
label define cpuma0010_lbl 0814 `"0814"', add
label define cpuma0010_lbl 0815 `"0815"', add
label define cpuma0010_lbl 0816 `"0816"', add
label define cpuma0010_lbl 0817 `"0817"', add
label define cpuma0010_lbl 0818 `"0818"', add
label define cpuma0010_lbl 0819 `"0819"', add
label define cpuma0010_lbl 0820 `"0820"', add
label define cpuma0010_lbl 0821 `"0821"', add
label define cpuma0010_lbl 0822 `"0822"', add
label define cpuma0010_lbl 0823 `"0823"', add
label define cpuma0010_lbl 0824 `"0824"', add
label define cpuma0010_lbl 0825 `"0825"', add
label define cpuma0010_lbl 0826 `"0826"', add
label define cpuma0010_lbl 0827 `"0827"', add
label define cpuma0010_lbl 0828 `"0828"', add
label define cpuma0010_lbl 0829 `"0829"', add
label define cpuma0010_lbl 0830 `"0830"', add
label define cpuma0010_lbl 0831 `"0831"', add
label define cpuma0010_lbl 0832 `"0832"', add
label define cpuma0010_lbl 0833 `"0833"', add
label define cpuma0010_lbl 0834 `"0834"', add
label define cpuma0010_lbl 0835 `"0835"', add
label define cpuma0010_lbl 0836 `"0836"', add
label define cpuma0010_lbl 0837 `"0837"', add
label define cpuma0010_lbl 0838 `"0838"', add
label define cpuma0010_lbl 0839 `"0839"', add
label define cpuma0010_lbl 0840 `"0840"', add
label define cpuma0010_lbl 0841 `"0841"', add
label define cpuma0010_lbl 0842 `"0842"', add
label define cpuma0010_lbl 0843 `"0843"', add
label define cpuma0010_lbl 0844 `"0844"', add
label define cpuma0010_lbl 0845 `"0845"', add
label define cpuma0010_lbl 0846 `"0846"', add
label define cpuma0010_lbl 0847 `"0847"', add
label define cpuma0010_lbl 0848 `"0848"', add
label define cpuma0010_lbl 0849 `"0849"', add
label define cpuma0010_lbl 0850 `"0850"', add
label define cpuma0010_lbl 0851 `"0851"', add
label define cpuma0010_lbl 0852 `"0852"', add
label define cpuma0010_lbl 0853 `"0853"', add
label define cpuma0010_lbl 0854 `"0854"', add
label define cpuma0010_lbl 0855 `"0855"', add
label define cpuma0010_lbl 0856 `"0856"', add
label define cpuma0010_lbl 0857 `"0857"', add
label define cpuma0010_lbl 0858 `"0858"', add
label define cpuma0010_lbl 0859 `"0859"', add
label define cpuma0010_lbl 0860 `"0860"', add
label define cpuma0010_lbl 0861 `"0861"', add
label define cpuma0010_lbl 0862 `"0862"', add
label define cpuma0010_lbl 0863 `"0863"', add
label define cpuma0010_lbl 0864 `"0864"', add
label define cpuma0010_lbl 0865 `"0865"', add
label define cpuma0010_lbl 0866 `"0866"', add
label define cpuma0010_lbl 0867 `"0867"', add
label define cpuma0010_lbl 0868 `"0868"', add
label define cpuma0010_lbl 0869 `"0869"', add
label define cpuma0010_lbl 0870 `"0870"', add
label define cpuma0010_lbl 0871 `"0871"', add
label define cpuma0010_lbl 0872 `"0872"', add
label define cpuma0010_lbl 0873 `"0873"', add
label define cpuma0010_lbl 0874 `"0874"', add
label define cpuma0010_lbl 0875 `"0875"', add
label define cpuma0010_lbl 0876 `"0876"', add
label define cpuma0010_lbl 0877 `"0877"', add
label define cpuma0010_lbl 0878 `"0878"', add
label define cpuma0010_lbl 0879 `"0879"', add
label define cpuma0010_lbl 0880 `"0880"', add
label define cpuma0010_lbl 0881 `"0881"', add
label define cpuma0010_lbl 0882 `"0882"', add
label define cpuma0010_lbl 0883 `"0883"', add
label define cpuma0010_lbl 0884 `"0884"', add
label define cpuma0010_lbl 0885 `"0885"', add
label define cpuma0010_lbl 0886 `"0886"', add
label define cpuma0010_lbl 0887 `"0887"', add
label define cpuma0010_lbl 0888 `"0888"', add
label define cpuma0010_lbl 0889 `"0889"', add
label define cpuma0010_lbl 0890 `"0890"', add
label define cpuma0010_lbl 0891 `"0891"', add
label define cpuma0010_lbl 0892 `"0892"', add
label define cpuma0010_lbl 0893 `"0893"', add
label define cpuma0010_lbl 0894 `"0894"', add
label define cpuma0010_lbl 0895 `"0895"', add
label define cpuma0010_lbl 0896 `"0896"', add
label define cpuma0010_lbl 0897 `"0897"', add
label define cpuma0010_lbl 0898 `"0898"', add
label define cpuma0010_lbl 0899 `"0899"', add
label define cpuma0010_lbl 0900 `"0900"', add
label define cpuma0010_lbl 0901 `"0901"', add
label define cpuma0010_lbl 0902 `"0902"', add
label define cpuma0010_lbl 0903 `"0903"', add
label define cpuma0010_lbl 0904 `"0904"', add
label define cpuma0010_lbl 0905 `"0905"', add
label define cpuma0010_lbl 0906 `"0906"', add
label define cpuma0010_lbl 0907 `"0907"', add
label define cpuma0010_lbl 0908 `"0908"', add
label define cpuma0010_lbl 0909 `"0909"', add
label define cpuma0010_lbl 0910 `"0910"', add
label define cpuma0010_lbl 0911 `"0911"', add
label define cpuma0010_lbl 0912 `"0912"', add
label define cpuma0010_lbl 0913 `"0913"', add
label define cpuma0010_lbl 0914 `"0914"', add
label define cpuma0010_lbl 0915 `"0915"', add
label define cpuma0010_lbl 0916 `"0916"', add
label define cpuma0010_lbl 0917 `"0917"', add
label define cpuma0010_lbl 0918 `"0918"', add
label define cpuma0010_lbl 0919 `"0919"', add
label define cpuma0010_lbl 0920 `"0920"', add
label define cpuma0010_lbl 0921 `"0921"', add
label define cpuma0010_lbl 0922 `"0922"', add
label define cpuma0010_lbl 0923 `"0923"', add
label define cpuma0010_lbl 0924 `"0924"', add
label define cpuma0010_lbl 0925 `"0925"', add
label define cpuma0010_lbl 0926 `"0926"', add
label define cpuma0010_lbl 0927 `"0927"', add
label define cpuma0010_lbl 0928 `"0928"', add
label define cpuma0010_lbl 0929 `"0929"', add
label define cpuma0010_lbl 0930 `"0930"', add
label define cpuma0010_lbl 0931 `"0931"', add
label define cpuma0010_lbl 0932 `"0932"', add
label define cpuma0010_lbl 0933 `"0933"', add
label define cpuma0010_lbl 0934 `"0934"', add
label define cpuma0010_lbl 0935 `"0935"', add
label define cpuma0010_lbl 0936 `"0936"', add
label define cpuma0010_lbl 0937 `"0937"', add
label define cpuma0010_lbl 0938 `"0938"', add
label define cpuma0010_lbl 0939 `"0939"', add
label define cpuma0010_lbl 0940 `"0940"', add
label define cpuma0010_lbl 0941 `"0941"', add
label define cpuma0010_lbl 0942 `"0942"', add
label define cpuma0010_lbl 0943 `"0943"', add
label define cpuma0010_lbl 0944 `"0944"', add
label define cpuma0010_lbl 0945 `"0945"', add
label define cpuma0010_lbl 0946 `"0946"', add
label define cpuma0010_lbl 0947 `"0947"', add
label define cpuma0010_lbl 0948 `"0948"', add
label define cpuma0010_lbl 0949 `"0949"', add
label define cpuma0010_lbl 0950 `"0950"', add
label define cpuma0010_lbl 0951 `"0951"', add
label define cpuma0010_lbl 0952 `"0952"', add
label define cpuma0010_lbl 0953 `"0953"', add
label define cpuma0010_lbl 0954 `"0954"', add
label define cpuma0010_lbl 0955 `"0955"', add
label define cpuma0010_lbl 0956 `"0956"', add
label define cpuma0010_lbl 0957 `"0957"', add
label define cpuma0010_lbl 0958 `"0958"', add
label define cpuma0010_lbl 0959 `"0959"', add
label define cpuma0010_lbl 0960 `"0960"', add
label define cpuma0010_lbl 0961 `"0961"', add
label define cpuma0010_lbl 0962 `"0962"', add
label define cpuma0010_lbl 0963 `"0963"', add
label define cpuma0010_lbl 0964 `"0964"', add
label define cpuma0010_lbl 0965 `"0965"', add
label define cpuma0010_lbl 0966 `"0966"', add
label define cpuma0010_lbl 0967 `"0967"', add
label define cpuma0010_lbl 0968 `"0968"', add
label define cpuma0010_lbl 0969 `"0969"', add
label define cpuma0010_lbl 0970 `"0970"', add
label define cpuma0010_lbl 0971 `"0971"', add
label define cpuma0010_lbl 0972 `"0972"', add
label define cpuma0010_lbl 0973 `"0973"', add
label define cpuma0010_lbl 0974 `"0974"', add
label define cpuma0010_lbl 0975 `"0975"', add
label define cpuma0010_lbl 0976 `"0976"', add
label define cpuma0010_lbl 0977 `"0977"', add
label define cpuma0010_lbl 0978 `"0978"', add
label define cpuma0010_lbl 0979 `"0979"', add
label define cpuma0010_lbl 0980 `"0980"', add
label define cpuma0010_lbl 0981 `"0981"', add
label define cpuma0010_lbl 0982 `"0982"', add
label define cpuma0010_lbl 0983 `"0983"', add
label define cpuma0010_lbl 0984 `"0984"', add
label define cpuma0010_lbl 0985 `"0985"', add
label define cpuma0010_lbl 0986 `"0986"', add
label define cpuma0010_lbl 0987 `"0987"', add
label define cpuma0010_lbl 0988 `"0988"', add
label define cpuma0010_lbl 0989 `"0989"', add
label define cpuma0010_lbl 0990 `"0990"', add
label define cpuma0010_lbl 0991 `"0991"', add
label define cpuma0010_lbl 0992 `"0992"', add
label define cpuma0010_lbl 0993 `"0993"', add
label define cpuma0010_lbl 0994 `"0994"', add
label define cpuma0010_lbl 0995 `"0995"', add
label define cpuma0010_lbl 0996 `"0996"', add
label define cpuma0010_lbl 0997 `"0997"', add
label define cpuma0010_lbl 0998 `"0998"', add
label define cpuma0010_lbl 0999 `"0999"', add
label define cpuma0010_lbl 1000 `"1000"', add
label define cpuma0010_lbl 1001 `"1001"', add
label define cpuma0010_lbl 1002 `"1002"', add
label define cpuma0010_lbl 1003 `"1003"', add
label define cpuma0010_lbl 1004 `"1004"', add
label define cpuma0010_lbl 1005 `"1005"', add
label define cpuma0010_lbl 1006 `"1006"', add
label define cpuma0010_lbl 1007 `"1007"', add
label define cpuma0010_lbl 1008 `"1008"', add
label define cpuma0010_lbl 1009 `"1009"', add
label define cpuma0010_lbl 1010 `"1010"', add
label define cpuma0010_lbl 1011 `"1011"', add
label define cpuma0010_lbl 1012 `"1012"', add
label define cpuma0010_lbl 1013 `"1013"', add
label define cpuma0010_lbl 1014 `"1014"', add
label define cpuma0010_lbl 1015 `"1015"', add
label define cpuma0010_lbl 1016 `"1016"', add
label define cpuma0010_lbl 1017 `"1017"', add
label define cpuma0010_lbl 1018 `"1018"', add
label define cpuma0010_lbl 1019 `"1019"', add
label define cpuma0010_lbl 1020 `"1020"', add
label define cpuma0010_lbl 1021 `"1021"', add
label define cpuma0010_lbl 1022 `"1022"', add
label define cpuma0010_lbl 1023 `"1023"', add
label define cpuma0010_lbl 1024 `"1024"', add
label define cpuma0010_lbl 1025 `"1025"', add
label define cpuma0010_lbl 1026 `"1026"', add
label define cpuma0010_lbl 1027 `"1027"', add
label define cpuma0010_lbl 1028 `"1028"', add
label define cpuma0010_lbl 1029 `"1029"', add
label define cpuma0010_lbl 1030 `"1030"', add
label define cpuma0010_lbl 1031 `"1031"', add
label define cpuma0010_lbl 1032 `"1032"', add
label define cpuma0010_lbl 1033 `"1033"', add
label define cpuma0010_lbl 1034 `"1034"', add
label define cpuma0010_lbl 1035 `"1035"', add
label define cpuma0010_lbl 1036 `"1036"', add
label define cpuma0010_lbl 1037 `"1037"', add
label define cpuma0010_lbl 1038 `"1038"', add
label define cpuma0010_lbl 1039 `"1039"', add
label define cpuma0010_lbl 1040 `"1040"', add
label define cpuma0010_lbl 1041 `"1041"', add
label define cpuma0010_lbl 1042 `"1042"', add
label define cpuma0010_lbl 1043 `"1043"', add
label define cpuma0010_lbl 1044 `"1044"', add
label define cpuma0010_lbl 1045 `"1045"', add
label define cpuma0010_lbl 1046 `"1046"', add
label define cpuma0010_lbl 1047 `"1047"', add
label define cpuma0010_lbl 1048 `"1048"', add
label define cpuma0010_lbl 1049 `"1049"', add
label define cpuma0010_lbl 1050 `"1050"', add
label define cpuma0010_lbl 1051 `"1051"', add
label define cpuma0010_lbl 1052 `"1052"', add
label define cpuma0010_lbl 1053 `"1053"', add
label define cpuma0010_lbl 1054 `"1054"', add
label define cpuma0010_lbl 1055 `"1055"', add
label define cpuma0010_lbl 1056 `"1056"', add
label define cpuma0010_lbl 1057 `"1057"', add
label define cpuma0010_lbl 1058 `"1058"', add
label define cpuma0010_lbl 1059 `"1059"', add
label define cpuma0010_lbl 1060 `"1060"', add
label define cpuma0010_lbl 1061 `"1061"', add
label define cpuma0010_lbl 1062 `"1062"', add
label define cpuma0010_lbl 1063 `"1063"', add
label define cpuma0010_lbl 1064 `"1064"', add
label define cpuma0010_lbl 1065 `"1065"', add
label define cpuma0010_lbl 1066 `"1066"', add
label define cpuma0010_lbl 1067 `"1067"', add
label define cpuma0010_lbl 1068 `"1068"', add
label define cpuma0010_lbl 1069 `"1069"', add
label define cpuma0010_lbl 1070 `"1070"', add
label define cpuma0010_lbl 1071 `"1071"', add
label define cpuma0010_lbl 1072 `"1072"', add
label define cpuma0010_lbl 1073 `"1073"', add
label define cpuma0010_lbl 1074 `"1074"', add
label define cpuma0010_lbl 1075 `"1075"', add
label define cpuma0010_lbl 1076 `"1076"', add
label define cpuma0010_lbl 1077 `"1077"', add
label define cpuma0010_lbl 1078 `"1078"', add
label define cpuma0010_lbl 1079 `"1079"', add
label define cpuma0010_lbl 1080 `"1080"', add
label define cpuma0010_lbl 1081 `"1081"', add
label define cpuma0010_lbl 1082 `"1082"', add
label define cpuma0010_lbl 1083 `"1083"', add
label define cpuma0010_lbl 1084 `"1084"', add
label define cpuma0010_lbl 1085 `"1085"', add
label values cpuma0010 cpuma0010_lbl

label define metro_lbl 0 `"Metropolitan status indeterminable (mixed)"'
label define metro_lbl 1 `"Not in metropolitan area"', add
label define metro_lbl 2 `"In metropolitan area: In central/principal city"', add
label define metro_lbl 3 `"In metropolitan area: Not in central/principal city"', add
label define metro_lbl 4 `"In metropolitan area: Central/principal city status indeterminable (mixed)"', add
label values metro metro_lbl

label define met2013_lbl 00000 `"Not in identifiable area"'
label define met2013_lbl 10420 `"Akron, OH"', add
label define met2013_lbl 10540 `"Albany, OR"', add
label define met2013_lbl 10580 `"Albany-Schenectady-Troy, NY"', add
label define met2013_lbl 10740 `"Albuquerque, NM"', add
label define met2013_lbl 10780 `"Alexandria, LA"', add
label define met2013_lbl 10900 `"Allentown-Bethlehem-Easton, PA-NJ"', add
label define met2013_lbl 11020 `"Altoona, PA"', add
label define met2013_lbl 11100 `"Amarillo, TX"', add
label define met2013_lbl 11260 `"Anchorage, AK"', add
label define met2013_lbl 11460 `"Ann Arbor, MI"', add
label define met2013_lbl 11500 `"Anniston-Oxford-Jacksonville, AL"', add
label define met2013_lbl 11700 `"Asheville, NC"', add
label define met2013_lbl 12020 `"Athens-Clarke County, GA"', add
label define met2013_lbl 12060 `"Atlanta-Sandy Springs-Roswell, GA"', add
label define met2013_lbl 12100 `"Atlantic City-Hammonton, NJ"', add
label define met2013_lbl 12220 `"Auburn-Opelika, AL"', add
label define met2013_lbl 12260 `"Augusta-Richmond County, GA-SC"', add
label define met2013_lbl 12420 `"Austin-Round Rock, TX"', add
label define met2013_lbl 12540 `"Bakersfield, CA"', add
label define met2013_lbl 12580 `"Baltimore-Columbia-Towson, MD"', add
label define met2013_lbl 12620 `"Bangor, ME"', add
label define met2013_lbl 12700 `"Barnstable Town, MA"', add
label define met2013_lbl 12940 `"Baton Rouge, LA"', add
label define met2013_lbl 12980 `"Battle Creek, MI"', add
label define met2013_lbl 13140 `"Beaumont-Port Arthur, TX"', add
label define met2013_lbl 13220 `"Beckley, WV"', add
label define met2013_lbl 13380 `"Bellingham, WA"', add
label define met2013_lbl 13460 `"Bend-Redmond, OR"', add
label define met2013_lbl 13740 `"Billings, MT"', add
label define met2013_lbl 13780 `"Binghamton, NY"', add
label define met2013_lbl 13820 `"Birmingham-Hoover, AL"', add
label define met2013_lbl 13900 `"Bismarck, ND"', add
label define met2013_lbl 13980 `"Blacksburg-Christiansburg-Radford, VA"', add
label define met2013_lbl 14010 `"Bloomington, IL"', add
label define met2013_lbl 14020 `"Bloomington, IN"', add
label define met2013_lbl 14260 `"Boise City, ID"', add
label define met2013_lbl 14460 `"Boston-Cambridge-Newton, MA-NH"', add
label define met2013_lbl 14740 `"Bremerton-Silverdale, WA"', add
label define met2013_lbl 14860 `"Bridgeport-Stamford-Norwalk, CT"', add
label define met2013_lbl 15180 `"Brownsville-Harlingen, TX"', add
label define met2013_lbl 15380 `"Buffalo-Cheektowaga-Niagara Falls, NY"', add
label define met2013_lbl 15500 `"Burlington, NC"', add
label define met2013_lbl 15540 `"Burlington-South Burlington, VT"', add
label define met2013_lbl 15680 `"California-Lexington Park, MD"', add
label define met2013_lbl 15940 `"Canton-Massillon, OH"', add
label define met2013_lbl 15980 `"Cape Coral-Fort Myers, FL"', add
label define met2013_lbl 16580 `"Champaign-Urbana, IL"', add
label define met2013_lbl 16620 `"Charleston, WV"', add
label define met2013_lbl 16700 `"Charleston-North Charleston, SC"', add
label define met2013_lbl 16740 `"Charlotte-Concord-Gastonia, NC-SC"', add
label define met2013_lbl 16820 `"Charlottesville, VA"', add
label define met2013_lbl 16860 `"Chattanooga, TN-GA"', add
label define met2013_lbl 16940 `"Cheyenne, WY"', add
label define met2013_lbl 16980 `"Chicago-Naperville-Elgin, IL-IN-WI"', add
label define met2013_lbl 17020 `"Chico, CA"', add
label define met2013_lbl 17140 `"Cincinnati, OH-KY-IN"', add
label define met2013_lbl 17300 `"Clarksville, TN-KY"', add
label define met2013_lbl 17420 `"Cleveland, TN"', add
label define met2013_lbl 17460 `"Cleveland-Elyria, OH"', add
label define met2013_lbl 17660 `"Coeur d'Alene, ID"', add
label define met2013_lbl 17780 `"College Station-Bryan, TX"', add
label define met2013_lbl 17820 `"Colorado Springs, CO"', add
label define met2013_lbl 17860 `"Columbia, MO"', add
label define met2013_lbl 17900 `"Columbia, SC"', add
label define met2013_lbl 18140 `"Columbus, OH"', add
label define met2013_lbl 18580 `"Corpus Christi, TX"', add
label define met2013_lbl 18700 `"Corvallis, OR"', add
label define met2013_lbl 18880 `"Crestview-Fort Walton Beach-Destin, FL"', add
label define met2013_lbl 19100 `"Dallas-Fort Worth-Arlington, TX"', add
label define met2013_lbl 19300 `"Daphne-Fairhope-Foley, AL"', add
label define met2013_lbl 19340 `"Davenport-Moline-Rock Island, IA-IL"', add
label define met2013_lbl 19380 `"Dayton, OH"', add
label define met2013_lbl 19460 `"Decatur, AL"', add
label define met2013_lbl 19500 `"Decatur, IL"', add
label define met2013_lbl 19660 `"Deltona-Daytona Beach-Ormond Beach, FL"', add
label define met2013_lbl 19740 `"Denver-Aurora-Lakewood, CO"', add
label define met2013_lbl 19780 `"Des Moines-West Des Moines, IA"', add
label define met2013_lbl 19820 `"Detroit-Warren-Dearborn, MI"', add
label define met2013_lbl 20020 `"Dothan, AL"', add
label define met2013_lbl 20100 `"Dover, DE"', add
label define met2013_lbl 20500 `"Durham-Chapel Hill, NC"', add
label define met2013_lbl 20700 `"East Stroudsburg, PA"', add
label define met2013_lbl 20740 `"Eau Claire, WI"', add
label define met2013_lbl 20940 `"El Centro, CA"', add
label define met2013_lbl 21060 `"Elizabethtown-Fort Knox, KY"', add
label define met2013_lbl 21140 `"Elkhart-Goshen, IN"', add
label define met2013_lbl 21340 `"El Paso, TX"', add
label define met2013_lbl 21500 `"Erie, PA"', add
label define met2013_lbl 21660 `"Eugene, OR"', add
label define met2013_lbl 21780 `"Evansville, IN-KY"', add
label define met2013_lbl 22140 `"Farmington, NM"', add
label define met2013_lbl 22180 `"Fayetteville, NC"', add
label define met2013_lbl 22220 `"Fayetteville-Springdale-Rogers, AR-MO"', add
label define met2013_lbl 22380 `"Flagstaff, AZ"', add
label define met2013_lbl 22420 `"Flint, MI"', add
label define met2013_lbl 22500 `"Florence, SC"', add
label define met2013_lbl 22520 `"Florence-Muscle Shoals, AL"', add
label define met2013_lbl 22660 `"Fort Collins, CO"', add
label define met2013_lbl 23060 `"Fort Wayne, IN"', add
label define met2013_lbl 23420 `"Fresno, CA"', add
label define met2013_lbl 23460 `"Gadsden, AL"', add
label define met2013_lbl 23540 `"Gainesville, FL"', add
label define met2013_lbl 23580 `"Gainesville, GA"', add
label define met2013_lbl 24020 `"Glens Falls, NY"', add
label define met2013_lbl 24140 `"Goldsboro, NC"', add
label define met2013_lbl 24300 `"Grand Junction, CO"', add
label define met2013_lbl 24340 `"Grand Rapids-Wyoming, MI"', add
label define met2013_lbl 24540 `"Greeley, CO"', add
label define met2013_lbl 24660 `"Greensboro-High Point, NC"', add
label define met2013_lbl 24780 `"Greenville, NC"', add
label define met2013_lbl 24860 `"Greenville-Anderson-Mauldin, SC"', add
label define met2013_lbl 25060 `"Gulfport-Biloxi-Pascagoula, MS"', add
label define met2013_lbl 25220 `"Hammond, LA"', add
label define met2013_lbl 25260 `"Hanford-Corcoran, CA"', add
label define met2013_lbl 25420 `"Harrisburg-Carlisle, PA"', add
label define met2013_lbl 25500 `"Harrisonburg, VA"', add
label define met2013_lbl 25540 `"Hartford-West Hartford-East Hartford, CT"', add
label define met2013_lbl 25620 `"Hattiesburg, MS"', add
label define met2013_lbl 25860 `"Hickory-Lenoir-Morganton, NC"', add
label define met2013_lbl 25940 `"Hilton Head Island-Bluffton-Beaufort, SC"', add
label define met2013_lbl 26140 `"Homosassa Springs, FL"', add
label define met2013_lbl 26380 `"Houma-Thibodaux, LA"', add
label define met2013_lbl 26420 `"Houston-The Woodlands-Sugar Land, TX"', add
label define met2013_lbl 26620 `"Huntsville, AL"', add
label define met2013_lbl 26900 `"Indianapolis-Carmel-Anderson, IN"', add
label define met2013_lbl 26980 `"Iowa City, IA"', add
label define met2013_lbl 27060 `"Ithaca, NY"', add
label define met2013_lbl 27100 `"Jackson, MI"', add
label define met2013_lbl 27140 `"Jackson, MS"', add
label define met2013_lbl 27180 `"Jackson, TN"', add
label define met2013_lbl 27260 `"Jacksonville, FL"', add
label define met2013_lbl 27340 `"Jacksonville, NC"', add
label define met2013_lbl 27500 `"Janesville-Beloit, WI"', add
label define met2013_lbl 27620 `"Jefferson City, MO"', add
label define met2013_lbl 27740 `"Johnson City, TN"', add
label define met2013_lbl 27780 `"Johnstown, PA"', add
label define met2013_lbl 27860 `"Jonesboro, AR"', add
label define met2013_lbl 27900 `"Joplin, MO"', add
label define met2013_lbl 28020 `"Kalamazoo-Portage, MI"', add
label define met2013_lbl 28100 `"Kankakee, IL"', add
label define met2013_lbl 28140 `"Kansas City, MO-KS"', add
label define met2013_lbl 28420 `"Kennewick-Richland, WA"', add
label define met2013_lbl 28660 `"Killeen-Temple, TX"', add
label define met2013_lbl 28700 `"Kingsport-Bristol-Bristol, TN-VA"', add
label define met2013_lbl 28940 `"Knoxville, TN"', add
label define met2013_lbl 29100 `"La Crosse-Onalaska, WI-MN"', add
label define met2013_lbl 29180 `"Lafayette, LA"', add
label define met2013_lbl 29200 `"Lafayette-West Lafayette, IN"', add
label define met2013_lbl 29340 `"Lake Charles, LA"', add
label define met2013_lbl 29420 `"Lake Havasu City-Kingman, AZ"', add
label define met2013_lbl 29460 `"Lakeland-Winter Haven, FL"', add
label define met2013_lbl 29540 `"Lancaster, PA"', add
label define met2013_lbl 29620 `"Lansing-East Lansing, MI"', add
label define met2013_lbl 29700 `"Laredo, TX"', add
label define met2013_lbl 29740 `"Las Cruces, NM"', add
label define met2013_lbl 29820 `"Las Vegas-Henderson-Paradise, NV"', add
label define met2013_lbl 29940 `"Lawrence, KS"', add
label define met2013_lbl 30020 `"Lawton, OK"', add
label define met2013_lbl 30140 `"Lebanon, PA"', add
label define met2013_lbl 30340 `"Lewiston-Auburn, ME"', add
label define met2013_lbl 30620 `"Lima, OH"', add
label define met2013_lbl 30700 `"Lincoln, NE"', add
label define met2013_lbl 30780 `"Little Rock-North Little Rock-Conway, AR"', add
label define met2013_lbl 31080 `"Los Angeles-Long Beach-Anaheim, CA"', add
label define met2013_lbl 31140 `"Louisville/Jefferson County, KY-IN"', add
label define met2013_lbl 31180 `"Lubbock, TX"', add
label define met2013_lbl 31340 `"Lynchburg, VA"', add
label define met2013_lbl 31460 `"Madera, CA"', add
label define met2013_lbl 31700 `"Manchester-Nashua, NH"', add
label define met2013_lbl 31860 `"Mankato-North Mankato, MN"', add
label define met2013_lbl 31900 `"Mansfield, OH"', add
label define met2013_lbl 32420 `"Mayagüez, PR"', add
label define met2013_lbl 32580 `"McAllen-Edinburg-Mission, TX"', add
label define met2013_lbl 32780 `"Medford, OR"', add
label define met2013_lbl 32820 `"Memphis, TN-MS-AR"', add
label define met2013_lbl 32900 `"Merced, CA"', add
label define met2013_lbl 33100 `"Miami-Fort Lauderdale-West Palm Beach, FL"', add
label define met2013_lbl 33140 `"Michigan City-La Porte, IN"', add
label define met2013_lbl 33260 `"Midland, TX"', add
label define met2013_lbl 33340 `"Milwaukee-Waukesha-West Allis, WI"', add
label define met2013_lbl 33460 `"Minneapolis-St. Paul-Bloomington, MN-WI"', add
label define met2013_lbl 33660 `"Mobile, AL"', add
label define met2013_lbl 33700 `"Modesto, CA"', add
label define met2013_lbl 33740 `"Monroe, LA"', add
label define met2013_lbl 33780 `"Monroe, MI"', add
label define met2013_lbl 33860 `"Montgomery, AL"', add
label define met2013_lbl 34060 `"Morgantown, WV"', add
label define met2013_lbl 34580 `"Mount Vernon-Anacortes, WA"', add
label define met2013_lbl 34620 `"Muncie, IN"', add
label define met2013_lbl 34740 `"Muskegon, MI"', add
label define met2013_lbl 34820 `"Myrtle Beach-Conway-North Myrtle Beach, SC-NC"', add
label define met2013_lbl 34900 `"Napa, CA"', add
label define met2013_lbl 34940 `"Naples-Immokalee-Marco Island, FL"', add
label define met2013_lbl 34980 `"Nashville-Davidson--Murfreesboro--Franklin, TN"', add
label define met2013_lbl 35300 `"New Haven-Milford, CT"', add
label define met2013_lbl 35380 `"New Orleans-Metairie, LA"', add
label define met2013_lbl 35620 `"New York-Newark-Jersey City, NY-NJ-PA"', add
label define met2013_lbl 35660 `"Niles-Benton Harbor, MI"', add
label define met2013_lbl 35840 `"North Port-Sarasota-Bradenton, FL"', add
label define met2013_lbl 35980 `"Norwich-New London, CT"', add
label define met2013_lbl 36100 `"Ocala, FL"', add
label define met2013_lbl 36140 `"Ocean City, NJ"', add
label define met2013_lbl 36220 `"Odessa, TX"', add
label define met2013_lbl 36260 `"Ogden-Clearfield, UT"', add
label define met2013_lbl 36420 `"Oklahoma City, OK"', add
label define met2013_lbl 36500 `"Olympia-Tumwater, WA"', add
label define met2013_lbl 36540 `"Omaha-Council Bluffs, NE-IA"', add
label define met2013_lbl 36740 `"Orlando-Kissimmee-Sanford, FL"', add
label define met2013_lbl 36780 `"Oshkosh-Neenah, WI"', add
label define met2013_lbl 36980 `"Owensboro, KY"', add
label define met2013_lbl 37100 `"Oxnard-Thousand Oaks-Ventura, CA"', add
label define met2013_lbl 37340 `"Palm Bay-Melbourne-Titusville, FL"', add
label define met2013_lbl 37460 `"Panama City, FL"', add
label define met2013_lbl 37620 `"Parkersburg-Vienna, WV"', add
label define met2013_lbl 37860 `"Pensacola-Ferry Pass-Brent, FL"', add
label define met2013_lbl 37900 `"Peoria, IL"', add
label define met2013_lbl 37980 `"Philadelphia-Camden-Wilmington, PA-NJ-DE-MD"', add
label define met2013_lbl 38060 `"Phoenix-Mesa-Scottsdale, AZ"', add
label define met2013_lbl 38300 `"Pittsburgh, PA"', add
label define met2013_lbl 38340 `"Pittsfield, MA"', add
label define met2013_lbl 38660 `"Ponce, PR"', add
label define met2013_lbl 38860 `"Portland-South Portland, ME"', add
label define met2013_lbl 38900 `"Portland-Vancouver-Hillsboro, OR-WA"', add
label define met2013_lbl 38940 `"Port St. Lucie, FL"', add
label define met2013_lbl 39140 `"Prescott, AZ"', add
label define met2013_lbl 39300 `"Providence-Warwick, RI-MA"', add
label define met2013_lbl 39340 `"Provo-Orem, UT"', add
label define met2013_lbl 39380 `"Pueblo, CO"', add
label define met2013_lbl 39460 `"Punta Gorda, FL"', add
label define met2013_lbl 39540 `"Racine, WI"', add
label define met2013_lbl 39580 `"Raleigh, NC"', add
label define met2013_lbl 39740 `"Reading, PA"', add
label define met2013_lbl 39820 `"Redding, CA"', add
label define met2013_lbl 39900 `"Reno, NV"', add
label define met2013_lbl 40060 `"Richmond, VA"', add
label define met2013_lbl 40140 `"Riverside-San Bernardino-Ontario, CA"', add
label define met2013_lbl 40220 `"Roanoke, VA"', add
label define met2013_lbl 40380 `"Rochester, NY"', add
label define met2013_lbl 40420 `"Rockford, IL"', add
label define met2013_lbl 40580 `"Rocky Mount, NC"', add
label define met2013_lbl 40900 `"Sacramento--Roseville--Arden-Arcade, CA"', add
label define met2013_lbl 40980 `"Saginaw, MI"', add
label define met2013_lbl 41060 `"St. Cloud, MN"', add
label define met2013_lbl 41100 `"St. George, UT"', add
label define met2013_lbl 41140 `"St. Joseph, MO-KS"', add
label define met2013_lbl 41180 `"St. Louis, MO-IL"', add
label define met2013_lbl 41420 `"Salem, OR"', add
label define met2013_lbl 41500 `"Salinas, CA"', add
label define met2013_lbl 41540 `"Salisbury, MD-DE"', add
label define met2013_lbl 41620 `"Salt Lake City, UT"', add
label define met2013_lbl 41660 `"San Angelo, TX"', add
label define met2013_lbl 41700 `"San Antonio-New Braunfels, TX"', add
label define met2013_lbl 41740 `"San Diego-Carlsbad, CA"', add
label define met2013_lbl 41860 `"San Francisco-Oakland-Hayward, CA"', add
label define met2013_lbl 41900 `"San Germán, PR"', add
label define met2013_lbl 41940 `"San Jose-Sunnyvale-Santa Clara, CA"', add
label define met2013_lbl 41980 `"San Juan-Carolina-Caguas, PR"', add
label define met2013_lbl 42020 `"San Luis Obispo-Paso Robles-Arroyo Grande, CA"', add
label define met2013_lbl 42100 `"Santa Cruz-Watsonville, CA"', add
label define met2013_lbl 42140 `"Santa Fe, NM"', add
label define met2013_lbl 42200 `"Santa Maria-Santa Barbara, CA"', add
label define met2013_lbl 42220 `"Santa Rosa, CA"', add
label define met2013_lbl 42540 `"Scranton--Wilkes-Barre--Hazleton, PA"', add
label define met2013_lbl 42660 `"Seattle-Tacoma-Bellevue, WA"', add
label define met2013_lbl 42680 `"Sebastian-Vero Beach, FL"', add
label define met2013_lbl 43100 `"Sheboygan, WI"', add
label define met2013_lbl 43340 `"Shreveport-Bossier City, LA"', add
label define met2013_lbl 43900 `"Spartanburg, SC"', add
label define met2013_lbl 44060 `"Spokane-Spokane Valley, WA"', add
label define met2013_lbl 44100 `"Springfield, IL"', add
label define met2013_lbl 44140 `"Springfield, MA"', add
label define met2013_lbl 44180 `"Springfield, MO"', add
label define met2013_lbl 44220 `"Springfield, OH"', add
label define met2013_lbl 44300 `"State College, PA"', add
label define met2013_lbl 44700 `"Stockton-Lodi, CA"', add
label define met2013_lbl 44940 `"Sumter, SC"', add
label define met2013_lbl 45060 `"Syracuse, NY"', add
label define met2013_lbl 45220 `"Tallahassee, FL"', add
label define met2013_lbl 45300 `"Tampa-St. Petersburg-Clearwater, FL"', add
label define met2013_lbl 45460 `"Terre Haute, IN"', add
label define met2013_lbl 45540 `"The Villages, FL"', add
label define met2013_lbl 45780 `"Toledo, OH"', add
label define met2013_lbl 45820 `"Topeka, KS"', add
label define met2013_lbl 45940 `"Trenton, NJ"', add
label define met2013_lbl 46060 `"Tucson, AZ"', add
label define met2013_lbl 46140 `"Tulsa, OK"', add
label define met2013_lbl 46220 `"Tuscaloosa, AL"', add
label define met2013_lbl 46340 `"Tyler, TX"', add
label define met2013_lbl 46520 `"Urban Honolulu, HI"', add
label define met2013_lbl 46540 `"Utica-Rome, NY"', add
label define met2013_lbl 46660 `"Valdosta, GA"', add
label define met2013_lbl 46700 `"Vallejo-Fairfield, CA"', add
label define met2013_lbl 47220 `"Vineland-Bridgeton, NJ"', add
label define met2013_lbl 47260 `"Virginia Beach-Norfolk-Newport News, VA-NC"', add
label define met2013_lbl 47300 `"Visalia-Porterville, CA"', add
label define met2013_lbl 47380 `"Waco, TX"', add
label define met2013_lbl 47580 `"Warner Robins, GA"', add
label define met2013_lbl 47900 `"Washington-Arlington-Alexandria, DC-VA-MD-WV"', add
label define met2013_lbl 48140 `"Wausau, WI"', add
label define met2013_lbl 48300 `"Wenatchee, WA"', add
label define met2013_lbl 48620 `"Wichita, KS"', add
label define met2013_lbl 48660 `"Wichita Falls, TX"', add
label define met2013_lbl 48700 `"Williamsport, PA"', add
label define met2013_lbl 48900 `"Wilmington, NC"', add
label define met2013_lbl 49180 `"Winston-Salem, NC"', add
label define met2013_lbl 49340 `"Worcester, MA-CT"', add
label define met2013_lbl 49420 `"Yakima, WA"', add
label define met2013_lbl 49620 `"York-Hanover, PA"', add
label define met2013_lbl 49660 `"Youngstown-Warren-Boardman, OH-PA"', add
label define met2013_lbl 49700 `"Yuba City, CA"', add
label define met2013_lbl 49740 `"Yuma, AZ"', add
label values met2013 met2013_lbl

label define met2013err_lbl 0 `"Not applicable (no metro area identified)"'
label define met2013err_lbl 1 `"Less than 0.1%"', add
label define met2013err_lbl 2 `"0.1 to 0.9%"', add
label define met2013err_lbl 3 `"1.0 to 1.9%"', add
label define met2013err_lbl 4 `"2.0 to 4.9%"', add
label define met2013err_lbl 5 `"5.0 to 9.9%"', add
label define met2013err_lbl 6 `"10.0 to 14.9%"', add
label values met2013err met2013err_lbl

label define met2023_lbl 00000 `"Not in identifiable area"'
label define met2023_lbl 10180 `"Abilene, TX"', add
label define met2023_lbl 10380 `"Aguadilla, PR"', add
label define met2023_lbl 10420 `"Akron, OH"', add
label define met2023_lbl 10500 `"Albany, GA"', add
label define met2023_lbl 10540 `"Albany, OR"', add
label define met2023_lbl 10580 `"Albany-Schenectady-Troy, NY"', add
label define met2023_lbl 10740 `"Albuquerque, NM"', add
label define met2023_lbl 10780 `"Alexandria, LA"', add
label define met2023_lbl 10900 `"Allentown-Bethlehem-Easton, PA-NJ"', add
label define met2023_lbl 11020 `"Altoona, PA"', add
label define met2023_lbl 11100 `"Amarillo, TX"', add
label define met2023_lbl 11180 `"Ames, IA"', add
label define met2023_lbl 11200 `"Amherst Town-Northampton, MA"', add
label define met2023_lbl 11260 `"Anchorage, AK"', add
label define met2023_lbl 11460 `"Ann Arbor, MI"', add
label define met2023_lbl 11500 `"Anniston-Oxford, AL"', add
label define met2023_lbl 11540 `"Appleton, WI"', add
label define met2023_lbl 11640 `"Arecibo, PR"', add
label define met2023_lbl 11700 `"Asheville, NC"', add
label define met2023_lbl 12020 `"Athens-Clarke County, GA"', add
label define met2023_lbl 12060 `"Atlanta-Sandy Springs-Roswell, GA"', add
label define met2023_lbl 12100 `"Atlantic City-Hammonton, NJ"', add
label define met2023_lbl 12220 `"Auburn-Opelika, AL"', add
label define met2023_lbl 12260 `"Augusta-Richmond County, GA-SC"', add
label define met2023_lbl 12420 `"Austin-Round Rock-San Marcos, TX"', add
label define met2023_lbl 12540 `"Bakersfield-Delano, CA"', add
label define met2023_lbl 12580 `"Baltimore-Columbia-Towson, MD"', add
label define met2023_lbl 12620 `"Bangor, ME"', add
label define met2023_lbl 12700 `"Barnstable Town, MA"', add
label define met2023_lbl 12940 `"Baton Rouge, LA"', add
label define met2023_lbl 12980 `"Battle Creek, MI"', add
label define met2023_lbl 13020 `"Bay City, MI"', add
label define met2023_lbl 13140 `"Beaumont-Port Arthur, TX"', add
label define met2023_lbl 13220 `"Beckley, WV"', add
label define met2023_lbl 13380 `"Bellingham, WA"', add
label define met2023_lbl 13460 `"Bend, OR"', add
label define met2023_lbl 13740 `"Billings, MT"', add
label define met2023_lbl 13780 `"Binghamton, NY"', add
label define met2023_lbl 13820 `"Birmingham, AL"', add
label define met2023_lbl 13900 `"Bismarck, ND"', add
label define met2023_lbl 13980 `"Blacksburg-Christiansburg-Radford, VA"', add
label define met2023_lbl 14010 `"Bloomington, IL"', add
label define met2023_lbl 14020 `"Bloomington, IN"', add
label define met2023_lbl 14260 `"Boise City, ID"', add
label define met2023_lbl 14460 `"Boston-Cambridge-Newton, MA-NH"', add
label define met2023_lbl 14500 `"Boulder, CO"', add
label define met2023_lbl 14540 `"Bowling Green, KY"', add
label define met2023_lbl 14580 `"Bozeman, MT"', add
label define met2023_lbl 14740 `"Bremerton-Silverdale-Port Orchard, WA"', add
label define met2023_lbl 14860 `"Bridgeport-Stamford-Danbury, CT"', add
label define met2023_lbl 15180 `"Brownsville-Harlingen, TX"', add
label define met2023_lbl 15260 `"Brunswick-St. Simons, GA"', add
label define met2023_lbl 15380 `"Buffalo-Cheektowaga, NY"', add
label define met2023_lbl 15500 `"Burlington, NC"', add
label define met2023_lbl 15540 `"Burlington-South Burlington, VT"', add
label define met2023_lbl 15940 `"Canton-Massillon, OH"', add
label define met2023_lbl 15980 `"Cape Coral-Fort Myers, FL"', add
label define met2023_lbl 16020 `"Cape Girardeau, MO-IL"', add
label define met2023_lbl 16180 `"Carson City, NV"', add
label define met2023_lbl 16220 `"Casper, WY"', add
label define met2023_lbl 16300 `"Cedar Rapids, IA"', add
label define met2023_lbl 16540 `"Chambersburg, PA"', add
label define met2023_lbl 16580 `"Champaign-Urbana, IL"', add
label define met2023_lbl 16620 `"Charleston, WV"', add
label define met2023_lbl 16700 `"Charleston-North Charleston, SC"', add
label define met2023_lbl 16740 `"Charlotte-Concord-Gastonia, NC-SC"', add
label define met2023_lbl 16820 `"Charlottesville, VA"', add
label define met2023_lbl 16860 `"Chattanooga, TN-GA"', add
label define met2023_lbl 16940 `"Cheyenne, WY"', add
label define met2023_lbl 16980 `"Chicago-Naperville-Elgin, IL-IN"', add
label define met2023_lbl 17020 `"Chico, CA"', add
label define met2023_lbl 17140 `"Cincinnati, OH-KY-IN"', add
label define met2023_lbl 17300 `"Clarksville, TN-KY"', add
label define met2023_lbl 17410 `"Cleveland, OH"', add
label define met2023_lbl 17420 `"Cleveland, TN"', add
label define met2023_lbl 17660 `"Coeur d'Alene, ID"', add
label define met2023_lbl 17780 `"College Station-Bryan, TX"', add
label define met2023_lbl 17820 `"Colorado Springs, CO"', add
label define met2023_lbl 17860 `"Columbia, MO"', add
label define met2023_lbl 17900 `"Columbia, SC"', add
label define met2023_lbl 17980 `"Columbus, GA-AL"', add
label define met2023_lbl 18020 `"Columbus, IN"', add
label define met2023_lbl 18140 `"Columbus, OH"', add
label define met2023_lbl 18580 `"Corpus Christi, TX"', add
label define met2023_lbl 18700 `"Corvallis, OR"', add
label define met2023_lbl 18880 `"Crestview-Fort Walton Beach-Destin, FL"', add
label define met2023_lbl 19100 `"Dallas-Fort Worth-Arlington, TX"', add
label define met2023_lbl 19140 `"Dalton, GA"', add
label define met2023_lbl 19300 `"Daphne-Fairhope-Foley, AL"', add
label define met2023_lbl 19340 `"Davenport-Moline-Rock Island, IA-IL"', add
label define met2023_lbl 19430 `"Dayton-Kettering-Beavercreek, OH"', add
label define met2023_lbl 19460 `"Decatur, AL"', add
label define met2023_lbl 19500 `"Decatur, IL"', add
label define met2023_lbl 19660 `"Deltona-Daytona Beach-Ormond Beach, FL"', add
label define met2023_lbl 19740 `"Denver-Aurora-Centennial, CO"', add
label define met2023_lbl 19780 `"Des Moines-West Des Moines, IA"', add
label define met2023_lbl 19820 `"Detroit-Warren-Dearborn, MI"', add
label define met2023_lbl 20020 `"Dothan, AL"', add
label define met2023_lbl 20100 `"Dover, DE"', add
label define met2023_lbl 20220 `"Dubuque, IA"', add
label define met2023_lbl 20260 `"Duluth, MN-WI"', add
label define met2023_lbl 20500 `"Durham-Chapel Hill, NC"', add
label define met2023_lbl 20580 `"Eagle Pass, TX"', add
label define met2023_lbl 20740 `"Eau Claire, WI"', add
label define met2023_lbl 20940 `"El Centro, CA"', add
label define met2023_lbl 21060 `"Elizabethtown, KY"', add
label define met2023_lbl 21140 `"Elkhart-Goshen, IN"', add
label define met2023_lbl 21300 `"Elmira, NY"', add
label define met2023_lbl 21340 `"El Paso, TX"', add
label define met2023_lbl 21420 `"Enid, OK"', add
label define met2023_lbl 21500 `"Erie, PA"', add
label define met2023_lbl 21660 `"Eugene-Springfield, OR"', add
label define met2023_lbl 21780 `"Evansville, IN"', add
label define met2023_lbl 21820 `"Fairbanks-College, AK"', add
label define met2023_lbl 22020 `"Fargo, ND-MN"', add
label define met2023_lbl 22140 `"Farmington, NM"', add
label define met2023_lbl 22180 `"Fayetteville, NC"', add
label define met2023_lbl 22220 `"Fayetteville-Springdale-Rogers, AR"', add
label define met2023_lbl 22380 `"Flagstaff, AZ"', add
label define met2023_lbl 22420 `"Flint, MI"', add
label define met2023_lbl 22500 `"Florence, SC"', add
label define met2023_lbl 22520 `"Florence-Muscle Shoals, AL"', add
label define met2023_lbl 22540 `"Fond du Lac, WI"', add
label define met2023_lbl 22660 `"Fort Collins-Loveland, CO"', add
label define met2023_lbl 22900 `"Fort Smith, AR-OK"', add
label define met2023_lbl 23060 `"Fort Wayne, IN"', add
label define met2023_lbl 23420 `"Fresno, CA"', add
label define met2023_lbl 23460 `"Gadsden, AL"', add
label define met2023_lbl 23540 `"Gainesville, FL"', add
label define met2023_lbl 23580 `"Gainesville, GA"', add
label define met2023_lbl 23900 `"Gettysburg, PA"', add
label define met2023_lbl 24020 `"Glens Falls, NY"', add
label define met2023_lbl 24140 `"Goldsboro, NC"', add
label define met2023_lbl 24220 `"Grand Forks, ND-MN"', add
label define met2023_lbl 24260 `"Grand Island, NE"', add
label define met2023_lbl 24300 `"Grand Junction, CO"', add
label define met2023_lbl 24340 `"Grand Rapids-Wyoming-Kentwood, MI"', add
label define met2023_lbl 24420 `"Grants Pass, OR"', add
label define met2023_lbl 24500 `"Great Falls, MT"', add
label define met2023_lbl 24540 `"Greeley, CO"', add
label define met2023_lbl 24580 `"Green Bay, WI"', add
label define met2023_lbl 24660 `"Greensboro-High Point, NC"', add
label define met2023_lbl 24780 `"Greenville, NC"', add
label define met2023_lbl 24860 `"Greenville-Anderson-Greer, SC"', add
label define met2023_lbl 25020 `"Guayama, PR"', add
label define met2023_lbl 25060 `"Gulfport-Biloxi, MS"', add
label define met2023_lbl 25180 `"Hagerstown-Martinsburg, MD-WV"', add
label define met2023_lbl 25220 `"Hammond, LA"', add
label define met2023_lbl 25260 `"Hanford-Corcoran, CA"', add
label define met2023_lbl 25420 `"Harrisburg-Carlisle, PA"', add
label define met2023_lbl 25500 `"Harrisonburg, VA"', add
label define met2023_lbl 25540 `"Hartford-West Hartford-East Hartford, CT"', add
label define met2023_lbl 25620 `"Hattiesburg, MS"', add
label define met2023_lbl 25740 `"Helena, MT"', add
label define met2023_lbl 25860 `"Hickory-Lenoir-Morganton, NC"', add
label define met2023_lbl 25940 `"Hilton Head Island-Bluffton-Port Royal, SC"', add
label define met2023_lbl 25980 `"Hinesville, GA"', add
label define met2023_lbl 26140 `"Homosassa Springs, FL"', add
label define met2023_lbl 26300 `"Hot Springs, AR"', add
label define met2023_lbl 26380 `"Houma-Bayou Cane-Thibodaux, LA"', add
label define met2023_lbl 26420 `"Houston-Pasadena-The Woodlands, TX"', add
label define met2023_lbl 26580 `"Huntington-Ashland, WV-KY-OH"', add
label define met2023_lbl 26620 `"Huntsville, AL"', add
label define met2023_lbl 26820 `"Idaho Falls, ID"', add
label define met2023_lbl 26900 `"Indianapolis-Carmel-Greenwood, IN"', add
label define met2023_lbl 26980 `"Iowa City, IA"', add
label define met2023_lbl 27060 `"Ithaca, NY"', add
label define met2023_lbl 27100 `"Jackson, MI"', add
label define met2023_lbl 27140 `"Jackson, MS"', add
label define met2023_lbl 27180 `"Jackson, TN"', add
label define met2023_lbl 27260 `"Jacksonville, FL"', add
label define met2023_lbl 27340 `"Jacksonville, NC"', add
label define met2023_lbl 27500 `"Janesville-Beloit, WI"', add
label define met2023_lbl 27620 `"Jefferson City, MO"', add
label define met2023_lbl 27740 `"Johnson City, TN"', add
label define met2023_lbl 27780 `"Johnstown, PA"', add
label define met2023_lbl 27860 `"Jonesboro, AR"', add
label define met2023_lbl 27900 `"Joplin, MO-KS"', add
label define met2023_lbl 27980 `"Kahului-Wailuku, HI"', add
label define met2023_lbl 28020 `"Kalamazoo-Portage, MI"', add
label define met2023_lbl 28100 `"Kankakee, IL"', add
label define met2023_lbl 28140 `"Kansas City, MO-KS"', add
label define met2023_lbl 28420 `"Kennewick-Richland, WA"', add
label define met2023_lbl 28450 `"Kenosha, WI"', add
label define met2023_lbl 28660 `"Killeen-Temple, TX"', add
label define met2023_lbl 28700 `"Kingsport-Bristol, TN-VA"', add
label define met2023_lbl 28740 `"Kingston, NY"', add
label define met2023_lbl 28880 `"Kiryas Joel-Poughkeepsie-Newburgh, NY"', add
label define met2023_lbl 28940 `"Knoxville, TN"', add
label define met2023_lbl 29020 `"Kokomo, IN"', add
label define met2023_lbl 29100 `"La Crosse-Onalaska, WI-MN"', add
label define met2023_lbl 29180 `"Lafayette, LA"', add
label define met2023_lbl 29200 `"Lafayette-West Lafayette, IN"', add
label define met2023_lbl 29340 `"Lake Charles, LA"', add
label define met2023_lbl 29420 `"Lake Havasu City-Kingman, AZ"', add
label define met2023_lbl 29460 `"Lakeland-Winter Haven, FL"', add
label define met2023_lbl 29540 `"Lancaster, PA"', add
label define met2023_lbl 29620 `"Lansing-East Lansing, MI"', add
label define met2023_lbl 29700 `"Laredo, TX"', add
label define met2023_lbl 29740 `"Las Cruces, NM"', add
label define met2023_lbl 29820 `"Las Vegas-Henderson-North Las Vegas, NV"', add
label define met2023_lbl 29940 `"Lawrence, KS"', add
label define met2023_lbl 30020 `"Lawton, OK"', add
label define met2023_lbl 30140 `"Lebanon, PA"', add
label define met2023_lbl 30300 `"Lewiston, ID-WA"', add
label define met2023_lbl 30340 `"Lewiston-Auburn, ME"', add
label define met2023_lbl 30460 `"Lexington-Fayette, KY"', add
label define met2023_lbl 30500 `"Lexington Park, MD"', add
label define met2023_lbl 30620 `"Lima, OH"', add
label define met2023_lbl 30700 `"Lincoln, NE"', add
label define met2023_lbl 30780 `"Little Rock-North Little Rock-Conway, AR"', add
label define met2023_lbl 30860 `"Logan, UT-ID"', add
label define met2023_lbl 30980 `"Longview, TX"', add
label define met2023_lbl 31020 `"Longview-Kelso, WA"', add
label define met2023_lbl 31080 `"Los Angeles-Long Beach-Anaheim, CA"', add
label define met2023_lbl 31140 `"Louisville/Jefferson County, KY-IN"', add
label define met2023_lbl 31180 `"Lubbock, TX"', add
label define met2023_lbl 31340 `"Lynchburg, VA"', add
label define met2023_lbl 31420 `"Macon-Bibb County, GA"', add
label define met2023_lbl 31540 `"Madison, WI"', add
label define met2023_lbl 31700 `"Manchester-Nashua, NH"', add
label define met2023_lbl 31740 `"Manhattan, KS"', add
label define met2023_lbl 31860 `"Mankato, MN"', add
label define met2023_lbl 31900 `"Mansfield, OH"', add
label define met2023_lbl 32420 `"Mayagüez, PR"', add
label define met2023_lbl 32580 `"McAllen-Edinburg-Mission, TX"', add
label define met2023_lbl 32780 `"Medford, OR"', add
label define met2023_lbl 32820 `"Memphis, TN-MS-AR"', add
label define met2023_lbl 32900 `"Merced, CA"', add
label define met2023_lbl 33100 `"Miami-Fort Lauderdale-West Palm Beach, FL"', add
label define met2023_lbl 33140 `"Michigan City-La Porte, IN"', add
label define met2023_lbl 33220 `"Midland, MI"', add
label define met2023_lbl 33260 `"Midland, TX"', add
label define met2023_lbl 33340 `"Milwaukee-Waukesha, WI"', add
label define met2023_lbl 33460 `"Minneapolis-St. Paul-Bloomington, MN-WI"', add
label define met2023_lbl 33500 `"Minot, ND"', add
label define met2023_lbl 33540 `"Missoula, MT"', add
label define met2023_lbl 33660 `"Mobile, AL"', add
label define met2023_lbl 33700 `"Modesto, CA"', add
label define met2023_lbl 33740 `"Monroe, LA"', add
label define met2023_lbl 33780 `"Monroe, MI"', add
label define met2023_lbl 33860 `"Montgomery, AL"', add
label define met2023_lbl 34060 `"Morgantown, WV"', add
label define met2023_lbl 34100 `"Morristown, TN"', add
label define met2023_lbl 34580 `"Mount Vernon-Anacortes, WA"', add
label define met2023_lbl 34620 `"Muncie, IN"', add
label define met2023_lbl 34740 `"Muskegon-Norton Shores, MI"', add
label define met2023_lbl 34820 `"Myrtle Beach-Conway-North Myrtle Beach, SC"', add
label define met2023_lbl 34900 `"Napa, CA"', add
label define met2023_lbl 34940 `"Naples-Marco Island, FL"', add
label define met2023_lbl 34980 `"Nashville-Davidson--Murfreesboro--Franklin, TN"', add
label define met2023_lbl 35300 `"New Haven, CT"', add
label define met2023_lbl 35380 `"New Orleans-Metairie, LA"', add
label define met2023_lbl 35620 `"New York-Newark-Jersey City, NY-NJ"', add
label define met2023_lbl 35660 `"Niles, MI"', add
label define met2023_lbl 35840 `"North Port-Bradenton-Sarasota, FL"', add
label define met2023_lbl 35980 `"Norwich-New London-Willimantic, CT"', add
label define met2023_lbl 36100 `"Ocala, FL"', add
label define met2023_lbl 36220 `"Odessa, TX"', add
label define met2023_lbl 36260 `"Ogden, UT"', add
label define met2023_lbl 36420 `"Oklahoma City, OK"', add
label define met2023_lbl 36500 `"Olympia-Lacey-Tumwater, WA"', add
label define met2023_lbl 36540 `"Omaha, NE-IA"', add
label define met2023_lbl 36740 `"Orlando-Kissimmee-Sanford, FL"', add
label define met2023_lbl 36780 `"Oshkosh-Neenah, WI"', add
label define met2023_lbl 36980 `"Owensboro, KY"', add
label define met2023_lbl 37100 `"Oxnard-Thousand Oaks-Ventura, CA"', add
label define met2023_lbl 37140 `"Paducah, KY-IL"', add
label define met2023_lbl 37340 `"Palm Bay-Melbourne-Titusville, FL"', add
label define met2023_lbl 37460 `"Panama City-Panama City Beach, FL"', add
label define met2023_lbl 37620 `"Parkersburg-Vienna, WV"', add
label define met2023_lbl 37860 `"Pensacola-Ferry Pass-Brent, FL"', add
label define met2023_lbl 37900 `"Peoria, IL"', add
label define met2023_lbl 37980 `"Philadelphia-Camden-Wilmington, PA-NJ-DE-MD"', add
label define met2023_lbl 38060 `"Phoenix-Mesa-Chandler, AZ"', add
label define met2023_lbl 38240 `"Pinehurst-Southern Pines, NC"', add
label define met2023_lbl 38300 `"Pittsburgh, PA"', add
label define met2023_lbl 38340 `"Pittsfield, MA"', add
label define met2023_lbl 38540 `"Pocatello, ID"', add
label define met2023_lbl 38660 `"Ponce, PR"', add
label define met2023_lbl 38860 `"Portland-South Portland, ME"', add
label define met2023_lbl 38900 `"Portland-Vancouver-Hillsboro, OR-WA"', add
label define met2023_lbl 38940 `"Port St. Lucie, FL"', add
label define met2023_lbl 39150 `"Prescott Valley-Prescott, AZ"', add
label define met2023_lbl 39300 `"Providence-Warwick, RI-MA"', add
label define met2023_lbl 39340 `"Provo-Orem-Lehi, UT"', add
label define met2023_lbl 39380 `"Pueblo, CO"', add
label define met2023_lbl 39460 `"Punta Gorda, FL"', add
label define met2023_lbl 39540 `"Racine-Mount Pleasant, WI"', add
label define met2023_lbl 39580 `"Raleigh-Cary, NC"', add
label define met2023_lbl 39660 `"Rapid City, SD"', add
label define met2023_lbl 39740 `"Reading, PA"', add
label define met2023_lbl 39820 `"Redding, CA"', add
label define met2023_lbl 39900 `"Reno, NV"', add
label define met2023_lbl 40060 `"Richmond, VA"', add
label define met2023_lbl 40140 `"Riverside-San Bernardino-Ontario, CA"', add
label define met2023_lbl 40220 `"Roanoke, VA"', add
label define met2023_lbl 40340 `"Rochester, MN"', add
label define met2023_lbl 40380 `"Rochester, NY"', add
label define met2023_lbl 40420 `"Rockford, IL"', add
label define met2023_lbl 40580 `"Rocky Mount, NC"', add
label define met2023_lbl 40660 `"Rome, GA"', add
label define met2023_lbl 40900 `"Sacramento-Roseville-Folsom, CA"', add
label define met2023_lbl 40980 `"Saginaw, MI"', add
label define met2023_lbl 41060 `"St. Cloud, MN"', add
label define met2023_lbl 41100 `"St. George, UT"', add
label define met2023_lbl 41140 `"St. Joseph, MO-KS"', add
label define met2023_lbl 41180 `"St. Louis, MO-IL"', add
label define met2023_lbl 41420 `"Salem, OR"', add
label define met2023_lbl 41500 `"Salinas, CA"', add
label define met2023_lbl 41540 `"Salisbury, MD"', add
label define met2023_lbl 41620 `"Salt Lake City-Murray, UT"', add
label define met2023_lbl 41660 `"San Angelo, TX"', add
label define met2023_lbl 41700 `"San Antonio-New Braunfels, TX"', add
label define met2023_lbl 41740 `"San Diego-Chula Vista-Carlsbad, CA"', add
label define met2023_lbl 41780 `"Sandusky, OH"', add
label define met2023_lbl 41860 `"San Francisco-Oakland-Fremont, CA"', add
label define met2023_lbl 41940 `"San Jose-Sunnyvale-Santa Clara, CA"', add
label define met2023_lbl 41980 `"San Juan-Bayamón-Caguas, PR"', add
label define met2023_lbl 42020 `"San Luis Obispo-Paso Robles, CA"', add
label define met2023_lbl 42100 `"Santa Cruz-Watsonville, CA"', add
label define met2023_lbl 42140 `"Santa Fe, NM"', add
label define met2023_lbl 42200 `"Santa Maria-Santa Barbara, CA"', add
label define met2023_lbl 42220 `"Santa Rosa-Petaluma, CA"', add
label define met2023_lbl 42340 `"Savannah, GA"', add
label define met2023_lbl 42540 `"Scranton--Wilkes-Barre, PA"', add
label define met2023_lbl 42660 `"Seattle-Tacoma-Bellevue, WA"', add
label define met2023_lbl 42680 `"Sebastian-Vero Beach-West Vero Corridor, FL"', add
label define met2023_lbl 42700 `"Sebring, FL"', add
label define met2023_lbl 43100 `"Sheboygan, WI"', add
label define met2023_lbl 43300 `"Sherman-Denison, TX"', add
label define met2023_lbl 43340 `"Shreveport-Bossier City, LA"', add
label define met2023_lbl 43420 `"Sierra Vista-Douglas, AZ"', add
label define met2023_lbl 43580 `"Sioux City, IA-NE-SD"', add
label define met2023_lbl 43620 `"Sioux Falls, SD-MN"', add
label define met2023_lbl 43640 `"Slidell-Mandeville-Covington, LA"', add
label define met2023_lbl 43780 `"South Bend-Mishawaka, IN-MI"', add
label define met2023_lbl 43900 `"Spartanburg, SC"', add
label define met2023_lbl 44060 `"Spokane-Spokane Valley, WA"', add
label define met2023_lbl 44100 `"Springfield, IL"', add
label define met2023_lbl 44140 `"Springfield, MA"', add
label define met2023_lbl 44180 `"Springfield, MO"', add
label define met2023_lbl 44220 `"Springfield, OH"', add
label define met2023_lbl 44300 `"State College, PA"', add
label define met2023_lbl 44420 `"Staunton-Stuarts Draft, VA"', add
label define met2023_lbl 44700 `"Stockton-Lodi, CA"', add
label define met2023_lbl 44940 `"Sumter, SC"', add
label define met2023_lbl 45060 `"Syracuse, NY"', add
label define met2023_lbl 45220 `"Tallahassee, FL"', add
label define met2023_lbl 45300 `"Tampa-St. Petersburg-Clearwater, FL"', add
label define met2023_lbl 45460 `"Terre Haute, IN"', add
label define met2023_lbl 45500 `"Texarkana, TX-AR"', add
label define met2023_lbl 45780 `"Toledo, OH"', add
label define met2023_lbl 45820 `"Topeka, KS"', add
label define met2023_lbl 45900 `"Traverse City, MI"', add
label define met2023_lbl 45940 `"Trenton-Princeton, NJ"', add
label define met2023_lbl 46060 `"Tucson, AZ"', add
label define met2023_lbl 46140 `"Tulsa, OK"', add
label define met2023_lbl 46220 `"Tuscaloosa, AL"', add
label define met2023_lbl 46300 `"Twin Falls, ID"', add
label define met2023_lbl 46340 `"Tyler, TX"', add
label define met2023_lbl 46520 `"Urban Honolulu, HI"', add
label define met2023_lbl 46540 `"Utica-Rome, NY"', add
label define met2023_lbl 46660 `"Valdosta, GA"', add
label define met2023_lbl 46700 `"Vallejo, CA"', add
label define met2023_lbl 47020 `"Victoria, TX"', add
label define met2023_lbl 47220 `"Vineland, NJ"', add
label define met2023_lbl 47260 `"Virginia Beach-Chesapeake-Norfolk, VA-NC"', add
label define met2023_lbl 47300 `"Visalia, CA"', add
label define met2023_lbl 47380 `"Waco, TX"', add
label define met2023_lbl 47460 `"Walla Walla, WA"', add
label define met2023_lbl 47580 `"Warner Robins, GA"', add
label define met2023_lbl 47900 `"Washington-Arlington-Alexandria, DC-VA-MD-WV"', add
label define met2023_lbl 47930 `"Waterbury-Shelton, CT"', add
label define met2023_lbl 47940 `"Waterloo-Cedar Falls, IA"', add
label define met2023_lbl 48060 `"Watertown-Fort Drum, NY"', add
label define met2023_lbl 48140 `"Wausau, WI"', add
label define met2023_lbl 48260 `"Weirton-Steubenville, WV-OH"', add
label define met2023_lbl 48300 `"Wenatchee-East Wenatchee, WA"', add
label define met2023_lbl 48540 `"Wheeling, WV-OH"', add
label define met2023_lbl 48620 `"Wichita, KS"', add
label define met2023_lbl 48660 `"Wichita Falls, TX"', add
label define met2023_lbl 48680 `"Wildwood-The Villages, FL"', add
label define met2023_lbl 48700 `"Williamsport, PA"', add
label define met2023_lbl 48900 `"Wilmington, NC"', add
label define met2023_lbl 49020 `"Winchester, VA-WV"', add
label define met2023_lbl 49180 `"Winston-Salem, NC"', add
label define met2023_lbl 49340 `"Worcester, MA"', add
label define met2023_lbl 49420 `"Yakima, WA"', add
label define met2023_lbl 49620 `"York-Hanover, PA"', add
label define met2023_lbl 49660 `"Youngstown-Warren, OH"', add
label define met2023_lbl 49700 `"Yuba City, CA"', add
label define met2023_lbl 49740 `"Yuma, AZ"', add
label values met2023 met2023_lbl

label define met2023err_lbl 0 `"Not applicable (no metro area identified)"'
label define met2023err_lbl 1 `"Less than 0.1%"', add
label define met2023err_lbl 2 `"0.1 to 0.9%"', add
label define met2023err_lbl 3 `"1.0 to 1.9%"', add
label define met2023err_lbl 4 `"2.0 to 4.9%"', add
label define met2023err_lbl 5 `"5.0 to 9.9%"', add
label define met2023err_lbl 6 `"10.0 to 14.9%"', add
label values met2023err met2023err_lbl

label define city_lbl 0000 `"Not in identifiable city (or size group)"'
label define city_lbl 0001 `"Aberdeen, SD"', add
label define city_lbl 0002 `"Aberdeen, WA"', add
label define city_lbl 0003 `"Abilene, TX"', add
label define city_lbl 0004 `"Ada, OK"', add
label define city_lbl 0005 `"Adams, MA"', add
label define city_lbl 0006 `"Adrian, MI"', add
label define city_lbl 0007 `"Abington, PA"', add
label define city_lbl 0010 `"Akron, OH"', add
label define city_lbl 0030 `"Alameda, CA"', add
label define city_lbl 0050 `"Albany, NY"', add
label define city_lbl 0051 `"Albany, GA"', add
label define city_lbl 0052 `"Albert Lea, MN"', add
label define city_lbl 0070 `"Albuquerque, NM"', add
label define city_lbl 0090 `"Alexandria, VA"', add
label define city_lbl 0091 `"Alexandria, LA"', add
label define city_lbl 0100 `"Alhambra, CA"', add
label define city_lbl 0110 `"Allegheny, PA"', add
label define city_lbl 0120 `"Aliquippa, PA"', add
label define city_lbl 0130 `"Allentown, PA"', add
label define city_lbl 0131 `"Alliance, OH"', add
label define city_lbl 0132 `"Alpena, MI"', add
label define city_lbl 0140 `"Alton, IL"', add
label define city_lbl 0150 `"Altoona, PA"', add
label define city_lbl 0160 `"Amarillo, TX"', add
label define city_lbl 0161 `"Ambridge, PA"', add
label define city_lbl 0162 `"Ames, IA"', add
label define city_lbl 0163 `"Amesbury, MA"', add
label define city_lbl 0170 `"Amsterdam, NY"', add
label define city_lbl 0171 `"Anaconda, MT"', add
label define city_lbl 0190 `"Anaheim, CA"', add
label define city_lbl 0210 `"Anchorage, AK"', add
label define city_lbl 0230 `"Anderson, IN"', add
label define city_lbl 0231 `"Anderson, SC"', add
label define city_lbl 0250 `"Andover, MA"', add
label define city_lbl 0270 `"Ann Arbor, MI"', add
label define city_lbl 0271 `"Annapolis, MD"', add
label define city_lbl 0272 `"Anniston, AL"', add
label define city_lbl 0273 `"Ansonia, CT"', add
label define city_lbl 0275 `"Antioch, CA"', add
label define city_lbl 0280 `"Appleton, WI"', add
label define city_lbl 0281 `"Ardmore, OK"', add
label define city_lbl 0282 `"Argenta, AR"', add
label define city_lbl 0283 `"Arkansas, KS"', add
label define city_lbl 0284 `"Arden-Arcade, CA"', add
label define city_lbl 0290 `"Arlington, TX"', add
label define city_lbl 0310 `"Arlington, VA"', add
label define city_lbl 0311 `"Arlington, MA"', add
label define city_lbl 0312 `"Arnold, PA"', add
label define city_lbl 0313 `"Asbury Park, NJ"', add
label define city_lbl 0330 `"Asheville, NC"', add
label define city_lbl 0331 `"Ashland, OH"', add
label define city_lbl 0340 `"Ashland, KY"', add
label define city_lbl 0341 `"Ashland, WI"', add
label define city_lbl 0342 `"Ashtabula, OH"', add
label define city_lbl 0343 `"Astoria, OR"', add
label define city_lbl 0344 `"Atchison, KS"', add
label define city_lbl 0345 `"Athens, GA"', add
label define city_lbl 0346 `"Athol, MA"', add
label define city_lbl 0347 `"Athens-Clarke County, GA"', add
label define city_lbl 0350 `"Atlanta, GA"', add
label define city_lbl 0370 `"Atlantic City, NJ"', add
label define city_lbl 0371 `"Attleboro, MA"', add
label define city_lbl 0390 `"Auburn, NY"', add
label define city_lbl 0391 `"Auburn, ME"', add
label define city_lbl 0410 `"Augusta, GA"', add
label define city_lbl 0411 `"Augusta-Richmond County, GA"', add
label define city_lbl 0430 `"Augusta, ME"', add
label define city_lbl 0450 `"Aurora, CO"', add
label define city_lbl 0470 `"Aurora, IL"', add
label define city_lbl 0490 `"Austin, TX"', add
label define city_lbl 0491 `"Austin, MN"', add
label define city_lbl 0510 `"Bakersfield, CA"', add
label define city_lbl 0530 `"Baltimore, MD"', add
label define city_lbl 0550 `"Bangor, ME"', add
label define city_lbl 0551 `"Barberton, OH"', add
label define city_lbl 0552 `"Barre, VT"', add
label define city_lbl 0553 `"Bartlesville, OK"', add
label define city_lbl 0554 `"Batavia, NY"', add
label define city_lbl 0570 `"Bath, ME"', add
label define city_lbl 0590 `"Baton Rouge, LA"', add
label define city_lbl 0610 `"Battle Creek, MI"', add
label define city_lbl 0630 `"Bay City, MI"', add
label define city_lbl 0640 `"Bayamon, PR"', add
label define city_lbl 0650 `"Bayonne, NJ"', add
label define city_lbl 0651 `"Beacon, NY"', add
label define city_lbl 0652 `"Beatrice, NE"', add
label define city_lbl 0660 `"Belleville, IL"', add
label define city_lbl 0670 `"Beaumont, TX"', add
label define city_lbl 0671 `"Beaver Falls, PA"', add
label define city_lbl 0672 `"Bedford, IN"', add
label define city_lbl 0673 `"Bellaire, OH"', add
label define city_lbl 0680 `"Bellevue, WA"', add
label define city_lbl 0690 `"Bellingham, WA"', add
label define city_lbl 0695 `"Belvedere, CA"', add
label define city_lbl 0700 `"Belleville, NJ"', add
label define city_lbl 0701 `"Bellevue, PA"', add
label define city_lbl 0702 `"Belmont, OH"', add
label define city_lbl 0703 `"Belmont, MA"', add
label define city_lbl 0704 `"Beloit, WI"', add
label define city_lbl 0705 `"Bennington, VT"', add
label define city_lbl 0706 `"Benton Harbor, MI"', add
label define city_lbl 0710 `"Berkeley, CA"', add
label define city_lbl 0711 `"Berlin, NH"', add
label define city_lbl 0712 `"Berwick, PA"', add
label define city_lbl 0720 `"Berwyn, IL"', add
label define city_lbl 0721 `"Bessemer, AL"', add
label define city_lbl 0730 `"Bethlehem, PA"', add
label define city_lbl 0740 `"Biddeford, ME"', add
label define city_lbl 0741 `"Big Spring, TX"', add
label define city_lbl 0742 `"Billings, MT"', add
label define city_lbl 0743 `"Biloxi, MS"', add
label define city_lbl 0750 `"Binghamton, NY"', add
label define city_lbl 0760 `"Beverly, MA"', add
label define city_lbl 0761 `"Beverly Hills, CA"', add
label define city_lbl 0770 `"Birmingham, AL"', add
label define city_lbl 0771 `"Birmingham, CT"', add
label define city_lbl 0772 `"Bismarck, ND"', add
label define city_lbl 0780 `"Bloomfield, NJ"', add
label define city_lbl 0790 `"Bloomington, IL"', add
label define city_lbl 0791 `"Bloomington, IN"', add
label define city_lbl 0792 `"Blue Island, IL"', add
label define city_lbl 0793 `"Bluefield, WV"', add
label define city_lbl 0794 `"Blytheville, AR"', add
label define city_lbl 0795 `"Bogalusa, LA"', add
label define city_lbl 0800 `"Boise, ID"', add
label define city_lbl 0801 `"Boone, IA"', add
label define city_lbl 0810 `"Boston, MA"', add
label define city_lbl 0811 `"Boulder, CO"', add
label define city_lbl 0812 `"Bowling Green, KY"', add
label define city_lbl 0813 `"Braddock, PA"', add
label define city_lbl 0814 `"Braden, WA"', add
label define city_lbl 0815 `"Bradford, PA"', add
label define city_lbl 0816 `"Brainerd, MN"', add
label define city_lbl 0817 `"Braintree, MA"', add
label define city_lbl 0818 `"Brawley, CA"', add
label define city_lbl 0819 `"Bremerton, WA"', add
label define city_lbl 0830 `"Bridgeport, CT"', add
label define city_lbl 0831 `"Bridgeton, NJ"', add
label define city_lbl 0832 `"Bristol, CT"', add
label define city_lbl 0833 `"Bristol, PA"', add
label define city_lbl 0834 `"Bristol, VA"', add
label define city_lbl 0835 `"Bristol, TN"', add
label define city_lbl 0837 `"Bristol, RI"', add
label define city_lbl 0850 `"Brockton, MA"', add
label define city_lbl 0851 `"Brookfield, IL"', add
label define city_lbl 0870 `"Brookline, MA"', add
label define city_lbl 0880 `"Brownsville, TX"', add
label define city_lbl 0881 `"Brownwood, TX"', add
label define city_lbl 0882 `"Brunswick, GA"', add
label define city_lbl 0883 `"Bucyrus, OH"', add
label define city_lbl 0890 `"Buffalo, NY"', add
label define city_lbl 0900 `"Burlington, IA"', add
label define city_lbl 0905 `"Burlington, VT"', add
label define city_lbl 0906 `"Burlington, NJ"', add
label define city_lbl 0907 `"Bushkill, PA"', add
label define city_lbl 0910 `"Butte, MT"', add
label define city_lbl 0911 `"Butler, PA"', add
label define city_lbl 0920 `"Burbank, CA"', add
label define city_lbl 0921 `"Burlingame, CA"', add
label define city_lbl 0926 `"Cairo, IL"', add
label define city_lbl 0927 `"Calumet City, IL"', add
label define city_lbl 0930 `"Cambridge, MA"', add
label define city_lbl 0931 `"Cambridge, OH"', add
label define city_lbl 0950 `"Camden, NJ"', add
label define city_lbl 0951 `"Campbell, OH"', add
label define city_lbl 0952 `"Canonsburg, PA"', add
label define city_lbl 0970 `"Camden, NY"', add
label define city_lbl 0990 `"Canton, OH"', add
label define city_lbl 0991 `"Canton, IL"', add
label define city_lbl 0992 `"Cape Girardeau, MO"', add
label define city_lbl 0993 `"Carbondale, PA"', add
label define city_lbl 0994 `"Carlisle, PA"', add
label define city_lbl 0995 `"Carnegie, PA"', add
label define city_lbl 0996 `"Carrick, PA"', add
label define city_lbl 0997 `"Carteret, NJ"', add
label define city_lbl 0998 `"Carthage, MO"', add
label define city_lbl 0999 `"Casper, WY"', add
label define city_lbl 1000 `"Cape Coral, FL"', add
label define city_lbl 1010 `"Cedar Rapids, IA"', add
label define city_lbl 1020 `"Central Falls, RI"', add
label define city_lbl 1021 `"Centralia, IL"', add
label define city_lbl 1023 `"Chambersburg, PA"', add
label define city_lbl 1024 `"Champaign, IL"', add
label define city_lbl 1025 `"Chanute, KS"', add
label define city_lbl 1026 `"Charleroi, PA"', add
label define city_lbl 1027 `"Chandler, AZ"', add
label define city_lbl 1030 `"Charlestown, MA"', add
label define city_lbl 1050 `"Charleston, SC"', add
label define city_lbl 1060 `"Carolina, PR"', add
label define city_lbl 1070 `"Charleston, WV"', add
label define city_lbl 1090 `"Charlotte, NC"', add
label define city_lbl 1091 `"Charlottesville, VA"', add
label define city_lbl 1110 `"Chattanooga, TN"', add
label define city_lbl 1130 `"Chelsea, MA"', add
label define city_lbl 1140 `"Cheltenham, PA"', add
label define city_lbl 1150 `"Chesapeake, VA"', add
label define city_lbl 1170 `"Chester, PA"', add
label define city_lbl 1171 `"Cheyenne, WY"', add
label define city_lbl 1190 `"Chicago, IL"', add
label define city_lbl 1191 `"Chicago Heights, IL"', add
label define city_lbl 1192 `"Chickasha, OK"', add
label define city_lbl 1210 `"Chicopee, MA"', add
label define city_lbl 1230 `"Chillicothe, OH"', add
label define city_lbl 1250 `"Chula Vista, CA"', add
label define city_lbl 1270 `"Cicero, IL"', add
label define city_lbl 1290 `"Cincinnati, OH"', add
label define city_lbl 1291 `"Clairton, PA"', add
label define city_lbl 1292 `"Claremont, NH"', add
label define city_lbl 1310 `"Clarksburg, WV"', add
label define city_lbl 1311 `"Clarksdale, MS"', add
label define city_lbl 1312 `"Cleburne, TX"', add
label define city_lbl 1330 `"Cleveland, OH"', add
label define city_lbl 1340 `"Cleveland Heights, OH"', add
label define city_lbl 1341 `"Cliffside Park, NJ"', add
label define city_lbl 1350 `"Clifton, NJ"', add
label define city_lbl 1351 `"Clinton, IN"', add
label define city_lbl 1370 `"Clinton, IA"', add
label define city_lbl 1371 `"Clinton, MA"', add
label define city_lbl 1372 `"Coatesville, PA"', add
label define city_lbl 1373 `"Coffeyville, KS"', add
label define city_lbl 1374 `"Cohoes, NY"', add
label define city_lbl 1375 `"Collingswood, NJ"', add
label define city_lbl 1390 `"Colorado Springs, CO"', add
label define city_lbl 1410 `"Columbia, SC"', add
label define city_lbl 1411 `"Columbia, PA"', add
label define city_lbl 1412 `"Columbia, MO"', add
label define city_lbl 1414 `"Columbia CDP, MD"', add
label define city_lbl 1420 `"Columbia City, IN"', add
label define city_lbl 1430 `"Columbus, GA"', add
label define city_lbl 1450 `"Columbus, OH"', add
label define city_lbl 1451 `"Columbus, MS"', add
label define city_lbl 1452 `"Compton, CA"', add
label define city_lbl 1470 `"Concord, CA"', add
label define city_lbl 1490 `"Concord, NH"', add
label define city_lbl 1491 `"Concord, NC"', add
label define city_lbl 1492 `"Connellsville, PA"', add
label define city_lbl 1493 `"Connersville, IN"', add
label define city_lbl 1494 `"Conshohocken, PA"', add
label define city_lbl 1495 `"Coraopolis, PA"', add
label define city_lbl 1496 `"Corning, NY"', add
label define city_lbl 1500 `"Corona, CA"', add
label define city_lbl 1510 `"Council Bluffs, IA"', add
label define city_lbl 1520 `"Corpus Christi, TX"', add
label define city_lbl 1521 `"Corsicana, TX"', add
label define city_lbl 1522 `"Cortland, NY"', add
label define city_lbl 1523 `"Coshocton, OH"', add
label define city_lbl 1530 `"Covington, KY"', add
label define city_lbl 1540 `"Costa Mesa, CA"', add
label define city_lbl 1545 `"Cranford, NJ"', add
label define city_lbl 1550 `"Cranston, RI"', add
label define city_lbl 1551 `"Crawfordsville, IN"', add
label define city_lbl 1552 `"Cripple Creek, CO"', add
label define city_lbl 1553 `"Cudahy, WI"', add
label define city_lbl 1570 `"Cumberland, MD"', add
label define city_lbl 1571 `"Cumberland, RI"', add
label define city_lbl 1572 `"Cuyahoga Falls, OH"', add
label define city_lbl 1590 `"Dallas, TX"', add
label define city_lbl 1591 `"Danbury, CT"', add
label define city_lbl 1592 `"Daly City, CA"', add
label define city_lbl 1610 `"Danvers, MA"', add
label define city_lbl 1630 `"Danville, IL"', add
label define city_lbl 1631 `"Danville, VA"', add
label define city_lbl 1650 `"Davenport, IA"', add
label define city_lbl 1670 `"Dayton, OH"', add
label define city_lbl 1671 `"Daytona Beach, FL"', add
label define city_lbl 1680 `"Dearborn, MI"', add
label define city_lbl 1690 `"Decatur, IL"', add
label define city_lbl 1691 `"Decatur, AL"', add
label define city_lbl 1692 `"Decatur, GA"', add
label define city_lbl 1693 `"Dedham, MA"', add
label define city_lbl 1694 `"Del Rio, TX"', add
label define city_lbl 1695 `"Denison, TX"', add
label define city_lbl 1710 `"Denver, CO"', add
label define city_lbl 1711 `"Derby, CT"', add
label define city_lbl 1713 `"Derry, PA"', add
label define city_lbl 1730 `"Des Moines, IA"', add
label define city_lbl 1750 `"Detroit, MI"', add
label define city_lbl 1751 `"Dickson City, PA"', add
label define city_lbl 1752 `"Dodge, KS"', add
label define city_lbl 1753 `"Donora, PA"', add
label define city_lbl 1754 `"Dormont, PA"', add
label define city_lbl 1755 `"Dothan, AL"', add
label define city_lbl 1770 `"Dorchester, MA"', add
label define city_lbl 1790 `"Dover, NH"', add
label define city_lbl 1791 `"Dover, NJ"', add
label define city_lbl 1792 `"Du Bois, PA"', add
label define city_lbl 1800 `"Downey, CA"', add
label define city_lbl 1810 `"Dubuque, IA"', add
label define city_lbl 1830 `"Duluth, MN"', add
label define city_lbl 1831 `"Dunkirk, NY"', add
label define city_lbl 1832 `"Dunmore, PA"', add
label define city_lbl 1833 `"Duquesne, PA"', add
label define city_lbl 1834 `"Dundalk, MD"', add
label define city_lbl 1850 `"Durham, NC"', add
label define city_lbl 1860 `"1860"', add
label define city_lbl 1870 `"East Chicago, IN"', add
label define city_lbl 1890 `"East Cleveland, OH"', add
label define city_lbl 1891 `"East Hartford, CT"', add
label define city_lbl 1892 `"East Liverpool, OH"', add
label define city_lbl 1893 `"East Moline, IL"', add
label define city_lbl 1910 `"East Los Angeles, CA"', add
label define city_lbl 1930 `"East Orange, NJ"', add
label define city_lbl 1931 `"East Providence, RI"', add
label define city_lbl 1940 `"East Saginaw, MI"', add
label define city_lbl 1950 `"East St. Louis, IL"', add
label define city_lbl 1951 `"East Youngstown, OH"', add
label define city_lbl 1952 `"Easthampton, MA"', add
label define city_lbl 1970 `"Easton, PA"', add
label define city_lbl 1971 `"Eau Claire, WI"', add
label define city_lbl 1972 `"Ecorse, MI"', add
label define city_lbl 1973 `"El Dorado, KS"', add
label define city_lbl 1974 `"El Dorado, AR"', add
label define city_lbl 1990 `"El Monte, CA"', add
label define city_lbl 2010 `"El Paso, TX"', add
label define city_lbl 2030 `"Elgin, IL"', add
label define city_lbl 2040 `"Elyria, OH"', add
label define city_lbl 2050 `"Elizabeth, NJ"', add
label define city_lbl 2051 `"Elizabeth City, NC"', add
label define city_lbl 2055 `"Elk Grove, CA"', add
label define city_lbl 2060 `"Elkhart, IN"', add
label define city_lbl 2061 `"Ellwood City, PA"', add
label define city_lbl 2062 `"Elmhurst, IL"', add
label define city_lbl 2070 `"Elmira, NY"', add
label define city_lbl 2071 `"Elmwood Park, IL"', add
label define city_lbl 2072 `"Elwood, IN"', add
label define city_lbl 2073 `"Emporia, KS"', add
label define city_lbl 2074 `"Endicott, NY"', add
label define city_lbl 2075 `"Enfield, CT"', add
label define city_lbl 2076 `"Englewood, NJ"', add
label define city_lbl 2080 `"Enid, OK"', add
label define city_lbl 2090 `"Erie, PA"', add
label define city_lbl 2091 `"Escanaba, MI"', add
label define city_lbl 2092 `"Euclid, OH"', add
label define city_lbl 2110 `"Escondido, CA"', add
label define city_lbl 2130 `"Eugene, OR"', add
label define city_lbl 2131 `"Eureka, CA"', add
label define city_lbl 2150 `"Evanston, IL"', add
label define city_lbl 2170 `"Evansville, IN"', add
label define city_lbl 2190 `"Everett, MA"', add
label define city_lbl 2210 `"Everett, WA"', add
label define city_lbl 2211 `"Fairfield, AL"', add
label define city_lbl 2212 `"Fairfield, CT"', add
label define city_lbl 2213 `"Fairhaven, MA"', add
label define city_lbl 2214 `"Fairmont, WV"', add
label define city_lbl 2220 `"Fargo, ND"', add
label define city_lbl 2221 `"Faribault, MN"', add
label define city_lbl 2222 `"Farrell, PA"', add
label define city_lbl 2230 `"Fall River, MA"', add
label define city_lbl 2240 `"Fayetteville, NC"', add
label define city_lbl 2241 `"Ferndale, MI"', add
label define city_lbl 2242 `"Findlay, OH"', add
label define city_lbl 2250 `"Fitchburg, MA"', add
label define city_lbl 2260 `"Fontana, CA"', add
label define city_lbl 2270 `"Flint, MI"', add
label define city_lbl 2271 `"Floral Park, NY"', add
label define city_lbl 2273 `"Florence, AL"', add
label define city_lbl 2274 `"Florence, SC"', add
label define city_lbl 2275 `"Flushing, NY"', add
label define city_lbl 2280 `"Fond du Lac, WI"', add
label define city_lbl 2281 `"Forest Park, IL"', add
label define city_lbl 2290 `"Fort Lauderdale, FL"', add
label define city_lbl 2300 `"Fort Collins, CO"', add
label define city_lbl 2301 `"Fort Dodge, IA"', add
label define city_lbl 2302 `"Fort Madison, IA"', add
label define city_lbl 2303 `"Fort Scott, KS"', add
label define city_lbl 2310 `"Fort Smith, AR"', add
label define city_lbl 2311 `"Fort Thomas, KY"', add
label define city_lbl 2330 `"Fort Wayne, IN"', add
label define city_lbl 2350 `"Fort Worth, TX"', add
label define city_lbl 2351 `"Fostoria, OH"', add
label define city_lbl 2352 `"Framingham, MA"', add
label define city_lbl 2353 `"Frankfort, IN"', add
label define city_lbl 2354 `"Frankfort, KY"', add
label define city_lbl 2355 `"Franklin, PA"', add
label define city_lbl 2356 `"Frederick, MD"', add
label define city_lbl 2357 `"Freeport, NY"', add
label define city_lbl 2358 `"Freeport, IL"', add
label define city_lbl 2359 `"Fremont, OH"', add
label define city_lbl 2360 `"Fremont, NE"', add
label define city_lbl 2370 `"Fresno, CA"', add
label define city_lbl 2390 `"Fullerton, CA"', add
label define city_lbl 2391 `"Fulton, NY"', add
label define city_lbl 2392 `"Gadsden, AL"', add
label define city_lbl 2393 `"Galena, KS"', add
label define city_lbl 2394 `"Gainesville, FL"', add
label define city_lbl 2400 `"Galesburg, IL"', add
label define city_lbl 2410 `"Galveston, TX"', add
label define city_lbl 2411 `"Gardner, MA"', add
label define city_lbl 2430 `"Garden Grove, CA"', add
label define city_lbl 2435 `"Gardena, CA"', add
label define city_lbl 2440 `"Garfield, NJ"', add
label define city_lbl 2441 `"Garfield Heights, OH"', add
label define city_lbl 2450 `"Garland, TX"', add
label define city_lbl 2470 `"Gary, IN"', add
label define city_lbl 2471 `"Gastonia, NC"', add
label define city_lbl 2472 `"Geneva, NY"', add
label define city_lbl 2473 `"Glen Cove, NY"', add
label define city_lbl 2489 `"Glendale, AZ"', add
label define city_lbl 2490 `"Glendale, CA"', add
label define city_lbl 2491 `"Glens Falls, NY"', add
label define city_lbl 2510 `"Gloucester, MA"', add
label define city_lbl 2511 `"Gloucester, NJ"', add
label define city_lbl 2512 `"Gloversville, NY"', add
label define city_lbl 2513 `"Goldsboro, NC"', add
label define city_lbl 2514 `"Goshen, IN"', add
label define city_lbl 2515 `"Grand Forks, ND"', add
label define city_lbl 2516 `"Grand Island, NE"', add
label define city_lbl 2517 `"Grand Junction, CO"', add
label define city_lbl 2520 `"Granite City, IL"', add
label define city_lbl 2530 `"Grand Rapids, MI"', add
label define city_lbl 2531 `"Grandville, MI"', add
label define city_lbl 2540 `"Great Falls, MT"', add
label define city_lbl 2541 `"Greeley, CO"', add
label define city_lbl 2550 `"Green Bay, WI"', add
label define city_lbl 2551 `"Greenfield, MA"', add
label define city_lbl 2570 `"Greensboro, NC"', add
label define city_lbl 2571 `"Greensburg, PA"', add
label define city_lbl 2572 `"Greenville, MS"', add
label define city_lbl 2573 `"Greenville, SC"', add
label define city_lbl 2574 `"Greenville, TX"', add
label define city_lbl 2575 `"Greenwich, CT"', add
label define city_lbl 2576 `"Greenwood, MS"', add
label define city_lbl 2577 `"Greenwood, SC"', add
label define city_lbl 2578 `"Griffin, GA"', add
label define city_lbl 2579 `"Grosse Pointe Park, MI"', add
label define city_lbl 2580 `"Guynabo, PR"', add
label define city_lbl 2581 `"Groton, CT"', add
label define city_lbl 2582 `"Gulfport, MS"', add
label define city_lbl 2583 `"Guthrie, OK"', add
label define city_lbl 2584 `"Hackensack, NJ"', add
label define city_lbl 2590 `"Hagerstown, MD"', add
label define city_lbl 2591 `"Hamden, CT"', add
label define city_lbl 2610 `"Hamilton, OH"', add
label define city_lbl 2630 `"Hammond, IN"', add
label define city_lbl 2650 `"Hampton, VA"', add
label define city_lbl 2670 `"Hamtramck Village, MI"', add
label define city_lbl 2680 `"Hannibal, MO"', add
label define city_lbl 2681 `"Hanover, PA"', add
label define city_lbl 2682 `"Harlingen, TX"', add
label define city_lbl 2683 `"Hanover township, Luzerne county, PA"', add
label define city_lbl 2690 `"Harrisburg, PA"', add
label define city_lbl 2691 `"Harrisburg, IL"', add
label define city_lbl 2692 `"Harrison, NJ"', add
label define city_lbl 2693 `"Harrison, PA"', add
label define city_lbl 2710 `"Hartford, CT"', add
label define city_lbl 2711 `"Harvey, IL"', add
label define city_lbl 2712 `"Hastings, NE"', add
label define city_lbl 2713 `"Hattiesburg, MS"', add
label define city_lbl 2725 `"Haverford, PA"', add
label define city_lbl 2730 `"Haverhill, MA"', add
label define city_lbl 2731 `"Hawthorne, NJ"', add
label define city_lbl 2740 `"Hayward, CA"', add
label define city_lbl 2750 `"Hazleton, PA"', add
label define city_lbl 2751 `"Helena, MT"', add
label define city_lbl 2752 `"Hempstead, NY"', add
label define city_lbl 2753 `"Henderson, KY"', add
label define city_lbl 2754 `"Herkimer, NY"', add
label define city_lbl 2755 `"Herrin, IL"', add
label define city_lbl 2756 `"Hibbing, MN"', add
label define city_lbl 2757 `"Henderson, NV"', add
label define city_lbl 2770 `"Hialeah, FL"', add
label define city_lbl 2780 `"High Point, NC"', add
label define city_lbl 2781 `"Highland Park, IL"', add
label define city_lbl 2790 `"Highland Park, MI"', add
label define city_lbl 2791 `"Hilo, HI"', add
label define city_lbl 2792 `"Hillside, NJ"', add
label define city_lbl 2810 `"Hoboken, NJ"', add
label define city_lbl 2811 `"Holland, MI"', add
label define city_lbl 2830 `"Hollywood, FL"', add
label define city_lbl 2850 `"Holyoke, MA"', add
label define city_lbl 2851 `"Homestead, PA"', add
label define city_lbl 2870 `"Honolulu, HI"', add
label define city_lbl 2871 `"Hopewell, VA"', add
label define city_lbl 2872 `"Hopkinsville, KY"', add
label define city_lbl 2873 `"Hoquiam, WA"', add
label define city_lbl 2874 `"Hornell, NY"', add
label define city_lbl 2875 `"Hot Springs, AR"', add
label define city_lbl 2890 `"Houston, TX"', add
label define city_lbl 2891 `"Hudson, NY"', add
label define city_lbl 2892 `"Huntington, IN"', add
label define city_lbl 2910 `"Huntington, WV"', add
label define city_lbl 2930 `"Huntington Beach, CA"', add
label define city_lbl 2950 `"Huntsville, AL"', add
label define city_lbl 2951 `"Huron, SD"', add
label define city_lbl 2960 `"Hutchinson, KS"', add
label define city_lbl 2961 `"Hyde Park, MA"', add
label define city_lbl 2962 `"Ilion, NY"', add
label define city_lbl 2963 `"Independence, KS"', add
label define city_lbl 2970 `"Independence, MO"', add
label define city_lbl 2990 `"Indianapolis, IN"', add
label define city_lbl 3010 `"Inglewood, CA"', add
label define city_lbl 3011 `"Iowa City, IA"', add
label define city_lbl 3012 `"Iron Mountain, MI"', add
label define city_lbl 3013 `"Ironton, OH"', add
label define city_lbl 3014 `"Ironwood, MI"', add
label define city_lbl 3015 `"Irondequoit, NY"', add
label define city_lbl 3020 `"Irvine, CA"', add
label define city_lbl 3030 `"Irving, TX"', add
label define city_lbl 3050 `"Irvington, NJ"', add
label define city_lbl 3051 `"Ishpeming, MI"', add
label define city_lbl 3052 `"Ithaca, NY"', add
label define city_lbl 3070 `"Jackson, MI"', add
label define city_lbl 3071 `"Jackson, MN"', add
label define city_lbl 3090 `"Jackson, MS"', add
label define city_lbl 3091 `"Jackson, TN"', add
label define city_lbl 3110 `"Jacksonville, FL"', add
label define city_lbl 3111 `"Jacksonville, IL"', add
label define city_lbl 3130 `"Jamestown, NY"', add
label define city_lbl 3131 `"Janesville, WI"', add
label define city_lbl 3132 `"Jeannette, PA"', add
label define city_lbl 3133 `"Jefferson City, MO"', add
label define city_lbl 3134 `"Jeffersonville, IN"', add
label define city_lbl 3150 `"Jersey City, NJ"', add
label define city_lbl 3151 `"Johnson City, NY"', add
label define city_lbl 3160 `"Johnson City, TN"', add
label define city_lbl 3161 `"Johnstown, NY"', add
label define city_lbl 3170 `"Johnstown, PA"', add
label define city_lbl 3190 `"Joliet, IL"', add
label define city_lbl 3191 `"Jonesboro, AR"', add
label define city_lbl 3210 `"Joplin, MO"', add
label define city_lbl 3230 `"Kalamazoo, MI"', add
label define city_lbl 3231 `"Kankakee, IL"', add
label define city_lbl 3250 `"Kansas City, KS"', add
label define city_lbl 3260 `"Kansas City, MO"', add
label define city_lbl 3270 `"Kearny, NJ"', add
label define city_lbl 3271 `"Keene, NH"', add
label define city_lbl 3272 `"Kenmore, NY"', add
label define city_lbl 3273 `"Kenmore, OH"', add
label define city_lbl 3290 `"Kenosha, WI"', add
label define city_lbl 3291 `"Keokuk, IA"', add
label define city_lbl 3292 `"Kewanee, IL"', add
label define city_lbl 3293 `"Key West, FL"', add
label define city_lbl 3294 `"Kingsport, TN"', add
label define city_lbl 3300 `"Kent, WA"', add
label define city_lbl 3310 `"Kingston, NY"', add
label define city_lbl 3311 `"Kingston, PA"', add
label define city_lbl 3312 `"Kinston, NC"', add
label define city_lbl 3313 `"Klamath Falls, OR"', add
label define city_lbl 3330 `"Knoxville, TN"', add
label define city_lbl 3350 `"Kokomo, IN"', add
label define city_lbl 3370 `"La Crosse, WI"', add
label define city_lbl 3380 `"Lafayette, IN"', add
label define city_lbl 3390 `"Lafayette, LA"', add
label define city_lbl 3391 `"La Grange, IL"', add
label define city_lbl 3392 `"La Grange, GA"', add
label define city_lbl 3393 `"La Porte, IN"', add
label define city_lbl 3394 `"La Salle, IL"', add
label define city_lbl 3395 `"Lackawanna, NY"', add
label define city_lbl 3396 `"Laconia, NH"', add
label define city_lbl 3397 `"Historical Lafayette, LA"', add
label define city_lbl 3400 `"Lake Charles, LA"', add
label define city_lbl 3405 `"Lakeland, FL"', add
label define city_lbl 3410 `"Lakewood, CO"', add
label define city_lbl 3430 `"Lakewood, OH"', add
label define city_lbl 3440 `"Lancaster, CA"', add
label define city_lbl 3450 `"Lancaster, PA"', add
label define city_lbl 3451 `"Lancaster, OH"', add
label define city_lbl 3470 `"Lansing, MI"', add
label define city_lbl 3471 `"Lansingburgh, NY"', add
label define city_lbl 3480 `"Laredo, TX"', add
label define city_lbl 3481 `"Latrobe, PA"', add
label define city_lbl 3482 `"Laurel, MS"', add
label define city_lbl 3490 `"Las Vegas, NV"', add
label define city_lbl 3510 `"Lawrence, MA"', add
label define city_lbl 3511 `"Lawrence, KS"', add
label define city_lbl 3512 `"Lawton, OK"', add
label define city_lbl 3513 `"Leadville, CO"', add
label define city_lbl 3520 `"Leavenworth, KS"', add
label define city_lbl 3521 `"Lebanon, PA"', add
label define city_lbl 3522 `"Leominster, MA"', add
label define city_lbl 3530 `"Lehigh, PA"', add
label define city_lbl 3550 `"Lewiston, ME"', add
label define city_lbl 3551 `"Lewistown, PA"', add
label define city_lbl 3560 `"Lewisville, TX"', add
label define city_lbl 3570 `"Lexington, KY"', add
label define city_lbl 3590 `"Lexington-Fayette, KY"', add
label define city_lbl 3610 `"Lima, OH"', add
label define city_lbl 3630 `"Lincoln, NE"', add
label define city_lbl 3631 `"Lincoln, IL"', add
label define city_lbl 3632 `"Lincoln Park, MI"', add
label define city_lbl 3633 `"Lincoln, RI"', add
label define city_lbl 3634 `"Linden, NJ"', add
label define city_lbl 3635 `"Little Falls, NY"', add
label define city_lbl 3638 `"Lodi, NJ"', add
label define city_lbl 3639 `"Logansport, IN"', add
label define city_lbl 3650 `"Little Rock, AR"', add
label define city_lbl 3670 `"Livonia, MI"', add
label define city_lbl 3680 `"Lockport, NY"', add
label define city_lbl 3690 `"Long Beach, CA"', add
label define city_lbl 3691 `"Long Branch, NJ"', add
label define city_lbl 3692 `"Long Island City, NY"', add
label define city_lbl 3693 `"Longview, WA"', add
label define city_lbl 3710 `"Lorain, OH"', add
label define city_lbl 3730 `"Los Angeles, CA"', add
label define city_lbl 3750 `"Louisville, KY"', add
label define city_lbl 3765 `"Lower Merion, PA"', add
label define city_lbl 3770 `"Lowell, MA"', add
label define city_lbl 3771 `"Lubbock, TX"', add
label define city_lbl 3772 `"Lynbrook, NY"', add
label define city_lbl 3790 `"Lynchburg, VA"', add
label define city_lbl 3800 `"Lyndhurst, NJ"', add
label define city_lbl 3810 `"Lynn, MA"', add
label define city_lbl 3830 `"Macon, GA"', add
label define city_lbl 3850 `"Madison, IN"', add
label define city_lbl 3870 `"Madison, WI"', add
label define city_lbl 3871 `"Mahanoy City, PA"', add
label define city_lbl 3890 `"Malden, MA"', add
label define city_lbl 3891 `"Mamaroneck, NY"', add
label define city_lbl 3910 `"Manchester, NH"', add
label define city_lbl 3911 `"Manchester, CT"', add
label define city_lbl 3912 `"Manhattan, KS"', add
label define city_lbl 3913 `"Manistee, MI"', add
label define city_lbl 3914 `"Manitowoc, WI"', add
label define city_lbl 3915 `"Mankato, MN"', add
label define city_lbl 3929 `"Maplewood, NJ"', add
label define city_lbl 3930 `"Mansfield, OH"', add
label define city_lbl 3931 `"Maplewood, MO"', add
label define city_lbl 3932 `"Marietta, OH"', add
label define city_lbl 3933 `"Marinette, WI"', add
label define city_lbl 3934 `"Marion, IN"', add
label define city_lbl 3940 `"Maywood, IL"', add
label define city_lbl 3950 `"Marion, OH"', add
label define city_lbl 3951 `"Marlborough, MA"', add
label define city_lbl 3952 `"Marquette, MI"', add
label define city_lbl 3953 `"Marshall, TX"', add
label define city_lbl 3954 `"Marshalltown, IA"', add
label define city_lbl 3955 `"Martins Ferry, OH"', add
label define city_lbl 3956 `"Martinsburg, WV"', add
label define city_lbl 3957 `"Mason City, IA"', add
label define city_lbl 3958 `"Massena, NY"', add
label define city_lbl 3959 `"Massillon, OH"', add
label define city_lbl 3960 `"McAllen, TX"', add
label define city_lbl 3961 `"Mattoon, IL"', add
label define city_lbl 3962 `"Mcalester, OK"', add
label define city_lbl 3963 `"Mccomb, MS"', add
label define city_lbl 3964 `"Mckees Rocks, PA"', add
label define city_lbl 3970 `"McKeesport, PA"', add
label define city_lbl 3971 `"Meadville, PA"', add
label define city_lbl 3990 `"Medford, MA"', add
label define city_lbl 3991 `"Medford, OR"', add
label define city_lbl 3992 `"Melrose, MA"', add
label define city_lbl 3993 `"Melrose Park, IL"', add
label define city_lbl 4010 `"Memphis, TN"', add
label define city_lbl 4011 `"Menominee, MI"', add
label define city_lbl 4030 `"Meriden, CT"', add
label define city_lbl 4040 `"Meridian, MS"', add
label define city_lbl 4041 `"Methuen, MA"', add
label define city_lbl 4050 `"Mesa, AZ"', add
label define city_lbl 4070 `"Mesquite, TX"', add
label define city_lbl 4090 `"Metairie, LA"', add
label define city_lbl 4110 `"Miami, FL"', add
label define city_lbl 4120 `"Michigan City, IN"', add
label define city_lbl 4121 `"Middlesboro, KY"', add
label define city_lbl 4122 `"Middletown, CT"', add
label define city_lbl 4123 `"Middletown, NY"', add
label define city_lbl 4124 `"Middletown, OH"', add
label define city_lbl 4125 `"Milford, CT"', add
label define city_lbl 4126 `"Milford, MA"', add
label define city_lbl 4127 `"Millville, NJ"', add
label define city_lbl 4128 `"Milton, MA"', add
label define city_lbl 4130 `"Milwaukee, WI"', add
label define city_lbl 4150 `"Minneapolis, MN"', add
label define city_lbl 4151 `"Minot, ND"', add
label define city_lbl 4160 `"Mishawaka, IN"', add
label define city_lbl 4161 `"Missoula, MT"', add
label define city_lbl 4162 `"Mitchell, SD"', add
label define city_lbl 4163 `"Moberly, MO"', add
label define city_lbl 4170 `"Mobile, AL"', add
label define city_lbl 4190 `"Modesto, CA"', add
label define city_lbl 4210 `"Moline, IL"', add
label define city_lbl 4211 `"Monessen, PA"', add
label define city_lbl 4212 `"Monroe, MI"', add
label define city_lbl 4213 `"Monroe, LA"', add
label define city_lbl 4214 `"Monrovia, CA"', add
label define city_lbl 4230 `"Montclair, NJ"', add
label define city_lbl 4250 `"Montgomery, AL"', add
label define city_lbl 4251 `"Morgantown, WV"', add
label define city_lbl 4252 `"Morristown, NJ"', add
label define city_lbl 4253 `"Moundsville, WV"', add
label define city_lbl 4254 `"Mount Arlington, NJ"', add
label define city_lbl 4255 `"Mount Carmel, PA"', add
label define city_lbl 4256 `"Mount Clemens, MI"', add
label define city_lbl 4260 `"Mount Lebanon, PA"', add
label define city_lbl 4270 `"Moreno Valley, CA"', add
label define city_lbl 4290 `"Mount Vernon, NY"', add
label define city_lbl 4291 `"Mount Vernon, IL"', add
label define city_lbl 4310 `"Muncie, IN"', add
label define city_lbl 4311 `"Munhall, PA"', add
label define city_lbl 4312 `"Murphysboro, IL"', add
label define city_lbl 4313 `"Muscatine, IA"', add
label define city_lbl 4330 `"Muskegon, MI"', add
label define city_lbl 4331 `"Muskegon Heights, MI"', add
label define city_lbl 4350 `"Muskogee, OK"', add
label define city_lbl 4351 `"Nanticoke, PA"', add
label define city_lbl 4370 `"Nantucket, MA"', add
label define city_lbl 4390 `"Nashua, NH"', add
label define city_lbl 4410 `"Nashville-Davidson, TN"', add
label define city_lbl 4411 `"Nashville, TN"', add
label define city_lbl 4413 `"Natchez, MS"', add
label define city_lbl 4414 `"Natick, MA"', add
label define city_lbl 4415 `"Naugatuck, CT"', add
label define city_lbl 4416 `"Needham, MA"', add
label define city_lbl 4420 `"Neptune, NJ"', add
label define city_lbl 4430 `"New Albany, IN"', add
label define city_lbl 4450 `"New Bedford, MA"', add
label define city_lbl 4451 `"New Bern, NC"', add
label define city_lbl 4452 `"New Brighton, NY"', add
label define city_lbl 4470 `"New Britain, CT"', add
label define city_lbl 4490 `"New Brunswick, NJ"', add
label define city_lbl 4510 `"New Castle, PA"', add
label define city_lbl 4511 `"New Castle, IN"', add
label define city_lbl 4530 `"New Haven, CT"', add
label define city_lbl 4550 `"New London, CT"', add
label define city_lbl 4570 `"New Orleans, LA"', add
label define city_lbl 4571 `"New Philadelphia, OH"', add
label define city_lbl 4590 `"New Rochelle, NY"', add
label define city_lbl 4610 `"New York, NY"', add
label define city_lbl 4611 `"Brooklyn (only in census years before 1900)"', add
label define city_lbl 4612 `"Williamsburgh, NY"', add
label define city_lbl 4630 `"Newark, NJ"', add
label define city_lbl 4650 `"Newark, OH"', add
label define city_lbl 4670 `"Newburgh, NY"', add
label define city_lbl 4690 `"Newburyport, MA"', add
label define city_lbl 4710 `"Newport, KY"', add
label define city_lbl 4730 `"Newport, RI"', add
label define city_lbl 4750 `"Newport News, VA"', add
label define city_lbl 4770 `"Newton, MA"', add
label define city_lbl 4771 `"Newton, IA"', add
label define city_lbl 4772 `"Newton, KS"', add
label define city_lbl 4790 `"Niagara Falls, NY"', add
label define city_lbl 4791 `"Niles, MI"', add
label define city_lbl 4792 `"Niles, OH"', add
label define city_lbl 4810 `"Norfolk, VA"', add
label define city_lbl 4811 `"Norfolk, NE"', add
label define city_lbl 4820 `"North Las Vegas, NV"', add
label define city_lbl 4830 `"Norristown Borough, PA"', add
label define city_lbl 4831 `"North Adams, MA"', add
label define city_lbl 4832 `"North Attleborough, MA"', add
label define city_lbl 4833 `"North Bennington, VT"', add
label define city_lbl 4834 `"North Braddock, PA"', add
label define city_lbl 4835 `"North Branford, CT"', add
label define city_lbl 4836 `"North Haven, CT"', add
label define city_lbl 4837 `"North Little Rock, AR"', add
label define city_lbl 4838 `"North Platte, NE"', add
label define city_lbl 4839 `"North Providence, RI"', add
label define city_lbl 4840 `"Northampton, MA"', add
label define city_lbl 4841 `"North Tonawanda, NY"', add
label define city_lbl 4842 `"North Yakima, WA"', add
label define city_lbl 4843 `"Northbridge, MA"', add
label define city_lbl 4845 `"North Bergen, NJ"', add
label define city_lbl 4860 `"Norwalk, CA"', add
label define city_lbl 4870 `"Norwalk, CT"', add
label define city_lbl 4890 `"Norwich, CT"', add
label define city_lbl 4900 `"Norwood, OH"', add
label define city_lbl 4901 `"Norwood, MA"', add
label define city_lbl 4902 `"Nutley, NJ"', add
label define city_lbl 4905 `"Oak Park, IL"', add
label define city_lbl 4910 `"Oak Park Village, IL"', add
label define city_lbl 4930 `"Oakland, CA"', add
label define city_lbl 4950 `"Oceanside, CA"', add
label define city_lbl 4970 `"Ogden, UT"', add
label define city_lbl 4971 `"Ogdensburg, NY"', add
label define city_lbl 4972 `"Oil City, PA"', add
label define city_lbl 4990 `"Oklahoma City, OK"', add
label define city_lbl 4991 `"Okmulgee, OK"', add
label define city_lbl 4992 `"Old Bennington, VT"', add
label define city_lbl 4993 `"Old Forge, PA"', add
label define city_lbl 4994 `"Olean, NY"', add
label define city_lbl 4995 `"Olympia, WA"', add
label define city_lbl 4996 `"Olyphant, PA"', add
label define city_lbl 5010 `"Omaha, NE"', add
label define city_lbl 5011 `"Oneida, NY"', add
label define city_lbl 5012 `"Oneonta, NY"', add
label define city_lbl 5030 `"Ontario, CA"', add
label define city_lbl 5040 `"Orange, CA"', add
label define city_lbl 5050 `"Orange, NJ"', add
label define city_lbl 5051 `"Orange, CT"', add
label define city_lbl 5070 `"Orlando, FL"', add
label define city_lbl 5090 `"Oshkosh, WI"', add
label define city_lbl 5091 `"Oskaloosa, IA"', add
label define city_lbl 5092 `"Ossining, NY"', add
label define city_lbl 5110 `"Oswego, NY"', add
label define city_lbl 5111 `"Ottawa, IL"', add
label define city_lbl 5112 `"Ottumwa, IA"', add
label define city_lbl 5113 `"Owensboro, KY"', add
label define city_lbl 5114 `"Owosso, MI"', add
label define city_lbl 5116 `"Painesville, OH"', add
label define city_lbl 5117 `"Palestine, TX"', add
label define city_lbl 5118 `"Palo Alto, CA"', add
label define city_lbl 5119 `"Pampa, TX"', add
label define city_lbl 5121 `"Paris, TX"', add
label define city_lbl 5122 `"Park Ridge, IL"', add
label define city_lbl 5123 `"Parkersburg, WV"', add
label define city_lbl 5124 `"Parma, OH"', add
label define city_lbl 5125 `"Parsons, KS"', add
label define city_lbl 5130 `"Oxnard, CA"', add
label define city_lbl 5140 `"Palmdale, CA"', add
label define city_lbl 5150 `"Pasadena, CA"', add
label define city_lbl 5170 `"Pasadena, TX"', add
label define city_lbl 5180 `"Paducah, KY"', add
label define city_lbl 5190 `"Passaic, NJ"', add
label define city_lbl 5210 `"Paterson, NJ"', add
label define city_lbl 5230 `"Pawtucket, RI"', add
label define city_lbl 5231 `"Peabody, MA"', add
label define city_lbl 5232 `"Peekskill, NY"', add
label define city_lbl 5233 `"Pekin, IL"', add
label define city_lbl 5240 `"Pembroke Pines, FL"', add
label define city_lbl 5250 `"Pensacola, FL"', add
label define city_lbl 5255 `"Pensauken, NJ"', add
label define city_lbl 5269 `"Peoria, AZ"', add
label define city_lbl 5270 `"Peoria, IL"', add
label define city_lbl 5271 `"Peoria Heights, IL"', add
label define city_lbl 5290 `"Perth Amboy, NJ"', add
label define city_lbl 5291 `"Peru, IN"', add
label define city_lbl 5310 `"Petersburg, VA"', add
label define city_lbl 5311 `"Phenix City, AL"', add
label define city_lbl 5330 `"Philadelphia, PA"', add
label define city_lbl 5331 `"Kensington"', add
label define city_lbl 5332 `"Moyamensing"', add
label define city_lbl 5333 `"Northern Liberties"', add
label define city_lbl 5334 `"Southwark"', add
label define city_lbl 5335 `"Spring Garden"', add
label define city_lbl 5341 `"Phillipsburg, NJ"', add
label define city_lbl 5350 `"Phoenix, AZ"', add
label define city_lbl 5351 `"Phoenixville, PA"', add
label define city_lbl 5352 `"Pine Bluff, AR"', add
label define city_lbl 5353 `"Piqua, OH"', add
label define city_lbl 5354 `"Pittsburg, KS"', add
label define city_lbl 5370 `"Pittsburgh, PA"', add
label define city_lbl 5390 `"Pittsfield, MA"', add
label define city_lbl 5391 `"Pittston, PA"', add
label define city_lbl 5409 `"Plains, PA"', add
label define city_lbl 5410 `"Plainfield, NJ"', add
label define city_lbl 5411 `"Plattsburg, NY"', add
label define city_lbl 5412 `"Pleasantville, NJ"', add
label define city_lbl 5413 `"Plymouth, PA"', add
label define city_lbl 5414 `"Plymouth, MA"', add
label define city_lbl 5415 `"Pocatello, ID"', add
label define city_lbl 5430 `"Plano, TX"', add
label define city_lbl 5450 `"Pomona, CA"', add
label define city_lbl 5451 `"Ponca City, OK"', add
label define city_lbl 5460 `"Ponce, PR"', add
label define city_lbl 5470 `"Pontiac, MI"', add
label define city_lbl 5471 `"Port Angeles, WA"', add
label define city_lbl 5480 `"Port Arthur, TX"', add
label define city_lbl 5481 `"Port Chester, NY"', add
label define city_lbl 5490 `"Port Huron, MI"', add
label define city_lbl 5491 `"Port Jervis, NY"', add
label define city_lbl 5500 `"Port St. Lucie, FL"', add
label define city_lbl 5510 `"Portland, ME"', add
label define city_lbl 5511 `"Portland, IL"', add
label define city_lbl 5530 `"Portland, OR"', add
label define city_lbl 5550 `"Portsmouth, NH"', add
label define city_lbl 5570 `"Portsmouth, OH"', add
label define city_lbl 5590 `"Portsmouth, VA"', add
label define city_lbl 5591 `"Pottstown, PA"', add
label define city_lbl 5610 `"Pottsville, PA"', add
label define city_lbl 5630 `"Poughkeepsie, NY"', add
label define city_lbl 5650 `"Providence, RI"', add
label define city_lbl 5660 `"Provo, UT"', add
label define city_lbl 5670 `"Pueblo, CO"', add
label define city_lbl 5671 `"Punxsutawney, PA"', add
label define city_lbl 5690 `"Quincy, IL"', add
label define city_lbl 5710 `"Quincy, MA"', add
label define city_lbl 5730 `"Racine, WI"', add
label define city_lbl 5731 `"Rahway, NJ"', add
label define city_lbl 5750 `"Raleigh, NC"', add
label define city_lbl 5751 `"Ranger, TX"', add
label define city_lbl 5752 `"Rapid City, SD"', add
label define city_lbl 5770 `"Rancho Cucamonga, CA"', add
label define city_lbl 5790 `"Reading, PA"', add
label define city_lbl 5791 `"Red Bank, NJ"', add
label define city_lbl 5792 `"Redlands, CA"', add
label define city_lbl 5810 `"Reno, NV"', add
label define city_lbl 5811 `"Rensselaer, NY"', add
label define city_lbl 5830 `"Revere, MA"', add
label define city_lbl 5850 `"Richmond, IN"', add
label define city_lbl 5870 `"Richmond, VA"', add
label define city_lbl 5871 `"Richmond, CA"', add
label define city_lbl 5872 `"Ridgefield Park, NJ"', add
label define city_lbl 5873 `"Ridgewood, NJ"', add
label define city_lbl 5874 `"River Rouge, MI"', add
label define city_lbl 5890 `"Riverside, CA"', add
label define city_lbl 5910 `"Roanoke, VA"', add
label define city_lbl 5930 `"Rochester, NY"', add
label define city_lbl 5931 `"Rochester, NH"', add
label define city_lbl 5932 `"Rochester, MN"', add
label define city_lbl 5933 `"Rock Hill, SC"', add
label define city_lbl 5950 `"Rock Island, IL"', add
label define city_lbl 5970 `"Rockford, IL"', add
label define city_lbl 5971 `"Rockland, ME"', add
label define city_lbl 5972 `"Rockton, IL"', add
label define city_lbl 5973 `"Rockville Centre, NY"', add
label define city_lbl 5974 `"Rocky Mount, NC"', add
label define city_lbl 5990 `"Rome, NY"', add
label define city_lbl 5991 `"Rome, GA"', add
label define city_lbl 5992 `"Roosevelt, NJ"', add
label define city_lbl 5993 `"Roselle, NJ"', add
label define city_lbl 5994 `"Roswell, NM"', add
label define city_lbl 5995 `"Roseville, CA"', add
label define city_lbl 5996 `"Rondout, NY"', add
label define city_lbl 6010 `"Roxbury, MA"', add
label define city_lbl 6011 `"Royal Oak, MI"', add
label define city_lbl 6012 `"Rumford Falls, ME"', add
label define city_lbl 6013 `"Rutherford, NJ"', add
label define city_lbl 6014 `"Rutland, VT"', add
label define city_lbl 6030 `"Sacramento, CA"', add
label define city_lbl 6050 `"Saginaw, MI"', add
label define city_lbl 6070 `"Saint Joseph, MO"', add
label define city_lbl 6090 `"Saint Louis, MO"', add
label define city_lbl 6110 `"Saint Paul, MN"', add
label define city_lbl 6130 `"Saint Petersburg, FL"', add
label define city_lbl 6150 `"Salem, MA"', add
label define city_lbl 6170 `"Salem, OR"', add
label define city_lbl 6171 `"Salem, OH"', add
label define city_lbl 6172 `"Salina, KS"', add
label define city_lbl 6190 `"Salinas, CA"', add
label define city_lbl 6191 `"Salisbury, NC"', add
label define city_lbl 6192 `"Salisbury, MD"', add
label define city_lbl 6210 `"Salt Lake City, UT"', add
label define city_lbl 6211 `"San Angelo, TX"', add
label define city_lbl 6230 `"San Antonio, TX"', add
label define city_lbl 6231 `"San Benito, TX"', add
label define city_lbl 6250 `"San Bernardino, CA"', add
label define city_lbl 6260 `"San Buenaventura (Ventura), CA"', add
label define city_lbl 6270 `"San Diego, CA"', add
label define city_lbl 6280 `"Sandusky, OH"', add
label define city_lbl 6281 `"Sanford, FL"', add
label define city_lbl 6282 `"Sanford, ME"', add
label define city_lbl 6290 `"San Francisco, CA"', add
label define city_lbl 6300 `"San Juan, PR"', add
label define city_lbl 6310 `"San Jose, CA"', add
label define city_lbl 6311 `"San Leandro, CA"', add
label define city_lbl 6312 `"San Mateo, CA"', add
label define city_lbl 6320 `"Santa Barbara, CA"', add
label define city_lbl 6321 `"Santa Cruz, CA"', add
label define city_lbl 6322 `"Santa Fe, NM"', add
label define city_lbl 6326 `"Sandy Springs, GA"', add
label define city_lbl 6330 `"Santa Ana, CA"', add
label define city_lbl 6335 `"Santa Clara, CA"', add
label define city_lbl 6340 `"Santa Clarita, CA"', add
label define city_lbl 6350 `"Santa Rosa, CA"', add
label define city_lbl 6351 `"Sapulpa, OK"', add
label define city_lbl 6352 `"Saratoga Springs, NY"', add
label define city_lbl 6353 `"Saugus, MA"', add
label define city_lbl 6354 `"Sault Ste. Marie, MI"', add
label define city_lbl 6360 `"Santa Monica, CA"', add
label define city_lbl 6370 `"Savannah, GA"', add
label define city_lbl 6390 `"Schenectedy, NY"', add
label define city_lbl 6410 `"Scranton, PA"', add
label define city_lbl 6430 `"Seattle, WA"', add
label define city_lbl 6431 `"Sedalia, MO"', add
label define city_lbl 6432 `"Selma, AL"', add
label define city_lbl 6433 `"Seminole, OK"', add
label define city_lbl 6434 `"Shaker Heights, OH"', add
label define city_lbl 6435 `"Shamokin, PA"', add
label define city_lbl 6437 `"Sharpsville, PA"', add
label define city_lbl 6438 `"Shawnee, OK"', add
label define city_lbl 6440 `"Sharon, PA"', add
label define city_lbl 6450 `"Sheboygan, WI"', add
label define city_lbl 6451 `"Shelby, NC"', add
label define city_lbl 6452 `"Shelbyville, IN"', add
label define city_lbl 6453 `"Shelton, CT"', add
label define city_lbl 6470 `"Shenandoah Borough, PA"', add
label define city_lbl 6471 `"Sherman, TX"', add
label define city_lbl 6472 `"Shorewood, WI"', add
label define city_lbl 6490 `"Shreveport, LA"', add
label define city_lbl 6500 `"Simi Valley, CA"', add
label define city_lbl 6510 `"Sioux City, IA"', add
label define city_lbl 6530 `"Sioux Falls, SD"', add
label define city_lbl 6550 `"Smithfield, RI (1850)"', add
label define city_lbl 6570 `"Somerville, MA"', add
label define city_lbl 6590 `"South Bend, IN"', add
label define city_lbl 6591 `"South Bethlehem, PA"', add
label define city_lbl 6592 `"South Boise, ID"', add
label define city_lbl 6593 `"South Gate, CA"', add
label define city_lbl 6594 `"South Milwaukee, WI"', add
label define city_lbl 6595 `"South Norwalk, CT"', add
label define city_lbl 6610 `"South Omaha, NE"', add
label define city_lbl 6611 `"South Orange, NJ"', add
label define city_lbl 6612 `"South Pasadena, CA"', add
label define city_lbl 6613 `"South Pittsburgh, PA"', add
label define city_lbl 6614 `"South Portland, ME"', add
label define city_lbl 6615 `"South River, NJ"', add
label define city_lbl 6616 `"South St. Paul, MN"', add
label define city_lbl 6617 `"Southbridge, MA"', add
label define city_lbl 6620 `"Spartanburg, SC"', add
label define city_lbl 6630 `"Spokane, WA"', add
label define city_lbl 6640 `"Spring Valley, NV"', add
label define city_lbl 6650 `"Springfield, IL"', add
label define city_lbl 6670 `"Springfield, MA"', add
label define city_lbl 6690 `"Springfield, MO"', add
label define city_lbl 6691 `"St. Augustine, FL"', add
label define city_lbl 6692 `"St. Charles, MO"', add
label define city_lbl 6693 `"St. Cloud, MN"', add
label define city_lbl 6710 `"Springfield, OH"', add
label define city_lbl 6730 `"Stamford, CT"', add
label define city_lbl 6731 `"Statesville, NC"', add
label define city_lbl 6732 `"Staunton, VA"', add
label define city_lbl 6733 `"Steelton, PA"', add
label define city_lbl 6734 `"Sterling, IL"', add
label define city_lbl 6750 `"Sterling Heights, MI"', add
label define city_lbl 6770 `"Steubenville, OH"', add
label define city_lbl 6771 `"Stevens Point, WI"', add
label define city_lbl 6772 `"Stillwater, MN"', add
label define city_lbl 6789 `"Stowe, PA"', add
label define city_lbl 6790 `"Stockton, CA"', add
label define city_lbl 6791 `"Stoneham, MA"', add
label define city_lbl 6792 `"Stonington, CT"', add
label define city_lbl 6793 `"Stratford, CT"', add
label define city_lbl 6794 `"Streator, IL"', add
label define city_lbl 6795 `"Struthers, OH"', add
label define city_lbl 6796 `"Suffolk, VA"', add
label define city_lbl 6797 `"Summit, NJ"', add
label define city_lbl 6798 `"Sumter, SC"', add
label define city_lbl 6799 `"Sunbury, PA"', add
label define city_lbl 6810 `"Sunnyvale, CA"', add
label define city_lbl 6830 `"Superior, WI"', add
label define city_lbl 6831 `"Swampscott, MA"', add
label define city_lbl 6832 `"Sweetwater, TX"', add
label define city_lbl 6833 `"Swissvale, PA"', add
label define city_lbl 6850 `"Syracuse, NY"', add
label define city_lbl 6870 `"Tacoma, WA"', add
label define city_lbl 6871 `"Tallahassee, FL"', add
label define city_lbl 6872 `"Tamaqua, PA"', add
label define city_lbl 6890 `"Tampa, FL"', add
label define city_lbl 6910 `"Taunton, MA"', add
label define city_lbl 6911 `"Taylor, PA"', add
label define city_lbl 6912 `"Temple, TX"', add
label define city_lbl 6913 `"Teaneck, NJ"', add
label define city_lbl 6930 `"Tempe, AZ"', add
label define city_lbl 6950 `"Terre Haute, IN"', add
label define city_lbl 6951 `"Texarkana, TX/AR"', add
label define city_lbl 6952 `"Thomasville, GA"', add
label define city_lbl 6953 `"Thomasville, NC"', add
label define city_lbl 6954 `"Tiffin, OH"', add
label define city_lbl 6960 `"Thousand Oaks, CA"', add
label define city_lbl 6970 `"Toledo, OH"', add
label define city_lbl 6971 `"Tonawanda, NY"', add
label define city_lbl 6990 `"Topeka, KS"', add
label define city_lbl 6991 `"Torrington, CT"', add
label define city_lbl 6992 `"Traverse City, MI"', add
label define city_lbl 7000 `"Torrance, CA"', add
label define city_lbl 7010 `"Trenton, NJ"', add
label define city_lbl 7011 `"Trinidad, CO"', add
label define city_lbl 7030 `"Troy, NY"', add
label define city_lbl 7050 `"Tucson, AZ"', add
label define city_lbl 7070 `"Tulsa, OK"', add
label define city_lbl 7071 `"Turtle Creek, PA"', add
label define city_lbl 7072 `"Tuscaloosa, AL"', add
label define city_lbl 7073 `"Two Rivers, WI"', add
label define city_lbl 7074 `"Tyler, TX"', add
label define city_lbl 7079 `"Union, NJ"', add
label define city_lbl 7080 `"Union City, NJ"', add
label define city_lbl 7081 `"Uniontown, PA"', add
label define city_lbl 7082 `"University City, MO"', add
label define city_lbl 7083 `"Urbana, IL"', add
label define city_lbl 7084 `"Upper Darby, PA"', add
label define city_lbl 7090 `"Utica, NY"', add
label define city_lbl 7091 `"Valdosta, GA"', add
label define city_lbl 7093 `"Valley Stream, NY"', add
label define city_lbl 7100 `"Vancouver, WA"', add
label define city_lbl 7110 `"Vallejo, CA"', add
label define city_lbl 7111 `"Vandergrift, PA"', add
label define city_lbl 7112 `"Venice, CA"', add
label define city_lbl 7120 `"Vicksburg, MS"', add
label define city_lbl 7121 `"Vincennes, IN"', add
label define city_lbl 7122 `"Virginia, MN"', add
label define city_lbl 7123 `"Virginia City, NV"', add
label define city_lbl 7130 `"Virginia Beach, VA"', add
label define city_lbl 7140 `"Visalia, CA"', add
label define city_lbl 7150 `"Waco, TX"', add
label define city_lbl 7151 `"Wakefield, MA"', add
label define city_lbl 7152 `"Walla Walla, WA"', add
label define city_lbl 7153 `"Wallingford, CT"', add
label define city_lbl 7170 `"Waltham, MA"', add
label define city_lbl 7180 `"Warren, MI"', add
label define city_lbl 7190 `"Warren, OH"', add
label define city_lbl 7191 `"Warren, PA"', add
label define city_lbl 7210 `"Warwick Town, RI"', add
label define city_lbl 7230 `"Washington, DC"', add
label define city_lbl 7231 `"Georgetown, DC"', add
label define city_lbl 7241 `"Washington, PA"', add
label define city_lbl 7242 `"Washington, VA"', add
label define city_lbl 7250 `"Waterbury, CT"', add
label define city_lbl 7270 `"Waterloo, IA"', add
label define city_lbl 7290 `"Waterloo, NY"', add
label define city_lbl 7310 `"Watertown, NY"', add
label define city_lbl 7311 `"Watertown, WI"', add
label define city_lbl 7312 `"Watertown, SD"', add
label define city_lbl 7313 `"Watertown, MA"', add
label define city_lbl 7314 `"Waterville, ME"', add
label define city_lbl 7315 `"Watervliet, NY"', add
label define city_lbl 7316 `"Waukegan, IL"', add
label define city_lbl 7317 `"Waukesha, WI"', add
label define city_lbl 7318 `"Wausau, WI"', add
label define city_lbl 7319 `"Wauwatosa, WI"', add
label define city_lbl 7320 `"West Covina, CA"', add
label define city_lbl 7321 `"Waycross, GA"', add
label define city_lbl 7322 `"Waynesboro, PA"', add
label define city_lbl 7323 `"Webb City, MO"', add
label define city_lbl 7324 `"Webster Groves, MO"', add
label define city_lbl 7325 `"Webster, MA"', add
label define city_lbl 7326 `"Wellesley, MA"', add
label define city_lbl 7327 `"Wenatchee, WA"', add
label define city_lbl 7328 `"Weehawken, NJ"', add
label define city_lbl 7329 `"West Bay City, MI"', add
label define city_lbl 7330 `"West Hoboken, NJ"', add
label define city_lbl 7331 `"West Bethlehem, PA"', add
label define city_lbl 7332 `"West Chester, PA"', add
label define city_lbl 7333 `"West Frankfort, IL"', add
label define city_lbl 7334 `"West Hartford, CT"', add
label define city_lbl 7335 `"West Haven, CT"', add
label define city_lbl 7340 `"West Allis, WI"', add
label define city_lbl 7350 `"West New York, NJ"', add
label define city_lbl 7351 `"West Orange, NJ"', add
label define city_lbl 7352 `"West Palm Beach, FL"', add
label define city_lbl 7353 `"West Springfield, MA"', add
label define city_lbl 7360 `"West Valley City, UT"', add
label define city_lbl 7370 `"West Troy, NY"', add
label define city_lbl 7371 `"West Warwick, RI"', add
label define city_lbl 7372 `"Westbrook, ME"', add
label define city_lbl 7373 `"Westerly, RI"', add
label define city_lbl 7374 `"Westfield, MA"', add
label define city_lbl 7375 `"Westfield, NJ"', add
label define city_lbl 7376 `"Wewoka, OK"', add
label define city_lbl 7377 `"Weymouth, MA"', add
label define city_lbl 7390 `"Wheeling, WV"', add
label define city_lbl 7400 `"White Plains, NY"', add
label define city_lbl 7401 `"Whiting, IN"', add
label define city_lbl 7402 `"Whittier, CA"', add
label define city_lbl 7410 `"Wichita, KS"', add
label define city_lbl 7430 `"Wichita Falls, TX"', add
label define city_lbl 7450 `"Wilkes-Barre, PA"', add
label define city_lbl 7460 `"Wilkinsburg, PA"', add
label define city_lbl 7470 `"Williamsport, PA"', add
label define city_lbl 7471 `"Willimantic, CT"', add
label define city_lbl 7472 `"Wilmette, IL"', add
label define city_lbl 7490 `"Wilmington, DE"', add
label define city_lbl 7510 `"Wilmington, NC"', add
label define city_lbl 7511 `"Wilson, NC"', add
label define city_lbl 7512 `"Winchester, VA"', add
label define city_lbl 7513 `"Winchester, MA"', add
label define city_lbl 7514 `"Windham, CT"', add
label define city_lbl 7515 `"Winnetka, IL"', add
label define city_lbl 7516 `"Winona, MN"', add
label define city_lbl 7530 `"Winston-Salem, NC"', add
label define city_lbl 7531 `"Winthrop, MA"', add
label define city_lbl 7532 `"Woburn, MA"', add
label define city_lbl 7533 `"Woodlawn, PA"', add
label define city_lbl 7534 `"Woodmont, CT"', add
label define city_lbl 7535 `"Woodbridge, NJ"', add
label define city_lbl 7550 `"Woonsocket, RI"', add
label define city_lbl 7551 `"Wooster, OH"', add
label define city_lbl 7570 `"Worcester, MA"', add
label define city_lbl 7571 `"Wyandotte, MI"', add
label define city_lbl 7572 `"Xenia, OH"', add
label define city_lbl 7573 `"Yakima, WA"', add
label define city_lbl 7590 `"Yonkers, NY"', add
label define city_lbl 7610 `"York, PA"', add
label define city_lbl 7630 `"Youngstown, OH"', add
label define city_lbl 7631 `"Ypsilanti, MI"', add
label define city_lbl 7650 `"Zanesville, OH"', add
label values city city_lbl

label define cityerr_lbl 0 `"Not Applicable (no city identified)"'
label define cityerr_lbl 1 `"0%"', add
label define cityerr_lbl 2 `"0.1 to 0.9%"', add
label define cityerr_lbl 3 `"1.0 to 1.9%"', add
label define cityerr_lbl 4 `"2.0 to 4.9%"', add
label define cityerr_lbl 5 `"5.0 to 9.9%"', add
label values cityerr cityerr_lbl

label define homeland_lbl 1 `"PUMA does not include a Homeland area"'
label define homeland_lbl 2 `"PUMA includes a Homeland area"', add
label values homeland homeland_lbl

label define cntry_lbl 630 `"Puerto Rico"'
label define cntry_lbl 840 `"United States"', add
label values cntry cntry_lbl

label define gq_lbl 0 `"Vacant unit"'
label define gq_lbl 1 `"Households under 1970 definition"', add
label define gq_lbl 2 `"Additional households under 1990 definition"', add
label define gq_lbl 3 `"Group quarters--Institutions"', add
label define gq_lbl 4 `"Other group quarters"', add
label define gq_lbl 5 `"Additional households under 2000 definition"', add
label define gq_lbl 6 `"Fragment"', add
label values gq gq_lbl

label define relate_lbl 01 `"Head/Householder"'
label define relate_lbl 02 `"Spouse"', add
label define relate_lbl 03 `"Child"', add
label define relate_lbl 04 `"Child-in-law"', add
label define relate_lbl 05 `"Parent"', add
label define relate_lbl 06 `"Parent-in-Law"', add
label define relate_lbl 07 `"Sibling"', add
label define relate_lbl 08 `"Sibling-in-Law"', add
label define relate_lbl 09 `"Grandchild"', add
label define relate_lbl 10 `"Other relatives"', add
label define relate_lbl 11 `"Partner, friend, visitor"', add
label define relate_lbl 12 `"Other non-relatives"', add
label define relate_lbl 13 `"Institutional inmates"', add
label values relate relate_lbl

label define related_lbl 0101 `"Head/Householder"'
label define related_lbl 0201 `"Spouse"', add
label define related_lbl 0202 `"2nd/3rd Wife (Polygamous)"', add
label define related_lbl 0301 `"Child"', add
label define related_lbl 0302 `"Adopted Child"', add
label define related_lbl 0303 `"Stepchild"', add
label define related_lbl 0304 `"Adopted, n.s."', add
label define related_lbl 0401 `"Child-in-law"', add
label define related_lbl 0402 `"Step Child-in-law"', add
label define related_lbl 0501 `"Parent"', add
label define related_lbl 0502 `"Stepparent"', add
label define related_lbl 0601 `"Parent-in-Law"', add
label define related_lbl 0602 `"Stepparent-in-law"', add
label define related_lbl 0701 `"Sibling"', add
label define related_lbl 0702 `"Step/Half/Adopted Sibling"', add
label define related_lbl 0801 `"Sibling-in-Law"', add
label define related_lbl 0802 `"Step/Half Sibling-in-law"', add
label define related_lbl 0901 `"Grandchild"', add
label define related_lbl 0902 `"Adopted Grandchild"', add
label define related_lbl 0903 `"Step Grandchild"', add
label define related_lbl 0904 `"Grandchild-in-law"', add
label define related_lbl 1000 `"Other relatives:"', add
label define related_lbl 1001 `"Other Relatives"', add
label define related_lbl 1011 `"Grandparent"', add
label define related_lbl 1012 `"Step Grandparent"', add
label define related_lbl 1013 `"Grandparent-in-law"', add
label define related_lbl 1021 `"Aunt or Uncle"', add
label define related_lbl 1022 `"Aunt,Uncle-in-law"', add
label define related_lbl 1031 `"Nephew, Niece"', add
label define related_lbl 1032 `"Neph/Niece-in-law"', add
label define related_lbl 1033 `"Step/Adopted Nephew/Niece"', add
label define related_lbl 1034 `"Grand Niece/Nephew"', add
label define related_lbl 1041 `"Cousin"', add
label define related_lbl 1042 `"Cousin-in-law"', add
label define related_lbl 1051 `"Great Grandchild"', add
label define related_lbl 1061 `"Other relatives, nec"', add
label define related_lbl 1100 `"Partner, Friend, Visitor"', add
label define related_lbl 1110 `"Partner/friend"', add
label define related_lbl 1111 `"Friend"', add
label define related_lbl 1112 `"Partner"', add
label define related_lbl 1113 `"Partner/roommate"', add
label define related_lbl 1114 `"Unmarried Partner"', add
label define related_lbl 1115 `"Housemate/Roomate"', add
label define related_lbl 1120 `"Relative of partner"', add
label define related_lbl 1130 `"Concubine/Mistress"', add
label define related_lbl 1131 `"Visitor"', add
label define related_lbl 1132 `"Companion and family of companion"', add
label define related_lbl 1139 `"Allocated partner/friend/visitor"', add
label define related_lbl 1200 `"Other non-relatives"', add
label define related_lbl 1201 `"Roomers/boarders/lodgers"', add
label define related_lbl 1202 `"Boarders"', add
label define related_lbl 1203 `"Lodgers"', add
label define related_lbl 1204 `"Roomer"', add
label define related_lbl 1205 `"Tenant"', add
label define related_lbl 1206 `"Foster child"', add
label define related_lbl 1210 `"Employees:"', add
label define related_lbl 1211 `"Servant"', add
label define related_lbl 1212 `"Housekeeper"', add
label define related_lbl 1213 `"Maid"', add
label define related_lbl 1214 `"Cook"', add
label define related_lbl 1215 `"Nurse"', add
label define related_lbl 1216 `"Other probable domestic employee"', add
label define related_lbl 1217 `"Other employee"', add
label define related_lbl 1219 `"Relative of employee"', add
label define related_lbl 1221 `"Military"', add
label define related_lbl 1222 `"Students"', add
label define related_lbl 1223 `"Members of religious orders"', add
label define related_lbl 1230 `"Other non-relatives"', add
label define related_lbl 1239 `"Allocated other non-relative"', add
label define related_lbl 1240 `"Roomers/boarders/lodgers and foster children"', add
label define related_lbl 1241 `"Roomers/boarders/lodgers"', add
label define related_lbl 1242 `"Foster children"', add
label define related_lbl 1250 `"Employees"', add
label define related_lbl 1251 `"Domestic employees"', add
label define related_lbl 1252 `"Non-domestic employees"', add
label define related_lbl 1253 `"Relative of employee"', add
label define related_lbl 1260 `"Other non-relatives (1990 includes employees)"', add
label define related_lbl 1270 `"Non-inmate 1990"', add
label define related_lbl 1281 `"Head of group quarters"', add
label define related_lbl 1282 `"Employees of group quarters"', add
label define related_lbl 1283 `"Relative of head, staff, or employee group quarters"', add
label define related_lbl 1284 `"Other non-inmate 1940-1959"', add
label define related_lbl 1291 `"Military"', add
label define related_lbl 1292 `"College dormitories"', add
label define related_lbl 1293 `"Residents of rooming houses"', add
label define related_lbl 1294 `"Other non-inmate 1980 (includes employees and non-inmates in"', add
label define related_lbl 1295 `"Other non-inmates 1960-1970 (includes employees)"', add
label define related_lbl 1296 `"Non-inmates in institutions"', add
label define related_lbl 1301 `"Institutional inmates"', add
label define related_lbl 9996 `"Unclassifiable"', add
label define related_lbl 9997 `"Unknown"', add
label define related_lbl 9998 `"Illegible"', add
label define related_lbl 9999 `"Missing"', add
label values related related_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"Missing/blank"', add
label values sex sex_lbl

label define age_lbl 000 `"Less than 1 year old"'
label define age_lbl 001 `"1"', add
label define age_lbl 002 `"2"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_lbl 101 `"101"', add
label define age_lbl 102 `"102"', add
label define age_lbl 103 `"103"', add
label define age_lbl 104 `"104"', add
label define age_lbl 105 `"105"', add
label define age_lbl 106 `"106"', add
label define age_lbl 107 `"107"', add
label define age_lbl 108 `"108"', add
label define age_lbl 109 `"109"', add
label define age_lbl 110 `"110"', add
label define age_lbl 111 `"111"', add
label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_lbl 113 `"113"', add
label define age_lbl 114 `"114"', add
label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_lbl 116 `"116"', add
label define age_lbl 117 `"117"', add
label define age_lbl 118 `"118"', add
label define age_lbl 119 `"119"', add
label define age_lbl 120 `"120"', add
label define age_lbl 121 `"121"', add
label define age_lbl 122 `"122"', add
label define age_lbl 123 `"123"', add
label define age_lbl 124 `"124"', add
label define age_lbl 125 `"125"', add
label define age_lbl 126 `"126"', add
label define age_lbl 127 `"127"', add
label define age_lbl 128 `"128"', add
label define age_lbl 129 `"129"', add
label define age_lbl 130 `"130"', add
label define age_lbl 131 `"131"', add
label define age_lbl 132 `"132"', add
label define age_lbl 133 `"133"', add
label define age_lbl 134 `"134"', add
label define age_lbl 135 `"135"', add
label define age_lbl 140 `"140"', add
label define age_lbl 999 `"Missing"', add
label values age age_lbl

label define birthqtr_lbl 0 `"N/A"'
label define birthqtr_lbl 1 `"Jan-Feb-March"', add
label define birthqtr_lbl 2 `"April-May-June"', add
label define birthqtr_lbl 3 `"July-Aug-Sept"', add
label define birthqtr_lbl 4 `"Oct-Nov-Dec"', add
label define birthqtr_lbl 9 `"Missing"', add
label values birthqtr birthqtr_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label define marst_lbl 9 `"Blank, missing"', add
label values marst marst_lbl

label define marrno_lbl 0 `"Not Applicable"'
label define marrno_lbl 1 `"Married once"', add
label define marrno_lbl 2 `"Married twice (or more)"', add
label define marrno_lbl 3 `"Married thrice (or more)"', add
label define marrno_lbl 4 `"Four times"', add
label define marrno_lbl 5 `"Five times"', add
label define marrno_lbl 6 `"Six times"', add
label define marrno_lbl 7 `"Unknown"', add
label define marrno_lbl 8 `"Illegible"', add
label define marrno_lbl 9 `"Missing"', add
label values marrno marrno_lbl

label define marrinyr_lbl 0 `"N/A"'
label define marrinyr_lbl 1 `"Blank (No)"', add
label define marrinyr_lbl 2 `"Yes"', add
label values marrinyr marrinyr_lbl

label define yrmarr_lbl 0000 `"N/A"'
label values yrmarr yrmarr_lbl

label define divinyr_lbl 0 `"N/A"'
label define divinyr_lbl 1 `"Blank (No)"', add
label define divinyr_lbl 2 `"Yes"', add
label define divinyr_lbl 8 `"Suppressed"', add
label values divinyr divinyr_lbl

label define widinyr_lbl 0 `"N/A"'
label define widinyr_lbl 1 `"Blank (No)"', add
label define widinyr_lbl 2 `"Yes"', add
label values widinyr widinyr_lbl

label define fertyr_lbl 0 `"N/A"'
label define fertyr_lbl 1 `"No"', add
label define fertyr_lbl 2 `"Yes"', add
label define fertyr_lbl 8 `"Suppressed"', add
label values fertyr fertyr_lbl

label define race_lbl 1 `"White"'
label define race_lbl 2 `"Black/African American"', add
label define race_lbl 3 `"American Indian or Alaska Native"', add
label define race_lbl 4 `"Chinese"', add
label define race_lbl 5 `"Japanese"', add
label define race_lbl 6 `"Other Asian or Pacific Islander"', add
label define race_lbl 7 `"Other race, nec"', add
label define race_lbl 8 `"Two major races"', add
label define race_lbl 9 `"Three or more major races"', add
label values race race_lbl

label define raced_lbl 100 `"White"'
label define raced_lbl 110 `"Spanish write_in"', add
label define raced_lbl 120 `"Blank (white) (1850)"', add
label define raced_lbl 130 `"Portuguese"', add
label define raced_lbl 140 `"Mexican (1930)"', add
label define raced_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
label define raced_lbl 200 `"Black/African American"', add
label define raced_lbl 210 `"Mulatto"', add
label define raced_lbl 300 `"American Indian/Alaska Native"', add
label define raced_lbl 302 `"Apache"', add
label define raced_lbl 303 `"Blackfoot"', add
label define raced_lbl 304 `"Cherokee"', add
label define raced_lbl 305 `"Cheyenne"', add
label define raced_lbl 306 `"Chickasaw"', add
label define raced_lbl 307 `"Chippewa"', add
label define raced_lbl 308 `"Choctaw"', add
label define raced_lbl 309 `"Comanche"', add
label define raced_lbl 310 `"Creek"', add
label define raced_lbl 311 `"Crow"', add
label define raced_lbl 312 `"Iroquois"', add
label define raced_lbl 313 `"Kiowa"', add
label define raced_lbl 314 `"Lumbee"', add
label define raced_lbl 315 `"Navajo"', add
label define raced_lbl 316 `"Osage"', add
label define raced_lbl 317 `"Paiute"', add
label define raced_lbl 318 `"Pima"', add
label define raced_lbl 319 `"Potawatomi"', add
label define raced_lbl 320 `"Pueblo"', add
label define raced_lbl 321 `"Seminole"', add
label define raced_lbl 322 `"Shoshone"', add
label define raced_lbl 323 `"Sioux"', add
label define raced_lbl 324 `"Tlingit (Tlingit_Haida, 2000/ACS)"', add
label define raced_lbl 325 `"Tohono O Odham"', add
label define raced_lbl 326 `"All other tribes (1990)"', add
label define raced_lbl 328 `"Hopi"', add
label define raced_lbl 329 `"Central American Indian"', add
label define raced_lbl 330 `"Spanish American Indian"', add
label define raced_lbl 340 `"Aztec"', add
label define raced_lbl 341 `"Inca"', add
label define raced_lbl 342 `"Maya"', add
label define raced_lbl 343 `"Mixtec"', add
label define raced_lbl 344 `"Taino"', add
label define raced_lbl 345 `"Tarasco (Purepecha)"', add
label define raced_lbl 350 `"Delaware"', add
label define raced_lbl 351 `"Latin American Indian"', add
label define raced_lbl 352 `"Puget Sound Salish"', add
label define raced_lbl 353 `"Yakama"', add
label define raced_lbl 354 `"Yaqui"', add
label define raced_lbl 355 `"Colville"', add
label define raced_lbl 356 `"Houma"', add
label define raced_lbl 357 `"Menominee"', add
label define raced_lbl 358 `"Yuman"', add
label define raced_lbl 359 `"South American Indian"', add
label define raced_lbl 360 `"Mexican American Indian"', add
label define raced_lbl 361 `"Other Amer. Indian tribe (2000,ACS)"', add
label define raced_lbl 362 `"2+ Amer. Indian tribes (2000,ACS)"', add
label define raced_lbl 363 `"American Indian alone, not specified"', add
label define raced_lbl 364 `"All other Latin American Indian alone"', add
label define raced_lbl 370 `"Alaskan Athabaskan"', add
label define raced_lbl 371 `"Aleut"', add
label define raced_lbl 372 `"Eskimo"', add
label define raced_lbl 373 `"Alaskan mixed"', add
label define raced_lbl 374 `"Inupiat"', add
label define raced_lbl 375 `"Yup'ik"', add
label define raced_lbl 379 `"Other Alaska Native tribe(s) (2000,ACS)"', add
label define raced_lbl 380 `"Alaska Native alone, not specified"', add
label define raced_lbl 381 `"Alaska Native tribes and villages alone"', add
label define raced_lbl 398 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
label define raced_lbl 399 `"Tribe not specified"', add
label define raced_lbl 400 `"Chinese"', add
label define raced_lbl 410 `"Taiwanese"', add
label define raced_lbl 420 `"Chinese and Taiwanese"', add
label define raced_lbl 500 `"Japanese"', add
label define raced_lbl 600 `"Filipino"', add
label define raced_lbl 610 `"Asian Indian (Hindu 1920_1940)"', add
label define raced_lbl 620 `"Korean"', add
label define raced_lbl 630 `"Hawaiian"', add
label define raced_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
label define raced_lbl 632 `"Hawaiian and European (1900,1920)"', add
label define raced_lbl 634 `"Hawaiian mixed"', add
label define raced_lbl 640 `"Vietnamese"', add
label define raced_lbl 641 `"Bhutanese"', add
label define raced_lbl 642 `"Mongolian"', add
label define raced_lbl 643 `"Nepalese"', add
label define raced_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
label define raced_lbl 651 `"Asian only (CPS)"', add
label define raced_lbl 652 `"Pacific Islander only (CPS)"', add
label define raced_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
label define raced_lbl 656 `"Mien"', add
label define raced_lbl 657 `"Sikh"', add
label define raced_lbl 658 `"Kazakh"', add
label define raced_lbl 659 `"Uzbek"', add
label define raced_lbl 660 `"Cambodian"', add
label define raced_lbl 661 `"Hmong"', add
label define raced_lbl 662 `"Laotian"', add
label define raced_lbl 663 `"Thai"', add
label define raced_lbl 664 `"Bangladeshi"', add
label define raced_lbl 665 `"Burmese"', add
label define raced_lbl 666 `"Indonesian"', add
label define raced_lbl 667 `"Malaysian"', add
label define raced_lbl 668 `"Okinawan"', add
label define raced_lbl 669 `"Pakistani"', add
label define raced_lbl 670 `"Sri Lankan"', add
label define raced_lbl 671 `"Other Asian, n.e.c."', add
label define raced_lbl 672 `"Asian, not specified"', add
label define raced_lbl 673 `"Chinese and Japanese"', add
label define raced_lbl 674 `"Chinese and Filipino"', add
label define raced_lbl 675 `"Chinese and Vietnamese"', add
label define raced_lbl 676 `"Chinese and Asian write_in"', add
label define raced_lbl 677 `"Japanese and Filipino"', add
label define raced_lbl 678 `"Asian Indian and Asian write_in"', add
label define raced_lbl 679 `"Other Asian race combinations"', add
label define raced_lbl 680 `"Samoan"', add
label define raced_lbl 681 `"Tahitian"', add
label define raced_lbl 682 `"Tongan"', add
label define raced_lbl 683 `"Other Polynesian (1990)"', add
label define raced_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
label define raced_lbl 685 `"Chamorro"', add
label define raced_lbl 686 `"Northern Mariana Islander"', add
label define raced_lbl 687 `"Palauan"', add
label define raced_lbl 688 `"Other Micronesian (1990)"', add
label define raced_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
label define raced_lbl 690 `"Chuukese"', add
label define raced_lbl 691 `"Guamanian"', add
label define raced_lbl 692 `"Marshallese"', add
label define raced_lbl 695 `"Fijian"', add
label define raced_lbl 696 `"Other Melanesian (1990)"', add
label define raced_lbl 697 `"1+ other Melanesian races (2000,ACS)"', add
label define raced_lbl 698 `"2+ PI races from 2+ PI regions"', add
label define raced_lbl 699 `"Pacific Islander, n.s."', add
label define raced_lbl 700 `"Other race, n.e.c."', add
label define raced_lbl 801 `"White and Black"', add
label define raced_lbl 802 `"White and AIAN"', add
label define raced_lbl 810 `"White and Asian"', add
label define raced_lbl 811 `"White and Chinese"', add
label define raced_lbl 812 `"White and Japanese"', add
label define raced_lbl 813 `"White and Filipino"', add
label define raced_lbl 814 `"White and Asian Indian"', add
label define raced_lbl 815 `"White and Korean"', add
label define raced_lbl 816 `"White and Vietnamese"', add
label define raced_lbl 817 `"White and Asian write_in"', add
label define raced_lbl 818 `"White and other Asian race(s)"', add
label define raced_lbl 819 `"White and two or more Asian groups"', add
label define raced_lbl 820 `"White and PI"', add
label define raced_lbl 821 `"White and Native Hawaiian"', add
label define raced_lbl 822 `"White and Samoan"', add
label define raced_lbl 823 `"White and Chamorro"', add
label define raced_lbl 824 `"White and PI write_in"', add
label define raced_lbl 825 `"White and other PI race(s)"', add
label define raced_lbl 826 `"White and other race write_in"', add
label define raced_lbl 827 `"White and other race, n.e.c."', add
label define raced_lbl 830 `"Black and AIAN"', add
label define raced_lbl 831 `"Black and Asian"', add
label define raced_lbl 832 `"Black and Chinese"', add
label define raced_lbl 833 `"Black and Japanese"', add
label define raced_lbl 834 `"Black and Filipino"', add
label define raced_lbl 835 `"Black and Asian Indian"', add
label define raced_lbl 836 `"Black and Korean"', add
label define raced_lbl 837 `"Black and Asian write_in"', add
label define raced_lbl 838 `"Black and other Asian race(s)"', add
label define raced_lbl 840 `"Black and PI"', add
label define raced_lbl 841 `"Black and PI write_in"', add
label define raced_lbl 842 `"Black and other PI race(s)"', add
label define raced_lbl 845 `"Black and other race write_in"', add
label define raced_lbl 850 `"AIAN and Asian"', add
label define raced_lbl 851 `"AIAN and Filipino (2000 1%)"', add
label define raced_lbl 852 `"AIAN and Asian Indian"', add
label define raced_lbl 853 `"AIAN and Asian write_in (2000 1%)"', add
label define raced_lbl 854 `"AIAN and other Asian race(s)"', add
label define raced_lbl 855 `"AIAN and PI"', add
label define raced_lbl 856 `"AIAN and other race write_in"', add
label define raced_lbl 860 `"Asian and PI"', add
label define raced_lbl 861 `"Chinese and Hawaiian"', add
label define raced_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
label define raced_lbl 864 `"Filipino and Hawaiian"', add
label define raced_lbl 865 `"Filipino and PI write_in"', add
label define raced_lbl 866 `"Asian Indian and PI write_in (2000 1%)"', add
label define raced_lbl 867 `"Asian write_in and PI write_in"', add
label define raced_lbl 868 `"Other Asian race(s) and PI race(s)"', add
label define raced_lbl 869 `"Japanese and Korean (ACS)"', add
label define raced_lbl 880 `"Asian and other race write_in"', add
label define raced_lbl 881 `"Chinese and other race write_in"', add
label define raced_lbl 882 `"Japanese and other race write_in"', add
label define raced_lbl 883 `"Filipino and other race write_in"', add
label define raced_lbl 884 `"Asian Indian and other race write_in"', add
label define raced_lbl 885 `"Asian write_in and other race write_in"', add
label define raced_lbl 886 `"Other Asian race(s) and other race write_in"', add
label define raced_lbl 887 `"Chinese and Korean"', add
label define raced_lbl 890 `"PI and other race write_in:"', add
label define raced_lbl 891 `"PI write_in and other race write_in"', add
label define raced_lbl 892 `"Other PI race(s) and other race write_in"', add
label define raced_lbl 893 `"Native Hawaiian or PI other race(s)"', add
label define raced_lbl 899 `"API and other race write_in"', add
label define raced_lbl 901 `"White, Black, AIAN"', add
label define raced_lbl 902 `"White, Black, Asian"', add
label define raced_lbl 903 `"White, Black, PI"', add
label define raced_lbl 904 `"White, Black, other race write_in"', add
label define raced_lbl 905 `"White, AIAN, Asian"', add
label define raced_lbl 906 `"White, AIAN, PI"', add
label define raced_lbl 907 `"White, AIAN, other race write_in"', add
label define raced_lbl 910 `"White, Asian, PI"', add
label define raced_lbl 911 `"White, Chinese, Hawaiian"', add
label define raced_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
label define raced_lbl 914 `"White, Filipino, Hawaiian"', add
label define raced_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
label define raced_lbl 916 `"White, AIAN and Filipino"', add
label define raced_lbl 917 `"White, Black, and Filipino"', add
label define raced_lbl 920 `"White, Asian, other race write_in"', add
label define raced_lbl 921 `"White, Filipino, other race write_in (2000 1%)"', add
label define raced_lbl 922 `"White, Asian write_in, other race write_in (2000 1%)"', add
label define raced_lbl 923 `"Other White, Asian race(s), other race write_in (2000 1%)"', add
label define raced_lbl 925 `"White, PI, other race write_in"', add
label define raced_lbl 926 `"White and Japanese and Native Hawaiian and Pacific Islander"', add
label define raced_lbl 927 `"White and Asian and Native Hawaiian and Pacific Islander"', add
label define raced_lbl 930 `"Black, AIAN, Asian"', add
label define raced_lbl 931 `"Black, AIAN, PI"', add
label define raced_lbl 932 `"Black, AIAN, other race write_in"', add
label define raced_lbl 933 `"Black, Asian, PI"', add
label define raced_lbl 934 `"Black, Asian, other race write_in"', add
label define raced_lbl 935 `"Black, PI, other race write_in"', add
label define raced_lbl 936 `"Black and Native Hawaiian and Other Pacific Islander"', add
label define raced_lbl 940 `"AIAN, Asian, PI"', add
label define raced_lbl 941 `"AIAN, Asian, other race write_in"', add
label define raced_lbl 942 `"AIAN, PI, other race write_in"', add
label define raced_lbl 943 `"Asian, PI, other race write_in"', add
label define raced_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
label define raced_lbl 949 `"2 or 3 races (CPS)"', add
label define raced_lbl 950 `"White, Black, AIAN, Asian"', add
label define raced_lbl 951 `"White, Black, AIAN, PI"', add
label define raced_lbl 952 `"White, Black, AIAN, other race write_in"', add
label define raced_lbl 953 `"White, Black, Asian, PI"', add
label define raced_lbl 954 `"White, Black, Asian, other race write_in"', add
label define raced_lbl 955 `"White, Black, PI, other race write_in"', add
label define raced_lbl 960 `"White, AIAN, Asian, PI"', add
label define raced_lbl 961 `"White, AIAN, Asian, other race write_in"', add
label define raced_lbl 962 `"White, AIAN, PI, other race write_in"', add
label define raced_lbl 963 `"White, Asian, PI, other race write_in"', add
label define raced_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
label define raced_lbl 970 `"Black, AIAN, Asian, PI"', add
label define raced_lbl 971 `"Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 972 `"Black, AIAN, PI, other race write_in"', add
label define raced_lbl 973 `"Black, Asian, PI, other race write_in"', add
label define raced_lbl 974 `"AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write_in"', add
label define raced_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
label define raced_lbl 980 `"White, Black, AIAN, Asian, PI"', add
label define raced_lbl 981 `"White, Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 982 `"White, Black, AIAN, PI, other race write_in"', add
label define raced_lbl 983 `"White, Black, Asian, PI, other race write_in"', add
label define raced_lbl 984 `"White, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 985 `"Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write_in"', add
label define raced_lbl 989 `"4 or 5 races (CPS)"', add
label define raced_lbl 990 `"White, Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
label define raced_lbl 996 `"2+ races, n.e.c. (CPS)"', add
label define raced_lbl 997 `"Unknown"', add
label values raced raced_lbl

label define hispan_lbl 0 `"Not Hispanic"'
label define hispan_lbl 1 `"Mexican"', add
label define hispan_lbl 2 `"Puerto Rican"', add
label define hispan_lbl 3 `"Cuban"', add
label define hispan_lbl 4 `"Other"', add
label define hispan_lbl 9 `"Not Reported"', add
label values hispan hispan_lbl

label define hispand_lbl 000 `"Not Hispanic"'
label define hispand_lbl 100 `"Mexican"', add
label define hispand_lbl 102 `"Mexican American"', add
label define hispand_lbl 103 `"Mexicano/Mexicana"', add
label define hispand_lbl 104 `"Chicano/Chicana"', add
label define hispand_lbl 105 `"La Raza"', add
label define hispand_lbl 106 `"Mexican American Indian"', add
label define hispand_lbl 107 `"Mexico"', add
label define hispand_lbl 200 `"Puerto Rican"', add
label define hispand_lbl 300 `"Cuban"', add
label define hispand_lbl 401 `"Central American Indian"', add
label define hispand_lbl 402 `"Canal Zone"', add
label define hispand_lbl 411 `"Costa Rican"', add
label define hispand_lbl 412 `"Guatemalan"', add
label define hispand_lbl 413 `"Honduran"', add
label define hispand_lbl 414 `"Nicaraguan"', add
label define hispand_lbl 415 `"Panamanian"', add
label define hispand_lbl 416 `"Salvadoran"', add
label define hispand_lbl 417 `"Central American, n.e.c."', add
label define hispand_lbl 420 `"Argentinean"', add
label define hispand_lbl 421 `"Bolivian"', add
label define hispand_lbl 422 `"Chilean"', add
label define hispand_lbl 423 `"Colombian"', add
label define hispand_lbl 424 `"Ecuadorian"', add
label define hispand_lbl 425 `"Paraguayan"', add
label define hispand_lbl 426 `"Peruvian"', add
label define hispand_lbl 427 `"Uruguayan"', add
label define hispand_lbl 428 `"Venezuelan"', add
label define hispand_lbl 429 `"South American Indian"', add
label define hispand_lbl 430 `"Criollo"', add
label define hispand_lbl 431 `"South American, n.e.c."', add
label define hispand_lbl 450 `"Spaniard"', add
label define hispand_lbl 451 `"Andalusian"', add
label define hispand_lbl 452 `"Asturian"', add
label define hispand_lbl 453 `"Castillian"', add
label define hispand_lbl 454 `"Catalonian"', add
label define hispand_lbl 455 `"Balearic Islander"', add
label define hispand_lbl 456 `"Gallego"', add
label define hispand_lbl 457 `"Valencian"', add
label define hispand_lbl 458 `"Canarian"', add
label define hispand_lbl 459 `"Spanish Basque"', add
label define hispand_lbl 460 `"Dominican"', add
label define hispand_lbl 465 `"Latin American"', add
label define hispand_lbl 470 `"Hispanic"', add
label define hispand_lbl 480 `"Spanish"', add
label define hispand_lbl 490 `"Californio"', add
label define hispand_lbl 491 `"Tejano"', add
label define hispand_lbl 492 `"Nuevo Mexicano"', add
label define hispand_lbl 493 `"Spanish American"', add
label define hispand_lbl 494 `"Spanish American Indian"', add
label define hispand_lbl 495 `"Meso American Indian"', add
label define hispand_lbl 496 `"Mestizo"', add
label define hispand_lbl 498 `"Other, n.s."', add
label define hispand_lbl 499 `"Other, n.e.c."', add
label define hispand_lbl 900 `"Not Reported"', add
label values hispand hispand_lbl

label define bpl_lbl 001 `"Alabama"'
label define bpl_lbl 002 `"Alaska"', add
label define bpl_lbl 004 `"Arizona"', add
label define bpl_lbl 005 `"Arkansas"', add
label define bpl_lbl 006 `"California"', add
label define bpl_lbl 008 `"Colorado"', add
label define bpl_lbl 009 `"Connecticut"', add
label define bpl_lbl 010 `"Delaware"', add
label define bpl_lbl 011 `"District of Columbia"', add
label define bpl_lbl 012 `"Florida"', add
label define bpl_lbl 013 `"Georgia"', add
label define bpl_lbl 015 `"Hawaii"', add
label define bpl_lbl 016 `"Idaho"', add
label define bpl_lbl 017 `"Illinois"', add
label define bpl_lbl 018 `"Indiana"', add
label define bpl_lbl 019 `"Iowa"', add
label define bpl_lbl 020 `"Kansas"', add
label define bpl_lbl 021 `"Kentucky"', add
label define bpl_lbl 022 `"Louisiana"', add
label define bpl_lbl 023 `"Maine"', add
label define bpl_lbl 024 `"Maryland"', add
label define bpl_lbl 025 `"Massachusetts"', add
label define bpl_lbl 026 `"Michigan"', add
label define bpl_lbl 027 `"Minnesota"', add
label define bpl_lbl 028 `"Mississippi"', add
label define bpl_lbl 029 `"Missouri"', add
label define bpl_lbl 030 `"Montana"', add
label define bpl_lbl 031 `"Nebraska"', add
label define bpl_lbl 032 `"Nevada"', add
label define bpl_lbl 033 `"New Hampshire"', add
label define bpl_lbl 034 `"New Jersey"', add
label define bpl_lbl 035 `"New Mexico"', add
label define bpl_lbl 036 `"New York"', add
label define bpl_lbl 037 `"North Carolina"', add
label define bpl_lbl 038 `"North Dakota"', add
label define bpl_lbl 039 `"Ohio"', add
label define bpl_lbl 040 `"Oklahoma"', add
label define bpl_lbl 041 `"Oregon"', add
label define bpl_lbl 042 `"Pennsylvania"', add
label define bpl_lbl 044 `"Rhode Island"', add
label define bpl_lbl 045 `"South Carolina"', add
label define bpl_lbl 046 `"South Dakota"', add
label define bpl_lbl 047 `"Tennessee"', add
label define bpl_lbl 048 `"Texas"', add
label define bpl_lbl 049 `"Utah"', add
label define bpl_lbl 050 `"Vermont"', add
label define bpl_lbl 051 `"Virginia"', add
label define bpl_lbl 053 `"Washington"', add
label define bpl_lbl 054 `"West Virginia"', add
label define bpl_lbl 055 `"Wisconsin"', add
label define bpl_lbl 056 `"Wyoming"', add
label define bpl_lbl 090 `"Native American"', add
label define bpl_lbl 099 `"United States, ns"', add
label define bpl_lbl 100 `"American Samoa"', add
label define bpl_lbl 105 `"Guam"', add
label define bpl_lbl 110 `"Puerto Rico"', add
label define bpl_lbl 115 `"U.S. Virgin Islands"', add
label define bpl_lbl 120 `"Other US Possessions"', add
label define bpl_lbl 150 `"Canada"', add
label define bpl_lbl 155 `"St. Pierre and Miquelon"', add
label define bpl_lbl 160 `"Atlantic Islands"', add
label define bpl_lbl 199 `"North America, ns"', add
label define bpl_lbl 200 `"Mexico"', add
label define bpl_lbl 210 `"Central America"', add
label define bpl_lbl 250 `"Cuba"', add
label define bpl_lbl 260 `"West Indies"', add
label define bpl_lbl 299 `"Americas, n.s."', add
label define bpl_lbl 300 `"SOUTH AMERICA"', add
label define bpl_lbl 400 `"Denmark"', add
label define bpl_lbl 401 `"Finland"', add
label define bpl_lbl 402 `"Iceland"', add
label define bpl_lbl 403 `"Lapland, n.s."', add
label define bpl_lbl 404 `"Norway"', add
label define bpl_lbl 405 `"Sweden"', add
label define bpl_lbl 410 `"England"', add
label define bpl_lbl 411 `"Scotland"', add
label define bpl_lbl 412 `"Wales"', add
label define bpl_lbl 413 `"United Kingdom, ns"', add
label define bpl_lbl 414 `"Ireland"', add
label define bpl_lbl 419 `"Northern Europe, ns"', add
label define bpl_lbl 420 `"Belgium"', add
label define bpl_lbl 421 `"France"', add
label define bpl_lbl 422 `"Liechtenstein"', add
label define bpl_lbl 423 `"Luxembourg"', add
label define bpl_lbl 424 `"Monaco"', add
label define bpl_lbl 425 `"Netherlands"', add
label define bpl_lbl 426 `"Switzerland"', add
label define bpl_lbl 429 `"Western Europe, ns"', add
label define bpl_lbl 430 `"Albania"', add
label define bpl_lbl 431 `"Andorra"', add
label define bpl_lbl 432 `"Gibraltar"', add
label define bpl_lbl 433 `"Greece"', add
label define bpl_lbl 434 `"Italy"', add
label define bpl_lbl 435 `"Malta"', add
label define bpl_lbl 436 `"Portugal"', add
label define bpl_lbl 437 `"San Marino"', add
label define bpl_lbl 438 `"Spain"', add
label define bpl_lbl 439 `"Vatican City"', add
label define bpl_lbl 440 `"Southern Europe, ns"', add
label define bpl_lbl 450 `"Austria"', add
label define bpl_lbl 451 `"Bulgaria"', add
label define bpl_lbl 452 `"Czechoslovakia"', add
label define bpl_lbl 453 `"Germany"', add
label define bpl_lbl 454 `"Hungary"', add
label define bpl_lbl 455 `"Poland"', add
label define bpl_lbl 456 `"Romania"', add
label define bpl_lbl 457 `"Yugoslavia"', add
label define bpl_lbl 458 `"Central Europe, ns"', add
label define bpl_lbl 459 `"Eastern Europe, ns"', add
label define bpl_lbl 460 `"Estonia"', add
label define bpl_lbl 461 `"Latvia"', add
label define bpl_lbl 462 `"Lithuania"', add
label define bpl_lbl 463 `"Baltic States, ns"', add
label define bpl_lbl 465 `"Other USSR/Russia"', add
label define bpl_lbl 499 `"Europe, ns"', add
label define bpl_lbl 500 `"China"', add
label define bpl_lbl 501 `"Japan"', add
label define bpl_lbl 502 `"Korea"', add
label define bpl_lbl 509 `"East Asia, ns"', add
label define bpl_lbl 510 `"Brunei"', add
label define bpl_lbl 511 `"Cambodia (Kampuchea)"', add
label define bpl_lbl 512 `"Indonesia"', add
label define bpl_lbl 513 `"Laos"', add
label define bpl_lbl 514 `"Malaysia"', add
label define bpl_lbl 515 `"Philippines"', add
label define bpl_lbl 516 `"Singapore"', add
label define bpl_lbl 517 `"Thailand"', add
label define bpl_lbl 518 `"Vietnam"', add
label define bpl_lbl 519 `"Southeast Asia, ns"', add
label define bpl_lbl 520 `"Afghanistan"', add
label define bpl_lbl 521 `"India"', add
label define bpl_lbl 522 `"Iran"', add
label define bpl_lbl 523 `"Maldives"', add
label define bpl_lbl 524 `"Nepal"', add
label define bpl_lbl 530 `"Bahrain"', add
label define bpl_lbl 531 `"Cyprus"', add
label define bpl_lbl 532 `"Iraq"', add
label define bpl_lbl 533 `"Iraq/Saudi Arabia"', add
label define bpl_lbl 534 `"Israel/Palestine"', add
label define bpl_lbl 535 `"Jordan"', add
label define bpl_lbl 536 `"Kuwait"', add
label define bpl_lbl 537 `"Lebanon"', add
label define bpl_lbl 538 `"Oman"', add
label define bpl_lbl 539 `"Qatar"', add
label define bpl_lbl 540 `"Saudi Arabia"', add
label define bpl_lbl 541 `"Syria"', add
label define bpl_lbl 542 `"Turkey"', add
label define bpl_lbl 543 `"United Arab Emirates"', add
label define bpl_lbl 544 `"Yemen Arab Republic (North)"', add
label define bpl_lbl 545 `"Yemen, PDR (South)"', add
label define bpl_lbl 546 `"Persian Gulf States, n.s."', add
label define bpl_lbl 547 `"Middle East, ns"', add
label define bpl_lbl 548 `"Southwest Asia, nec/ns"', add
label define bpl_lbl 549 `"Asia Minor, ns"', add
label define bpl_lbl 550 `"South Asia, nec"', add
label define bpl_lbl 599 `"Asia, nec/ns"', add
label define bpl_lbl 600 `"AFRICA"', add
label define bpl_lbl 700 `"Australia and New Zealand"', add
label define bpl_lbl 710 `"Pacific Islands"', add
label define bpl_lbl 800 `"Antarctica, ns/nec"', add
label define bpl_lbl 900 `"Abroad (unknown) or at sea"', add
label define bpl_lbl 950 `"Other n.e.c."', add
label define bpl_lbl 997 `"Unknown"', add
label define bpl_lbl 999 `"Missing/blank"', add
label values bpl bpl_lbl

label define bpld_lbl 00100 `"Alabama"'
label define bpld_lbl 00200 `"Alaska"', add
label define bpld_lbl 00400 `"Arizona"', add
label define bpld_lbl 00500 `"Arkansas"', add
label define bpld_lbl 00600 `"California"', add
label define bpld_lbl 00800 `"Colorado"', add
label define bpld_lbl 00810 `"Colorado Territory"', add
label define bpld_lbl 00900 `"Connecticut"', add
label define bpld_lbl 01000 `"Delaware"', add
label define bpld_lbl 01100 `"District of Columbia"', add
label define bpld_lbl 01200 `"Florida"', add
label define bpld_lbl 01300 `"Georgia"', add
label define bpld_lbl 01500 `"Hawaii"', add
label define bpld_lbl 01600 `"Idaho"', add
label define bpld_lbl 01610 `"Idaho Territory"', add
label define bpld_lbl 01700 `"Illinois"', add
label define bpld_lbl 01800 `"Indiana"', add
label define bpld_lbl 01900 `"Iowa"', add
label define bpld_lbl 02000 `"Kansas"', add
label define bpld_lbl 02100 `"Kentucky"', add
label define bpld_lbl 02200 `"Louisiana"', add
label define bpld_lbl 02300 `"Maine"', add
label define bpld_lbl 02400 `"Maryland"', add
label define bpld_lbl 02500 `"Massachusetts"', add
label define bpld_lbl 02600 `"Michigan"', add
label define bpld_lbl 02700 `"Minnesota"', add
label define bpld_lbl 02710 `"Minnesota Territory"', add
label define bpld_lbl 02800 `"Mississippi"', add
label define bpld_lbl 02900 `"Missouri"', add
label define bpld_lbl 03000 `"Montana"', add
label define bpld_lbl 03010 `"Montana Territory"', add
label define bpld_lbl 03100 `"Nebraska"', add
label define bpld_lbl 03110 `"Nebraska Territory"', add
label define bpld_lbl 03200 `"Nevada"', add
label define bpld_lbl 03210 `"Nevada Territory"', add
label define bpld_lbl 03300 `"New Hampshire"', add
label define bpld_lbl 03400 `"New Jersey"', add
label define bpld_lbl 03500 `"New Mexico"', add
label define bpld_lbl 03510 `"New Mexico Territory"', add
label define bpld_lbl 03600 `"New York"', add
label define bpld_lbl 03700 `"North Carolina"', add
label define bpld_lbl 03800 `"North Dakota"', add
label define bpld_lbl 03900 `"Ohio"', add
label define bpld_lbl 04000 `"Oklahoma"', add
label define bpld_lbl 04010 `"Indian Territory"', add
label define bpld_lbl 04100 `"Oregon"', add
label define bpld_lbl 04200 `"Pennsylvania"', add
label define bpld_lbl 04400 `"Rhode Island"', add
label define bpld_lbl 04500 `"South Carolina"', add
label define bpld_lbl 04600 `"South Dakota"', add
label define bpld_lbl 04610 `"Dakota Territory"', add
label define bpld_lbl 04700 `"Tennessee"', add
label define bpld_lbl 04800 `"Texas"', add
label define bpld_lbl 04900 `"Utah"', add
label define bpld_lbl 04910 `"Utah Territory"', add
label define bpld_lbl 05000 `"Vermont"', add
label define bpld_lbl 05100 `"Virginia"', add
label define bpld_lbl 05300 `"Washington"', add
label define bpld_lbl 05310 `"Washington Territory"', add
label define bpld_lbl 05400 `"West Virginia"', add
label define bpld_lbl 05500 `"Wisconsin"', add
label define bpld_lbl 05600 `"Wyoming"', add
label define bpld_lbl 05610 `"Wyoming Territory"', add
label define bpld_lbl 09000 `"Native American"', add
label define bpld_lbl 09900 `"United States, ns"', add
label define bpld_lbl 10000 `"American Samoa"', add
label define bpld_lbl 10010 `"Samoa, 1940-1950"', add
label define bpld_lbl 10500 `"Guam"', add
label define bpld_lbl 11000 `"Puerto Rico"', add
label define bpld_lbl 11500 `"U.S. Virgin Islands"', add
label define bpld_lbl 11510 `"St. Croix"', add
label define bpld_lbl 11520 `"St. John"', add
label define bpld_lbl 11530 `"St. Thomas"', add
label define bpld_lbl 12000 `"Other US Possessions:"', add
label define bpld_lbl 12010 `"Johnston Atoll"', add
label define bpld_lbl 12020 `"Midway Islands"', add
label define bpld_lbl 12030 `"Wake Island"', add
label define bpld_lbl 12040 `"Other US Caribbean Islands"', add
label define bpld_lbl 12041 `"Navassa Island"', add
label define bpld_lbl 12050 `"Other US Pacific Islands"', add
label define bpld_lbl 12051 `"Baker Island"', add
label define bpld_lbl 12052 `"Howland Island"', add
label define bpld_lbl 12053 `"Jarvis Island"', add
label define bpld_lbl 12054 `"Kingman Reef"', add
label define bpld_lbl 12055 `"Palmyra Atoll"', add
label define bpld_lbl 12056 `"Canton and Enderbury Island"', add
label define bpld_lbl 12090 `"US outlying areas, ns"', add
label define bpld_lbl 12091 `"US possessions, ns"', add
label define bpld_lbl 12092 `"US territory, ns"', add
label define bpld_lbl 15000 `"Canada"', add
label define bpld_lbl 15010 `"English Canada"', add
label define bpld_lbl 15011 `"British Columbia"', add
label define bpld_lbl 15013 `"Alberta"', add
label define bpld_lbl 15015 `"Saskatchewan"', add
label define bpld_lbl 15017 `"Northwest"', add
label define bpld_lbl 15019 `"Ruperts Land"', add
label define bpld_lbl 15020 `"Manitoba"', add
label define bpld_lbl 15021 `"Red River"', add
label define bpld_lbl 15030 `"Ontario/Upper Canada"', add
label define bpld_lbl 15031 `"Upper Canada"', add
label define bpld_lbl 15032 `"Canada West"', add
label define bpld_lbl 15040 `"New Brunswick"', add
label define bpld_lbl 15050 `"Nova Scotia"', add
label define bpld_lbl 15051 `"Cape Breton"', add
label define bpld_lbl 15052 `"Halifax"', add
label define bpld_lbl 15060 `"Prince Edward Island"', add
label define bpld_lbl 15070 `"Newfoundland"', add
label define bpld_lbl 15080 `"French Canada"', add
label define bpld_lbl 15081 `"Quebec"', add
label define bpld_lbl 15082 `"Lower Canada"', add
label define bpld_lbl 15083 `"Canada East"', add
label define bpld_lbl 15500 `"St. Pierre and Miquelon"', add
label define bpld_lbl 16000 `"Atlantic Islands"', add
label define bpld_lbl 16010 `"Bermuda"', add
label define bpld_lbl 16020 `"Cape Verde"', add
label define bpld_lbl 16030 `"Falkland Islands"', add
label define bpld_lbl 16040 `"Greenland"', add
label define bpld_lbl 16050 `"St. Helena and Ascension"', add
label define bpld_lbl 16060 `"Canary Islands"', add
label define bpld_lbl 19900 `"North America, ns"', add
label define bpld_lbl 20000 `"Mexico"', add
label define bpld_lbl 21000 `"Central America"', add
label define bpld_lbl 21010 `"Belize/British Honduras"', add
label define bpld_lbl 21020 `"Costa Rica"', add
label define bpld_lbl 21030 `"El Salvador"', add
label define bpld_lbl 21040 `"Guatemala"', add
label define bpld_lbl 21050 `"Honduras"', add
label define bpld_lbl 21060 `"Nicaragua"', add
label define bpld_lbl 21070 `"Panama"', add
label define bpld_lbl 21071 `"Canal Zone"', add
label define bpld_lbl 21090 `"Central America, ns"', add
label define bpld_lbl 25000 `"Cuba"', add
label define bpld_lbl 26000 `"West Indies"', add
label define bpld_lbl 26010 `"Dominican Republic"', add
label define bpld_lbl 26020 `"Haiti"', add
label define bpld_lbl 26030 `"Jamaica"', add
label define bpld_lbl 26040 `"British West Indies"', add
label define bpld_lbl 26041 `"Anguilla"', add
label define bpld_lbl 26042 `"Antigua-Barbuda"', add
label define bpld_lbl 26043 `"Bahamas"', add
label define bpld_lbl 26044 `"Barbados"', add
label define bpld_lbl 26045 `"British Virgin Islands"', add
label define bpld_lbl 26046 `"Anegada"', add
label define bpld_lbl 26047 `"Cooper"', add
label define bpld_lbl 26048 `"Jost Van Dyke"', add
label define bpld_lbl 26049 `"Peter"', add
label define bpld_lbl 26050 `"Tortola"', add
label define bpld_lbl 26051 `"Virgin Gorda"', add
label define bpld_lbl 26052 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26053 `"Cayman Islands"', add
label define bpld_lbl 26054 `"Dominica"', add
label define bpld_lbl 26055 `"Grenada"', add
label define bpld_lbl 26056 `"Montserrat"', add
label define bpld_lbl 26057 `"St. Kitts-Nevis"', add
label define bpld_lbl 26058 `"St. Lucia"', add
label define bpld_lbl 26059 `"St. Vincent"', add
label define bpld_lbl 26060 `"Trinidad and Tobago"', add
label define bpld_lbl 26061 `"Turks and Caicos"', add
label define bpld_lbl 26069 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26070 `"Other West Indies"', add
label define bpld_lbl 26071 `"Aruba"', add
label define bpld_lbl 26072 `"Netherlands Antilles"', add
label define bpld_lbl 26073 `"Bonaire"', add
label define bpld_lbl 26074 `"Curacao"', add
label define bpld_lbl 26075 `"Dutch St. Maarten"', add
label define bpld_lbl 26076 `"Saba"', add
label define bpld_lbl 26077 `"St. Eustatius"', add
label define bpld_lbl 26079 `"Dutch Caribbean, ns"', add
label define bpld_lbl 26080 `"French St. Maarten"', add
label define bpld_lbl 26081 `"Guadeloupe"', add
label define bpld_lbl 26082 `"Martinique"', add
label define bpld_lbl 26083 `"St. Barthelemy"', add
label define bpld_lbl 26089 `"French Caribbean, ns"', add
label define bpld_lbl 26090 `"Antilles, ns"', add
label define bpld_lbl 26091 `"Caribbean, ns"', add
label define bpld_lbl 26092 `"Latin America, ns"', add
label define bpld_lbl 26093 `"Leeward Islands, ns"', add
label define bpld_lbl 26094 `"West Indies, ns"', add
label define bpld_lbl 26095 `"Windward Islands, ns"', add
label define bpld_lbl 29900 `"Americas, ns"', add
label define bpld_lbl 30000 `"South America"', add
label define bpld_lbl 30005 `"Argentina"', add
label define bpld_lbl 30010 `"Bolivia"', add
label define bpld_lbl 30015 `"Brazil"', add
label define bpld_lbl 30020 `"Chile"', add
label define bpld_lbl 30025 `"Colombia"', add
label define bpld_lbl 30030 `"Ecuador"', add
label define bpld_lbl 30035 `"French Guiana"', add
label define bpld_lbl 30040 `"Guyana/British Guiana"', add
label define bpld_lbl 30045 `"Paraguay"', add
label define bpld_lbl 30050 `"Peru"', add
label define bpld_lbl 30055 `"Suriname"', add
label define bpld_lbl 30060 `"Uruguay"', add
label define bpld_lbl 30065 `"Venezuela"', add
label define bpld_lbl 30090 `"South America, ns"', add
label define bpld_lbl 30091 `"South and Central America, n.s."', add
label define bpld_lbl 40000 `"Denmark"', add
label define bpld_lbl 40010 `"Faeroe Islands"', add
label define bpld_lbl 40100 `"Finland"', add
label define bpld_lbl 40200 `"Iceland"', add
label define bpld_lbl 40300 `"Lapland, ns"', add
label define bpld_lbl 40400 `"Norway"', add
label define bpld_lbl 40410 `"Svalbard and Jan Meyen"', add
label define bpld_lbl 40411 `"Svalbard"', add
label define bpld_lbl 40412 `"Jan Meyen"', add
label define bpld_lbl 40500 `"Sweden"', add
label define bpld_lbl 41000 `"England"', add
label define bpld_lbl 41010 `"Channel Islands"', add
label define bpld_lbl 41011 `"Guernsey"', add
label define bpld_lbl 41012 `"Jersey"', add
label define bpld_lbl 41020 `"Isle of Man"', add
label define bpld_lbl 41100 `"Scotland"', add
label define bpld_lbl 41200 `"Wales"', add
label define bpld_lbl 41300 `"United Kingdom, ns"', add
label define bpld_lbl 41400 `"Ireland"', add
label define bpld_lbl 41410 `"Northern Ireland"', add
label define bpld_lbl 41900 `"Northern Europe, ns"', add
label define bpld_lbl 42000 `"Belgium"', add
label define bpld_lbl 42100 `"France"', add
label define bpld_lbl 42110 `"Alsace-Lorraine"', add
label define bpld_lbl 42111 `"Alsace"', add
label define bpld_lbl 42112 `"Lorraine"', add
label define bpld_lbl 42200 `"Liechtenstein"', add
label define bpld_lbl 42300 `"Luxembourg"', add
label define bpld_lbl 42400 `"Monaco"', add
label define bpld_lbl 42500 `"Netherlands"', add
label define bpld_lbl 42600 `"Switzerland"', add
label define bpld_lbl 42900 `"Western Europe, ns"', add
label define bpld_lbl 43000 `"Albania"', add
label define bpld_lbl 43100 `"Andorra"', add
label define bpld_lbl 43200 `"Gibraltar"', add
label define bpld_lbl 43300 `"Greece"', add
label define bpld_lbl 43310 `"Dodecanese Islands"', add
label define bpld_lbl 43320 `"Turkey Greece"', add
label define bpld_lbl 43330 `"Macedonia"', add
label define bpld_lbl 43400 `"Italy"', add
label define bpld_lbl 43500 `"Malta"', add
label define bpld_lbl 43600 `"Portugal"', add
label define bpld_lbl 43610 `"Azores"', add
label define bpld_lbl 43620 `"Madeira Islands"', add
label define bpld_lbl 43630 `"Cape Verde Islands"', add
label define bpld_lbl 43640 `"St. Miguel"', add
label define bpld_lbl 43700 `"San Marino"', add
label define bpld_lbl 43800 `"Spain"', add
label define bpld_lbl 43900 `"Vatican City"', add
label define bpld_lbl 44000 `"Southern Europe, ns"', add
label define bpld_lbl 45000 `"Austria"', add
label define bpld_lbl 45010 `"Austria-Hungary"', add
label define bpld_lbl 45020 `"Austria-Graz"', add
label define bpld_lbl 45030 `"Austria-Linz"', add
label define bpld_lbl 45040 `"Austria-Salzburg"', add
label define bpld_lbl 45050 `"Austria-Tyrol"', add
label define bpld_lbl 45060 `"Austria-Vienna"', add
label define bpld_lbl 45070 `"Austria-Kaernsten"', add
label define bpld_lbl 45080 `"Austria-Neustadt"', add
label define bpld_lbl 45100 `"Bulgaria"', add
label define bpld_lbl 45200 `"Czechoslovakia"', add
label define bpld_lbl 45210 `"Bohemia"', add
label define bpld_lbl 45211 `"Bohemia-Moravia"', add
label define bpld_lbl 45212 `"Slovakia"', add
label define bpld_lbl 45213 `"Czech Republic"', add
label define bpld_lbl 45300 `"Germany"', add
label define bpld_lbl 45301 `"Berlin"', add
label define bpld_lbl 45302 `"West Berlin"', add
label define bpld_lbl 45303 `"East Berlin"', add
label define bpld_lbl 45310 `"West Germany"', add
label define bpld_lbl 45311 `"Baden"', add
label define bpld_lbl 45312 `"Bavaria"', add
label define bpld_lbl 45313 `"Braunschweig"', add
label define bpld_lbl 45314 `"Bremen"', add
label define bpld_lbl 45315 `"Hamburg"', add
label define bpld_lbl 45316 `"Hanover"', add
label define bpld_lbl 45317 `"Hessen"', add
label define bpld_lbl 45318 `"Hesse-Nassau"', add
label define bpld_lbl 45319 `"Lippe"', add
label define bpld_lbl 45320 `"Lubeck"', add
label define bpld_lbl 45321 `"Oldenburg"', add
label define bpld_lbl 45322 `"Rheinland"', add
label define bpld_lbl 45323 `"Schaumburg-Lippe"', add
label define bpld_lbl 45324 `"Schleswig"', add
label define bpld_lbl 45325 `"Sigmaringen"', add
label define bpld_lbl 45326 `"Schwarzburg"', add
label define bpld_lbl 45327 `"Westphalia"', add
label define bpld_lbl 45328 `"Wurttemberg"', add
label define bpld_lbl 45329 `"Waldeck"', add
label define bpld_lbl 45330 `"Wittenberg"', add
label define bpld_lbl 45331 `"Frankfurt"', add
label define bpld_lbl 45332 `"Saarland"', add
label define bpld_lbl 45333 `"Nordrhein-Westfalen"', add
label define bpld_lbl 45340 `"East Germany"', add
label define bpld_lbl 45341 `"Anhalt"', add
label define bpld_lbl 45342 `"Brandenburg"', add
label define bpld_lbl 45344 `"Kingdom of Saxony"', add
label define bpld_lbl 45345 `"Mecklenburg"', add
label define bpld_lbl 45346 `"Saxony"', add
label define bpld_lbl 45347 `"Thuringian States"', add
label define bpld_lbl 45348 `"Sachsen-Meiningen"', add
label define bpld_lbl 45349 `"Sachsen-Weimar-Eisenach"', add
label define bpld_lbl 45350 `"Probable Saxony"', add
label define bpld_lbl 45351 `"Schwerin"', add
label define bpld_lbl 45352 `"Strelitz"', add
label define bpld_lbl 45353 `"Probably Thuringian States"', add
label define bpld_lbl 45360 `"Prussia, nec"', add
label define bpld_lbl 45361 `"Hohenzollern"', add
label define bpld_lbl 45362 `"Niedersachsen"', add
label define bpld_lbl 45400 `"Hungary"', add
label define bpld_lbl 45500 `"Poland"', add
label define bpld_lbl 45510 `"Austrian Poland"', add
label define bpld_lbl 45511 `"Galicia"', add
label define bpld_lbl 45520 `"German Poland"', add
label define bpld_lbl 45521 `"East Prussia"', add
label define bpld_lbl 45522 `"Pomerania"', add
label define bpld_lbl 45523 `"Posen"', add
label define bpld_lbl 45524 `"Prussian Poland"', add
label define bpld_lbl 45525 `"Silesia"', add
label define bpld_lbl 45526 `"West Prussia"', add
label define bpld_lbl 45530 `"Russian Poland"', add
label define bpld_lbl 45600 `"Romania"', add
label define bpld_lbl 45610 `"Transylvania"', add
label define bpld_lbl 45700 `"Yugoslavia"', add
label define bpld_lbl 45710 `"Croatia"', add
label define bpld_lbl 45720 `"Montenegro"', add
label define bpld_lbl 45730 `"Serbia"', add
label define bpld_lbl 45740 `"Bosnia"', add
label define bpld_lbl 45750 `"Dalmatia"', add
label define bpld_lbl 45760 `"Slovonia"', add
label define bpld_lbl 45770 `"Carniola"', add
label define bpld_lbl 45780 `"Slovenia"', add
label define bpld_lbl 45790 `"Kosovo"', add
label define bpld_lbl 45800 `"Central Europe, ns"', add
label define bpld_lbl 45900 `"Eastern Europe, ns"', add
label define bpld_lbl 46000 `"Estonia"', add
label define bpld_lbl 46100 `"Latvia"', add
label define bpld_lbl 46200 `"Lithuania"', add
label define bpld_lbl 46300 `"Baltic States, ns"', add
label define bpld_lbl 46500 `"Other USSR/Russia"', add
label define bpld_lbl 46510 `"Byelorussia"', add
label define bpld_lbl 46520 `"Moldavia"', add
label define bpld_lbl 46521 `"Bessarabia"', add
label define bpld_lbl 46530 `"Ukraine"', add
label define bpld_lbl 46540 `"Armenia"', add
label define bpld_lbl 46541 `"Azerbaijan"', add
label define bpld_lbl 46542 `"Republic of Georgia"', add
label define bpld_lbl 46543 `"Kazakhstan"', add
label define bpld_lbl 46544 `"Kirghizia"', add
label define bpld_lbl 46545 `"Tadzhik"', add
label define bpld_lbl 46546 `"Turkmenistan"', add
label define bpld_lbl 46547 `"Uzbekistan"', add
label define bpld_lbl 46548 `"Siberia"', add
label define bpld_lbl 46590 `"USSR, ns"', add
label define bpld_lbl 49900 `"Europe, ns."', add
label define bpld_lbl 50000 `"China"', add
label define bpld_lbl 50010 `"Hong Kong"', add
label define bpld_lbl 50020 `"Macau"', add
label define bpld_lbl 50030 `"Mongolia"', add
label define bpld_lbl 50040 `"Taiwan"', add
label define bpld_lbl 50100 `"Japan"', add
label define bpld_lbl 50200 `"Korea"', add
label define bpld_lbl 50210 `"North Korea"', add
label define bpld_lbl 50220 `"South Korea"', add
label define bpld_lbl 50900 `"East Asia, ns"', add
label define bpld_lbl 51000 `"Brunei"', add
label define bpld_lbl 51100 `"Cambodia (Kampuchea)"', add
label define bpld_lbl 51200 `"Indonesia"', add
label define bpld_lbl 51210 `"East Indies"', add
label define bpld_lbl 51220 `"East Timor"', add
label define bpld_lbl 51300 `"Laos"', add
label define bpld_lbl 51400 `"Malaysia"', add
label define bpld_lbl 51500 `"Philippines"', add
label define bpld_lbl 51600 `"Singapore"', add
label define bpld_lbl 51700 `"Thailand"', add
label define bpld_lbl 51800 `"Vietnam"', add
label define bpld_lbl 51900 `"Southeast Asia, ns"', add
label define bpld_lbl 51910 `"Indochina, ns"', add
label define bpld_lbl 52000 `"Afghanistan"', add
label define bpld_lbl 52100 `"India"', add
label define bpld_lbl 52110 `"Bangladesh"', add
label define bpld_lbl 52120 `"Bhutan"', add
label define bpld_lbl 52130 `"Burma (Myanmar)"', add
label define bpld_lbl 52140 `"Pakistan"', add
label define bpld_lbl 52150 `"Sri Lanka (Ceylon)"', add
label define bpld_lbl 52200 `"Iran"', add
label define bpld_lbl 52300 `"Maldives"', add
label define bpld_lbl 52400 `"Nepal"', add
label define bpld_lbl 53000 `"Bahrain"', add
label define bpld_lbl 53100 `"Cyprus"', add
label define bpld_lbl 53200 `"Iraq"', add
label define bpld_lbl 53210 `"Mesopotamia"', add
label define bpld_lbl 53300 `"Iraq/Saudi Arabia"', add
label define bpld_lbl 53400 `"Israel/Palestine"', add
label define bpld_lbl 53410 `"Gaza Strip"', add
label define bpld_lbl 53420 `"Palestine"', add
label define bpld_lbl 53430 `"West Bank"', add
label define bpld_lbl 53440 `"Israel"', add
label define bpld_lbl 53500 `"Jordan"', add
label define bpld_lbl 53600 `"Kuwait"', add
label define bpld_lbl 53700 `"Lebanon"', add
label define bpld_lbl 53800 `"Oman"', add
label define bpld_lbl 53900 `"Qatar"', add
label define bpld_lbl 54000 `"Saudi Arabia"', add
label define bpld_lbl 54100 `"Syria"', add
label define bpld_lbl 54200 `"Turkey"', add
label define bpld_lbl 54210 `"European Turkey"', add
label define bpld_lbl 54220 `"Asian Turkey"', add
label define bpld_lbl 54300 `"United Arab Emirates"', add
label define bpld_lbl 54400 `"Yemen Arab Republic (North)"', add
label define bpld_lbl 54500 `"Yemen, PDR (South)"', add
label define bpld_lbl 54600 `"Persian Gulf States, ns"', add
label define bpld_lbl 54700 `"Middle East, ns"', add
label define bpld_lbl 54800 `"Southwest Asia, nec/ns"', add
label define bpld_lbl 54900 `"Asia Minor, ns"', add
label define bpld_lbl 55000 `"South Asia, nec"', add
label define bpld_lbl 59900 `"Asia, nec/ns"', add
label define bpld_lbl 60000 `"Africa"', add
label define bpld_lbl 60010 `"Northern Africa"', add
label define bpld_lbl 60011 `"Algeria"', add
label define bpld_lbl 60012 `"Egypt/United Arab Rep."', add
label define bpld_lbl 60013 `"Libya"', add
label define bpld_lbl 60014 `"Morocco"', add
label define bpld_lbl 60015 `"Sudan"', add
label define bpld_lbl 60016 `"Tunisia"', add
label define bpld_lbl 60017 `"Western Sahara"', add
label define bpld_lbl 60019 `"North Africa, ns"', add
label define bpld_lbl 60020 `"Benin"', add
label define bpld_lbl 60021 `"Burkina Faso"', add
label define bpld_lbl 60022 `"Gambia"', add
label define bpld_lbl 60023 `"Ghana"', add
label define bpld_lbl 60024 `"Guinea"', add
label define bpld_lbl 60025 `"Guinea-Bissau"', add
label define bpld_lbl 60026 `"Ivory Coast"', add
label define bpld_lbl 60027 `"Liberia"', add
label define bpld_lbl 60028 `"Mali"', add
label define bpld_lbl 60029 `"Mauritania"', add
label define bpld_lbl 60030 `"Niger"', add
label define bpld_lbl 60031 `"Nigeria"', add
label define bpld_lbl 60032 `"Senegal"', add
label define bpld_lbl 60033 `"Sierra Leone"', add
label define bpld_lbl 60034 `"Togo"', add
label define bpld_lbl 60038 `"Western Africa, ns"', add
label define bpld_lbl 60039 `"French West Africa, ns"', add
label define bpld_lbl 60040 `"British Indian Ocean Territory"', add
label define bpld_lbl 60041 `"Burundi"', add
label define bpld_lbl 60042 `"Comoros"', add
label define bpld_lbl 60043 `"Djibouti"', add
label define bpld_lbl 60044 `"Ethiopia"', add
label define bpld_lbl 60045 `"Kenya"', add
label define bpld_lbl 60046 `"Madagascar"', add
label define bpld_lbl 60047 `"Malawi"', add
label define bpld_lbl 60048 `"Mauritius"', add
label define bpld_lbl 60049 `"Mozambique"', add
label define bpld_lbl 60050 `"Reunion"', add
label define bpld_lbl 60051 `"Rwanda"', add
label define bpld_lbl 60052 `"Seychelles"', add
label define bpld_lbl 60053 `"Somalia"', add
label define bpld_lbl 60054 `"Tanzania"', add
label define bpld_lbl 60055 `"Uganda"', add
label define bpld_lbl 60056 `"Zambia"', add
label define bpld_lbl 60057 `"Zimbabwe"', add
label define bpld_lbl 60058 `"Bassas de India"', add
label define bpld_lbl 60059 `"Europa"', add
label define bpld_lbl 60060 `"Gloriosos"', add
label define bpld_lbl 60061 `"Juan de Nova"', add
label define bpld_lbl 60062 `"Mayotte"', add
label define bpld_lbl 60063 `"Tromelin"', add
label define bpld_lbl 60064 `"Eastern Africa, nec/ns"', add
label define bpld_lbl 60065 `"Eritrea"', add
label define bpld_lbl 60066 `"South Sudan"', add
label define bpld_lbl 60070 `"Central Africa"', add
label define bpld_lbl 60071 `"Angola"', add
label define bpld_lbl 60072 `"Cameroon"', add
label define bpld_lbl 60073 `"Central African Republic"', add
label define bpld_lbl 60074 `"Chad"', add
label define bpld_lbl 60075 `"Congo"', add
label define bpld_lbl 60076 `"Equatorial Guinea"', add
label define bpld_lbl 60077 `"Gabon"', add
label define bpld_lbl 60078 `"Sao Tome and Principe"', add
label define bpld_lbl 60079 `"Zaire"', add
label define bpld_lbl 60080 `"Central Africa, ns"', add
label define bpld_lbl 60081 `"Equatorial Africa, ns"', add
label define bpld_lbl 60082 `"French Equatorial Africa, ns"', add
label define bpld_lbl 60090 `"Southern Africa"', add
label define bpld_lbl 60091 `"Botswana"', add
label define bpld_lbl 60092 `"Lesotho"', add
label define bpld_lbl 60093 `"Namibia"', add
label define bpld_lbl 60094 `"South Africa (Union of)"', add
label define bpld_lbl 60095 `"Swaziland"', add
label define bpld_lbl 60096 `"Southern Africa, ns"', add
label define bpld_lbl 60099 `"Africa, ns/nec"', add
label define bpld_lbl 70000 `"Australia and New Zealand"', add
label define bpld_lbl 70010 `"Australia"', add
label define bpld_lbl 70011 `"Ashmore and Cartier Islands"', add
label define bpld_lbl 70012 `"Coral Sea Islands Territory"', add
label define bpld_lbl 70013 `"Christmas Island"', add
label define bpld_lbl 70014 `"Cocos Islands"', add
label define bpld_lbl 70020 `"New Zealand"', add
label define bpld_lbl 71000 `"Pacific Islands"', add
label define bpld_lbl 71010 `"New Caledonia"', add
label define bpld_lbl 71012 `"Papua New Guinea"', add
label define bpld_lbl 71013 `"Solomon Islands"', add
label define bpld_lbl 71014 `"Vanuatu (New Hebrides)"', add
label define bpld_lbl 71015 `"Fiji"', add
label define bpld_lbl 71016 `"Melanesia, ns"', add
label define bpld_lbl 71017 `"Norfolk Islands"', add
label define bpld_lbl 71018 `"Niue"', add
label define bpld_lbl 71020 `"Cook Islands"', add
label define bpld_lbl 71022 `"French Polynesia"', add
label define bpld_lbl 71023 `"Tonga"', add
label define bpld_lbl 71024 `"Wallis and Futuna Islands"', add
label define bpld_lbl 71025 `"Western Samoa"', add
label define bpld_lbl 71026 `"Pitcairn Island"', add
label define bpld_lbl 71027 `"Tokelau"', add
label define bpld_lbl 71028 `"Tuvalu"', add
label define bpld_lbl 71029 `"Polynesia, ns"', add
label define bpld_lbl 71032 `"Kiribati"', add
label define bpld_lbl 71033 `"Canton and Enderbury"', add
label define bpld_lbl 71034 `"Nauru"', add
label define bpld_lbl 71039 `"Micronesia, ns"', add
label define bpld_lbl 71040 `"US Pacific Trust Territories"', add
label define bpld_lbl 71041 `"Marshall Islands"', add
label define bpld_lbl 71042 `"Micronesia"', add
label define bpld_lbl 71043 `"Kosrae"', add
label define bpld_lbl 71044 `"Pohnpei"', add
label define bpld_lbl 71045 `"Truk"', add
label define bpld_lbl 71046 `"Yap"', add
label define bpld_lbl 71047 `"Northern Mariana Islands"', add
label define bpld_lbl 71048 `"Palau"', add
label define bpld_lbl 71049 `"Pacific Trust Terr, ns"', add
label define bpld_lbl 71050 `"Clipperton Island"', add
label define bpld_lbl 71090 `"Oceania, ns/nec"', add
label define bpld_lbl 80000 `"Antarctica, ns/nec"', add
label define bpld_lbl 80010 `"Bouvet Islands"', add
label define bpld_lbl 80020 `"British Antarctic Terr."', add
label define bpld_lbl 80030 `"Dronning Maud Land"', add
label define bpld_lbl 80040 `"French Southern and Antarctic Lands"', add
label define bpld_lbl 80050 `"Heard and McDonald Islands"', add
label define bpld_lbl 90000 `"Abroad (unknown) or at sea"', add
label define bpld_lbl 90010 `"Abroad, ns"', add
label define bpld_lbl 90011 `"Abroad (US citizen)"', add
label define bpld_lbl 90020 `"At sea"', add
label define bpld_lbl 90021 `"At sea (US citizen)"', add
label define bpld_lbl 90022 `"At sea or abroad (U.S. citizen)"', add
label define bpld_lbl 95000 `"Other n.e.c."', add
label define bpld_lbl 99700 `"Unknown"', add
label define bpld_lbl 99900 `"Missing/blank"', add
label values bpld bpld_lbl

label define ancestr1_lbl 001 `"Alsatian, Alsace-Lorraine"'
label define ancestr1_lbl 002 `"Andorran"', add
label define ancestr1_lbl 003 `"Austrian"', add
label define ancestr1_lbl 004 `"Tirolean"', add
label define ancestr1_lbl 005 `"Basque"', add
label define ancestr1_lbl 006 `"French Basque"', add
label define ancestr1_lbl 008 `"Belgian"', add
label define ancestr1_lbl 009 `"Flemish"', add
label define ancestr1_lbl 010 `"Walloon"', add
label define ancestr1_lbl 011 `"British"', add
label define ancestr1_lbl 012 `"British Isles"', add
label define ancestr1_lbl 013 `"Channel Islander"', add
label define ancestr1_lbl 014 `"Gibraltan"', add
label define ancestr1_lbl 015 `"Cornish"', add
label define ancestr1_lbl 016 `"Corsican"', add
label define ancestr1_lbl 017 `"Cypriot"', add
label define ancestr1_lbl 018 `"Greek Cypriote"', add
label define ancestr1_lbl 019 `"Turkish Cypriote"', add
label define ancestr1_lbl 020 `"Danish"', add
label define ancestr1_lbl 021 `"Dutch"', add
label define ancestr1_lbl 022 `"English"', add
label define ancestr1_lbl 023 `"Faeroe Islander"', add
label define ancestr1_lbl 024 `"Finnish"', add
label define ancestr1_lbl 025 `"Karelian"', add
label define ancestr1_lbl 026 `"French"', add
label define ancestr1_lbl 027 `"Lorrainian"', add
label define ancestr1_lbl 028 `"Breton"', add
label define ancestr1_lbl 029 `"Frisian"', add
label define ancestr1_lbl 030 `"Friulian"', add
label define ancestr1_lbl 032 `"German"', add
label define ancestr1_lbl 033 `"Bavarian"', add
label define ancestr1_lbl 034 `"Berliner"', add
label define ancestr1_lbl 035 `"Hamburger"', add
label define ancestr1_lbl 036 `"Hanoverian"', add
label define ancestr1_lbl 037 `"Hessian"', add
label define ancestr1_lbl 038 `"Lubecker"', add
label define ancestr1_lbl 039 `"Pomeranian"', add
label define ancestr1_lbl 040 `"Prussian"', add
label define ancestr1_lbl 041 `"Saxon"', add
label define ancestr1_lbl 042 `"Sudetenlander"', add
label define ancestr1_lbl 043 `"Westphalian"', add
label define ancestr1_lbl 046 `"Greek"', add
label define ancestr1_lbl 047 `"Cretan"', add
label define ancestr1_lbl 048 `"Cycladic Islander, Dodecanese Islander, Peloponnesian"', add
label define ancestr1_lbl 049 `"Icelander"', add
label define ancestr1_lbl 050 `"Irish, various subheads,"', add
label define ancestr1_lbl 051 `"Italian"', add
label define ancestr1_lbl 053 `"Abruzzi"', add
label define ancestr1_lbl 054 `"Apulian"', add
label define ancestr1_lbl 055 `"Basilicata"', add
label define ancestr1_lbl 056 `"Calabrian"', add
label define ancestr1_lbl 057 `"Amalfin"', add
label define ancestr1_lbl 058 `"Emilia Romagna"', add
label define ancestr1_lbl 059 `"Rome"', add
label define ancestr1_lbl 060 `"Ligurian"', add
label define ancestr1_lbl 061 `"Lombardian"', add
label define ancestr1_lbl 062 `"Marches"', add
label define ancestr1_lbl 063 `"Molise"', add
label define ancestr1_lbl 064 `"Neapolitan"', add
label define ancestr1_lbl 065 `"Piedmontese"', add
label define ancestr1_lbl 066 `"Puglia"', add
label define ancestr1_lbl 067 `"Sardinian"', add
label define ancestr1_lbl 068 `"Sicilian"', add
label define ancestr1_lbl 069 `"Tuscan"', add
label define ancestr1_lbl 070 `"Trentino"', add
label define ancestr1_lbl 071 `"Umbrian"', add
label define ancestr1_lbl 072 `"Valle dAosta"', add
label define ancestr1_lbl 073 `"Venetian"', add
label define ancestr1_lbl 075 `"Lapp"', add
label define ancestr1_lbl 076 `"Liechtensteiner"', add
label define ancestr1_lbl 077 `"Luxemburger"', add
label define ancestr1_lbl 078 `"Maltese"', add
label define ancestr1_lbl 079 `"Manx"', add
label define ancestr1_lbl 080 `"Monegasque"', add
label define ancestr1_lbl 081 `"Northern Irelander"', add
label define ancestr1_lbl 082 `"Norwegian"', add
label define ancestr1_lbl 084 `"Portuguese"', add
label define ancestr1_lbl 085 `"Azorean"', add
label define ancestr1_lbl 086 `"Madeiran"', add
label define ancestr1_lbl 087 `"Scotch Irish"', add
label define ancestr1_lbl 088 `"Scottish"', add
label define ancestr1_lbl 089 `"Swedish"', add
label define ancestr1_lbl 090 `"Aland Islander"', add
label define ancestr1_lbl 091 `"Swiss"', add
label define ancestr1_lbl 092 `"Suisse"', add
label define ancestr1_lbl 095 `"Romansch"', add
label define ancestr1_lbl 096 `"Suisse Romane"', add
label define ancestr1_lbl 097 `"Welsh"', add
label define ancestr1_lbl 098 `"Scandinavian, Nordic"', add
label define ancestr1_lbl 100 `"Albanian"', add
label define ancestr1_lbl 101 `"Azerbaijani"', add
label define ancestr1_lbl 102 `"Belorussian"', add
label define ancestr1_lbl 103 `"Bulgarian"', add
label define ancestr1_lbl 105 `"Carpathian"', add
label define ancestr1_lbl 108 `"Cossack"', add
label define ancestr1_lbl 109 `"Croatian"', add
label define ancestr1_lbl 111 `"Czechoslovakian"', add
label define ancestr1_lbl 112 `"Bohemian"', add
label define ancestr1_lbl 115 `"Estonian"', add
label define ancestr1_lbl 116 `"Livonian"', add
label define ancestr1_lbl 117 `"Finno Ugrian"', add
label define ancestr1_lbl 118 `"Mordovian"', add
label define ancestr1_lbl 119 `"Voytak"', add
label define ancestr1_lbl 120 `"Georgian"', add
label define ancestr1_lbl 122 `"Germans from Russia"', add
label define ancestr1_lbl 123 `"Gruziia"', add
label define ancestr1_lbl 124 `"Rom"', add
label define ancestr1_lbl 125 `"Hungarian"', add
label define ancestr1_lbl 126 `"Magyar"', add
label define ancestr1_lbl 128 `"Latvian"', add
label define ancestr1_lbl 129 `"Lithuanian"', add
label define ancestr1_lbl 130 `"Macedonian"', add
label define ancestr1_lbl 132 `"North Caucasian"', add
label define ancestr1_lbl 133 `"North Caucasian Turkic"', add
label define ancestr1_lbl 140 `"Ossetian"', add
label define ancestr1_lbl 142 `"Polish"', add
label define ancestr1_lbl 143 `"Kashubian"', add
label define ancestr1_lbl 144 `"Romanian"', add
label define ancestr1_lbl 145 `"Bessarabian"', add
label define ancestr1_lbl 146 `"Moldavian"', add
label define ancestr1_lbl 147 `"Wallachian"', add
label define ancestr1_lbl 148 `"Russian"', add
label define ancestr1_lbl 150 `"Muscovite"', add
label define ancestr1_lbl 152 `"Serbian"', add
label define ancestr1_lbl 153 `"Slovak"', add
label define ancestr1_lbl 154 `"Slovene"', add
label define ancestr1_lbl 155 `"Sorb/Wend"', add
label define ancestr1_lbl 156 `"Soviet Turkic"', add
label define ancestr1_lbl 157 `"Bashkir"', add
label define ancestr1_lbl 158 `"Chevash"', add
label define ancestr1_lbl 159 `"Gagauz"', add
label define ancestr1_lbl 160 `"Mesknetian"', add
label define ancestr1_lbl 163 `"Yakut"', add
label define ancestr1_lbl 164 `"Soviet Union, nec"', add
label define ancestr1_lbl 165 `"Tatar"', add
label define ancestr1_lbl 169 `"Uzbek"', add
label define ancestr1_lbl 171 `"Ukrainian"', add
label define ancestr1_lbl 176 `"Yugoslavian"', add
label define ancestr1_lbl 178 `"Slav"', add
label define ancestr1_lbl 179 `"Slavonian"', add
label define ancestr1_lbl 181 `"Central European, nec"', add
label define ancestr1_lbl 183 `"Northern European, nec"', add
label define ancestr1_lbl 185 `"Southern European, nec"', add
label define ancestr1_lbl 187 `"Western European, nec"', add
label define ancestr1_lbl 190 `"Eastern European, nec"', add
label define ancestr1_lbl 195 `"European, nec"', add
label define ancestr1_lbl 200 `"Spaniard"', add
label define ancestr1_lbl 201 `"Andalusian"', add
label define ancestr1_lbl 202 `"Astorian"', add
label define ancestr1_lbl 204 `"Catalonian"', add
label define ancestr1_lbl 205 `"Balearic Islander"', add
label define ancestr1_lbl 206 `"Galician"', add
label define ancestr1_lbl 210 `"Mexican"', add
label define ancestr1_lbl 211 `"Mexican American"', add
label define ancestr1_lbl 213 `"Chicano/Chicana"', add
label define ancestr1_lbl 218 `"Nuevo Mexicano"', add
label define ancestr1_lbl 219 `"Californio"', add
label define ancestr1_lbl 221 `"Costa Rican"', add
label define ancestr1_lbl 222 `"Guatemalan"', add
label define ancestr1_lbl 223 `"Honduran"', add
label define ancestr1_lbl 224 `"Nicaraguan"', add
label define ancestr1_lbl 225 `"Panamanian"', add
label define ancestr1_lbl 226 `"Salvadoran"', add
label define ancestr1_lbl 227 `"Latin American"', add
label define ancestr1_lbl 231 `"Argentinean"', add
label define ancestr1_lbl 232 `"Bolivian"', add
label define ancestr1_lbl 233 `"Chilean"', add
label define ancestr1_lbl 234 `"Colombian"', add
label define ancestr1_lbl 235 `"Ecuadorian"', add
label define ancestr1_lbl 236 `"Paraguayan"', add
label define ancestr1_lbl 237 `"Peruvian"', add
label define ancestr1_lbl 238 `"Uruguayan"', add
label define ancestr1_lbl 239 `"Venezuelan"', add
label define ancestr1_lbl 248 `"South American"', add
label define ancestr1_lbl 261 `"Puerto Rican"', add
label define ancestr1_lbl 271 `"Cuban"', add
label define ancestr1_lbl 275 `"Dominican"', add
label define ancestr1_lbl 290 `"Hispanic"', add
label define ancestr1_lbl 291 `"Spanish"', add
label define ancestr1_lbl 295 `"Spanish American"', add
label define ancestr1_lbl 296 `"Other Spanish/Hispanic"', add
label define ancestr1_lbl 300 `"Bahamian"', add
label define ancestr1_lbl 301 `"Barbadian"', add
label define ancestr1_lbl 302 `"Belizean"', add
label define ancestr1_lbl 303 `"Bermudan"', add
label define ancestr1_lbl 304 `"Cayman Islander"', add
label define ancestr1_lbl 308 `"Jamaican"', add
label define ancestr1_lbl 310 `"Dutch West Indies"', add
label define ancestr1_lbl 311 `"Aruba Islander"', add
label define ancestr1_lbl 312 `"St Maarten Islander"', add
label define ancestr1_lbl 314 `"Trinidadian/Tobagonian"', add
label define ancestr1_lbl 315 `"Trinidadian"', add
label define ancestr1_lbl 316 `"Tobagonian"', add
label define ancestr1_lbl 317 `"U.S. Virgin Islander"', add
label define ancestr1_lbl 321 `"British Virgin Islander"', add
label define ancestr1_lbl 322 `"British West Indian"', add
label define ancestr1_lbl 323 `"Turks and Caicos Islander"', add
label define ancestr1_lbl 324 `"Anguilla Islander"', add
label define ancestr1_lbl 328 `"Dominica Islander"', add
label define ancestr1_lbl 329 `"Grenadian"', add
label define ancestr1_lbl 331 `"St Lucia Islander"', add
label define ancestr1_lbl 332 `"French West Indies"', add
label define ancestr1_lbl 333 `"Guadeloupe Islander"', add
label define ancestr1_lbl 334 `"Cayenne"', add
label define ancestr1_lbl 335 `"West Indian"', add
label define ancestr1_lbl 336 `"Haitian"', add
label define ancestr1_lbl 337 `"Other West Indian"', add
label define ancestr1_lbl 360 `"Brazilian"', add
label define ancestr1_lbl 365 `"San Andres"', add
label define ancestr1_lbl 370 `"Guyanese/British Guiana"', add
label define ancestr1_lbl 375 `"Providencia"', add
label define ancestr1_lbl 380 `"Surinam/Dutch Guiana"', add
label define ancestr1_lbl 400 `"Algerian"', add
label define ancestr1_lbl 402 `"Egyptian"', add
label define ancestr1_lbl 404 `"Libyan"', add
label define ancestr1_lbl 406 `"Moroccan"', add
label define ancestr1_lbl 407 `"Ifni"', add
label define ancestr1_lbl 408 `"Tunisian"', add
label define ancestr1_lbl 411 `"North African"', add
label define ancestr1_lbl 412 `"Alhucemas"', add
label define ancestr1_lbl 413 `"Berber"', add
label define ancestr1_lbl 414 `"Rio de Oro"', add
label define ancestr1_lbl 415 `"Bahraini"', add
label define ancestr1_lbl 416 `"Iranian"', add
label define ancestr1_lbl 417 `"Iraqi"', add
label define ancestr1_lbl 419 `"Israeli"', add
label define ancestr1_lbl 421 `"Jordanian"', add
label define ancestr1_lbl 423 `"Kuwaiti"', add
label define ancestr1_lbl 425 `"Lebanese"', add
label define ancestr1_lbl 427 `"Saudi Arabian"', add
label define ancestr1_lbl 429 `"Syrian"', add
label define ancestr1_lbl 431 `"Armenian"', add
label define ancestr1_lbl 434 `"Turkish"', add
label define ancestr1_lbl 435 `"Yemeni"', add
label define ancestr1_lbl 436 `"Omani"', add
label define ancestr1_lbl 437 `"Muscat"', add
label define ancestr1_lbl 438 `"Trucial Oman"', add
label define ancestr1_lbl 439 `"Qatar"', add
label define ancestr1_lbl 442 `"Kurdish"', add
label define ancestr1_lbl 444 `"Kuria Muria Islander"', add
label define ancestr1_lbl 465 `"Palestinian"', add
label define ancestr1_lbl 466 `"Gazan"', add
label define ancestr1_lbl 467 `"West Bank"', add
label define ancestr1_lbl 470 `"South Yemeni"', add
label define ancestr1_lbl 471 `"Aden"', add
label define ancestr1_lbl 480 `"United Arab Emirates"', add
label define ancestr1_lbl 482 `"Assyrian/Chaldean/Syriac"', add
label define ancestr1_lbl 490 `"Middle Eastern"', add
label define ancestr1_lbl 495 `"Arab"', add
label define ancestr1_lbl 496 `"Other Arab"', add
label define ancestr1_lbl 500 `"Angolan"', add
label define ancestr1_lbl 502 `"Benin"', add
label define ancestr1_lbl 504 `"Botswana"', add
label define ancestr1_lbl 506 `"Burundian"', add
label define ancestr1_lbl 508 `"Cameroonian"', add
label define ancestr1_lbl 510 `"Cape Verdean"', add
label define ancestr1_lbl 513 `"Chadian"', add
label define ancestr1_lbl 515 `"Congolese"', add
label define ancestr1_lbl 516 `"Congo-Brazzaville"', add
label define ancestr1_lbl 519 `"Djibouti"', add
label define ancestr1_lbl 520 `"Equatorial Guinea"', add
label define ancestr1_lbl 522 `"Ethiopian"', add
label define ancestr1_lbl 523 `"Eritrean"', add
label define ancestr1_lbl 525 `"Gabonese"', add
label define ancestr1_lbl 527 `"Gambian"', add
label define ancestr1_lbl 529 `"Ghanian"', add
label define ancestr1_lbl 530 `"Guinean"', add
label define ancestr1_lbl 531 `"Guinea Bissau"', add
label define ancestr1_lbl 532 `"Ivory Coast"', add
label define ancestr1_lbl 534 `"Kenyan"', add
label define ancestr1_lbl 538 `"Lesotho"', add
label define ancestr1_lbl 541 `"Liberian"', add
label define ancestr1_lbl 543 `"Madagascan"', add
label define ancestr1_lbl 545 `"Malawian"', add
label define ancestr1_lbl 546 `"Malian"', add
label define ancestr1_lbl 549 `"Mozambican"', add
label define ancestr1_lbl 550 `"Namibian"', add
label define ancestr1_lbl 551 `"Niger"', add
label define ancestr1_lbl 553 `"Nigerian"', add
label define ancestr1_lbl 554 `"Fulani"', add
label define ancestr1_lbl 555 `"Hausa"', add
label define ancestr1_lbl 556 `"Ibo"', add
label define ancestr1_lbl 557 `"Tiv"', add
label define ancestr1_lbl 561 `"Rwandan"', add
label define ancestr1_lbl 564 `"Senegalese"', add
label define ancestr1_lbl 566 `"Sierra Leonean"', add
label define ancestr1_lbl 568 `"Somalian"', add
label define ancestr1_lbl 569 `"Swaziland"', add
label define ancestr1_lbl 570 `"South African"', add
label define ancestr1_lbl 571 `"Union of South Africa"', add
label define ancestr1_lbl 572 `"Afrikaner"', add
label define ancestr1_lbl 573 `"Natalian"', add
label define ancestr1_lbl 574 `"Zulu"', add
label define ancestr1_lbl 576 `"Sudanese"', add
label define ancestr1_lbl 577 `"Dinka"', add
label define ancestr1_lbl 578 `"Nuer"', add
label define ancestr1_lbl 579 `"Fur"', add
label define ancestr1_lbl 582 `"Tanzanian"', add
label define ancestr1_lbl 583 `"Tanganyikan"', add
label define ancestr1_lbl 584 `"Zanzibar Islander"', add
label define ancestr1_lbl 586 `"Togo"', add
label define ancestr1_lbl 588 `"Ugandan"', add
label define ancestr1_lbl 589 `"Upper Voltan"', add
label define ancestr1_lbl 591 `"Zairian"', add
label define ancestr1_lbl 592 `"Zambian"', add
label define ancestr1_lbl 593 `"Zimbabwean"', add
label define ancestr1_lbl 594 `"African Islands"', add
label define ancestr1_lbl 595 `"Other Subsaharan Africa"', add
label define ancestr1_lbl 596 `"Central African"', add
label define ancestr1_lbl 597 `"East African"', add
label define ancestr1_lbl 598 `"West African"', add
label define ancestr1_lbl 599 `"African"', add
label define ancestr1_lbl 600 `"Afghan"', add
label define ancestr1_lbl 601 `"Baluchi"', add
label define ancestr1_lbl 602 `"Pathan"', add
label define ancestr1_lbl 603 `"Bengali"', add
label define ancestr1_lbl 607 `"Bhutanese"', add
label define ancestr1_lbl 609 `"Nepali"', add
label define ancestr1_lbl 615 `"Asian Indian"', add
label define ancestr1_lbl 622 `"Andaman Islander"', add
label define ancestr1_lbl 624 `"Andhra Pradesh"', add
label define ancestr1_lbl 626 `"Assamese"', add
label define ancestr1_lbl 628 `"Goanese"', add
label define ancestr1_lbl 630 `"Gujarati"', add
label define ancestr1_lbl 632 `"Karnatakan"', add
label define ancestr1_lbl 634 `"Keralan"', add
label define ancestr1_lbl 638 `"Maharashtran"', add
label define ancestr1_lbl 640 `"Madrasi"', add
label define ancestr1_lbl 642 `"Mysore"', add
label define ancestr1_lbl 644 `"Naga"', add
label define ancestr1_lbl 648 `"Pondicherry"', add
label define ancestr1_lbl 650 `"Punjabi"', add
label define ancestr1_lbl 656 `"Tamil"', add
label define ancestr1_lbl 675 `"East Indies"', add
label define ancestr1_lbl 680 `"Pakistani"', add
label define ancestr1_lbl 690 `"Sri Lankan"', add
label define ancestr1_lbl 691 `"Singhalese"', add
label define ancestr1_lbl 692 `"Veddah"', add
label define ancestr1_lbl 695 `"Maldivian"', add
label define ancestr1_lbl 700 `"Burmese"', add
label define ancestr1_lbl 702 `"Shan"', add
label define ancestr1_lbl 703 `"Cambodian"', add
label define ancestr1_lbl 704 `"Khmer"', add
label define ancestr1_lbl 706 `"Chinese"', add
label define ancestr1_lbl 707 `"Cantonese"', add
label define ancestr1_lbl 708 `"Manchurian"', add
label define ancestr1_lbl 709 `"Mandarin"', add
label define ancestr1_lbl 712 `"Mongolian"', add
label define ancestr1_lbl 714 `"Tibetan"', add
label define ancestr1_lbl 716 `"Hong Kong"', add
label define ancestr1_lbl 718 `"Macao"', add
label define ancestr1_lbl 720 `"Filipino"', add
label define ancestr1_lbl 730 `"Indonesian"', add
label define ancestr1_lbl 740 `"Japanese"', add
label define ancestr1_lbl 746 `"Ryukyu Islander"', add
label define ancestr1_lbl 748 `"Okinawan"', add
label define ancestr1_lbl 750 `"Korean"', add
label define ancestr1_lbl 765 `"Laotian"', add
label define ancestr1_lbl 766 `"Meo"', add
label define ancestr1_lbl 768 `"Hmong"', add
label define ancestr1_lbl 770 `"Malaysian"', add
label define ancestr1_lbl 774 `"Singaporean"', add
label define ancestr1_lbl 776 `"Thai"', add
label define ancestr1_lbl 777 `"Black Thai"', add
label define ancestr1_lbl 778 `"Western Lao"', add
label define ancestr1_lbl 782 `"Taiwanese"', add
label define ancestr1_lbl 785 `"Vietnamese"', add
label define ancestr1_lbl 786 `"Katu"', add
label define ancestr1_lbl 787 `"Ma"', add
label define ancestr1_lbl 788 `"Mnong"', add
label define ancestr1_lbl 790 `"Montagnard"', add
label define ancestr1_lbl 792 `"Indochinese"', add
label define ancestr1_lbl 793 `"Eurasian"', add
label define ancestr1_lbl 795 `"Asian"', add
label define ancestr1_lbl 796 `"Other Asian"', add
label define ancestr1_lbl 800 `"Australian"', add
label define ancestr1_lbl 801 `"Tasmanian"', add
label define ancestr1_lbl 802 `"Australian Aborigine"', add
label define ancestr1_lbl 803 `"New Zealander"', add
label define ancestr1_lbl 808 `"Polynesian"', add
label define ancestr1_lbl 810 `"Maori"', add
label define ancestr1_lbl 811 `"Hawaiian"', add
label define ancestr1_lbl 813 `"Part Hawaiian"', add
label define ancestr1_lbl 814 `"Samoan"', add
label define ancestr1_lbl 815 `"Tongan"', add
label define ancestr1_lbl 816 `"Tokelauan"', add
label define ancestr1_lbl 817 `"Cook Islander"', add
label define ancestr1_lbl 818 `"Tahitian"', add
label define ancestr1_lbl 819 `"Niuean"', add
label define ancestr1_lbl 820 `"Micronesian"', add
label define ancestr1_lbl 821 `"Guamanian"', add
label define ancestr1_lbl 822 `"Chamorro Islander"', add
label define ancestr1_lbl 823 `"Saipanese"', add
label define ancestr1_lbl 824 `"Palauan"', add
label define ancestr1_lbl 825 `"Marshall Islander"', add
label define ancestr1_lbl 826 `"Kosraean"', add
label define ancestr1_lbl 827 `"Ponapean"', add
label define ancestr1_lbl 828 `"Chuukese"', add
label define ancestr1_lbl 829 `"Yap Islander"', add
label define ancestr1_lbl 830 `"Caroline Islander"', add
label define ancestr1_lbl 831 `"Kiribatese"', add
label define ancestr1_lbl 832 `"Nauruan"', add
label define ancestr1_lbl 833 `"Tarawa Islander"', add
label define ancestr1_lbl 834 `"Tinian Islander"', add
label define ancestr1_lbl 840 `"Melanesian Islander"', add
label define ancestr1_lbl 841 `"Fijian"', add
label define ancestr1_lbl 843 `"New Guinean"', add
label define ancestr1_lbl 844 `"Papuan"', add
label define ancestr1_lbl 845 `"Solomon Islander"', add
label define ancestr1_lbl 846 `"New Caledonian Islander"', add
label define ancestr1_lbl 847 `"Vanuatuan"', add
label define ancestr1_lbl 850 `"Pacific Islander"', add
label define ancestr1_lbl 860 `"Oceania"', add
label define ancestr1_lbl 862 `"Chamolinian"', add
label define ancestr1_lbl 863 `"Reserved Codes"', add
label define ancestr1_lbl 870 `"Other Pacific"', add
label define ancestr1_lbl 900 `"Afro-American"', add
label define ancestr1_lbl 902 `"African-American"', add
label define ancestr1_lbl 913 `"Central American Indian"', add
label define ancestr1_lbl 914 `"South American Indian"', add
label define ancestr1_lbl 920 `"American Indian  (all tribes)"', add
label define ancestr1_lbl 921 `"Aleut"', add
label define ancestr1_lbl 922 `"Eskimo"', add
label define ancestr1_lbl 923 `"Inuit"', add
label define ancestr1_lbl 924 `"White/Caucasian"', add
label define ancestr1_lbl 930 `"Greenlander"', add
label define ancestr1_lbl 931 `"Canadian"', add
label define ancestr1_lbl 933 `"Newfoundland"', add
label define ancestr1_lbl 934 `"Nova Scotian"', add
label define ancestr1_lbl 935 `"French Canadian"', add
label define ancestr1_lbl 936 `"Acadian"', add
label define ancestr1_lbl 939 `"American"', add
label define ancestr1_lbl 940 `"United States"', add
label define ancestr1_lbl 941 `"Alabama"', add
label define ancestr1_lbl 942 `"Alaska"', add
label define ancestr1_lbl 943 `"Arizona"', add
label define ancestr1_lbl 944 `"Arkansas"', add
label define ancestr1_lbl 945 `"California"', add
label define ancestr1_lbl 946 `"Colorado"', add
label define ancestr1_lbl 947 `"Connecticut"', add
label define ancestr1_lbl 948 `"District of Columbia"', add
label define ancestr1_lbl 949 `"Delaware"', add
label define ancestr1_lbl 950 `"Florida"', add
label define ancestr1_lbl 951 `"Georgia"', add
label define ancestr1_lbl 952 `"Idaho"', add
label define ancestr1_lbl 953 `"Illinois"', add
label define ancestr1_lbl 954 `"Indiana"', add
label define ancestr1_lbl 955 `"Iowa"', add
label define ancestr1_lbl 956 `"Kansas"', add
label define ancestr1_lbl 957 `"Kentucky"', add
label define ancestr1_lbl 958 `"Louisiana"', add
label define ancestr1_lbl 959 `"Maine"', add
label define ancestr1_lbl 960 `"Maryland"', add
label define ancestr1_lbl 961 `"Massachusetts"', add
label define ancestr1_lbl 962 `"Michigan"', add
label define ancestr1_lbl 963 `"Minnesota"', add
label define ancestr1_lbl 964 `"Mississippi"', add
label define ancestr1_lbl 965 `"Missouri"', add
label define ancestr1_lbl 966 `"Montana"', add
label define ancestr1_lbl 967 `"Nebraska"', add
label define ancestr1_lbl 968 `"Nevada"', add
label define ancestr1_lbl 969 `"New Hampshire"', add
label define ancestr1_lbl 970 `"New Jersey"', add
label define ancestr1_lbl 971 `"New Mexico"', add
label define ancestr1_lbl 972 `"New York"', add
label define ancestr1_lbl 973 `"North Carolina"', add
label define ancestr1_lbl 974 `"North Dakota"', add
label define ancestr1_lbl 975 `"Ohio"', add
label define ancestr1_lbl 976 `"Oklahoma"', add
label define ancestr1_lbl 977 `"Oregon"', add
label define ancestr1_lbl 978 `"Pennsylvania"', add
label define ancestr1_lbl 979 `"Rhode Island"', add
label define ancestr1_lbl 980 `"South Carolina"', add
label define ancestr1_lbl 981 `"South Dakota"', add
label define ancestr1_lbl 982 `"Tennessee"', add
label define ancestr1_lbl 983 `"Texas"', add
label define ancestr1_lbl 984 `"Utah"', add
label define ancestr1_lbl 985 `"Vermont"', add
label define ancestr1_lbl 986 `"Virginia"', add
label define ancestr1_lbl 987 `"Washington"', add
label define ancestr1_lbl 988 `"West Virginia"', add
label define ancestr1_lbl 989 `"Wisconsin"', add
label define ancestr1_lbl 990 `"Wyoming"', add
label define ancestr1_lbl 993 `"Southerner"', add
label define ancestr1_lbl 994 `"North American"', add
label define ancestr1_lbl 995 `"Mixture"', add
label define ancestr1_lbl 996 `"Uncodable"', add
label define ancestr1_lbl 998 `"Other"', add
label define ancestr1_lbl 999 `"Not Reported"', add
label values ancestr1 ancestr1_lbl

label define ancestr1d_lbl 0010 `"Alsatian"'
label define ancestr1d_lbl 0020 `"Andorran"', add
label define ancestr1d_lbl 0030 `"Austrian"', add
label define ancestr1d_lbl 0040 `"Tirolean"', add
label define ancestr1d_lbl 0051 `"Basque (1980)"', add
label define ancestr1d_lbl 0052 `"Spanish Basque (1980)"', add
label define ancestr1d_lbl 0053 `"Basque (1990-2000)"', add
label define ancestr1d_lbl 0054 `"Spanish Basque (1990-2000, 2001-2004 ACS)"', add
label define ancestr1d_lbl 0060 `"French Basque"', add
label define ancestr1d_lbl 0080 `"Belgian"', add
label define ancestr1d_lbl 0090 `"Flemish"', add
label define ancestr1d_lbl 0100 `"Walloon"', add
label define ancestr1d_lbl 0110 `"British"', add
label define ancestr1d_lbl 0120 `"British Isles"', add
label define ancestr1d_lbl 0130 `"Channel Islander"', add
label define ancestr1d_lbl 0140 `"Gibraltan"', add
label define ancestr1d_lbl 0150 `"Cornish"', add
label define ancestr1d_lbl 0160 `"Corsican"', add
label define ancestr1d_lbl 0170 `"Cypriot"', add
label define ancestr1d_lbl 0180 `"Greek Cypriote"', add
label define ancestr1d_lbl 0190 `"Turkish Cypriote"', add
label define ancestr1d_lbl 0200 `"Danish"', add
label define ancestr1d_lbl 0210 `"Dutch"', add
label define ancestr1d_lbl 0211 `"Dutch-French-Irish"', add
label define ancestr1d_lbl 0212 `"Dutch-German-Irish"', add
label define ancestr1d_lbl 0213 `"Dutch-Irish-Scotch"', add
label define ancestr1d_lbl 0220 `"English"', add
label define ancestr1d_lbl 0221 `"English-French-German"', add
label define ancestr1d_lbl 0222 `"English-French-Irish"', add
label define ancestr1d_lbl 0223 `"English-German-Irish"', add
label define ancestr1d_lbl 0224 `"English-German-Swedish"', add
label define ancestr1d_lbl 0225 `"English-Irish-Scotch"', add
label define ancestr1d_lbl 0226 `"English-Scotch-Welsh"', add
label define ancestr1d_lbl 0230 `"Faeroe Islander"', add
label define ancestr1d_lbl 0240 `"Finnish"', add
label define ancestr1d_lbl 0250 `"Karelian"', add
label define ancestr1d_lbl 0260 `"French (1980)"', add
label define ancestr1d_lbl 0261 `"French (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 0262 `"Occitan (1990-2000)"', add
label define ancestr1d_lbl 0270 `"Lorrainian"', add
label define ancestr1d_lbl 0280 `"Breton"', add
label define ancestr1d_lbl 0290 `"Frisian"', add
label define ancestr1d_lbl 0300 `"Friulian"', add
label define ancestr1d_lbl 0320 `"German (1980)"', add
label define ancestr1d_lbl 0321 `"German (1990-2000, ACS/PRCS)"', add
label define ancestr1d_lbl 0322 `"Pennsylvania German (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 0323 `"East German (1990-2000)"', add
label define ancestr1d_lbl 0324 `"West German (2000)"', add
label define ancestr1d_lbl 0325 `"German-French-Irish"', add
label define ancestr1d_lbl 0326 `"German-Irish-Italian"', add
label define ancestr1d_lbl 0327 `"German-Irish-Scotch"', add
label define ancestr1d_lbl 0328 `"German-Irish-Swedish"', add
label define ancestr1d_lbl 0329 `"Germanic"', add
label define ancestr1d_lbl 0330 `"Bavarian"', add
label define ancestr1d_lbl 0340 `"Berliner"', add
label define ancestr1d_lbl 0350 `"Hamburger"', add
label define ancestr1d_lbl 0360 `"Hanoverian"', add
label define ancestr1d_lbl 0370 `"Hessian"', add
label define ancestr1d_lbl 0380 `"Lubecker"', add
label define ancestr1d_lbl 0390 `"Pomeranian (1980)"', add
label define ancestr1d_lbl 0391 `"Pomeranian (1990-2000)"', add
label define ancestr1d_lbl 0392 `"Silesian (1990-2000)"', add
label define ancestr1d_lbl 0400 `"Prussian"', add
label define ancestr1d_lbl 0410 `"Saxon"', add
label define ancestr1d_lbl 0420 `"Sudetenlander"', add
label define ancestr1d_lbl 0430 `"Westphalian"', add
label define ancestr1d_lbl 0460 `"Greek"', add
label define ancestr1d_lbl 0470 `"Cretan"', add
label define ancestr1d_lbl 0480 `"Cycladic Islander"', add
label define ancestr1d_lbl 0490 `"Icelander"', add
label define ancestr1d_lbl 0500 `"Irish"', add
label define ancestr1d_lbl 0501 `"Celtic"', add
label define ancestr1d_lbl 0502 `"Irish Scotch"', add
label define ancestr1d_lbl 0510 `"Italian (1980)"', add
label define ancestr1d_lbl 0511 `"Italian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 0512 `"Trieste (1990-2000)"', add
label define ancestr1d_lbl 0513 `"San Marino (1990-2000)"', add
label define ancestr1d_lbl 0530 `"Abruzzi"', add
label define ancestr1d_lbl 0540 `"Apulian"', add
label define ancestr1d_lbl 0550 `"Basilicata"', add
label define ancestr1d_lbl 0560 `"Calabrian"', add
label define ancestr1d_lbl 0570 `"Amalfi"', add
label define ancestr1d_lbl 0580 `"Emilia Romagna"', add
label define ancestr1d_lbl 0590 `"Rome"', add
label define ancestr1d_lbl 0600 `"Ligurian"', add
label define ancestr1d_lbl 0610 `"Lombardian"', add
label define ancestr1d_lbl 0620 `"Marches"', add
label define ancestr1d_lbl 0630 `"Molise"', add
label define ancestr1d_lbl 0640 `"Neapolitan"', add
label define ancestr1d_lbl 0650 `"Piedmontese"', add
label define ancestr1d_lbl 0660 `"Puglia"', add
label define ancestr1d_lbl 0670 `"Sardinian"', add
label define ancestr1d_lbl 0680 `"Sicilian"', add
label define ancestr1d_lbl 0690 `"Tuscan"', add
label define ancestr1d_lbl 0700 `"Trentino"', add
label define ancestr1d_lbl 0710 `"Umbrian"', add
label define ancestr1d_lbl 0720 `"Valle dAosta"', add
label define ancestr1d_lbl 0730 `"Venetian"', add
label define ancestr1d_lbl 0750 `"Lapp"', add
label define ancestr1d_lbl 0760 `"Liechtensteiner"', add
label define ancestr1d_lbl 0770 `"Luxemburger"', add
label define ancestr1d_lbl 0780 `"Maltese"', add
label define ancestr1d_lbl 0790 `"Manx"', add
label define ancestr1d_lbl 0800 `"Monegasque"', add
label define ancestr1d_lbl 0810 `"Northern Irelander"', add
label define ancestr1d_lbl 0820 `"Norwegian"', add
label define ancestr1d_lbl 0840 `"Portuguese"', add
label define ancestr1d_lbl 0850 `"Azorean"', add
label define ancestr1d_lbl 0860 `"Madeiran"', add
label define ancestr1d_lbl 0870 `"Scotch Irish"', add
label define ancestr1d_lbl 0880 `"Scottish"', add
label define ancestr1d_lbl 0890 `"Swedish"', add
label define ancestr1d_lbl 0900 `"Aland Islander"', add
label define ancestr1d_lbl 0910 `"Swiss"', add
label define ancestr1d_lbl 0920 `"Suisse (1980)"', add
label define ancestr1d_lbl 0921 `"Suisse (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 0922 `"Switzer (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 0950 `"Romansch (1980, ACS)"', add
label define ancestr1d_lbl 0951 `"Romanscho (1990-2000)"', add
label define ancestr1d_lbl 0952 `"Ladin (1990-2000)"', add
label define ancestr1d_lbl 0960 `"Suisse Romane (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 0961 `"Suisse Romane (1980)"', add
label define ancestr1d_lbl 0962 `"Ticino"', add
label define ancestr1d_lbl 0970 `"Welsh"', add
label define ancestr1d_lbl 0980 `"Scandinavian, Nordic"', add
label define ancestr1d_lbl 1000 `"Albanian"', add
label define ancestr1d_lbl 1010 `"Azerbaijani"', add
label define ancestr1d_lbl 1020 `"Belorussian"', add
label define ancestr1d_lbl 1030 `"Bulgarian"', add
label define ancestr1d_lbl 1050 `"Carpathian"', add
label define ancestr1d_lbl 1051 `"Carpatho Rusyn"', add
label define ancestr1d_lbl 1052 `"Rusyn"', add
label define ancestr1d_lbl 1080 `"Cossack (1990-2000)"', add
label define ancestr1d_lbl 1081 `"Cossack (1980)"', add
label define ancestr1d_lbl 1082 `"Turkestani (1990-2000, 2012 ACS)"', add
label define ancestr1d_lbl 1083 `"Kirghiz (1980)"', add
label define ancestr1d_lbl 1084 `"Turcoman (1980)"', add
label define ancestr1d_lbl 1090 `"Croatian"', add
label define ancestr1d_lbl 1110 `"Czechoslovakian"', add
label define ancestr1d_lbl 1111 `"Czech"', add
label define ancestr1d_lbl 1120 `"Bohemian"', add
label define ancestr1d_lbl 1121 `"Bohemian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 1122 `"Moravian (1990-2000)"', add
label define ancestr1d_lbl 1150 `"Estonian"', add
label define ancestr1d_lbl 1160 `"Livonian"', add
label define ancestr1d_lbl 1170 `"Finno Ugrian (1990-2000)"', add
label define ancestr1d_lbl 1171 `"Udmert"', add
label define ancestr1d_lbl 1180 `"Mordovian"', add
label define ancestr1d_lbl 1190 `"Voytak"', add
label define ancestr1d_lbl 1200 `"Georgian"', add
label define ancestr1d_lbl 1220 `"Germans from Russia"', add
label define ancestr1d_lbl 1221 `"Volga"', add
label define ancestr1d_lbl 1222 `"German from Russia (1990-2000); German Russian (ACS, PRCS)"', add
label define ancestr1d_lbl 1230 `"Gruziia (1990-2000)"', add
label define ancestr1d_lbl 1240 `"Rom"', add
label define ancestr1d_lbl 1250 `"Hungarian"', add
label define ancestr1d_lbl 1260 `"Magyar"', add
label define ancestr1d_lbl 1280 `"Latvian"', add
label define ancestr1d_lbl 1290 `"Lithuanian"', add
label define ancestr1d_lbl 1300 `"Macedonian"', add
label define ancestr1d_lbl 1320 `"North Caucasian"', add
label define ancestr1d_lbl 1330 `"North Caucasian Turkic (1990-2000)"', add
label define ancestr1d_lbl 1400 `"Ossetian"', add
label define ancestr1d_lbl 1420 `"Polish"', add
label define ancestr1d_lbl 1430 `"Kashubian"', add
label define ancestr1d_lbl 1440 `"Romanian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 1441 `"Rumanian (1980)"', add
label define ancestr1d_lbl 1442 `"Transylvanian"', add
label define ancestr1d_lbl 1450 `"Bessarabian (1980)"', add
label define ancestr1d_lbl 1451 `"Bessarabian (1990-2000)"', add
label define ancestr1d_lbl 1452 `"Bucovina"', add
label define ancestr1d_lbl 1460 `"Moldavian"', add
label define ancestr1d_lbl 1470 `"Wallachian"', add
label define ancestr1d_lbl 1480 `"Russian"', add
label define ancestr1d_lbl 1500 `"Muscovite"', add
label define ancestr1d_lbl 1520 `"Serbian (1980)"', add
label define ancestr1d_lbl 1521 `"Serbian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 1522 `"Bosnian (1990) Herzegovinian (2000, ACS, PRCS)"', add
label define ancestr1d_lbl 1523 `"Montenegrin (1990-2000, 2012 ACS)"', add
label define ancestr1d_lbl 1530 `"Slovak"', add
label define ancestr1d_lbl 1540 `"Slovene"', add
label define ancestr1d_lbl 1550 `"Sorb/Wend"', add
label define ancestr1d_lbl 1560 `"Soviet Turkic (1990-2000)"', add
label define ancestr1d_lbl 1570 `"Bashkir"', add
label define ancestr1d_lbl 1580 `"Chevash"', add
label define ancestr1d_lbl 1590 `"Gagauz (1990-2000)"', add
label define ancestr1d_lbl 1600 `"Mesknetian (1990-2000)"', add
label define ancestr1d_lbl 1630 `"Yakut"', add
label define ancestr1d_lbl 1640 `"Soviet Union, nec"', add
label define ancestr1d_lbl 1650 `"Tatar (1990-2000)"', add
label define ancestr1d_lbl 1651 `"Tartar (1980)"', add
label define ancestr1d_lbl 1652 `"Crimean (1980)"', add
label define ancestr1d_lbl 1653 `"Tuvinian (1990-2000)"', add
label define ancestr1d_lbl 1654 `"Soviet Central Asia (1990-2000)"', add
label define ancestr1d_lbl 1655 `"Tadzhik (1980, 2000)"', add
label define ancestr1d_lbl 1690 `"Uzbek"', add
label define ancestr1d_lbl 1710 `"Ukrainian (1980)"', add
label define ancestr1d_lbl 1711 `"Ukrainian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 1712 `"Ruthenian (1980)"', add
label define ancestr1d_lbl 1713 `"Ruthenian (1990-2000)"', add
label define ancestr1d_lbl 1714 `"Lemko"', add
label define ancestr1d_lbl 1715 `"Bioko"', add
label define ancestr1d_lbl 1716 `"Husel"', add
label define ancestr1d_lbl 1717 `"Windish"', add
label define ancestr1d_lbl 1760 `"Yugoslavian"', add
label define ancestr1d_lbl 1780 `"Slav"', add
label define ancestr1d_lbl 1790 `"Slavonian"', add
label define ancestr1d_lbl 1810 `"Central European, nec"', add
label define ancestr1d_lbl 1830 `"Northern European, nec"', add
label define ancestr1d_lbl 1850 `"Southern European, nec"', add
label define ancestr1d_lbl 1870 `"Western European, nec"', add
label define ancestr1d_lbl 1900 `"Eastern European, nec"', add
label define ancestr1d_lbl 1950 `"European, nec"', add
label define ancestr1d_lbl 2000 `"Spaniard (1980)"', add
label define ancestr1d_lbl 2001 `"Spaniard (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2002 `"Castillian (1990-2000)"', add
label define ancestr1d_lbl 2003 `"Valencian (1990-2000)"', add
label define ancestr1d_lbl 2010 `"Andalusian (1990-2000)"', add
label define ancestr1d_lbl 2020 `"Asturian (1990-2000)"', add
label define ancestr1d_lbl 2040 `"Catalonian"', add
label define ancestr1d_lbl 2050 `"Balearic Islander (1980)"', add
label define ancestr1d_lbl 2051 `"Balearic Islander (1990-2000)"', add
label define ancestr1d_lbl 2052 `"Canary Islander (1990-2000)"', add
label define ancestr1d_lbl 2060 `"Galician (1980)"', add
label define ancestr1d_lbl 2061 `"Gallego (1990-2000)"', add
label define ancestr1d_lbl 2062 `"Galician (1990-2000)"', add
label define ancestr1d_lbl 2100 `"Mexican"', add
label define ancestr1d_lbl 2101 `"Mexican (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2102 `"Mexicano/Mexicana (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2103 `"Mexican Indian"', add
label define ancestr1d_lbl 2110 `"Mexican American"', add
label define ancestr1d_lbl 2111 `"Mexican American Indian"', add
label define ancestr1d_lbl 2130 `"Chicano/Chicana"', add
label define ancestr1d_lbl 2180 `"Nuevo Mexicano"', add
label define ancestr1d_lbl 2181 `"Nuevo Mexicano (1990-2000)"', add
label define ancestr1d_lbl 2182 `"La Raza (1990-2000)"', add
label define ancestr1d_lbl 2183 `"Mexican state (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2184 `"Tejano/Tejana (1990-2000)"', add
label define ancestr1d_lbl 2190 `"Californio"', add
label define ancestr1d_lbl 2210 `"Costa Rican"', add
label define ancestr1d_lbl 2220 `"Guatemalan"', add
label define ancestr1d_lbl 2230 `"Honduran"', add
label define ancestr1d_lbl 2240 `"Nicaraguan"', add
label define ancestr1d_lbl 2250 `"Panamanian (1980)"', add
label define ancestr1d_lbl 2251 `"Panamanian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2252 `"Canal Zone (1990-2000)"', add
label define ancestr1d_lbl 2260 `"Salvadoran"', add
label define ancestr1d_lbl 2270 `"Latin American (1980)"', add
label define ancestr1d_lbl 2271 `"Central American (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2272 `"Latin American (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2273 `"Latino/Latina (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2274 `"Latin (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2310 `"Argentinean"', add
label define ancestr1d_lbl 2320 `"Bolivian"', add
label define ancestr1d_lbl 2330 `"Chilean"', add
label define ancestr1d_lbl 2340 `"Colombian"', add
label define ancestr1d_lbl 2350 `"Ecuadorian"', add
label define ancestr1d_lbl 2360 `"Paraguayan"', add
label define ancestr1d_lbl 2370 `"Peruvian"', add
label define ancestr1d_lbl 2380 `"Uruguayan"', add
label define ancestr1d_lbl 2390 `"Venezuelan"', add
label define ancestr1d_lbl 2480 `"South American (1980)"', add
label define ancestr1d_lbl 2481 `"South American (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 2482 `"Criollo/Criolla (1990-2000)"', add
label define ancestr1d_lbl 2610 `"Puerto Rican"', add
label define ancestr1d_lbl 2710 `"Cuban"', add
label define ancestr1d_lbl 2750 `"Dominican"', add
label define ancestr1d_lbl 2900 `"Hispanic"', add
label define ancestr1d_lbl 2910 `"Spanish"', add
label define ancestr1d_lbl 2950 `"Spanish American"', add
label define ancestr1d_lbl 2960 `"Other Spanish/Hispanic"', add
label define ancestr1d_lbl 3000 `"Bahamian"', add
label define ancestr1d_lbl 3010 `"Barbadian"', add
label define ancestr1d_lbl 3020 `"Belizean"', add
label define ancestr1d_lbl 3030 `"Bermudan"', add
label define ancestr1d_lbl 3040 `"Cayman Islander"', add
label define ancestr1d_lbl 3080 `"Jamaican"', add
label define ancestr1d_lbl 3100 `"Dutch West Indies"', add
label define ancestr1d_lbl 3110 `"Aruba Islander"', add
label define ancestr1d_lbl 3120 `"St Maarten Islander"', add
label define ancestr1d_lbl 3140 `"Trinidadian/Tobagonian"', add
label define ancestr1d_lbl 3150 `"Trinidadian"', add
label define ancestr1d_lbl 3160 `"Tobagonian"', add
label define ancestr1d_lbl 3170 `"U.S. Virgin Islander (1980)"', add
label define ancestr1d_lbl 3171 `"U.S. Virgin Islander (1990-2000)"', add
label define ancestr1d_lbl 3172 `"St. Croix Islander (1990-2000)"', add
label define ancestr1d_lbl 3173 `"St. John Islander (1990-2000)"', add
label define ancestr1d_lbl 3174 `"St. Thomas Islander (1990-2000)"', add
label define ancestr1d_lbl 3210 `"British Virgin Islander (1980)"', add
label define ancestr1d_lbl 3211 `"British Virgin Islander (1990-2000)"', add
label define ancestr1d_lbl 3212 `"Antigua (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 3220 `"British West Indian"', add
label define ancestr1d_lbl 3230 `"Turks and Caicos Islander"', add
label define ancestr1d_lbl 3240 `"Anguilla Islander (1980)"', add
label define ancestr1d_lbl 3241 `"Anguilla Islander (1990-2000)"', add
label define ancestr1d_lbl 3242 `"Montserrat Islander (1990-2000)"', add
label define ancestr1d_lbl 3243 `"Kitts/Nevis Islander (1990-2000)"', add
label define ancestr1d_lbl 3244 `"St. Christopher (1980)"', add
label define ancestr1d_lbl 3245 `"St Vincent Islander (1990); Vincent-Grenadine Islander (2000 Census, 2005 ACS, 2005 PRCS)"', add
label define ancestr1d_lbl 3280 `"Dominica Islander"', add
label define ancestr1d_lbl 3290 `"Grenadian"', add
label define ancestr1d_lbl 3310 `"St Lucia Islander"', add
label define ancestr1d_lbl 3320 `"French West Indies"', add
label define ancestr1d_lbl 3330 `"Guadeloupe Islander"', add
label define ancestr1d_lbl 3340 `"Cayenne"', add
label define ancestr1d_lbl 3350 `"West Indian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 3351 `"West Indian (1980)"', add
label define ancestr1d_lbl 3352 `"Caribbean (1980)"', add
label define ancestr1d_lbl 3353 `"Arawak (1980)"', add
label define ancestr1d_lbl 3360 `"Haitian"', add
label define ancestr1d_lbl 3370 `"Other West Indian"', add
label define ancestr1d_lbl 3600 `"Brazilian"', add
label define ancestr1d_lbl 3650 `"San Andres"', add
label define ancestr1d_lbl 3700 `"Guyanese/British Guiana"', add
label define ancestr1d_lbl 3750 `"Providencia"', add
label define ancestr1d_lbl 3800 `"Surinam/Dutch Guiana"', add
label define ancestr1d_lbl 4000 `"Algerian"', add
label define ancestr1d_lbl 4020 `"Egyptian"', add
label define ancestr1d_lbl 4040 `"Libyan"', add
label define ancestr1d_lbl 4060 `"Moroccan (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 4061 `"Moroccan (1980)"', add
label define ancestr1d_lbl 4062 `"Moor (1980)"', add
label define ancestr1d_lbl 4070 `"Ifni"', add
label define ancestr1d_lbl 4080 `"Tunisian"', add
label define ancestr1d_lbl 4110 `"North African"', add
label define ancestr1d_lbl 4120 `"Alhucemas"', add
label define ancestr1d_lbl 4130 `"Berber"', add
label define ancestr1d_lbl 4140 `"Rio de Oro"', add
label define ancestr1d_lbl 4150 `"Bahraini"', add
label define ancestr1d_lbl 4160 `"Iranian"', add
label define ancestr1d_lbl 4170 `"Iraqi"', add
label define ancestr1d_lbl 4190 `"Israeli"', add
label define ancestr1d_lbl 4210 `"Jordanian"', add
label define ancestr1d_lbl 4220 `"Transjordan"', add
label define ancestr1d_lbl 4230 `"Kuwaiti"', add
label define ancestr1d_lbl 4250 `"Lebanese"', add
label define ancestr1d_lbl 4270 `"Saudi Arabian"', add
label define ancestr1d_lbl 4290 `"Syrian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 4291 `"Syrian (1980)"', add
label define ancestr1d_lbl 4292 `"Latakian (1980)"', add
label define ancestr1d_lbl 4293 `"Jebel Druse (1980)"', add
label define ancestr1d_lbl 4310 `"Armenian"', add
label define ancestr1d_lbl 4340 `"Turkish"', add
label define ancestr1d_lbl 4350 `"Yemeni"', add
label define ancestr1d_lbl 4360 `"Omani"', add
label define ancestr1d_lbl 4370 `"Muscat"', add
label define ancestr1d_lbl 4380 `"Trucial Oman"', add
label define ancestr1d_lbl 4390 `"Qatar"', add
label define ancestr1d_lbl 4410 `"Bedouin"', add
label define ancestr1d_lbl 4420 `"Kurdish"', add
label define ancestr1d_lbl 4440 `"Kuria Muria Islander"', add
label define ancestr1d_lbl 4650 `"Palestinian"', add
label define ancestr1d_lbl 4660 `"Gazan"', add
label define ancestr1d_lbl 4670 `"West Bank"', add
label define ancestr1d_lbl 4700 `"South Yemeni"', add
label define ancestr1d_lbl 4710 `"Aden"', add
label define ancestr1d_lbl 4800 `"United Arab Emirates"', add
label define ancestr1d_lbl 4820 `"Assyrian/Chaldean/Syriac (1990-2000)"', add
label define ancestr1d_lbl 4821 `"Assyrian"', add
label define ancestr1d_lbl 4822 `"Syriac (1980, 2000)"', add
label define ancestr1d_lbl 4823 `"Chaldean (2000, ACS, PRCS)"', add
label define ancestr1d_lbl 4900 `"Middle Eastern"', add
label define ancestr1d_lbl 4950 `"Arab"', add
label define ancestr1d_lbl 4951 `"Arabic (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 4960 `"Other Arab"', add
label define ancestr1d_lbl 5000 `"Angolan"', add
label define ancestr1d_lbl 5020 `"Benin"', add
label define ancestr1d_lbl 5040 `"Botswana"', add
label define ancestr1d_lbl 5060 `"Burundian"', add
label define ancestr1d_lbl 5080 `"Cameroonian"', add
label define ancestr1d_lbl 5100 `"Cape Verdean"', add
label define ancestr1d_lbl 5120 `"Central African Republic"', add
label define ancestr1d_lbl 5130 `"Chadian"', add
label define ancestr1d_lbl 5150 `"Congolese"', add
label define ancestr1d_lbl 5160 `"Congo-Brazzaville"', add
label define ancestr1d_lbl 5190 `"Djibouti"', add
label define ancestr1d_lbl 5200 `"Equatorial Guinea"', add
label define ancestr1d_lbl 5210 `"Corsico Islander"', add
label define ancestr1d_lbl 5220 `"Ethiopian"', add
label define ancestr1d_lbl 5230 `"Eritrean"', add
label define ancestr1d_lbl 5250 `"Gabonese"', add
label define ancestr1d_lbl 5270 `"Gambian"', add
label define ancestr1d_lbl 5290 `"Ghanian"', add
label define ancestr1d_lbl 5300 `"Guinean"', add
label define ancestr1d_lbl 5310 `"Guinea Bissau"', add
label define ancestr1d_lbl 5320 `"Ivory Coast"', add
label define ancestr1d_lbl 5340 `"Kenyan"', add
label define ancestr1d_lbl 5380 `"Lesotho"', add
label define ancestr1d_lbl 5410 `"Liberian"', add
label define ancestr1d_lbl 5430 `"Madagascan"', add
label define ancestr1d_lbl 5450 `"Malawian"', add
label define ancestr1d_lbl 5460 `"Malian"', add
label define ancestr1d_lbl 5470 `"Mauritanian"', add
label define ancestr1d_lbl 5490 `"Mozambican"', add
label define ancestr1d_lbl 5500 `"Namibian"', add
label define ancestr1d_lbl 5510 `"Niger"', add
label define ancestr1d_lbl 5530 `"Nigerian"', add
label define ancestr1d_lbl 5540 `"Fulani"', add
label define ancestr1d_lbl 5550 `"Hausa"', add
label define ancestr1d_lbl 5560 `"Ibo"', add
label define ancestr1d_lbl 5570 `"Tiv (1980)"', add
label define ancestr1d_lbl 5571 `"Tiv (1990-2000)"', add
label define ancestr1d_lbl 5572 `"Yoruba (1990-2000)"', add
label define ancestr1d_lbl 5610 `"Rwandan"', add
label define ancestr1d_lbl 5640 `"Senegalese"', add
label define ancestr1d_lbl 5660 `"Sierra Leonean"', add
label define ancestr1d_lbl 5680 `"Somalian"', add
label define ancestr1d_lbl 5690 `"Swaziland"', add
label define ancestr1d_lbl 5700 `"South African"', add
label define ancestr1d_lbl 5710 `"Union of South Africa"', add
label define ancestr1d_lbl 5720 `"Afrikaner"', add
label define ancestr1d_lbl 5730 `"Natalian"', add
label define ancestr1d_lbl 5740 `"Zulu"', add
label define ancestr1d_lbl 5760 `"Sudanese"', add
label define ancestr1d_lbl 5770 `"Dinka"', add
label define ancestr1d_lbl 5780 `"Nuer"', add
label define ancestr1d_lbl 5790 `"Fur"', add
label define ancestr1d_lbl 5800 `"Baggara"', add
label define ancestr1d_lbl 5820 `"Tanzanian"', add
label define ancestr1d_lbl 5830 `"Tanganyikan"', add
label define ancestr1d_lbl 5840 `"Zanzibar"', add
label define ancestr1d_lbl 5860 `"Togo"', add
label define ancestr1d_lbl 5880 `"Ugandan"', add
label define ancestr1d_lbl 5890 `"Upper Voltan"', add
label define ancestr1d_lbl 5900 `"Volta"', add
label define ancestr1d_lbl 5910 `"Zairian"', add
label define ancestr1d_lbl 5920 `"Zambian"', add
label define ancestr1d_lbl 5930 `"Zimbabwean"', add
label define ancestr1d_lbl 5940 `"African Islands (1980)"', add
label define ancestr1d_lbl 5941 `"African Islands (1990-2000)"', add
label define ancestr1d_lbl 5942 `"Mauritius (1990-2000)"', add
label define ancestr1d_lbl 5950 `"Other Subsaharan Africa"', add
label define ancestr1d_lbl 5960 `"Central African"', add
label define ancestr1d_lbl 5970 `"East African"', add
label define ancestr1d_lbl 5980 `"West African"', add
label define ancestr1d_lbl 5990 `"African"', add
label define ancestr1d_lbl 6000 `"Afghan"', add
label define ancestr1d_lbl 6010 `"Baluchi"', add
label define ancestr1d_lbl 6020 `"Pathan"', add
label define ancestr1d_lbl 6030 `"Bengali (1980)"', add
label define ancestr1d_lbl 6031 `"Bangladeshi (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 6032 `"Bengali (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 6070 `"Bhutanese"', add
label define ancestr1d_lbl 6090 `"Nepali"', add
label define ancestr1d_lbl 6150 `"Asian Indian (1980)"', add
label define ancestr1d_lbl 6151 `"India (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 6152 `"East Indian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 6153 `"Madhya Pradesh (1990-2000)"', add
label define ancestr1d_lbl 6154 `"Orissa (1990-2000)"', add
label define ancestr1d_lbl 6155 `"Rajasthani (1990-2000)"', add
label define ancestr1d_lbl 6156 `"Sikkim (1990-2000)"', add
label define ancestr1d_lbl 6157 `"Uttar Pradesh (1990-2000)"', add
label define ancestr1d_lbl 6220 `"Andaman Islander"', add
label define ancestr1d_lbl 6240 `"Andhra Pradesh"', add
label define ancestr1d_lbl 6260 `"Assamese"', add
label define ancestr1d_lbl 6280 `"Goanese"', add
label define ancestr1d_lbl 6300 `"Gujarati"', add
label define ancestr1d_lbl 6320 `"Karnatakan"', add
label define ancestr1d_lbl 6340 `"Keralan"', add
label define ancestr1d_lbl 6380 `"Maharashtran"', add
label define ancestr1d_lbl 6400 `"Madrasi"', add
label define ancestr1d_lbl 6420 `"Mysore"', add
label define ancestr1d_lbl 6440 `"Naga"', add
label define ancestr1d_lbl 6480 `"Pondicherry"', add
label define ancestr1d_lbl 6500 `"Punjabi"', add
label define ancestr1d_lbl 6560 `"Tamil"', add
label define ancestr1d_lbl 6750 `"East Indies (1990-2000)"', add
label define ancestr1d_lbl 6800 `"Pakistani (1980)"', add
label define ancestr1d_lbl 6801 `"Pakistani (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 6802 `"Kashmiri (1990-2000)"', add
label define ancestr1d_lbl 6900 `"Sri Lankan"', add
label define ancestr1d_lbl 6910 `"Singhalese"', add
label define ancestr1d_lbl 6920 `"Veddah"', add
label define ancestr1d_lbl 6950 `"Maldivian"', add
label define ancestr1d_lbl 7000 `"Burmese (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 7001 `"Burmese (1980)"', add
label define ancestr1d_lbl 7002 `"Burman (1980)"', add
label define ancestr1d_lbl 7020 `"Shan"', add
label define ancestr1d_lbl 7030 `"Cambodian"', add
label define ancestr1d_lbl 7040 `"Khmer"', add
label define ancestr1d_lbl 7060 `"Chinese"', add
label define ancestr1d_lbl 7070 `"Cantonese (1980)"', add
label define ancestr1d_lbl 7071 `"Cantonese (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 7072 `"Formosan (1990-2000)"', add
label define ancestr1d_lbl 7080 `"Manchurian"', add
label define ancestr1d_lbl 7090 `"Mandarin (1990-2000)"', add
label define ancestr1d_lbl 7120 `"Mongolian (1980)"', add
label define ancestr1d_lbl 7121 `"Mongolian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 7122 `"Kalmyk (1990-2000)"', add
label define ancestr1d_lbl 7140 `"Tibetan"', add
label define ancestr1d_lbl 7160 `"Hong Kong (1990-2000)"', add
label define ancestr1d_lbl 7161 `"Hong Kong (1980)"', add
label define ancestr1d_lbl 7162 `"Eastern Archipelago (1980)"', add
label define ancestr1d_lbl 7180 `"Macao"', add
label define ancestr1d_lbl 7200 `"Filipino"', add
label define ancestr1d_lbl 7300 `"Indonesian (1980)"', add
label define ancestr1d_lbl 7301 `"Indonesian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 7302 `"Borneo (1990-2000)"', add
label define ancestr1d_lbl 7303 `"Java (1990-2000)"', add
label define ancestr1d_lbl 7304 `"Sumatran (1990-2000)"', add
label define ancestr1d_lbl 7400 `"Japanese (1980)"', add
label define ancestr1d_lbl 7401 `"Japanese (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 7402 `"Issei (1990-2000)"', add
label define ancestr1d_lbl 7403 `"Nisei (1990-2000)"', add
label define ancestr1d_lbl 7404 `"Sansei (1990-2000)"', add
label define ancestr1d_lbl 7405 `"Yonsei (1990-2000)"', add
label define ancestr1d_lbl 7406 `"Gosei (1990-2000)"', add
label define ancestr1d_lbl 7460 `"Ryukyu Islander"', add
label define ancestr1d_lbl 7480 `"Okinawan"', add
label define ancestr1d_lbl 7500 `"Korean"', add
label define ancestr1d_lbl 7650 `"Laotian"', add
label define ancestr1d_lbl 7660 `"Meo"', add
label define ancestr1d_lbl 7680 `"Hmong"', add
label define ancestr1d_lbl 7700 `"Malaysian (1980)"', add
label define ancestr1d_lbl 7701 `"Malaysian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 7702 `"North Borneo (1990-2000)"', add
label define ancestr1d_lbl 7740 `"Singaporean"', add
label define ancestr1d_lbl 7760 `"Thai"', add
label define ancestr1d_lbl 7770 `"Black Thai"', add
label define ancestr1d_lbl 7780 `"Western Lao"', add
label define ancestr1d_lbl 7820 `"Taiwanese"', add
label define ancestr1d_lbl 7850 `"Vietnamese"', add
label define ancestr1d_lbl 7860 `"Katu"', add
label define ancestr1d_lbl 7870 `"Ma"', add
label define ancestr1d_lbl 7880 `"Mnong"', add
label define ancestr1d_lbl 7900 `"Montagnard"', add
label define ancestr1d_lbl 7920 `"Indochinese"', add
label define ancestr1d_lbl 7930 `"Eurasian"', add
label define ancestr1d_lbl 7931 `"Amerasian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 7950 `"Asian"', add
label define ancestr1d_lbl 7960 `"Other Asian"', add
label define ancestr1d_lbl 8000 `"Australian"', add
label define ancestr1d_lbl 8010 `"Tasmanian"', add
label define ancestr1d_lbl 8020 `"Australian Aborigine (1990-2000)"', add
label define ancestr1d_lbl 8030 `"New Zealander"', add
label define ancestr1d_lbl 8080 `"Polynesian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 8081 `"Polynesian (1980)"', add
label define ancestr1d_lbl 8082 `"Norfolk Islander (1980)"', add
label define ancestr1d_lbl 8090 `"Kapinagamarangan (1990-2000)"', add
label define ancestr1d_lbl 8091 `"Kapinagamarangan (1980)"', add
label define ancestr1d_lbl 8092 `"Nukuoroan (1980)"', add
label define ancestr1d_lbl 8100 `"Maori"', add
label define ancestr1d_lbl 8110 `"Hawaiian"', add
label define ancestr1d_lbl 8130 `"Part Hawaiian"', add
label define ancestr1d_lbl 8140 `"Samoan (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 8141 `"Samoan (1980)"', add
label define ancestr1d_lbl 8142 `"American Samoan (1980)"', add
label define ancestr1d_lbl 8143 `"French Samoan"', add
label define ancestr1d_lbl 8144 `"Part Samoan (1990-2000)"', add
label define ancestr1d_lbl 8150 `"Tongan"', add
label define ancestr1d_lbl 8160 `"Tokelauan"', add
label define ancestr1d_lbl 8170 `"Cook Islander"', add
label define ancestr1d_lbl 8180 `"Tahitian"', add
label define ancestr1d_lbl 8190 `"Niuean"', add
label define ancestr1d_lbl 8200 `"Micronesian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 8201 `"Micronesian (1980)"', add
label define ancestr1d_lbl 8202 `"U.S. Trust Terr of the Pacific (1980)"', add
label define ancestr1d_lbl 8210 `"Guamanian"', add
label define ancestr1d_lbl 8220 `"Chamorro Islander"', add
label define ancestr1d_lbl 8230 `"Saipanese (1990-2000)"', add
label define ancestr1d_lbl 8231 `"Saipanese (1980)"', add
label define ancestr1d_lbl 8232 `"Northern Marianas (1980)"', add
label define ancestr1d_lbl 8240 `"Palauan"', add
label define ancestr1d_lbl 8250 `"Marshall Islander"', add
label define ancestr1d_lbl 8260 `"Kosraean"', add
label define ancestr1d_lbl 8270 `"Ponapean (1990-2000)"', add
label define ancestr1d_lbl 8271 `"Ponapean (1980)"', add
label define ancestr1d_lbl 8272 `"Mokilese (1980)"', add
label define ancestr1d_lbl 8273 `"Ngatikese (1980)"', add
label define ancestr1d_lbl 8274 `"Pingelapese (1980)"', add
label define ancestr1d_lbl 8280 `"Chuukese (1990-2000)"', add
label define ancestr1d_lbl 8281 `"Hall Islander (1980)"', add
label define ancestr1d_lbl 8282 `"Mortlockese (1980)"', add
label define ancestr1d_lbl 8283 `"Namanouito (1980)"', add
label define ancestr1d_lbl 8284 `"Pulawatese (1980)"', add
label define ancestr1d_lbl 8285 `"Truk Islander"', add
label define ancestr1d_lbl 8290 `"Yap Islander"', add
label define ancestr1d_lbl 8300 `"Caroline Islander (1990-2000)"', add
label define ancestr1d_lbl 8301 `"Caroline Islander (1980)"', add
label define ancestr1d_lbl 8302 `"Lamotrekese (1980)"', add
label define ancestr1d_lbl 8303 `"Ulithian (1980)"', add
label define ancestr1d_lbl 8304 `"Woleaian (1980)"', add
label define ancestr1d_lbl 8310 `"Kiribatese"', add
label define ancestr1d_lbl 8320 `"Nauruan"', add
label define ancestr1d_lbl 8330 `"Tarawa Islander (1990-2000)"', add
label define ancestr1d_lbl 8340 `"Tinian Islander (1990-2000)"', add
label define ancestr1d_lbl 8400 `"Melanesian Islander"', add
label define ancestr1d_lbl 8410 `"Fijian"', add
label define ancestr1d_lbl 8430 `"New Guinean"', add
label define ancestr1d_lbl 8440 `"Papuan"', add
label define ancestr1d_lbl 8450 `"Solomon Islander"', add
label define ancestr1d_lbl 8460 `"New Caledonian Islander"', add
label define ancestr1d_lbl 8470 `"Vanuatuan"', add
label define ancestr1d_lbl 8500 `"Pacific Islander (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 8501 `"Campbell Islander (1980)"', add
label define ancestr1d_lbl 8502 `"Christmas Islander (1980)"', add
label define ancestr1d_lbl 8503 `"Kermadec Islander (1980)"', add
label define ancestr1d_lbl 8504 `"Midway Islander (1980)"', add
label define ancestr1d_lbl 8505 `"Phoenix Islander (1980)"', add
label define ancestr1d_lbl 8506 `"Wake Islander (1980)"', add
label define ancestr1d_lbl 8600 `"Oceania"', add
label define ancestr1d_lbl 8620 `"Chamolinian (1990-2000)"', add
label define ancestr1d_lbl 8630 `"Reserved Codes"', add
label define ancestr1d_lbl 8700 `"Other Pacific"', add
label define ancestr1d_lbl 9000 `"Afro-American"', add
label define ancestr1d_lbl 9001 `"Afro-American (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9002 `"Black (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9003 `"Negro (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9004 `"Nonwhite (1990-2000)"', add
label define ancestr1d_lbl 9005 `"Colored (1990-2000)"', add
label define ancestr1d_lbl 9006 `"Creole (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9007 `"Mulatto (1990-2000)"', add
label define ancestr1d_lbl 9008 `"Afro"', add
label define ancestr1d_lbl 9020 `"African-American (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9130 `"Central American Indian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9140 `"South American Indian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9200 `"American Indian (all tribes)"', add
label define ancestr1d_lbl 9201 `"American Indian-English-French"', add
label define ancestr1d_lbl 9202 `"American Indian-English-German"', add
label define ancestr1d_lbl 9203 `"American Indian-English-Irish"', add
label define ancestr1d_lbl 9204 `"American Indian-German-Irish"', add
label define ancestr1d_lbl 9205 `"Cherokee"', add
label define ancestr1d_lbl 9206 `"Native American"', add
label define ancestr1d_lbl 9207 `"Indian"', add
label define ancestr1d_lbl 9210 `"Aleut"', add
label define ancestr1d_lbl 9220 `"Eskimo"', add
label define ancestr1d_lbl 9230 `"Inuit"', add
label define ancestr1d_lbl 9240 `"White/Caucasian"', add
label define ancestr1d_lbl 9241 `"White/Caucasian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9242 `"Anglo (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9243 `"Appalachian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9244 `"Aryan (1990-2000)"', add
label define ancestr1d_lbl 9300 `"Greenlander"', add
label define ancestr1d_lbl 9310 `"Canadian"', add
label define ancestr1d_lbl 9330 `"Newfoundland"', add
label define ancestr1d_lbl 9340 `"Nova Scotian"', add
label define ancestr1d_lbl 9350 `"French Canadian"', add
label define ancestr1d_lbl 9360 `"Acadian"', add
label define ancestr1d_lbl 9361 `"Acadian (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9362 `"Cajun (1990-2000, ACS, PRCS)"', add
label define ancestr1d_lbl 9390 `"American"', add
label define ancestr1d_lbl 9391 `"American/United States"', add
label define ancestr1d_lbl 9400 `"United States"', add
label define ancestr1d_lbl 9410 `"Alabama"', add
label define ancestr1d_lbl 9420 `"Alaska"', add
label define ancestr1d_lbl 9430 `"Arizona"', add
label define ancestr1d_lbl 9440 `"Arkansas"', add
label define ancestr1d_lbl 9450 `"California"', add
label define ancestr1d_lbl 9460 `"Colorado"', add
label define ancestr1d_lbl 9470 `"Connecticut"', add
label define ancestr1d_lbl 9480 `"District of Columbia"', add
label define ancestr1d_lbl 9490 `"Delaware"', add
label define ancestr1d_lbl 9500 `"Florida"', add
label define ancestr1d_lbl 9510 `"Georgia"', add
label define ancestr1d_lbl 9520 `"Idaho"', add
label define ancestr1d_lbl 9530 `"Illinois"', add
label define ancestr1d_lbl 9540 `"Indiana"', add
label define ancestr1d_lbl 9550 `"Iowa"', add
label define ancestr1d_lbl 9560 `"Kansas"', add
label define ancestr1d_lbl 9570 `"Kentucky"', add
label define ancestr1d_lbl 9580 `"Louisiana"', add
label define ancestr1d_lbl 9590 `"Maine"', add
label define ancestr1d_lbl 9600 `"Maryland"', add
label define ancestr1d_lbl 9610 `"Massachusetts"', add
label define ancestr1d_lbl 9620 `"Michigan"', add
label define ancestr1d_lbl 9630 `"Minnesota"', add
label define ancestr1d_lbl 9640 `"Mississippi"', add
label define ancestr1d_lbl 9650 `"Missouri"', add
label define ancestr1d_lbl 9660 `"Montana"', add
label define ancestr1d_lbl 9670 `"Nebraska"', add
label define ancestr1d_lbl 9680 `"Nevada"', add
label define ancestr1d_lbl 9690 `"New Hampshire"', add
label define ancestr1d_lbl 9700 `"New Jersey"', add
label define ancestr1d_lbl 9710 `"New Mexico"', add
label define ancestr1d_lbl 9720 `"New York"', add
label define ancestr1d_lbl 9730 `"North Carolina"', add
label define ancestr1d_lbl 9740 `"North Dakota"', add
label define ancestr1d_lbl 9750 `"Ohio"', add
label define ancestr1d_lbl 9760 `"Oklahoma"', add
label define ancestr1d_lbl 9770 `"Oregon"', add
label define ancestr1d_lbl 9780 `"Pennsylvania"', add
label define ancestr1d_lbl 9790 `"Rhode Island"', add
label define ancestr1d_lbl 9800 `"South Carolina"', add
label define ancestr1d_lbl 9810 `"South Dakota"', add
label define ancestr1d_lbl 9820 `"Tennessee"', add
label define ancestr1d_lbl 9830 `"Texas"', add
label define ancestr1d_lbl 9840 `"Utah"', add
label define ancestr1d_lbl 9850 `"Vermont"', add
label define ancestr1d_lbl 9860 `"Virginia"', add
label define ancestr1d_lbl 9870 `"Washington"', add
label define ancestr1d_lbl 9880 `"West Virginia"', add
label define ancestr1d_lbl 9890 `"Wisconsin"', add
label define ancestr1d_lbl 9900 `"Wyoming"', add
label define ancestr1d_lbl 9930 `"Southerner"', add
label define ancestr1d_lbl 9940 `"North American"', add
label define ancestr1d_lbl 9950 `"Mixture"', add
label define ancestr1d_lbl 9960 `"Uncodable"', add
label define ancestr1d_lbl 9961 `"Not Classified"', add
label define ancestr1d_lbl 9962 `"Suppressed"', add
label define ancestr1d_lbl 9980 `"Other"', add
label define ancestr1d_lbl 9990 `"Not Reported"', add
label values ancestr1d ancestr1d_lbl

label define ancestr2_lbl 001 `"Alsatian, Alsace-Lorraine"'
label define ancestr2_lbl 002 `"Andorran"', add
label define ancestr2_lbl 003 `"Austrian"', add
label define ancestr2_lbl 004 `"Tirolean"', add
label define ancestr2_lbl 005 `"Basque"', add
label define ancestr2_lbl 006 `"French Basque"', add
label define ancestr2_lbl 008 `"Belgian"', add
label define ancestr2_lbl 009 `"Flemish"', add
label define ancestr2_lbl 010 `"Walloon"', add
label define ancestr2_lbl 011 `"British"', add
label define ancestr2_lbl 012 `"British Isles"', add
label define ancestr2_lbl 013 `"Channel Islander"', add
label define ancestr2_lbl 014 `"Gibraltan"', add
label define ancestr2_lbl 015 `"Cornish"', add
label define ancestr2_lbl 016 `"Corsican"', add
label define ancestr2_lbl 017 `"Cypriot"', add
label define ancestr2_lbl 018 `"Greek Cypriote"', add
label define ancestr2_lbl 019 `"Turkish Cypriote"', add
label define ancestr2_lbl 020 `"Danish"', add
label define ancestr2_lbl 021 `"Dutch"', add
label define ancestr2_lbl 022 `"English"', add
label define ancestr2_lbl 023 `"Faeroe Islander"', add
label define ancestr2_lbl 024 `"Finnish"', add
label define ancestr2_lbl 025 `"Karelian"', add
label define ancestr2_lbl 026 `"French"', add
label define ancestr2_lbl 027 `"Lorrainian"', add
label define ancestr2_lbl 028 `"Breton"', add
label define ancestr2_lbl 029 `"Frisian"', add
label define ancestr2_lbl 030 `"Friulian"', add
label define ancestr2_lbl 032 `"German"', add
label define ancestr2_lbl 033 `"Bavarian"', add
label define ancestr2_lbl 034 `"Berliner"', add
label define ancestr2_lbl 035 `"Hamburger"', add
label define ancestr2_lbl 036 `"Hanoverian"', add
label define ancestr2_lbl 037 `"Hessian"', add
label define ancestr2_lbl 038 `"Lubecker"', add
label define ancestr2_lbl 039 `"Pomeranian"', add
label define ancestr2_lbl 040 `"Prussian"', add
label define ancestr2_lbl 041 `"Saxon"', add
label define ancestr2_lbl 042 `"Sudetenlander"', add
label define ancestr2_lbl 043 `"Westphalian"', add
label define ancestr2_lbl 046 `"Greek"', add
label define ancestr2_lbl 047 `"Cretan"', add
label define ancestr2_lbl 048 `"Cycladic Islander"', add
label define ancestr2_lbl 049 `"Icelander"', add
label define ancestr2_lbl 050 `"Irish"', add
label define ancestr2_lbl 051 `"Italian"', add
label define ancestr2_lbl 053 `"Abruzzi"', add
label define ancestr2_lbl 054 `"Apulian"', add
label define ancestr2_lbl 055 `"Basilicata"', add
label define ancestr2_lbl 056 `"Calabrian"', add
label define ancestr2_lbl 057 `"Amalfin"', add
label define ancestr2_lbl 058 `"Emilia Romagna"', add
label define ancestr2_lbl 059 `"Rome"', add
label define ancestr2_lbl 060 `"Ligurian"', add
label define ancestr2_lbl 061 `"Lombardian"', add
label define ancestr2_lbl 062 `"Marches"', add
label define ancestr2_lbl 063 `"Molise"', add
label define ancestr2_lbl 064 `"Neapolitan"', add
label define ancestr2_lbl 065 `"Piedmontese"', add
label define ancestr2_lbl 066 `"Puglia"', add
label define ancestr2_lbl 067 `"Sardinian"', add
label define ancestr2_lbl 068 `"Sicilian"', add
label define ancestr2_lbl 069 `"Toscana"', add
label define ancestr2_lbl 070 `"Trentino"', add
label define ancestr2_lbl 071 `"Umbrian"', add
label define ancestr2_lbl 072 `"Valle dAosta"', add
label define ancestr2_lbl 073 `"Venetian"', add
label define ancestr2_lbl 075 `"Lapp"', add
label define ancestr2_lbl 076 `"Liechtensteiner"', add
label define ancestr2_lbl 077 `"Luxemburger"', add
label define ancestr2_lbl 078 `"Maltese"', add
label define ancestr2_lbl 079 `"Manx"', add
label define ancestr2_lbl 080 `"Monegasque"', add
label define ancestr2_lbl 081 `"Northern Irelander"', add
label define ancestr2_lbl 082 `"Norwegian"', add
label define ancestr2_lbl 084 `"Portuguese"', add
label define ancestr2_lbl 085 `"Azorean"', add
label define ancestr2_lbl 086 `"Madeiran"', add
label define ancestr2_lbl 087 `"Scotch Irish"', add
label define ancestr2_lbl 088 `"Scottish"', add
label define ancestr2_lbl 089 `"Swedish"', add
label define ancestr2_lbl 090 `"Aland Islander"', add
label define ancestr2_lbl 091 `"Swiss"', add
label define ancestr2_lbl 092 `"Suisse"', add
label define ancestr2_lbl 095 `"Romansch"', add
label define ancestr2_lbl 096 `"Suisse Romane"', add
label define ancestr2_lbl 097 `"Welsh"', add
label define ancestr2_lbl 098 `"Scandinavian, Nordic"', add
label define ancestr2_lbl 100 `"Albanian"', add
label define ancestr2_lbl 101 `"Azerbaijani"', add
label define ancestr2_lbl 102 `"Belourussian"', add
label define ancestr2_lbl 103 `"Bulgarian"', add
label define ancestr2_lbl 105 `"Carpathian"', add
label define ancestr2_lbl 108 `"Cossack"', add
label define ancestr2_lbl 109 `"Croatian"', add
label define ancestr2_lbl 111 `"Czechoslovakian"', add
label define ancestr2_lbl 112 `"Bohemian"', add
label define ancestr2_lbl 115 `"Estonian"', add
label define ancestr2_lbl 116 `"Livonian"', add
label define ancestr2_lbl 117 `"Finno Ugrian"', add
label define ancestr2_lbl 118 `"Mordovian"', add
label define ancestr2_lbl 119 `"Voytak"', add
label define ancestr2_lbl 120 `"Georgian"', add
label define ancestr2_lbl 122 `"Germans from Russia"', add
label define ancestr2_lbl 123 `"Gruziia"', add
label define ancestr2_lbl 124 `"Rom"', add
label define ancestr2_lbl 125 `"Hungarian"', add
label define ancestr2_lbl 126 `"Magyar"', add
label define ancestr2_lbl 128 `"Latvian"', add
label define ancestr2_lbl 129 `"Lithuanian"', add
label define ancestr2_lbl 130 `"Macedonian"', add
label define ancestr2_lbl 132 `"North Caucasian"', add
label define ancestr2_lbl 133 `"North Caucasian Turkic"', add
label define ancestr2_lbl 140 `"Ossetian"', add
label define ancestr2_lbl 142 `"Polish"', add
label define ancestr2_lbl 143 `"Kashubian"', add
label define ancestr2_lbl 144 `"Romanian"', add
label define ancestr2_lbl 145 `"Bessarabian"', add
label define ancestr2_lbl 146 `"Moldavian"', add
label define ancestr2_lbl 147 `"Wallachian"', add
label define ancestr2_lbl 148 `"Russian"', add
label define ancestr2_lbl 150 `"Muscovite"', add
label define ancestr2_lbl 152 `"Serbian"', add
label define ancestr2_lbl 153 `"Slovak"', add
label define ancestr2_lbl 154 `"Slovene"', add
label define ancestr2_lbl 155 `"Sorb/Wend"', add
label define ancestr2_lbl 156 `"Soviet Turkic"', add
label define ancestr2_lbl 157 `"Bashkir"', add
label define ancestr2_lbl 158 `"Chevash"', add
label define ancestr2_lbl 159 `"Gagauz"', add
label define ancestr2_lbl 160 `"Mesknetian"', add
label define ancestr2_lbl 163 `"Yakut"', add
label define ancestr2_lbl 164 `"Soviet Union, nec"', add
label define ancestr2_lbl 165 `"Tatar"', add
label define ancestr2_lbl 169 `"Uzbek"', add
label define ancestr2_lbl 171 `"Ukrainian"', add
label define ancestr2_lbl 176 `"Yugoslavian"', add
label define ancestr2_lbl 178 `"Slav"', add
label define ancestr2_lbl 179 `"Slavonian"', add
label define ancestr2_lbl 181 `"Central European, nec"', add
label define ancestr2_lbl 183 `"Northern European, nec"', add
label define ancestr2_lbl 185 `"Southern European, nec"', add
label define ancestr2_lbl 187 `"Western European, nec"', add
label define ancestr2_lbl 190 `"Eastern European, nec"', add
label define ancestr2_lbl 195 `"European, nec"', add
label define ancestr2_lbl 200 `"Spaniard"', add
label define ancestr2_lbl 201 `"Andalusian"', add
label define ancestr2_lbl 202 `"Astorian"', add
label define ancestr2_lbl 204 `"Catalonian"', add
label define ancestr2_lbl 205 `"Balearic Islander"', add
label define ancestr2_lbl 206 `"Galician"', add
label define ancestr2_lbl 210 `"Mexican"', add
label define ancestr2_lbl 211 `"Mexican American"', add
label define ancestr2_lbl 213 `"Chicano/Chicana"', add
label define ancestr2_lbl 218 `"Nuevo Mexicano"', add
label define ancestr2_lbl 219 `"Californio"', add
label define ancestr2_lbl 221 `"Costa Rican"', add
label define ancestr2_lbl 222 `"Guatemalan"', add
label define ancestr2_lbl 223 `"Honduran"', add
label define ancestr2_lbl 224 `"Nicaraguan"', add
label define ancestr2_lbl 225 `"Panamanian"', add
label define ancestr2_lbl 226 `"Salvadoran"', add
label define ancestr2_lbl 227 `"Latin American"', add
label define ancestr2_lbl 231 `"Argentinean"', add
label define ancestr2_lbl 232 `"Bolivian"', add
label define ancestr2_lbl 233 `"Chilean"', add
label define ancestr2_lbl 234 `"Colombian"', add
label define ancestr2_lbl 235 `"Ecuadorian"', add
label define ancestr2_lbl 236 `"Paraguayan"', add
label define ancestr2_lbl 237 `"Peruvian"', add
label define ancestr2_lbl 238 `"Uruguayan"', add
label define ancestr2_lbl 239 `"Venezuelan"', add
label define ancestr2_lbl 248 `"South American"', add
label define ancestr2_lbl 261 `"Puerto Rican"', add
label define ancestr2_lbl 271 `"Cuban"', add
label define ancestr2_lbl 275 `"Dominican"', add
label define ancestr2_lbl 290 `"Hispanic"', add
label define ancestr2_lbl 291 `"Spanish"', add
label define ancestr2_lbl 295 `"Spanish American"', add
label define ancestr2_lbl 296 `"Other Spanish/Hispanic"', add
label define ancestr2_lbl 300 `"Bahamian"', add
label define ancestr2_lbl 301 `"Barbadian"', add
label define ancestr2_lbl 302 `"Belizean"', add
label define ancestr2_lbl 303 `"Bermudan"', add
label define ancestr2_lbl 304 `"Cayman Islander"', add
label define ancestr2_lbl 308 `"Jamaican"', add
label define ancestr2_lbl 310 `"Dutch West Indies"', add
label define ancestr2_lbl 311 `"Aruba Islander"', add
label define ancestr2_lbl 312 `"St Maarten Islander"', add
label define ancestr2_lbl 314 `"Trinidadian/Tobagonian"', add
label define ancestr2_lbl 315 `"Trinidadian"', add
label define ancestr2_lbl 316 `"Tobagonian"', add
label define ancestr2_lbl 317 `"U.S. Virgin Islander"', add
label define ancestr2_lbl 321 `"British Virgin Islander"', add
label define ancestr2_lbl 322 `"British West Indian"', add
label define ancestr2_lbl 323 `"Turks and Caicos Islander"', add
label define ancestr2_lbl 324 `"Anguilla Islander"', add
label define ancestr2_lbl 328 `"Dominica Islander"', add
label define ancestr2_lbl 329 `"Grenadian"', add
label define ancestr2_lbl 331 `"St Lucia Islander"', add
label define ancestr2_lbl 332 `"French West Indies"', add
label define ancestr2_lbl 333 `"Guadeloupe Islander"', add
label define ancestr2_lbl 334 `"Cayenne"', add
label define ancestr2_lbl 335 `"West Indian"', add
label define ancestr2_lbl 336 `"Haitian"', add
label define ancestr2_lbl 337 `"Other West Indian"', add
label define ancestr2_lbl 360 `"Brazilian"', add
label define ancestr2_lbl 365 `"San Andres"', add
label define ancestr2_lbl 370 `"Guyanese/British Guiana"', add
label define ancestr2_lbl 375 `"Providencia"', add
label define ancestr2_lbl 380 `"Surinam/Dutch Guiana"', add
label define ancestr2_lbl 400 `"Algerian"', add
label define ancestr2_lbl 402 `"Egyptian"', add
label define ancestr2_lbl 404 `"Libyan"', add
label define ancestr2_lbl 406 `"Moroccan"', add
label define ancestr2_lbl 407 `"Ifni"', add
label define ancestr2_lbl 408 `"Tunisian"', add
label define ancestr2_lbl 411 `"North African"', add
label define ancestr2_lbl 412 `"Alhucemas"', add
label define ancestr2_lbl 413 `"Berber"', add
label define ancestr2_lbl 414 `"Rio de Oro"', add
label define ancestr2_lbl 415 `"Bahraini"', add
label define ancestr2_lbl 416 `"Iranian"', add
label define ancestr2_lbl 417 `"Iraqi"', add
label define ancestr2_lbl 419 `"Israeli"', add
label define ancestr2_lbl 421 `"Jordanian"', add
label define ancestr2_lbl 422 `"Transjordan"', add
label define ancestr2_lbl 423 `"Kuwaiti"', add
label define ancestr2_lbl 425 `"Lebanese"', add
label define ancestr2_lbl 427 `"Saudi Arabian"', add
label define ancestr2_lbl 429 `"Syrian"', add
label define ancestr2_lbl 431 `"Armenian"', add
label define ancestr2_lbl 434 `"Turkish"', add
label define ancestr2_lbl 435 `"Yemeni"', add
label define ancestr2_lbl 436 `"Omani"', add
label define ancestr2_lbl 437 `"Muscat"', add
label define ancestr2_lbl 438 `"Trucial Oman"', add
label define ancestr2_lbl 439 `"Qatar"', add
label define ancestr2_lbl 441 `"Bedouin"', add
label define ancestr2_lbl 442 `"Kurdish"', add
label define ancestr2_lbl 444 `"Kuria Muria Islander"', add
label define ancestr2_lbl 465 `"Palestinian"', add
label define ancestr2_lbl 466 `"Gazan"', add
label define ancestr2_lbl 467 `"West Bank"', add
label define ancestr2_lbl 470 `"South Yemeni"', add
label define ancestr2_lbl 471 `"Aden"', add
label define ancestr2_lbl 480 `"United Arab Emirates"', add
label define ancestr2_lbl 482 `"Assyrian/Chaldean/Syriac"', add
label define ancestr2_lbl 490 `"Middle Eastern"', add
label define ancestr2_lbl 495 `"Arab"', add
label define ancestr2_lbl 496 `"Other Arab"', add
label define ancestr2_lbl 500 `"Angolan"', add
label define ancestr2_lbl 502 `"Benin"', add
label define ancestr2_lbl 504 `"Botswana"', add
label define ancestr2_lbl 506 `"Burundian"', add
label define ancestr2_lbl 508 `"Cameroonian"', add
label define ancestr2_lbl 510 `"Cape Verdean"', add
label define ancestr2_lbl 513 `"Chadian"', add
label define ancestr2_lbl 515 `"Congolese"', add
label define ancestr2_lbl 516 `"Congo-Brazzaville"', add
label define ancestr2_lbl 519 `"Djibouti"', add
label define ancestr2_lbl 520 `"Equatorial Guinea"', add
label define ancestr2_lbl 521 `"Corsico Islander"', add
label define ancestr2_lbl 522 `"Ethiopian"', add
label define ancestr2_lbl 523 `"Eritrean"', add
label define ancestr2_lbl 525 `"Gabonese"', add
label define ancestr2_lbl 527 `"Gambian"', add
label define ancestr2_lbl 529 `"Ghanian"', add
label define ancestr2_lbl 530 `"Guinean"', add
label define ancestr2_lbl 531 `"Guinea Bissau"', add
label define ancestr2_lbl 532 `"Ivory Coast"', add
label define ancestr2_lbl 534 `"Kenyan"', add
label define ancestr2_lbl 538 `"Lesotho"', add
label define ancestr2_lbl 541 `"Liberian"', add
label define ancestr2_lbl 543 `"Madagascan"', add
label define ancestr2_lbl 545 `"Malawian"', add
label define ancestr2_lbl 546 `"Malian"', add
label define ancestr2_lbl 547 `"Mauritanian"', add
label define ancestr2_lbl 549 `"Mozambican"', add
label define ancestr2_lbl 550 `"Namibian"', add
label define ancestr2_lbl 551 `"Niger"', add
label define ancestr2_lbl 553 `"Nigerian"', add
label define ancestr2_lbl 554 `"Fulani"', add
label define ancestr2_lbl 555 `"Hausa"', add
label define ancestr2_lbl 556 `"Ibo"', add
label define ancestr2_lbl 557 `"Tiv"', add
label define ancestr2_lbl 561 `"Rwandan"', add
label define ancestr2_lbl 564 `"Senegalese"', add
label define ancestr2_lbl 566 `"Sierra Leonean"', add
label define ancestr2_lbl 568 `"Somalian"', add
label define ancestr2_lbl 569 `"Swaziland"', add
label define ancestr2_lbl 570 `"South African"', add
label define ancestr2_lbl 571 `"Union of South Africa"', add
label define ancestr2_lbl 572 `"Afrikaner"', add
label define ancestr2_lbl 573 `"Natalian"', add
label define ancestr2_lbl 574 `"Zulu"', add
label define ancestr2_lbl 576 `"Sudanese"', add
label define ancestr2_lbl 577 `"Dinka"', add
label define ancestr2_lbl 578 `"Nuer"', add
label define ancestr2_lbl 579 `"Fur"', add
label define ancestr2_lbl 580 `"Baggara"', add
label define ancestr2_lbl 582 `"Tanzanian"', add
label define ancestr2_lbl 583 `"Tanganyikan"', add
label define ancestr2_lbl 584 `"Zanzibar Islande"', add
label define ancestr2_lbl 586 `"Togo"', add
label define ancestr2_lbl 588 `"Ugandan"', add
label define ancestr2_lbl 589 `"Upper Voltan"', add
label define ancestr2_lbl 590 `"Voltan"', add
label define ancestr2_lbl 591 `"Zairian"', add
label define ancestr2_lbl 592 `"Zambian"', add
label define ancestr2_lbl 593 `"Zimbabwean"', add
label define ancestr2_lbl 594 `"African Islands"', add
label define ancestr2_lbl 595 `"Other Subsaharan Africa"', add
label define ancestr2_lbl 596 `"Central African"', add
label define ancestr2_lbl 597 `"East African"', add
label define ancestr2_lbl 598 `"West African"', add
label define ancestr2_lbl 599 `"African"', add
label define ancestr2_lbl 600 `"Afghan"', add
label define ancestr2_lbl 601 `"Baluchi"', add
label define ancestr2_lbl 602 `"Pathan"', add
label define ancestr2_lbl 603 `"Bengali"', add
label define ancestr2_lbl 607 `"Bhutanese"', add
label define ancestr2_lbl 609 `"Nepali"', add
label define ancestr2_lbl 615 `"Asian Indian"', add
label define ancestr2_lbl 622 `"Andaman Islander"', add
label define ancestr2_lbl 624 `"Andhra Pradesh"', add
label define ancestr2_lbl 626 `"Assamese"', add
label define ancestr2_lbl 628 `"Goanese"', add
label define ancestr2_lbl 630 `"Gujarati"', add
label define ancestr2_lbl 632 `"Karnatakan"', add
label define ancestr2_lbl 634 `"Keralan"', add
label define ancestr2_lbl 638 `"Maharashtran"', add
label define ancestr2_lbl 640 `"Madrasi"', add
label define ancestr2_lbl 642 `"Mysore"', add
label define ancestr2_lbl 644 `"Naga"', add
label define ancestr2_lbl 648 `"Pondicherry"', add
label define ancestr2_lbl 650 `"Punjabi"', add
label define ancestr2_lbl 656 `"Tamil"', add
label define ancestr2_lbl 675 `"East Indies"', add
label define ancestr2_lbl 680 `"Pakistani"', add
label define ancestr2_lbl 690 `"Sri Lankan"', add
label define ancestr2_lbl 691 `"Singhalese"', add
label define ancestr2_lbl 692 `"Veddah"', add
label define ancestr2_lbl 695 `"Maldivian"', add
label define ancestr2_lbl 700 `"Burmese"', add
label define ancestr2_lbl 702 `"Shan"', add
label define ancestr2_lbl 703 `"Cambodian"', add
label define ancestr2_lbl 704 `"Khmer"', add
label define ancestr2_lbl 706 `"Chinese"', add
label define ancestr2_lbl 707 `"Cantonese"', add
label define ancestr2_lbl 708 `"Manchurian"', add
label define ancestr2_lbl 709 `"Mandarin"', add
label define ancestr2_lbl 712 `"Mongolian"', add
label define ancestr2_lbl 714 `"Tibetan"', add
label define ancestr2_lbl 716 `"Hong Kong"', add
label define ancestr2_lbl 718 `"Macao"', add
label define ancestr2_lbl 720 `"Filipino"', add
label define ancestr2_lbl 730 `"Indonesian"', add
label define ancestr2_lbl 740 `"Japanese"', add
label define ancestr2_lbl 746 `"Ryukyu Islander"', add
label define ancestr2_lbl 748 `"Okinawan"', add
label define ancestr2_lbl 750 `"Korean"', add
label define ancestr2_lbl 765 `"Laotian"', add
label define ancestr2_lbl 766 `"Meo"', add
label define ancestr2_lbl 768 `"Hmong"', add
label define ancestr2_lbl 770 `"Malaysian"', add
label define ancestr2_lbl 774 `"Singaporean"', add
label define ancestr2_lbl 776 `"Thai"', add
label define ancestr2_lbl 777 `"Black Thai"', add
label define ancestr2_lbl 778 `"Western Lao"', add
label define ancestr2_lbl 782 `"Taiwanese"', add
label define ancestr2_lbl 785 `"Vietnamese"', add
label define ancestr2_lbl 786 `"Katu"', add
label define ancestr2_lbl 787 `"Ma"', add
label define ancestr2_lbl 788 `"Mnong"', add
label define ancestr2_lbl 790 `"Montagnard"', add
label define ancestr2_lbl 792 `"Indochinese"', add
label define ancestr2_lbl 793 `"Eurasian"', add
label define ancestr2_lbl 795 `"Asian"', add
label define ancestr2_lbl 796 `"Other Asian"', add
label define ancestr2_lbl 800 `"Australian"', add
label define ancestr2_lbl 801 `"Tasmanian"', add
label define ancestr2_lbl 802 `"Australian Aborigine"', add
label define ancestr2_lbl 803 `"New Zealander"', add
label define ancestr2_lbl 808 `"Polynesian"', add
label define ancestr2_lbl 809 `"Kapinagamarangan"', add
label define ancestr2_lbl 810 `"Maori"', add
label define ancestr2_lbl 811 `"Hawaiian"', add
label define ancestr2_lbl 813 `"Part Hawaiian"', add
label define ancestr2_lbl 814 `"Samoan"', add
label define ancestr2_lbl 815 `"Tongan"', add
label define ancestr2_lbl 816 `"Tokelauan"', add
label define ancestr2_lbl 817 `"Cook Islander"', add
label define ancestr2_lbl 818 `"Tahitian"', add
label define ancestr2_lbl 819 `"Niuean"', add
label define ancestr2_lbl 820 `"Micronesian"', add
label define ancestr2_lbl 821 `"Guamanian"', add
label define ancestr2_lbl 822 `"Chamorro Islander"', add
label define ancestr2_lbl 823 `"Saipanese"', add
label define ancestr2_lbl 824 `"Palauan"', add
label define ancestr2_lbl 825 `"Marshall Islander"', add
label define ancestr2_lbl 826 `"Kosraean"', add
label define ancestr2_lbl 827 `"Ponapean"', add
label define ancestr2_lbl 828 `"Chuukese"', add
label define ancestr2_lbl 829 `"Yap Islander"', add
label define ancestr2_lbl 830 `"Caroline Islander"', add
label define ancestr2_lbl 831 `"Kiribatese"', add
label define ancestr2_lbl 832 `"Nauruan"', add
label define ancestr2_lbl 833 `"Tarawa Islander"', add
label define ancestr2_lbl 834 `"Tinian Islander"', add
label define ancestr2_lbl 840 `"Melanesian Islander"', add
label define ancestr2_lbl 841 `"Fijian"', add
label define ancestr2_lbl 843 `"New Guinean"', add
label define ancestr2_lbl 844 `"Papuan"', add
label define ancestr2_lbl 845 `"Solomon Islander"', add
label define ancestr2_lbl 846 `"New Caledonian Islander"', add
label define ancestr2_lbl 847 `"Vanuatuan"', add
label define ancestr2_lbl 850 `"Pacific Islander"', add
label define ancestr2_lbl 860 `"Oceania"', add
label define ancestr2_lbl 862 `"Chamolinian"', add
label define ancestr2_lbl 863 `"Reserved Codes"', add
label define ancestr2_lbl 870 `"Other Pacific"', add
label define ancestr2_lbl 900 `"Afro-American"', add
label define ancestr2_lbl 902 `"African-American"', add
label define ancestr2_lbl 913 `"Central American Indian"', add
label define ancestr2_lbl 914 `"South American Indian"', add
label define ancestr2_lbl 920 `"American Indian  (all tribes)"', add
label define ancestr2_lbl 921 `"Aleut"', add
label define ancestr2_lbl 922 `"Eskimo"', add
label define ancestr2_lbl 923 `"Inuit"', add
label define ancestr2_lbl 924 `"White/Caucasian"', add
label define ancestr2_lbl 930 `"Greenlander"', add
label define ancestr2_lbl 931 `"Canadian (most provinces)"', add
label define ancestr2_lbl 933 `"Newfoundland"', add
label define ancestr2_lbl 934 `"Nova Scotian"', add
label define ancestr2_lbl 935 `"French Canadian"', add
label define ancestr2_lbl 936 `"Acadian"', add
label define ancestr2_lbl 939 `"American"', add
label define ancestr2_lbl 940 `"United States"', add
label define ancestr2_lbl 941 `"Alabama"', add
label define ancestr2_lbl 942 `"Alaska"', add
label define ancestr2_lbl 943 `"Arizona"', add
label define ancestr2_lbl 944 `"Arkansas"', add
label define ancestr2_lbl 945 `"California"', add
label define ancestr2_lbl 946 `"Colorado"', add
label define ancestr2_lbl 947 `"Connecticut"', add
label define ancestr2_lbl 948 `"District of Columbia"', add
label define ancestr2_lbl 949 `"Delaware"', add
label define ancestr2_lbl 950 `"Florida"', add
label define ancestr2_lbl 951 `"Georgia"', add
label define ancestr2_lbl 952 `"Idaho"', add
label define ancestr2_lbl 953 `"Illinois"', add
label define ancestr2_lbl 954 `"Indiana"', add
label define ancestr2_lbl 955 `"Iowa"', add
label define ancestr2_lbl 956 `"Kansas"', add
label define ancestr2_lbl 957 `"Kentucky"', add
label define ancestr2_lbl 958 `"Louisiana"', add
label define ancestr2_lbl 959 `"Maine"', add
label define ancestr2_lbl 960 `"Maryland"', add
label define ancestr2_lbl 961 `"Massachusetts"', add
label define ancestr2_lbl 962 `"Michigan"', add
label define ancestr2_lbl 963 `"Minnesota"', add
label define ancestr2_lbl 964 `"Mississippi"', add
label define ancestr2_lbl 965 `"Missouri"', add
label define ancestr2_lbl 966 `"Montana"', add
label define ancestr2_lbl 967 `"Nebraska"', add
label define ancestr2_lbl 968 `"Nevada"', add
label define ancestr2_lbl 969 `"New Hampshire"', add
label define ancestr2_lbl 970 `"New Jersey"', add
label define ancestr2_lbl 971 `"New Mexico"', add
label define ancestr2_lbl 972 `"New York"', add
label define ancestr2_lbl 973 `"North Carolina"', add
label define ancestr2_lbl 974 `"North Dakota"', add
label define ancestr2_lbl 975 `"Ohio"', add
label define ancestr2_lbl 976 `"Oklahoma"', add
label define ancestr2_lbl 977 `"Oregon"', add
label define ancestr2_lbl 978 `"Pennsylvania"', add
label define ancestr2_lbl 979 `"Rhode Island"', add
label define ancestr2_lbl 980 `"South Carolina"', add
label define ancestr2_lbl 981 `"South Dakota"', add
label define ancestr2_lbl 982 `"Tennessee"', add
label define ancestr2_lbl 983 `"Texas"', add
label define ancestr2_lbl 984 `"Utah"', add
label define ancestr2_lbl 985 `"Vermont"', add
label define ancestr2_lbl 986 `"Virginia"', add
label define ancestr2_lbl 987 `"Washington"', add
label define ancestr2_lbl 988 `"West Virginia"', add
label define ancestr2_lbl 989 `"Wisconsin"', add
label define ancestr2_lbl 990 `"Wyoming"', add
label define ancestr2_lbl 993 `"Southerner"', add
label define ancestr2_lbl 994 `"North American"', add
label define ancestr2_lbl 995 `"Mixture"', add
label define ancestr2_lbl 996 `"Uncodable"', add
label define ancestr2_lbl 997 `"Deferred Cases"', add
label define ancestr2_lbl 998 `"Other (Usually a Religion)"', add
label define ancestr2_lbl 999 `"Not Reported"', add
label values ancestr2 ancestr2_lbl

label define ancestr2d_lbl 0010 `"Alsatian"'
label define ancestr2d_lbl 0020 `"Andorran"', add
label define ancestr2d_lbl 0030 `"Austrian"', add
label define ancestr2d_lbl 0040 `"Tirolean"', add
label define ancestr2d_lbl 0051 `"Basque (1980)"', add
label define ancestr2d_lbl 0052 `"Spanish Basque (1980)"', add
label define ancestr2d_lbl 0053 `"Basque (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 0054 `"Spanish Basque (1990-2000, 2001-2004 ACS)"', add
label define ancestr2d_lbl 0060 `"French Basque"', add
label define ancestr2d_lbl 0080 `"Belgian"', add
label define ancestr2d_lbl 0090 `"Flemish"', add
label define ancestr2d_lbl 0100 `"Walloon"', add
label define ancestr2d_lbl 0110 `"British"', add
label define ancestr2d_lbl 0120 `"British Isles"', add
label define ancestr2d_lbl 0130 `"Channel Islander"', add
label define ancestr2d_lbl 0140 `"Gibraltan"', add
label define ancestr2d_lbl 0150 `"Cornish"', add
label define ancestr2d_lbl 0160 `"Corsican"', add
label define ancestr2d_lbl 0170 `"Cypriot"', add
label define ancestr2d_lbl 0180 `"Greek Cypriote"', add
label define ancestr2d_lbl 0190 `"Turkish Cypriote"', add
label define ancestr2d_lbl 0200 `"Danish"', add
label define ancestr2d_lbl 0210 `"Dutch"', add
label define ancestr2d_lbl 0211 `"Dutch-French-Irish"', add
label define ancestr2d_lbl 0212 `"Dutch-German-Irish"', add
label define ancestr2d_lbl 0213 `"Dutch-Irish-Scotch"', add
label define ancestr2d_lbl 0220 `"English"', add
label define ancestr2d_lbl 0221 `"English-French-German (1980)"', add
label define ancestr2d_lbl 0222 `"English-French-Irish (1980)"', add
label define ancestr2d_lbl 0223 `"English-German-Irish (1980)"', add
label define ancestr2d_lbl 0224 `"English-German-Swedish (1980)"', add
label define ancestr2d_lbl 0225 `"English-Irish-Scotch (1980)"', add
label define ancestr2d_lbl 0226 `"English-Scotch-Welsh (1980)"', add
label define ancestr2d_lbl 0230 `"Faeroe Islander"', add
label define ancestr2d_lbl 0240 `"Finnish"', add
label define ancestr2d_lbl 0250 `"Karelian"', add
label define ancestr2d_lbl 0260 `"French (1980)"', add
label define ancestr2d_lbl 0261 `"French (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 0262 `"Occitan (1990-2000)"', add
label define ancestr2d_lbl 0270 `"Lorrainian"', add
label define ancestr2d_lbl 0280 `"Breton"', add
label define ancestr2d_lbl 0290 `"Frisian"', add
label define ancestr2d_lbl 0300 `"Friulian"', add
label define ancestr2d_lbl 0320 `"German (1980)"', add
label define ancestr2d_lbl 0321 `"German (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 0322 `"Pennsylvania German (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 0323 `"East German (1990-2000)"', add
label define ancestr2d_lbl 0324 `"West German (2000)"', add
label define ancestr2d_lbl 0325 `"German-French-Irish (1980)"', add
label define ancestr2d_lbl 0326 `"German-Irish-Italian (1980)"', add
label define ancestr2d_lbl 0327 `"German-Irish-Scotch (1980)"', add
label define ancestr2d_lbl 0328 `"German-Irish-Swedish (1980)"', add
label define ancestr2d_lbl 0329 `"Germanic"', add
label define ancestr2d_lbl 0330 `"Bavarian"', add
label define ancestr2d_lbl 0340 `"Berliner"', add
label define ancestr2d_lbl 0350 `"Hamburger"', add
label define ancestr2d_lbl 0360 `"Hanoverian"', add
label define ancestr2d_lbl 0370 `"Hessian"', add
label define ancestr2d_lbl 0380 `"Lubecker"', add
label define ancestr2d_lbl 0390 `"Pomeranian (1980)"', add
label define ancestr2d_lbl 0391 `"Pomeranian (1990-2000)"', add
label define ancestr2d_lbl 0392 `"Silesian (1990-2000)"', add
label define ancestr2d_lbl 0400 `"Prussian"', add
label define ancestr2d_lbl 0410 `"Saxon"', add
label define ancestr2d_lbl 0420 `"Sudetenlander"', add
label define ancestr2d_lbl 0430 `"Westphalian"', add
label define ancestr2d_lbl 0460 `"Greek"', add
label define ancestr2d_lbl 0470 `"Cretan"', add
label define ancestr2d_lbl 0480 `"Cycladic Islander"', add
label define ancestr2d_lbl 0490 `"Icelander"', add
label define ancestr2d_lbl 0500 `"Irish"', add
label define ancestr2d_lbl 0501 `"Celtic"', add
label define ancestr2d_lbl 0502 `"Irish Scotch"', add
label define ancestr2d_lbl 0510 `"Italian (1980)"', add
label define ancestr2d_lbl 0511 `"Italian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 0512 `"Trieste (1990-2000)"', add
label define ancestr2d_lbl 0513 `"San Marino (1990-2000)"', add
label define ancestr2d_lbl 0530 `"Abruzzi"', add
label define ancestr2d_lbl 0540 `"Apulian"', add
label define ancestr2d_lbl 0550 `"Basilicata"', add
label define ancestr2d_lbl 0560 `"Calabrian"', add
label define ancestr2d_lbl 0570 `"Amalfi"', add
label define ancestr2d_lbl 0580 `"Emilia Romagna"', add
label define ancestr2d_lbl 0590 `"Rome"', add
label define ancestr2d_lbl 0600 `"Ligurian"', add
label define ancestr2d_lbl 0610 `"Lombardian"', add
label define ancestr2d_lbl 0620 `"Marches"', add
label define ancestr2d_lbl 0630 `"Molise"', add
label define ancestr2d_lbl 0640 `"Neapolitan"', add
label define ancestr2d_lbl 0650 `"Piedmontese"', add
label define ancestr2d_lbl 0660 `"Puglia"', add
label define ancestr2d_lbl 0670 `"Sardinian"', add
label define ancestr2d_lbl 0680 `"Sicilian"', add
label define ancestr2d_lbl 0690 `"Toscana"', add
label define ancestr2d_lbl 0700 `"Trentino"', add
label define ancestr2d_lbl 0710 `"Umbrian"', add
label define ancestr2d_lbl 0720 `"Valle dAosta"', add
label define ancestr2d_lbl 0730 `"Venetian"', add
label define ancestr2d_lbl 0750 `"Lapp"', add
label define ancestr2d_lbl 0760 `"Liechtensteiner"', add
label define ancestr2d_lbl 0770 `"Luxemburger"', add
label define ancestr2d_lbl 0780 `"Maltese"', add
label define ancestr2d_lbl 0790 `"Manx"', add
label define ancestr2d_lbl 0800 `"Monegasque"', add
label define ancestr2d_lbl 0810 `"Northern Irelander"', add
label define ancestr2d_lbl 0820 `"Norwegian"', add
label define ancestr2d_lbl 0840 `"Portuguese"', add
label define ancestr2d_lbl 0850 `"Azorean"', add
label define ancestr2d_lbl 0860 `"Madeiran"', add
label define ancestr2d_lbl 0870 `"Scotch Irish"', add
label define ancestr2d_lbl 0880 `"Scottish"', add
label define ancestr2d_lbl 0890 `"Swedish"', add
label define ancestr2d_lbl 0900 `"Aland Islander"', add
label define ancestr2d_lbl 0910 `"Swiss"', add
label define ancestr2d_lbl 0920 `"Suisse (1980)"', add
label define ancestr2d_lbl 0921 `"Suisse (1990-2000)"', add
label define ancestr2d_lbl 0922 `"Switzer (1990-2000)"', add
label define ancestr2d_lbl 0950 `"Romansch (1980)"', add
label define ancestr2d_lbl 0951 `"Romanscho (1990-2000)"', add
label define ancestr2d_lbl 0952 `"Ladin (1990-2000)"', add
label define ancestr2d_lbl 0960 `"Suisse Romane (1990-2000)"', add
label define ancestr2d_lbl 0961 `"Suisse Romane (1980)"', add
label define ancestr2d_lbl 0962 `"Ticino"', add
label define ancestr2d_lbl 0970 `"Welsh"', add
label define ancestr2d_lbl 0980 `"Scandinavian, Nordic"', add
label define ancestr2d_lbl 1000 `"Albanian"', add
label define ancestr2d_lbl 1010 `"Azerbaijani"', add
label define ancestr2d_lbl 1020 `"Belorussian"', add
label define ancestr2d_lbl 1030 `"Bulgarian"', add
label define ancestr2d_lbl 1050 `"Carpathian"', add
label define ancestr2d_lbl 1051 `"Carpatho Rusyn"', add
label define ancestr2d_lbl 1052 `"Rusyn"', add
label define ancestr2d_lbl 1080 `"Cossack (1990-2000)"', add
label define ancestr2d_lbl 1081 `"Cossack (1980)"', add
label define ancestr2d_lbl 1082 `"Turkestani (1990-2000, 2012 ACS)"', add
label define ancestr2d_lbl 1083 `"Kirghiz (1980)"', add
label define ancestr2d_lbl 1084 `"Turcoman (1980)"', add
label define ancestr2d_lbl 1090 `"Croatian"', add
label define ancestr2d_lbl 1110 `"Czechoslovakian"', add
label define ancestr2d_lbl 1111 `"Czech"', add
label define ancestr2d_lbl 1120 `"Bohemian (1980)"', add
label define ancestr2d_lbl 1121 `"Bohemian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 1122 `"Moravian (1990-2000)"', add
label define ancestr2d_lbl 1150 `"Estonian"', add
label define ancestr2d_lbl 1160 `"Livonian"', add
label define ancestr2d_lbl 1170 `"Finno Ugrian (1990-2000)"', add
label define ancestr2d_lbl 1171 `"Udmert"', add
label define ancestr2d_lbl 1180 `"Mordovian"', add
label define ancestr2d_lbl 1190 `"Voytak"', add
label define ancestr2d_lbl 1200 `"Georgian"', add
label define ancestr2d_lbl 1220 `"Germans from Russia"', add
label define ancestr2d_lbl 1221 `"Volga"', add
label define ancestr2d_lbl 1222 `"German from Russia (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 1230 `"Gruziia (1990-2000)"', add
label define ancestr2d_lbl 1240 `"Rom"', add
label define ancestr2d_lbl 1250 `"Hungarian"', add
label define ancestr2d_lbl 1260 `"Magyar"', add
label define ancestr2d_lbl 1280 `"Latvian"', add
label define ancestr2d_lbl 1290 `"Lithuanian"', add
label define ancestr2d_lbl 1300 `"Macedonian"', add
label define ancestr2d_lbl 1320 `"North Caucasian (1990-2000)"', add
label define ancestr2d_lbl 1330 `"North Caucasian Turkic (1990-2000)"', add
label define ancestr2d_lbl 1400 `"Ossetian"', add
label define ancestr2d_lbl 1420 `"Polish"', add
label define ancestr2d_lbl 1430 `"Kashubian"', add
label define ancestr2d_lbl 1440 `"Romanian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 1441 `"Romanian (1980)"', add
label define ancestr2d_lbl 1442 `"Transylvanian"', add
label define ancestr2d_lbl 1450 `"Bessarabian (1980)"', add
label define ancestr2d_lbl 1451 `"Bessarabian (1990-2000)"', add
label define ancestr2d_lbl 1452 `"Bucovina"', add
label define ancestr2d_lbl 1460 `"Moldavian"', add
label define ancestr2d_lbl 1470 `"Wallachian"', add
label define ancestr2d_lbl 1480 `"Russian"', add
label define ancestr2d_lbl 1500 `"Muscovite"', add
label define ancestr2d_lbl 1520 `"Serbian (1980)"', add
label define ancestr2d_lbl 1521 `"Serbian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 1522 `"Bosnian (1990) Herzegovinian (2000, ACS, PRCS)"', add
label define ancestr2d_lbl 1523 `"Montenegrin (1990-2000, 2012 ACS)"', add
label define ancestr2d_lbl 1530 `"Slovak"', add
label define ancestr2d_lbl 1540 `"Slovene"', add
label define ancestr2d_lbl 1550 `"Sorb/Wend"', add
label define ancestr2d_lbl 1560 `"Soviet Turkic (1990-2000)"', add
label define ancestr2d_lbl 1570 `"Bashkir"', add
label define ancestr2d_lbl 1580 `"Chevash"', add
label define ancestr2d_lbl 1590 `"Gagauz (1990-2000)"', add
label define ancestr2d_lbl 1600 `"Mesknetian (1990-2000)"', add
label define ancestr2d_lbl 1630 `"Yakut"', add
label define ancestr2d_lbl 1640 `"Soviet Union, nec"', add
label define ancestr2d_lbl 1650 `"Tatar (1990-2000)"', add
label define ancestr2d_lbl 1651 `"Tatar (1980)"', add
label define ancestr2d_lbl 1652 `"Crimean (1980)"', add
label define ancestr2d_lbl 1653 `"Tuvinian (1990-2000)"', add
label define ancestr2d_lbl 1654 `"Soviet Central Asian (1990-2000)"', add
label define ancestr2d_lbl 1655 `"Tadzhik (1980, 2000)"', add
label define ancestr2d_lbl 1690 `"Uzbek"', add
label define ancestr2d_lbl 1710 `"Ukrainian (1980)"', add
label define ancestr2d_lbl 1711 `"Ukrainian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 1712 `"Ruthenian (1980)"', add
label define ancestr2d_lbl 1713 `"Ruthenian (1990-2000)"', add
label define ancestr2d_lbl 1714 `"Lemko"', add
label define ancestr2d_lbl 1715 `"Bioko"', add
label define ancestr2d_lbl 1716 `"Hesel"', add
label define ancestr2d_lbl 1717 `"Windish"', add
label define ancestr2d_lbl 1760 `"Yugoslavian"', add
label define ancestr2d_lbl 1780 `"Slav"', add
label define ancestr2d_lbl 1790 `"Slavonian"', add
label define ancestr2d_lbl 1810 `"Central European, nec"', add
label define ancestr2d_lbl 1830 `"Northern European, nec"', add
label define ancestr2d_lbl 1850 `"Southern European, nec"', add
label define ancestr2d_lbl 1870 `"Western European, nec"', add
label define ancestr2d_lbl 1900 `"Eastern European, nec"', add
label define ancestr2d_lbl 1950 `"European, nec"', add
label define ancestr2d_lbl 2000 `"Spaniard (1980)"', add
label define ancestr2d_lbl 2001 `"Spaniard (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2002 `"Castillian (1990-2000)"', add
label define ancestr2d_lbl 2003 `"Valencian (1990-2000)"', add
label define ancestr2d_lbl 2010 `"Andalusian (1990-2000)"', add
label define ancestr2d_lbl 2020 `"Asturian (1990-2000)"', add
label define ancestr2d_lbl 2040 `"Catalonian"', add
label define ancestr2d_lbl 2050 `"Balearic Islander (1980)"', add
label define ancestr2d_lbl 2051 `"Balearic Islander (1990-2000)"', add
label define ancestr2d_lbl 2052 `"Canary Islander (1990-2000)"', add
label define ancestr2d_lbl 2060 `"Galician (1980)"', add
label define ancestr2d_lbl 2061 `"Gallego (1990-2000)"', add
label define ancestr2d_lbl 2062 `"Galician (1990-2000)"', add
label define ancestr2d_lbl 2100 `"Mexican"', add
label define ancestr2d_lbl 2101 `"Mexican (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2102 `"Mexicano/Mexicana (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2103 `"Mexican Indian"', add
label define ancestr2d_lbl 2110 `"Mexican American"', add
label define ancestr2d_lbl 2111 `"Mexican American Indian"', add
label define ancestr2d_lbl 2130 `"Chicano/Chicana"', add
label define ancestr2d_lbl 2180 `"Nuevo Mexicano"', add
label define ancestr2d_lbl 2181 `"Nuevo Mexicano (1990-2000)"', add
label define ancestr2d_lbl 2182 `"La Raza (1990-2000)"', add
label define ancestr2d_lbl 2183 `"Mexican state (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2184 `"Tejano/Tejana (1990-2000)"', add
label define ancestr2d_lbl 2190 `"Californio"', add
label define ancestr2d_lbl 2210 `"Costa Rican"', add
label define ancestr2d_lbl 2220 `"Guatemalan"', add
label define ancestr2d_lbl 2230 `"Honduran"', add
label define ancestr2d_lbl 2240 `"Nicaraguan"', add
label define ancestr2d_lbl 2250 `"Panamanian (1980)"', add
label define ancestr2d_lbl 2251 `"Panamanian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2252 `"Canal Zone (1990-2000)"', add
label define ancestr2d_lbl 2260 `"Salvadoran"', add
label define ancestr2d_lbl 2270 `"Latin American (1980)"', add
label define ancestr2d_lbl 2271 `"Central American (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2272 `"Latin American (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2273 `"Latino/Latina (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2274 `"Latin (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2310 `"Argentinean"', add
label define ancestr2d_lbl 2320 `"Bolivian"', add
label define ancestr2d_lbl 2330 `"Chilean"', add
label define ancestr2d_lbl 2340 `"Colombian"', add
label define ancestr2d_lbl 2350 `"Ecuadorian"', add
label define ancestr2d_lbl 2360 `"Paraguayan"', add
label define ancestr2d_lbl 2370 `"Peruvian"', add
label define ancestr2d_lbl 2380 `"Uruguayan"', add
label define ancestr2d_lbl 2390 `"Venezuelan"', add
label define ancestr2d_lbl 2480 `"South American (1980)"', add
label define ancestr2d_lbl 2481 `"South American (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 2482 `"Criollo/Criolla (1990-2000)"', add
label define ancestr2d_lbl 2610 `"Puerto Rican"', add
label define ancestr2d_lbl 2710 `"Cuban"', add
label define ancestr2d_lbl 2750 `"Dominican"', add
label define ancestr2d_lbl 2900 `"Hispanic"', add
label define ancestr2d_lbl 2910 `"Spanish"', add
label define ancestr2d_lbl 2950 `"Spanish American"', add
label define ancestr2d_lbl 2960 `"Other Spanish/Hispanic"', add
label define ancestr2d_lbl 3000 `"Bahamian"', add
label define ancestr2d_lbl 3010 `"Barbadian"', add
label define ancestr2d_lbl 3020 `"Belizean"', add
label define ancestr2d_lbl 3030 `"Bermudan"', add
label define ancestr2d_lbl 3040 `"Cayman Islander"', add
label define ancestr2d_lbl 3080 `"Jamaican"', add
label define ancestr2d_lbl 3100 `"Dutch West Indies"', add
label define ancestr2d_lbl 3110 `"Aruba Islander"', add
label define ancestr2d_lbl 3120 `"St Maarten Islander"', add
label define ancestr2d_lbl 3140 `"Trinidadian/Tobagonian"', add
label define ancestr2d_lbl 3150 `"Trinidadian"', add
label define ancestr2d_lbl 3160 `"Tobagonian"', add
label define ancestr2d_lbl 3170 `"U.S. Virgin Islander (1980)"', add
label define ancestr2d_lbl 3171 `"U.S. Virgin Islander (1990-2000)"', add
label define ancestr2d_lbl 3172 `"St. Croix Islander (1990-2000)"', add
label define ancestr2d_lbl 3173 `"St. John Islander (1990-2000)"', add
label define ancestr2d_lbl 3174 `"St. Thomas Islander (1990-2000)"', add
label define ancestr2d_lbl 3210 `"British Virgin Islander (1980)"', add
label define ancestr2d_lbl 3211 `"British Virgin Islander (1990-2000)"', add
label define ancestr2d_lbl 3212 `"Antigua (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 3220 `"British West Indian"', add
label define ancestr2d_lbl 3230 `"Turks and Caicos Islander"', add
label define ancestr2d_lbl 3240 `"Anguilla Islander (1980)"', add
label define ancestr2d_lbl 3241 `"Anguilla Islander (1990-2000)"', add
label define ancestr2d_lbl 3242 `"Montserrat Islander (1990-2000)"', add
label define ancestr2d_lbl 3243 `"Kitts/Nevis Islander (1990-2000)"', add
label define ancestr2d_lbl 3244 `"St. Christopher (1980)"', add
label define ancestr2d_lbl 3245 `"St Vincent Islander"', add
label define ancestr2d_lbl 3280 `"Dominica Islander"', add
label define ancestr2d_lbl 3290 `"Grenadian"', add
label define ancestr2d_lbl 3310 `"St Lucia Islander"', add
label define ancestr2d_lbl 3320 `"French West Indies"', add
label define ancestr2d_lbl 3330 `"Guadeloupe Islander"', add
label define ancestr2d_lbl 3340 `"Cayenne"', add
label define ancestr2d_lbl 3350 `"West Indian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 3351 `"West Indian (1980)"', add
label define ancestr2d_lbl 3352 `"Caribbean (1980)"', add
label define ancestr2d_lbl 3353 `"Arawak (1980)"', add
label define ancestr2d_lbl 3360 `"Haitian"', add
label define ancestr2d_lbl 3370 `"Other West Indian"', add
label define ancestr2d_lbl 3600 `"Brazilian"', add
label define ancestr2d_lbl 3650 `"San Andres"', add
label define ancestr2d_lbl 3700 `"Guyanese/British Guiana"', add
label define ancestr2d_lbl 3750 `"Providencia"', add
label define ancestr2d_lbl 3800 `"Surinam/Dutch Guiana"', add
label define ancestr2d_lbl 4000 `"Algerian"', add
label define ancestr2d_lbl 4020 `"Egyptian"', add
label define ancestr2d_lbl 4040 `"Libyan"', add
label define ancestr2d_lbl 4060 `"Moroccan (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 4061 `"Moroccan (1980)"', add
label define ancestr2d_lbl 4062 `"Moor (1980)"', add
label define ancestr2d_lbl 4070 `"Ifni"', add
label define ancestr2d_lbl 4080 `"Tunisian"', add
label define ancestr2d_lbl 4110 `"North African"', add
label define ancestr2d_lbl 4120 `"Alhucemas"', add
label define ancestr2d_lbl 4130 `"Berber"', add
label define ancestr2d_lbl 4140 `"Rio de Oro"', add
label define ancestr2d_lbl 4150 `"Bahraini"', add
label define ancestr2d_lbl 4160 `"Iranian"', add
label define ancestr2d_lbl 4170 `"Iraqi"', add
label define ancestr2d_lbl 4190 `"Israeli"', add
label define ancestr2d_lbl 4210 `"Jordanian"', add
label define ancestr2d_lbl 4220 `"Transjordan"', add
label define ancestr2d_lbl 4230 `"Kuwaiti"', add
label define ancestr2d_lbl 4250 `"Lebanese"', add
label define ancestr2d_lbl 4270 `"Saudi Arabian"', add
label define ancestr2d_lbl 4290 `"Syrian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 4291 `"Syrian (1980)"', add
label define ancestr2d_lbl 4292 `"Latakian (1980)"', add
label define ancestr2d_lbl 4293 `"Jebel Druse (1980)"', add
label define ancestr2d_lbl 4310 `"Armenian"', add
label define ancestr2d_lbl 4340 `"Turkish"', add
label define ancestr2d_lbl 4350 `"Yemeni"', add
label define ancestr2d_lbl 4360 `"Omani"', add
label define ancestr2d_lbl 4370 `"Muscat"', add
label define ancestr2d_lbl 4380 `"Trucial Oman"', add
label define ancestr2d_lbl 4390 `"Qatar"', add
label define ancestr2d_lbl 4410 `"Bedouin"', add
label define ancestr2d_lbl 4420 `"Kurdish"', add
label define ancestr2d_lbl 4440 `"Kuria Muria Islander"', add
label define ancestr2d_lbl 4650 `"Palestinian"', add
label define ancestr2d_lbl 4660 `"Gazan"', add
label define ancestr2d_lbl 4670 `"West Bank"', add
label define ancestr2d_lbl 4700 `"South Yemeni"', add
label define ancestr2d_lbl 4710 `"Aden"', add
label define ancestr2d_lbl 4800 `"United Arab Emirates"', add
label define ancestr2d_lbl 4820 `"Assyrian/Chaldean/Syriac (1990-2000)"', add
label define ancestr2d_lbl 4821 `"Assyrian"', add
label define ancestr2d_lbl 4822 `"Syriac (1980, 2000)"', add
label define ancestr2d_lbl 4823 `"Chaldean (2000, ACS, PRCS)"', add
label define ancestr2d_lbl 4900 `"Middle Eastern"', add
label define ancestr2d_lbl 4950 `"Arab"', add
label define ancestr2d_lbl 4951 `"Arabic (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 4960 `"Other Arab"', add
label define ancestr2d_lbl 5000 `"Angolan"', add
label define ancestr2d_lbl 5020 `"Benin"', add
label define ancestr2d_lbl 5040 `"Botswana"', add
label define ancestr2d_lbl 5060 `"Burundian"', add
label define ancestr2d_lbl 5080 `"Cameroonian"', add
label define ancestr2d_lbl 5100 `"Cape Verdean"', add
label define ancestr2d_lbl 5120 `"Central African Republic"', add
label define ancestr2d_lbl 5130 `"Chadian"', add
label define ancestr2d_lbl 5150 `"Congolese"', add
label define ancestr2d_lbl 5160 `"Congo-Brazzaville"', add
label define ancestr2d_lbl 5190 `"Djibouti"', add
label define ancestr2d_lbl 5200 `"Equatorial Guinea"', add
label define ancestr2d_lbl 5210 `"Corsico Islander"', add
label define ancestr2d_lbl 5220 `"Ethiopian"', add
label define ancestr2d_lbl 5230 `"Eritrean"', add
label define ancestr2d_lbl 5250 `"Gabonese"', add
label define ancestr2d_lbl 5270 `"Gambian"', add
label define ancestr2d_lbl 5290 `"Ghanian"', add
label define ancestr2d_lbl 5300 `"Guinean"', add
label define ancestr2d_lbl 5310 `"Guinea Bissau"', add
label define ancestr2d_lbl 5320 `"Ivory Coast"', add
label define ancestr2d_lbl 5340 `"Kenyan"', add
label define ancestr2d_lbl 5380 `"Lesotho"', add
label define ancestr2d_lbl 5410 `"Liberian"', add
label define ancestr2d_lbl 5430 `"Madagascan"', add
label define ancestr2d_lbl 5450 `"Malawian"', add
label define ancestr2d_lbl 5460 `"Malian"', add
label define ancestr2d_lbl 5470 `"Mauritanian"', add
label define ancestr2d_lbl 5490 `"Mozambican"', add
label define ancestr2d_lbl 5500 `"Namibian"', add
label define ancestr2d_lbl 5510 `"Niger"', add
label define ancestr2d_lbl 5530 `"Nigerian"', add
label define ancestr2d_lbl 5540 `"Fulani"', add
label define ancestr2d_lbl 5550 `"Hausa"', add
label define ancestr2d_lbl 5560 `"Ibo"', add
label define ancestr2d_lbl 5570 `"Tiv (1980)"', add
label define ancestr2d_lbl 5571 `"Tiv (1990-2000)"', add
label define ancestr2d_lbl 5572 `"Yoruba (1990-2000)"', add
label define ancestr2d_lbl 5610 `"Rwandan"', add
label define ancestr2d_lbl 5640 `"Senegalese"', add
label define ancestr2d_lbl 5660 `"Sierra Leonean"', add
label define ancestr2d_lbl 5680 `"Somalian"', add
label define ancestr2d_lbl 5690 `"Swaziland"', add
label define ancestr2d_lbl 5700 `"South African"', add
label define ancestr2d_lbl 5710 `"Union of South Africa"', add
label define ancestr2d_lbl 5720 `"Afrikaner"', add
label define ancestr2d_lbl 5730 `"Natalian"', add
label define ancestr2d_lbl 5740 `"Zulu"', add
label define ancestr2d_lbl 5760 `"Sudanese"', add
label define ancestr2d_lbl 5770 `"Dinka"', add
label define ancestr2d_lbl 5780 `"Nuer"', add
label define ancestr2d_lbl 5790 `"Fur"', add
label define ancestr2d_lbl 5800 `"Baggara"', add
label define ancestr2d_lbl 5820 `"Tanzanian"', add
label define ancestr2d_lbl 5830 `"Tanganyikan"', add
label define ancestr2d_lbl 5840 `"Zanzibar"', add
label define ancestr2d_lbl 5860 `"Togo"', add
label define ancestr2d_lbl 5880 `"Ugandan"', add
label define ancestr2d_lbl 5890 `"Upper Voltan"', add
label define ancestr2d_lbl 5900 `"Voltan"', add
label define ancestr2d_lbl 5910 `"Zairian"', add
label define ancestr2d_lbl 5920 `"Zambian"', add
label define ancestr2d_lbl 5930 `"Zimbabwean"', add
label define ancestr2d_lbl 5940 `"African Islands (1980)"', add
label define ancestr2d_lbl 5941 `"African Islands (1990-2000)"', add
label define ancestr2d_lbl 5942 `"Mauritius (1990-2000)"', add
label define ancestr2d_lbl 5950 `"Other Subsaharan Africa"', add
label define ancestr2d_lbl 5960 `"Central African"', add
label define ancestr2d_lbl 5970 `"East African"', add
label define ancestr2d_lbl 5980 `"West African"', add
label define ancestr2d_lbl 5990 `"African"', add
label define ancestr2d_lbl 6000 `"Afghan"', add
label define ancestr2d_lbl 6010 `"Baluchi"', add
label define ancestr2d_lbl 6020 `"Pathan"', add
label define ancestr2d_lbl 6030 `"Bengali (1980)"', add
label define ancestr2d_lbl 6031 `"Bangladeshi (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 6032 `"Bengali (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 6070 `"Bhutanese"', add
label define ancestr2d_lbl 6090 `"Nepali"', add
label define ancestr2d_lbl 6150 `"Asian Indian (1980)"', add
label define ancestr2d_lbl 6151 `"India (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 6152 `"East Indian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 6153 `"Madhya Pradesh (1990-2000)"', add
label define ancestr2d_lbl 6154 `"Orissa (1990-2000)"', add
label define ancestr2d_lbl 6155 `"Rajasthani (1990-2000)"', add
label define ancestr2d_lbl 6156 `"Sikkim (1990-2000)"', add
label define ancestr2d_lbl 6157 `"Uttar Pradesh (1990-2000)"', add
label define ancestr2d_lbl 6220 `"Andaman Islander"', add
label define ancestr2d_lbl 6240 `"Andhra Pradesh"', add
label define ancestr2d_lbl 6260 `"Assamese"', add
label define ancestr2d_lbl 6280 `"Goanese"', add
label define ancestr2d_lbl 6300 `"Gujarati"', add
label define ancestr2d_lbl 6320 `"Karnatakan"', add
label define ancestr2d_lbl 6340 `"Keralan"', add
label define ancestr2d_lbl 6380 `"Maharashtran"', add
label define ancestr2d_lbl 6400 `"Madrasi"', add
label define ancestr2d_lbl 6420 `"Mysore"', add
label define ancestr2d_lbl 6440 `"Naga"', add
label define ancestr2d_lbl 6480 `"Pondicherry"', add
label define ancestr2d_lbl 6500 `"Punjabi"', add
label define ancestr2d_lbl 6560 `"Tamil"', add
label define ancestr2d_lbl 6750 `"East Indies (1990-2000)"', add
label define ancestr2d_lbl 6800 `"Pakistani (1980)"', add
label define ancestr2d_lbl 6801 `"Pakistani (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 6802 `"Kashmiri (1990-2000)"', add
label define ancestr2d_lbl 6900 `"Sri Lankan"', add
label define ancestr2d_lbl 6910 `"Singhalese"', add
label define ancestr2d_lbl 6920 `"Veddah"', add
label define ancestr2d_lbl 6950 `"Maldivian"', add
label define ancestr2d_lbl 7000 `"Burmese (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 7001 `"Burmese (1980)"', add
label define ancestr2d_lbl 7002 `"Burman (1980)"', add
label define ancestr2d_lbl 7020 `"Shan"', add
label define ancestr2d_lbl 7030 `"Cambodian"', add
label define ancestr2d_lbl 7040 `"Khmer"', add
label define ancestr2d_lbl 7060 `"Chinese"', add
label define ancestr2d_lbl 7070 `"Cantonese (1980)"', add
label define ancestr2d_lbl 7071 `"Cantonese (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 7072 `"Formosan (1990-2000)"', add
label define ancestr2d_lbl 7080 `"Manchurian"', add
label define ancestr2d_lbl 7090 `"Mandarin (1990-2000)"', add
label define ancestr2d_lbl 7120 `"Mongolian (1980)"', add
label define ancestr2d_lbl 7121 `"Mongolian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 7122 `"Kalmyk (1990-2000)"', add
label define ancestr2d_lbl 7140 `"Tibetan"', add
label define ancestr2d_lbl 7160 `"Hong Kong (1990-2000)"', add
label define ancestr2d_lbl 7161 `"Hong Kong (1980)"', add
label define ancestr2d_lbl 7162 `"Eastern Archipelago (1980)"', add
label define ancestr2d_lbl 7180 `"Macao"', add
label define ancestr2d_lbl 7200 `"Filipino"', add
label define ancestr2d_lbl 7300 `"Indonesian (1980)"', add
label define ancestr2d_lbl 7301 `"Indonesian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 7302 `"Borneo (1990-2000)"', add
label define ancestr2d_lbl 7303 `"Java (1990-2000)"', add
label define ancestr2d_lbl 7304 `"Sumatran (1990-2000)"', add
label define ancestr2d_lbl 7400 `"Japanese (1980)"', add
label define ancestr2d_lbl 7401 `"Japanese (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 7402 `"Issei (1990-2000)"', add
label define ancestr2d_lbl 7403 `"Nisei (1990-2000)"', add
label define ancestr2d_lbl 7404 `"Sansei (1990-2000)"', add
label define ancestr2d_lbl 7405 `"Yonsei (1990-2000)"', add
label define ancestr2d_lbl 7406 `"Gosei (1990-2000)"', add
label define ancestr2d_lbl 7460 `"Ryukyu Islander"', add
label define ancestr2d_lbl 7480 `"Okinawan"', add
label define ancestr2d_lbl 7500 `"Korean"', add
label define ancestr2d_lbl 7650 `"Laotian"', add
label define ancestr2d_lbl 7660 `"Meo"', add
label define ancestr2d_lbl 7680 `"Hmong"', add
label define ancestr2d_lbl 7700 `"Malaysian (1980)"', add
label define ancestr2d_lbl 7701 `"Malaysian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 7702 `"North Borneo (1990-2000)"', add
label define ancestr2d_lbl 7740 `"Singaporean"', add
label define ancestr2d_lbl 7760 `"Thai"', add
label define ancestr2d_lbl 7770 `"Black Thai"', add
label define ancestr2d_lbl 7780 `"Western Lao"', add
label define ancestr2d_lbl 7820 `"Taiwanese"', add
label define ancestr2d_lbl 7850 `"Vietnamese"', add
label define ancestr2d_lbl 7860 `"Katu"', add
label define ancestr2d_lbl 7870 `"Ma"', add
label define ancestr2d_lbl 7880 `"Mnong"', add
label define ancestr2d_lbl 7900 `"Montagnard"', add
label define ancestr2d_lbl 7920 `"Indochinese"', add
label define ancestr2d_lbl 7930 `"Eurasian"', add
label define ancestr2d_lbl 7931 `"Amerasian"', add
label define ancestr2d_lbl 7950 `"Asian"', add
label define ancestr2d_lbl 7960 `"Other Asian"', add
label define ancestr2d_lbl 8000 `"Australian"', add
label define ancestr2d_lbl 8010 `"Tasmanian"', add
label define ancestr2d_lbl 8020 `"Australian Aborigine (1990-2000)"', add
label define ancestr2d_lbl 8030 `"New Zealander"', add
label define ancestr2d_lbl 8080 `"Polynesian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 8081 `"Polynesian (1980)"', add
label define ancestr2d_lbl 8082 `"Norfolk Islander (1980)"', add
label define ancestr2d_lbl 8090 `"Kapinagamarangan (1990-2000)"', add
label define ancestr2d_lbl 8091 `"Kapinagamarangan (1980)"', add
label define ancestr2d_lbl 8092 `"Nukuoroan (1980)"', add
label define ancestr2d_lbl 8100 `"Maori"', add
label define ancestr2d_lbl 8110 `"Hawaiian"', add
label define ancestr2d_lbl 8130 `"Part Hawaiian"', add
label define ancestr2d_lbl 8140 `"Samoan (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 8141 `"Samoan (1980)"', add
label define ancestr2d_lbl 8142 `"American Samoan (1980)"', add
label define ancestr2d_lbl 8143 `"French Samoan"', add
label define ancestr2d_lbl 8144 `"Part Samoan (1990-2000)"', add
label define ancestr2d_lbl 8150 `"Tongan"', add
label define ancestr2d_lbl 8160 `"Tokelauan"', add
label define ancestr2d_lbl 8170 `"Cook Islander"', add
label define ancestr2d_lbl 8180 `"Tahitian"', add
label define ancestr2d_lbl 8190 `"Niuean"', add
label define ancestr2d_lbl 8200 `"Micronesian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 8201 `"Micronesian (1980)"', add
label define ancestr2d_lbl 8202 `"U.S. Trust Terr of the Pacific"', add
label define ancestr2d_lbl 8210 `"Guamanian"', add
label define ancestr2d_lbl 8220 `"Chamorro Islander"', add
label define ancestr2d_lbl 8230 `"Saipanese (1990-2000)"', add
label define ancestr2d_lbl 8231 `"Saipanese (1980)"', add
label define ancestr2d_lbl 8232 `"Northern Marianas (1980)"', add
label define ancestr2d_lbl 8240 `"Palauan"', add
label define ancestr2d_lbl 8250 `"Marshall Islander"', add
label define ancestr2d_lbl 8260 `"Kosraean"', add
label define ancestr2d_lbl 8270 `"Ponapean (1990-2000)"', add
label define ancestr2d_lbl 8271 `"Ponapean (1980)"', add
label define ancestr2d_lbl 8272 `"Mokilese (1980)"', add
label define ancestr2d_lbl 8273 `"Ngatikese (1980)"', add
label define ancestr2d_lbl 8274 `"Pingelapese (1980)"', add
label define ancestr2d_lbl 8280 `"Chuukese"', add
label define ancestr2d_lbl 8281 `"Hall Islander (1980)"', add
label define ancestr2d_lbl 8282 `"Mortlockese (1980)"', add
label define ancestr2d_lbl 8283 `"Namanouito (1980)"', add
label define ancestr2d_lbl 8284 `"Pulawatese (1980)"', add
label define ancestr2d_lbl 8285 `"Truk Islander"', add
label define ancestr2d_lbl 8290 `"Yap Islander"', add
label define ancestr2d_lbl 8300 `"Caroline Islander (1990-2000)"', add
label define ancestr2d_lbl 8301 `"Caroline Islander (1980)"', add
label define ancestr2d_lbl 8302 `"Lamotrekese (1980)"', add
label define ancestr2d_lbl 8303 `"Ulithian (1980)"', add
label define ancestr2d_lbl 8304 `"Woleaian (1980)"', add
label define ancestr2d_lbl 8310 `"Kiribatese"', add
label define ancestr2d_lbl 8320 `"Nauruan"', add
label define ancestr2d_lbl 8330 `"Tarawa Islander (1990-2000)"', add
label define ancestr2d_lbl 8340 `"Tinian Islander (1990-2000)"', add
label define ancestr2d_lbl 8400 `"Melanesian Islander"', add
label define ancestr2d_lbl 8410 `"Fijian"', add
label define ancestr2d_lbl 8430 `"New Guinean"', add
label define ancestr2d_lbl 8440 `"Papuan"', add
label define ancestr2d_lbl 8450 `"Solomon Islander"', add
label define ancestr2d_lbl 8460 `"New Caledonian Islander"', add
label define ancestr2d_lbl 8470 `"Vanuatuan"', add
label define ancestr2d_lbl 8500 `"Pacific Islander (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 8501 `"Campbell Islander (1980)"', add
label define ancestr2d_lbl 8502 `"Christmas Islander (1980)"', add
label define ancestr2d_lbl 8503 `"Kermadec Islander (1980)"', add
label define ancestr2d_lbl 8504 `"Midway Islander (1980)"', add
label define ancestr2d_lbl 8505 `"Phoenix Islander (1980)"', add
label define ancestr2d_lbl 8506 `"Wake Islander (1980)"', add
label define ancestr2d_lbl 8600 `"Oceania"', add
label define ancestr2d_lbl 8620 `"Chamolinian (1990-2000)"', add
label define ancestr2d_lbl 8630 `"Reserved Codes"', add
label define ancestr2d_lbl 8700 `"Other Pacific"', add
label define ancestr2d_lbl 9000 `"Afro-American"', add
label define ancestr2d_lbl 9001 `"Afro-American (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9002 `"Black (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9003 `"Negro (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9004 `"Nonwhite (1990-2000)"', add
label define ancestr2d_lbl 9005 `"Colored (1990-2000)"', add
label define ancestr2d_lbl 9006 `"Creole (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9007 `"Mulatto (1990-2000)"', add
label define ancestr2d_lbl 9008 `"Afro"', add
label define ancestr2d_lbl 9020 `"African-American (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9130 `"Central American Indian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9140 `"South American Indian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9200 `"American Indian (all tribes)"', add
label define ancestr2d_lbl 9201 `"American Indian-English-French"', add
label define ancestr2d_lbl 9202 `"American Indian-English-German"', add
label define ancestr2d_lbl 9203 `"American Indian-English-Irish"', add
label define ancestr2d_lbl 9204 `"American Indian-German-Irish"', add
label define ancestr2d_lbl 9205 `"Cherokee"', add
label define ancestr2d_lbl 9206 `"Native American"', add
label define ancestr2d_lbl 9207 `"Indian"', add
label define ancestr2d_lbl 9210 `"Aleut"', add
label define ancestr2d_lbl 9220 `"Eskimo"', add
label define ancestr2d_lbl 9230 `"Inuit"', add
label define ancestr2d_lbl 9240 `"White/Caucasian"', add
label define ancestr2d_lbl 9241 `"White/Caucasian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9242 `"Anglo (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9243 `"Appalachian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9244 `"Aryan (1990-2000)"', add
label define ancestr2d_lbl 9300 `"Greenlander"', add
label define ancestr2d_lbl 9310 `"Canadian"', add
label define ancestr2d_lbl 9330 `"Newfoundland"', add
label define ancestr2d_lbl 9340 `"Nova Scotian"', add
label define ancestr2d_lbl 9350 `"French Canadian"', add
label define ancestr2d_lbl 9360 `"Acadian"', add
label define ancestr2d_lbl 9361 `"Acadian (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9362 `"Cajun (1990-2000, ACS, PRCS)"', add
label define ancestr2d_lbl 9390 `"American"', add
label define ancestr2d_lbl 9391 `"American/Unites States"', add
label define ancestr2d_lbl 9400 `"United States"', add
label define ancestr2d_lbl 9410 `"Alabama"', add
label define ancestr2d_lbl 9420 `"Alaska"', add
label define ancestr2d_lbl 9430 `"Arizona"', add
label define ancestr2d_lbl 9440 `"Arkansas"', add
label define ancestr2d_lbl 9450 `"California"', add
label define ancestr2d_lbl 9460 `"Colorado"', add
label define ancestr2d_lbl 9470 `"Connecticut"', add
label define ancestr2d_lbl 9480 `"District of Columbia"', add
label define ancestr2d_lbl 9490 `"Delaware"', add
label define ancestr2d_lbl 9500 `"Florida"', add
label define ancestr2d_lbl 9510 `"Georgia"', add
label define ancestr2d_lbl 9520 `"Idaho"', add
label define ancestr2d_lbl 9530 `"Illinois"', add
label define ancestr2d_lbl 9540 `"Indiana"', add
label define ancestr2d_lbl 9550 `"Iowa"', add
label define ancestr2d_lbl 9560 `"Kansas"', add
label define ancestr2d_lbl 9570 `"Kentucky"', add
label define ancestr2d_lbl 9580 `"Louisiana"', add
label define ancestr2d_lbl 9590 `"Maine"', add
label define ancestr2d_lbl 9600 `"Maryland"', add
label define ancestr2d_lbl 9610 `"Massachusetts"', add
label define ancestr2d_lbl 9620 `"Michigan"', add
label define ancestr2d_lbl 9630 `"Minnesota"', add
label define ancestr2d_lbl 9640 `"Mississippi"', add
label define ancestr2d_lbl 9650 `"Missouri"', add
label define ancestr2d_lbl 9660 `"Montana"', add
label define ancestr2d_lbl 9670 `"Nebraska"', add
label define ancestr2d_lbl 9680 `"Nevada"', add
label define ancestr2d_lbl 9690 `"New Hampshire"', add
label define ancestr2d_lbl 9700 `"New Jersey"', add
label define ancestr2d_lbl 9710 `"New Mexico"', add
label define ancestr2d_lbl 9720 `"New York"', add
label define ancestr2d_lbl 9730 `"North Carolina"', add
label define ancestr2d_lbl 9740 `"North Dakota"', add
label define ancestr2d_lbl 9750 `"Ohio"', add
label define ancestr2d_lbl 9760 `"Oklahoma"', add
label define ancestr2d_lbl 9770 `"Oregon"', add
label define ancestr2d_lbl 9780 `"Pennsylvania"', add
label define ancestr2d_lbl 9790 `"Rhode Island"', add
label define ancestr2d_lbl 9800 `"South Carolina"', add
label define ancestr2d_lbl 9810 `"South Dakota"', add
label define ancestr2d_lbl 9820 `"Tennessee"', add
label define ancestr2d_lbl 9830 `"Texas"', add
label define ancestr2d_lbl 9840 `"Utah"', add
label define ancestr2d_lbl 9850 `"Vermont"', add
label define ancestr2d_lbl 9860 `"Virginia"', add
label define ancestr2d_lbl 9870 `"Washington"', add
label define ancestr2d_lbl 9880 `"West Virginia"', add
label define ancestr2d_lbl 9890 `"Wisconsin"', add
label define ancestr2d_lbl 9900 `"Wyoming"', add
label define ancestr2d_lbl 9930 `"Southerner"', add
label define ancestr2d_lbl 9940 `"North American"', add
label define ancestr2d_lbl 9950 `"Mixture"', add
label define ancestr2d_lbl 9960 `"Uncodable"', add
label define ancestr2d_lbl 9961 `"Not Classified"', add
label define ancestr2d_lbl 9962 `"Suppressed"', add
label define ancestr2d_lbl 9970 `"Deferred Cases"', add
label define ancestr2d_lbl 9980 `"Other"', add
label define ancestr2d_lbl 9990 `"Not Reported"', add
label values ancestr2d ancestr2d_lbl

label define citizen_lbl 0 `"N/A"'
label define citizen_lbl 1 `"Born abroad of American parents"', add
label define citizen_lbl 2 `"Naturalized citizen"', add
label define citizen_lbl 3 `"Not a citizen"', add
label define citizen_lbl 4 `"Not a citizen, but has received first papers"', add
label define citizen_lbl 5 `"Foreign born, citizenship status not reported"', add
label define citizen_lbl 8 `"Illegible"', add
label define citizen_lbl 9 `"Missing/blank"', add
label values citizen citizen_lbl

label define yrnatur_lbl 1806 `"1806"'
label define yrnatur_lbl 1807 `"1807"', add
label define yrnatur_lbl 1808 `"1808"', add
label define yrnatur_lbl 1809 `"1809"', add
label define yrnatur_lbl 1810 `"1810"', add
label define yrnatur_lbl 1811 `"1811"', add
label define yrnatur_lbl 1812 `"1812"', add
label define yrnatur_lbl 1813 `"1813"', add
label define yrnatur_lbl 1814 `"1814"', add
label define yrnatur_lbl 1815 `"1815"', add
label define yrnatur_lbl 1816 `"1816"', add
label define yrnatur_lbl 1817 `"1817"', add
label define yrnatur_lbl 1818 `"1818"', add
label define yrnatur_lbl 1819 `"1819"', add
label define yrnatur_lbl 1820 `"1820"', add
label define yrnatur_lbl 1821 `"1821"', add
label define yrnatur_lbl 1822 `"1822"', add
label define yrnatur_lbl 1823 `"1823"', add
label define yrnatur_lbl 1824 `"1824"', add
label define yrnatur_lbl 1825 `"1825"', add
label define yrnatur_lbl 1826 `"1826"', add
label define yrnatur_lbl 1827 `"1827"', add
label define yrnatur_lbl 1828 `"1828"', add
label define yrnatur_lbl 1829 `"1829"', add
label define yrnatur_lbl 1830 `"1830"', add
label define yrnatur_lbl 1831 `"1831"', add
label define yrnatur_lbl 1832 `"1832"', add
label define yrnatur_lbl 1833 `"1833"', add
label define yrnatur_lbl 1834 `"1834"', add
label define yrnatur_lbl 1835 `"1835"', add
label define yrnatur_lbl 1836 `"1836"', add
label define yrnatur_lbl 1837 `"1837"', add
label define yrnatur_lbl 1838 `"1838"', add
label define yrnatur_lbl 1839 `"1839"', add
label define yrnatur_lbl 1840 `"1840"', add
label define yrnatur_lbl 1841 `"1841"', add
label define yrnatur_lbl 1842 `"1842"', add
label define yrnatur_lbl 1843 `"1843"', add
label define yrnatur_lbl 1844 `"1844"', add
label define yrnatur_lbl 1845 `"1845"', add
label define yrnatur_lbl 1846 `"1846"', add
label define yrnatur_lbl 1847 `"1847"', add
label define yrnatur_lbl 1848 `"1848"', add
label define yrnatur_lbl 1849 `"1849"', add
label define yrnatur_lbl 1850 `"1850"', add
label define yrnatur_lbl 1851 `"1851"', add
label define yrnatur_lbl 1852 `"1852"', add
label define yrnatur_lbl 1853 `"1853"', add
label define yrnatur_lbl 1854 `"1854"', add
label define yrnatur_lbl 1855 `"1855"', add
label define yrnatur_lbl 1856 `"1856"', add
label define yrnatur_lbl 1857 `"1857"', add
label define yrnatur_lbl 1858 `"1858"', add
label define yrnatur_lbl 1859 `"1859"', add
label define yrnatur_lbl 1860 `"1860"', add
label define yrnatur_lbl 1861 `"1861"', add
label define yrnatur_lbl 1862 `"1862"', add
label define yrnatur_lbl 1863 `"1863"', add
label define yrnatur_lbl 1864 `"1864"', add
label define yrnatur_lbl 1865 `"1865"', add
label define yrnatur_lbl 1866 `"1866"', add
label define yrnatur_lbl 1867 `"1867"', add
label define yrnatur_lbl 1868 `"1868"', add
label define yrnatur_lbl 1869 `"1869"', add
label define yrnatur_lbl 1870 `"1870"', add
label define yrnatur_lbl 1871 `"1871"', add
label define yrnatur_lbl 1872 `"1872"', add
label define yrnatur_lbl 1873 `"1873"', add
label define yrnatur_lbl 1874 `"1874"', add
label define yrnatur_lbl 1875 `"1875"', add
label define yrnatur_lbl 1876 `"1876"', add
label define yrnatur_lbl 1877 `"1877"', add
label define yrnatur_lbl 1878 `"1878"', add
label define yrnatur_lbl 1879 `"1879"', add
label define yrnatur_lbl 1880 `"1880"', add
label define yrnatur_lbl 1881 `"1881"', add
label define yrnatur_lbl 1882 `"1882"', add
label define yrnatur_lbl 1883 `"1883"', add
label define yrnatur_lbl 1884 `"1884"', add
label define yrnatur_lbl 1885 `"1885"', add
label define yrnatur_lbl 1886 `"1886"', add
label define yrnatur_lbl 1887 `"1887"', add
label define yrnatur_lbl 1888 `"1888"', add
label define yrnatur_lbl 1889 `"1889"', add
label define yrnatur_lbl 1890 `"1890"', add
label define yrnatur_lbl 1891 `"1891"', add
label define yrnatur_lbl 1892 `"1892"', add
label define yrnatur_lbl 1893 `"1893"', add
label define yrnatur_lbl 1894 `"1894"', add
label define yrnatur_lbl 1895 `"1895"', add
label define yrnatur_lbl 1896 `"1896"', add
label define yrnatur_lbl 1897 `"1897"', add
label define yrnatur_lbl 1898 `"1898"', add
label define yrnatur_lbl 1899 `"1899"', add
label define yrnatur_lbl 1900 `"1900"', add
label define yrnatur_lbl 1901 `"1901"', add
label define yrnatur_lbl 1902 `"1902"', add
label define yrnatur_lbl 1903 `"1903"', add
label define yrnatur_lbl 1904 `"1904"', add
label define yrnatur_lbl 1905 `"1905"', add
label define yrnatur_lbl 1906 `"1906"', add
label define yrnatur_lbl 1907 `"1907"', add
label define yrnatur_lbl 1908 `"1908"', add
label define yrnatur_lbl 1909 `"1909"', add
label define yrnatur_lbl 1910 `"1910"', add
label define yrnatur_lbl 1911 `"1911"', add
label define yrnatur_lbl 1912 `"1912"', add
label define yrnatur_lbl 1913 `"1913"', add
label define yrnatur_lbl 1914 `"1914"', add
label define yrnatur_lbl 1915 `"1915"', add
label define yrnatur_lbl 1916 `"1916"', add
label define yrnatur_lbl 1917 `"1917"', add
label define yrnatur_lbl 1918 `"1918"', add
label define yrnatur_lbl 1919 `"1919"', add
label define yrnatur_lbl 1920 `"1920"', add
label define yrnatur_lbl 1921 `"1921"', add
label define yrnatur_lbl 1922 `"1922"', add
label define yrnatur_lbl 1923 `"1923"', add
label define yrnatur_lbl 1924 `"1924"', add
label define yrnatur_lbl 1925 `"1925 (1925 or earlier, ACS/PRCS pre 2012)"', add
label define yrnatur_lbl 1926 `"1925 (1925 or earlier, ACS/PRCS pre 2012)"', add
label define yrnatur_lbl 1927 `"1927"', add
label define yrnatur_lbl 1928 `"1928 (1928 or earlier, 2012-2016 ACS/PRCS)"', add
label define yrnatur_lbl 1929 `"1929 (1929-1933, 2012-2016 ACS/PRCS)"', add
label define yrnatur_lbl 1930 `"1930"', add
label define yrnatur_lbl 1931 `"1931 (1931-1935, ACS/PRCS pre 2012)"', add
label define yrnatur_lbl 1932 `"1932"', add
label define yrnatur_lbl 1933 `"1933"', add
label define yrnatur_lbl 1934 `"1934 (1934-1939, 2012-2016 ACS/PRCS)"', add
label define yrnatur_lbl 1935 `"1935"', add
label define yrnatur_lbl 1936 `"1936 (1936-1940, ACS/PRCS pre 2012)"', add
label define yrnatur_lbl 1937 `"1937"', add
label define yrnatur_lbl 1938 `"1938"', add
label define yrnatur_lbl 1939 `"1939 (1939 or earlier, 2017-2018 ACS/PRCS)"', add
label define yrnatur_lbl 1940 `"1940 (1940-1942, 2012-2016 ACS/PRCS; 1940-1944, 2017-2018 ACS/PRCS)"', add
label define yrnatur_lbl 1941 `"1941 (1941-1942, ACS/PRCS pre 2012)"', add
label define yrnatur_lbl 1942 `"1942"', add
label define yrnatur_lbl 1943 `"1943 (1943-44, 2012-2016 ACS/PRCS)"', add
label define yrnatur_lbl 1944 `"1944 (1944 or earlier, 2019-onward ACS/PRCS)"', add
label define yrnatur_lbl 1945 `"1945 (1945-1947, 2017-onward ACS/PRCS)"', add
label define yrnatur_lbl 1946 `"1946 (1946-1947, 2012-2016 ACS/PRCS)"', add
label define yrnatur_lbl 1947 `"1947 (1947 or earlier, 2022-onward ACS/PRCS)"', add
label define yrnatur_lbl 1948 `"1948 (1948-1949, 2017-onward ACS/PRCS)"', add
label define yrnatur_lbl 1949 `"1949"', add
label define yrnatur_lbl 1950 `"1950 (1950-1951, 2020-onward ACS/PRCS)"', add
label define yrnatur_lbl 1951 `"1951"', add
label define yrnatur_lbl 1952 `"1952"', add
label define yrnatur_lbl 1953 `"1953"', add
label define yrnatur_lbl 1954 `"1954"', add
label define yrnatur_lbl 1955 `"1955"', add
label define yrnatur_lbl 1956 `"1956"', add
label define yrnatur_lbl 1957 `"1957"', add
label define yrnatur_lbl 1958 `"1958"', add
label define yrnatur_lbl 1959 `"1959"', add
label define yrnatur_lbl 1960 `"1960"', add
label define yrnatur_lbl 1961 `"1961"', add
label define yrnatur_lbl 1962 `"1962"', add
label define yrnatur_lbl 1963 `"1963"', add
label define yrnatur_lbl 1964 `"1964"', add
label define yrnatur_lbl 1965 `"1965"', add
label define yrnatur_lbl 1966 `"1966"', add
label define yrnatur_lbl 1967 `"1967"', add
label define yrnatur_lbl 1968 `"1968"', add
label define yrnatur_lbl 1969 `"1969"', add
label define yrnatur_lbl 1970 `"1970"', add
label define yrnatur_lbl 1971 `"1971"', add
label define yrnatur_lbl 1972 `"1972"', add
label define yrnatur_lbl 1973 `"1973"', add
label define yrnatur_lbl 1974 `"1974"', add
label define yrnatur_lbl 1975 `"1975"', add
label define yrnatur_lbl 1976 `"1976"', add
label define yrnatur_lbl 1977 `"1977"', add
label define yrnatur_lbl 1978 `"1978"', add
label define yrnatur_lbl 1979 `"1979"', add
label define yrnatur_lbl 1980 `"1980"', add
label define yrnatur_lbl 1981 `"1981"', add
label define yrnatur_lbl 1982 `"1982"', add
label define yrnatur_lbl 1983 `"1983"', add
label define yrnatur_lbl 1984 `"1984"', add
label define yrnatur_lbl 1985 `"1985"', add
label define yrnatur_lbl 1986 `"1986"', add
label define yrnatur_lbl 1987 `"1987"', add
label define yrnatur_lbl 1988 `"1988"', add
label define yrnatur_lbl 1989 `"1989"', add
label define yrnatur_lbl 1990 `"1990"', add
label define yrnatur_lbl 1991 `"1991"', add
label define yrnatur_lbl 1992 `"1992"', add
label define yrnatur_lbl 1993 `"1993"', add
label define yrnatur_lbl 1994 `"1994"', add
label define yrnatur_lbl 1995 `"1995"', add
label define yrnatur_lbl 1996 `"1996"', add
label define yrnatur_lbl 1997 `"1997"', add
label define yrnatur_lbl 1998 `"1998"', add
label define yrnatur_lbl 1999 `"1999"', add
label define yrnatur_lbl 2000 `"2000"', add
label define yrnatur_lbl 2001 `"2001"', add
label define yrnatur_lbl 2002 `"2002"', add
label define yrnatur_lbl 2003 `"2003"', add
label define yrnatur_lbl 2004 `"2004"', add
label define yrnatur_lbl 2005 `"2005"', add
label define yrnatur_lbl 2006 `"2006"', add
label define yrnatur_lbl 2007 `"2007"', add
label define yrnatur_lbl 2008 `"2008"', add
label define yrnatur_lbl 2009 `"2009"', add
label define yrnatur_lbl 2010 `"2010"', add
label define yrnatur_lbl 2011 `"2011"', add
label define yrnatur_lbl 2012 `"2012"', add
label define yrnatur_lbl 2013 `"2013"', add
label define yrnatur_lbl 2014 `"2014"', add
label define yrnatur_lbl 2015 `"2015"', add
label define yrnatur_lbl 2016 `"2016"', add
label define yrnatur_lbl 2017 `"2017"', add
label define yrnatur_lbl 2018 `"2018"', add
label define yrnatur_lbl 2019 `"2019"', add
label define yrnatur_lbl 2020 `"2020"', add
label define yrnatur_lbl 2021 `"2021"', add
label define yrnatur_lbl 2022 `"2022"', add
label define yrnatur_lbl 9997 `"Unknown"', add
label define yrnatur_lbl 9998 `"Illegible"', add
label define yrnatur_lbl 9999 `"N/A"', add
label values yrnatur yrnatur_lbl

label define yrimmig_lbl 0000 `"N/A"'
label define yrimmig_lbl 1790 `"1790"', add
label define yrimmig_lbl 1791 `"1791"', add
label define yrimmig_lbl 1792 `"1792"', add
label define yrimmig_lbl 1793 `"1793"', add
label define yrimmig_lbl 1794 `"1794"', add
label define yrimmig_lbl 1795 `"1795"', add
label define yrimmig_lbl 1796 `"1796"', add
label define yrimmig_lbl 1797 `"1797"', add
label define yrimmig_lbl 1798 `"1798"', add
label define yrimmig_lbl 1799 `"1799"', add
label define yrimmig_lbl 1800 `"1800"', add
label define yrimmig_lbl 1801 `"1801"', add
label define yrimmig_lbl 1802 `"1802"', add
label define yrimmig_lbl 1803 `"1803"', add
label define yrimmig_lbl 1804 `"1804"', add
label define yrimmig_lbl 1805 `"1805"', add
label define yrimmig_lbl 1806 `"1806"', add
label define yrimmig_lbl 1807 `"1807"', add
label define yrimmig_lbl 1808 `"1808"', add
label define yrimmig_lbl 1809 `"1809"', add
label define yrimmig_lbl 1810 `"1810"', add
label define yrimmig_lbl 1811 `"1811"', add
label define yrimmig_lbl 1812 `"1812"', add
label define yrimmig_lbl 1813 `"1813"', add
label define yrimmig_lbl 1814 `"1814"', add
label define yrimmig_lbl 1815 `"1815"', add
label define yrimmig_lbl 1816 `"1816"', add
label define yrimmig_lbl 1817 `"1817"', add
label define yrimmig_lbl 1818 `"1818"', add
label define yrimmig_lbl 1819 `"1819"', add
label define yrimmig_lbl 1820 `"1820"', add
label define yrimmig_lbl 1821 `"1821"', add
label define yrimmig_lbl 1822 `"1822"', add
label define yrimmig_lbl 1823 `"1823"', add
label define yrimmig_lbl 1824 `"1824"', add
label define yrimmig_lbl 1825 `"1825"', add
label define yrimmig_lbl 1826 `"1826"', add
label define yrimmig_lbl 1827 `"1827"', add
label define yrimmig_lbl 1828 `"1828"', add
label define yrimmig_lbl 1829 `"1829"', add
label define yrimmig_lbl 1830 `"1830"', add
label define yrimmig_lbl 1831 `"1831"', add
label define yrimmig_lbl 1832 `"1832"', add
label define yrimmig_lbl 1833 `"1833"', add
label define yrimmig_lbl 1834 `"1834"', add
label define yrimmig_lbl 1835 `"1835"', add
label define yrimmig_lbl 1836 `"1836"', add
label define yrimmig_lbl 1837 `"1837"', add
label define yrimmig_lbl 1838 `"1838"', add
label define yrimmig_lbl 1839 `"1839"', add
label define yrimmig_lbl 1840 `"1840"', add
label define yrimmig_lbl 1841 `"1841"', add
label define yrimmig_lbl 1842 `"1842"', add
label define yrimmig_lbl 1843 `"1843"', add
label define yrimmig_lbl 1844 `"1844"', add
label define yrimmig_lbl 1845 `"1845"', add
label define yrimmig_lbl 1846 `"1846"', add
label define yrimmig_lbl 1847 `"1847"', add
label define yrimmig_lbl 1848 `"1848"', add
label define yrimmig_lbl 1849 `"1849"', add
label define yrimmig_lbl 1850 `"1850"', add
label define yrimmig_lbl 1851 `"1851"', add
label define yrimmig_lbl 1852 `"1852"', add
label define yrimmig_lbl 1853 `"1853"', add
label define yrimmig_lbl 1854 `"1854"', add
label define yrimmig_lbl 1855 `"1855"', add
label define yrimmig_lbl 1856 `"1856"', add
label define yrimmig_lbl 1857 `"1857"', add
label define yrimmig_lbl 1858 `"1858"', add
label define yrimmig_lbl 1859 `"1859"', add
label define yrimmig_lbl 1860 `"1860"', add
label define yrimmig_lbl 1861 `"1861"', add
label define yrimmig_lbl 1862 `"1862"', add
label define yrimmig_lbl 1863 `"1863"', add
label define yrimmig_lbl 1864 `"1864"', add
label define yrimmig_lbl 1865 `"1865"', add
label define yrimmig_lbl 1866 `"1866"', add
label define yrimmig_lbl 1867 `"1867"', add
label define yrimmig_lbl 1868 `"1868"', add
label define yrimmig_lbl 1869 `"1869"', add
label define yrimmig_lbl 1870 `"1870"', add
label define yrimmig_lbl 1871 `"1871"', add
label define yrimmig_lbl 1872 `"1872"', add
label define yrimmig_lbl 1873 `"1873"', add
label define yrimmig_lbl 1874 `"1874"', add
label define yrimmig_lbl 1875 `"1875"', add
label define yrimmig_lbl 1876 `"1876"', add
label define yrimmig_lbl 1877 `"1877"', add
label define yrimmig_lbl 1878 `"1878"', add
label define yrimmig_lbl 1879 `"1879"', add
label define yrimmig_lbl 1880 `"1880"', add
label define yrimmig_lbl 1881 `"1881"', add
label define yrimmig_lbl 1882 `"1882"', add
label define yrimmig_lbl 1883 `"1883"', add
label define yrimmig_lbl 1884 `"1884"', add
label define yrimmig_lbl 1885 `"1885"', add
label define yrimmig_lbl 1886 `"1886"', add
label define yrimmig_lbl 1887 `"1887"', add
label define yrimmig_lbl 1888 `"1888"', add
label define yrimmig_lbl 1889 `"1889"', add
label define yrimmig_lbl 1890 `"1890"', add
label define yrimmig_lbl 1891 `"1891"', add
label define yrimmig_lbl 1892 `"1892"', add
label define yrimmig_lbl 1893 `"1893"', add
label define yrimmig_lbl 1894 `"1894"', add
label define yrimmig_lbl 1895 `"1895"', add
label define yrimmig_lbl 1896 `"1896"', add
label define yrimmig_lbl 1897 `"1897"', add
label define yrimmig_lbl 1898 `"1898"', add
label define yrimmig_lbl 1899 `"1899"', add
label define yrimmig_lbl 1900 `"1900"', add
label define yrimmig_lbl 1901 `"1901"', add
label define yrimmig_lbl 1902 `"1902"', add
label define yrimmig_lbl 1903 `"1903"', add
label define yrimmig_lbl 1904 `"1904"', add
label define yrimmig_lbl 1905 `"1905"', add
label define yrimmig_lbl 1906 `"1906"', add
label define yrimmig_lbl 1907 `"1907"', add
label define yrimmig_lbl 1908 `"1908"', add
label define yrimmig_lbl 1909 `"1909"', add
label define yrimmig_lbl 1910 `"1910 (2000 PUMS: 1910 or earlier)"', add
label define yrimmig_lbl 1911 `"1911 (2000 PUMS: 1911-1914)"', add
label define yrimmig_lbl 1912 `"1912"', add
label define yrimmig_lbl 1913 `"1913"', add
label define yrimmig_lbl 1914 `"1914 (1970 PUMS: 1914 or earlier)"', add
label define yrimmig_lbl 1915 `"1915 (1970 PUMS: 1915-1924; 2000 PUMS: 1915-1919)"', add
label define yrimmig_lbl 1916 `"1916"', add
label define yrimmig_lbl 1917 `"1917"', add
label define yrimmig_lbl 1918 `"1918"', add
label define yrimmig_lbl 1919 `"1919 (2005 - 2011 ACS & 2012 - 2016 ACS 1-yr & 2016 5-yr files: 1919 or earlier)"', add
label define yrimmig_lbl 1920 `"1920"', add
label define yrimmig_lbl 1921 `"1921 (2012 - 2016 ACS 1-yr & 2016 5-yr files: 1921 or earlier)"', add
label define yrimmig_lbl 1922 `"1922 (2012 - 2016 ACS 1-yr & 2016 5-yr files: 1922-1923)"', add
label define yrimmig_lbl 1923 `"1923"', add
label define yrimmig_lbl 1924 `"1924 (2012 - 2016 ACS 1-yr & 2016 5-yr files: 1924-1925)"', add
label define yrimmig_lbl 1925 `"1925 (1970 PUMS: 1925-1934; 2017 ACS: 1925 or earlier)"', add
label define yrimmig_lbl 1926 `"1926 (2012 - 2016 ACS 1-yr & 2016 5-yr files: 1926-1927; 2017 ACS: 1926-1929)"', add
label define yrimmig_lbl 1927 `"1927"', add
label define yrimmig_lbl 1928 `"1928 (2012 - 2016 ACS 1-yr & 2016 5-yr files: 1928-1929)"', add
label define yrimmig_lbl 1929 `"1929 (2018 - 2019 ACS: 1929 or earlier)"', add
label define yrimmig_lbl 1930 `"1930 (2000 PUMS, 2017 ACS, and 2018 - 2019 ACS: 1930-1934; 2012 - 2016 ACS 1-yr & 2016 5-yr files: 1930-1931)"', add
label define yrimmig_lbl 1931 `"1931 (2005 - 2011 ACS: 1931-1932)"', add
label define yrimmig_lbl 1932 `"1932 (2012 - 2016 ACS 1-yr & 2016 5-yr files: 1932-1934)"', add
label define yrimmig_lbl 1933 `"1933 (2005 - 2011 ACS: 1933-1934)"', add
label define yrimmig_lbl 1934 `"1934 (2020 - 2022: 1934 or earlier)"', add
label define yrimmig_lbl 1935 `"1935 (1970 PUMS: 1935-1944; 2012 - 2016 ACS 1-yr & 2016 5-yr files: 1935-1936; 2017 - 2022 ACS: 1935-1938)"', add
label define yrimmig_lbl 1936 `"1936"', add
label define yrimmig_lbl 1937 `"1937 (2012 - 2016 ACS 1-yr & 2016 5-yr files: 1937-1938)"', add
label define yrimmig_lbl 1938 `"1938 (2023 ACS - Onward: 1938 or earlier)"', add
label define yrimmig_lbl 1939 `"1939 (2018 - 2019 ACS: 1939-1940; 2020 ACS - Onward: 1939-1942)"', add
label define yrimmig_lbl 1940 `"1940"', add
label define yrimmig_lbl 1941 `"1941 (2017 - 2019 ACS: 1941-1942)"', add
label define yrimmig_lbl 1942 `"1942"', add
label define yrimmig_lbl 1943 `"1943 (2012 - 2016 ACS 1-yr & 2016 5-yr files & 2017 ACS - Onward: 1943-1944)"', add
label define yrimmig_lbl 1944 `"1944"', add
label define yrimmig_lbl 1945 `"1945 (1970 PUMS: 1945-1949)"', add
label define yrimmig_lbl 1946 `"1946"', add
label define yrimmig_lbl 1947 `"1947"', add
label define yrimmig_lbl 1948 `"1948"', add
label define yrimmig_lbl 1949 `"1949 (1980 - 1990 PUMS: 1949 or earlier)"', add
label define yrimmig_lbl 1950 `"1950 (1970 PUMS: 1950-1954; 1980 - 1990 PUMS: 1950-1959)"', add
label define yrimmig_lbl 1951 `"1951"', add
label define yrimmig_lbl 1952 `"1952"', add
label define yrimmig_lbl 1953 `"1953"', add
label define yrimmig_lbl 1954 `"1954"', add
label define yrimmig_lbl 1955 `"1955 (1970 PUMS: 1955-1959)"', add
label define yrimmig_lbl 1956 `"1956"', add
label define yrimmig_lbl 1957 `"1957"', add
label define yrimmig_lbl 1958 `"1958"', add
label define yrimmig_lbl 1959 `"1959"', add
label define yrimmig_lbl 1960 `"1960 (1970 - 1990 PUMS: 1960 - 1964)"', add
label define yrimmig_lbl 1961 `"1961"', add
label define yrimmig_lbl 1962 `"1962"', add
label define yrimmig_lbl 1963 `"1963"', add
label define yrimmig_lbl 1964 `"1964"', add
label define yrimmig_lbl 1965 `"1965 (1970 PUMS: 1965-1970; 1980 - 1990 PUMS: 1965-1969)"', add
label define yrimmig_lbl 1966 `"1966"', add
label define yrimmig_lbl 1967 `"1967"', add
label define yrimmig_lbl 1968 `"1968"', add
label define yrimmig_lbl 1969 `"1969"', add
label define yrimmig_lbl 1970 `"1970 (1980 - 1990 PUMS: 1970-1974)"', add
label define yrimmig_lbl 1971 `"1971"', add
label define yrimmig_lbl 1972 `"1972"', add
label define yrimmig_lbl 1973 `"1973"', add
label define yrimmig_lbl 1974 `"1974"', add
label define yrimmig_lbl 1975 `"1975 (1980 PUMS: 1975-1980; 1990 PUMS: 1975-1979)"', add
label define yrimmig_lbl 1976 `"1976"', add
label define yrimmig_lbl 1977 `"1977"', add
label define yrimmig_lbl 1978 `"1978"', add
label define yrimmig_lbl 1979 `"1979"', add
label define yrimmig_lbl 1980 `"1980 (1990 PUMS: 1980-1981)"', add
label define yrimmig_lbl 1981 `"1981"', add
label define yrimmig_lbl 1982 `"1982 (1990 PUMS: 1982-1984)"', add
label define yrimmig_lbl 1983 `"1983"', add
label define yrimmig_lbl 1984 `"1984"', add
label define yrimmig_lbl 1985 `"1985 (1990 PUMS: 1985-1986)"', add
label define yrimmig_lbl 1986 `"1986"', add
label define yrimmig_lbl 1987 `"1987 (1990 PUMS: 1987-1990)"', add
label define yrimmig_lbl 1988 `"1988"', add
label define yrimmig_lbl 1989 `"1989"', add
label define yrimmig_lbl 1990 `"1990"', add
label define yrimmig_lbl 1991 `"1991"', add
label define yrimmig_lbl 1992 `"1992"', add
label define yrimmig_lbl 1993 `"1993"', add
label define yrimmig_lbl 1994 `"1994"', add
label define yrimmig_lbl 1995 `"1995"', add
label define yrimmig_lbl 1996 `"1996"', add
label define yrimmig_lbl 1997 `"1997"', add
label define yrimmig_lbl 1998 `"1998"', add
label define yrimmig_lbl 1999 `"1999"', add
label define yrimmig_lbl 2000 `"2000"', add
label define yrimmig_lbl 2001 `"2001"', add
label define yrimmig_lbl 2002 `"2002"', add
label define yrimmig_lbl 2003 `"2003"', add
label define yrimmig_lbl 2004 `"2004"', add
label define yrimmig_lbl 2005 `"2005"', add
label define yrimmig_lbl 2006 `"2006"', add
label define yrimmig_lbl 2007 `"2007"', add
label define yrimmig_lbl 2008 `"2008"', add
label define yrimmig_lbl 2009 `"2009"', add
label define yrimmig_lbl 2010 `"2010"', add
label define yrimmig_lbl 2011 `"2011"', add
label define yrimmig_lbl 2012 `"2012"', add
label define yrimmig_lbl 2013 `"2013"', add
label define yrimmig_lbl 2014 `"2014"', add
label define yrimmig_lbl 2015 `"2015"', add
label define yrimmig_lbl 2016 `"2016"', add
label define yrimmig_lbl 2017 `"2017"', add
label define yrimmig_lbl 2018 `"2018"', add
label define yrimmig_lbl 2019 `"2019"', add
label define yrimmig_lbl 2020 `"2020"', add
label define yrimmig_lbl 2021 `"2021"', add
label define yrimmig_lbl 2022 `"2022"', add
label define yrimmig_lbl 2023 `"2023"', add
label define yrimmig_lbl 0996 `"Not reported"', add
label values yrimmig yrimmig_lbl

label define yrsusa1_lbl 00 `"N/A or less than one year"'
label values yrsusa1 yrsusa1_lbl

label define yrsusa2_lbl 0 `"N/A"'
label define yrsusa2_lbl 1 `"0-5 years"', add
label define yrsusa2_lbl 2 `"6-10 years"', add
label define yrsusa2_lbl 3 `"11-15 years"', add
label define yrsusa2_lbl 4 `"16-20 years"', add
label define yrsusa2_lbl 5 `"21+ years"', add
label define yrsusa2_lbl 9 `"Missing"', add
label values yrsusa2 yrsusa2_lbl

label define language_lbl 00 `"N/A or blank"'
label define language_lbl 01 `"English"', add
label define language_lbl 02 `"German"', add
label define language_lbl 03 `"Yiddish, Jewish"', add
label define language_lbl 04 `"Dutch"', add
label define language_lbl 05 `"Swedish"', add
label define language_lbl 06 `"Danish"', add
label define language_lbl 07 `"Norwegian"', add
label define language_lbl 08 `"Icelandic"', add
label define language_lbl 09 `"Scandinavian"', add
label define language_lbl 10 `"Italian"', add
label define language_lbl 11 `"French"', add
label define language_lbl 12 `"Spanish"', add
label define language_lbl 13 `"Portuguese"', add
label define language_lbl 14 `"Rumanian"', add
label define language_lbl 15 `"Celtic"', add
label define language_lbl 16 `"Greek"', add
label define language_lbl 17 `"Albanian"', add
label define language_lbl 18 `"Russian"', add
label define language_lbl 19 `"Ukrainian, Ruthenian, Little Russian"', add
label define language_lbl 20 `"Czech"', add
label define language_lbl 21 `"Polish"', add
label define language_lbl 22 `"Slovak"', add
label define language_lbl 23 `"Serbo-Croatian, Yugoslavian, Slavonian"', add
label define language_lbl 24 `"Slovene"', add
label define language_lbl 25 `"Lithuanian"', add
label define language_lbl 26 `"Other Balto-Slavic"', add
label define language_lbl 27 `"Slavic unknown"', add
label define language_lbl 28 `"Armenian"', add
label define language_lbl 29 `"Persian, Iranian, Farsi"', add
label define language_lbl 30 `"Other Persian dialects"', add
label define language_lbl 31 `"Hindi and related"', add
label define language_lbl 32 `"Romany, Gypsy"', add
label define language_lbl 33 `"Finnish"', add
label define language_lbl 34 `"Magyar, Hungarian"', add
label define language_lbl 35 `"Uralic"', add
label define language_lbl 36 `"Turkish"', add
label define language_lbl 37 `"Other Altaic"', add
label define language_lbl 38 `"Caucasian, Georgian, Avar"', add
label define language_lbl 39 `"Basque"', add
label define language_lbl 40 `"Dravidian"', add
label define language_lbl 41 `"Kurukh"', add
label define language_lbl 42 `"Burushaski"', add
label define language_lbl 43 `"Chinese"', add
label define language_lbl 44 `"Tibetan"', add
label define language_lbl 45 `"Burmese, Lisu, Lolo"', add
label define language_lbl 46 `"Kachin"', add
label define language_lbl 47 `"Thai, Siamese, Lao"', add
label define language_lbl 48 `"Japanese"', add
label define language_lbl 49 `"Korean"', add
label define language_lbl 50 `"Vietnamese"', add
label define language_lbl 51 `"Other East/Southeast Asian"', add
label define language_lbl 52 `"Indonesian"', add
label define language_lbl 53 `"Other Malayan"', add
label define language_lbl 54 `"Filipino, Tagalog"', add
label define language_lbl 55 `"Micronesian, Polynesian"', add
label define language_lbl 56 `"Hawaiian"', add
label define language_lbl 57 `"Arabic"', add
label define language_lbl 58 `"Near East Arabic dialect"', add
label define language_lbl 59 `"Hebrew, Israeli"', add
label define language_lbl 60 `"Amharic, Ethiopian, etc."', add
label define language_lbl 61 `"Hamitic"', add
label define language_lbl 62 `"Other Afro-Asiatic languages"', add
label define language_lbl 63 `"Sub-Saharan Africa"', add
label define language_lbl 64 `"African, n.s."', add
label define language_lbl 70 `"American Indian (all)"', add
label define language_lbl 71 `"Aleut, Eskimo"', add
label define language_lbl 72 `"Algonquian"', add
label define language_lbl 73 `"Salish, Flathead"', add
label define language_lbl 74 `"Athapascan"', add
label define language_lbl 75 `"Navajo"', add
label define language_lbl 76 `"Penutian-Sahaptin"', add
label define language_lbl 77 `"Other Penutian"', add
label define language_lbl 78 `"Zuni"', add
label define language_lbl 79 `"Yuman"', add
label define language_lbl 80 `"Other Hokan languages"', add
label define language_lbl 81 `"Siouan languages"', add
label define language_lbl 82 `"Muskogean"', add
label define language_lbl 83 `"Keres"', add
label define language_lbl 84 `"Iroquoian"', add
label define language_lbl 85 `"Caddoan"', add
label define language_lbl 86 `"Shoshonean/Hopi"', add
label define language_lbl 87 `"Pima, Papago"', add
label define language_lbl 88 `"Yaqui and other Sonoran, nec"', add
label define language_lbl 89 `"Aztecan, Nahuatl, Uto-Aztecan"', add
label define language_lbl 90 `"Tanoan languages"', add
label define language_lbl 91 `"Other Indian languages"', add
label define language_lbl 92 `"Mayan languages"', add
label define language_lbl 93 `"American Indian, n.s."', add
label define language_lbl 94 `"Native"', add
label define language_lbl 95 `"No language"', add
label define language_lbl 96 `"Other or not reported"', add
label define language_lbl 99 `"Not reported, blank"', add
label values language language_lbl

label define languaged_lbl 0000 `"N/A or blank"'
label define languaged_lbl 0100 `"English"', add
label define languaged_lbl 0110 `"Jamaican Creole"', add
label define languaged_lbl 0120 `"Krio, Pidgin Krio"', add
label define languaged_lbl 0130 `"Hawaiian Pidgin"', add
label define languaged_lbl 0140 `"Pidgin"', add
label define languaged_lbl 0150 `"Gullah, Geechee"', add
label define languaged_lbl 0160 `"Saramacca"', add
label define languaged_lbl 0170 `"Other English-based Creole languages"', add
label define languaged_lbl 0200 `"German"', add
label define languaged_lbl 0210 `"Austrian"', add
label define languaged_lbl 0220 `"Swiss"', add
label define languaged_lbl 0230 `"Luxembourgian"', add
label define languaged_lbl 0240 `"Pennsylvania Dutch"', add
label define languaged_lbl 0300 `"Yiddish, Jewish"', add
label define languaged_lbl 0310 `"Jewish"', add
label define languaged_lbl 0320 `"Yiddish"', add
label define languaged_lbl 0400 `"Dutch"', add
label define languaged_lbl 0410 `"Dutch, Flemish, Belgian"', add
label define languaged_lbl 0420 `"Afrikaans"', add
label define languaged_lbl 0430 `"Frisian"', add
label define languaged_lbl 0440 `"Dutch, Afrikaans, Frisian"', add
label define languaged_lbl 0450 `"Belgian, Flemish"', add
label define languaged_lbl 0460 `"Belgian"', add
label define languaged_lbl 0470 `"Flemish"', add
label define languaged_lbl 0500 `"Swedish"', add
label define languaged_lbl 0600 `"Danish"', add
label define languaged_lbl 0700 `"Norwegian"', add
label define languaged_lbl 0800 `"Icelandic"', add
label define languaged_lbl 0810 `"Faroese"', add
label define languaged_lbl 0900 `"Scandinavian"', add
label define languaged_lbl 1000 `"Italian"', add
label define languaged_lbl 1010 `"Rhaeto-Romanic, Ladin"', add
label define languaged_lbl 1020 `"Friulian"', add
label define languaged_lbl 1030 `"Romansh"', add
label define languaged_lbl 1100 `"French"', add
label define languaged_lbl 1110 `"French, Walloon"', add
label define languaged_lbl 1120 `"Provencal"', add
label define languaged_lbl 1130 `"Patois"', add
label define languaged_lbl 1140 `"French or Haitian Creole"', add
label define languaged_lbl 1150 `"Cajun"', add
label define languaged_lbl 1200 `"Spanish"', add
label define languaged_lbl 1210 `"Catalonian, Valencian"', add
label define languaged_lbl 1220 `"Ladino, Sefaradit, Spanol"', add
label define languaged_lbl 1230 `"Pachuco"', add
label define languaged_lbl 1250 `"Mexican"', add
label define languaged_lbl 1300 `"Portuguese"', add
label define languaged_lbl 1310 `"Papia Mentae"', add
label define languaged_lbl 1320 `"Cape Verdean Creole"', add
label define languaged_lbl 1400 `"Rumanian"', add
label define languaged_lbl 1500 `"Celtic"', add
label define languaged_lbl 1510 `"Welsh, Breton, Cornish"', add
label define languaged_lbl 1520 `"Welsh"', add
label define languaged_lbl 1530 `"Breton"', add
label define languaged_lbl 1540 `"Irish Gaelic, Gaelic"', add
label define languaged_lbl 1550 `"Gaelic"', add
label define languaged_lbl 1560 `"Irish"', add
label define languaged_lbl 1570 `"Scottish Gaelic"', add
label define languaged_lbl 1580 `"Scotch"', add
label define languaged_lbl 1590 `"Manx, Manx Gaelic"', add
label define languaged_lbl 1600 `"Greek"', add
label define languaged_lbl 1700 `"Albanian"', add
label define languaged_lbl 1800 `"Russian"', add
label define languaged_lbl 1810 `"Russian, Great Russian"', add
label define languaged_lbl 1811 `"Great Russian"', add
label define languaged_lbl 1820 `"Bielo-, White Russian"', add
label define languaged_lbl 1900 `"Ukrainian, Ruthenian, Little Russian"', add
label define languaged_lbl 1910 `"Ruthenian"', add
label define languaged_lbl 1920 `"Little Russian"', add
label define languaged_lbl 1930 `"Ukrainian"', add
label define languaged_lbl 2000 `"Czech"', add
label define languaged_lbl 2010 `"Bohemian"', add
label define languaged_lbl 2020 `"Moravian"', add
label define languaged_lbl 2100 `"Polish"', add
label define languaged_lbl 2110 `"Kashubian, Slovincian"', add
label define languaged_lbl 2200 `"Slovak"', add
label define languaged_lbl 2300 `"Serbo-Croatian, Yugoslavian, Slavonian"', add
label define languaged_lbl 2310 `"Croatian"', add
label define languaged_lbl 2320 `"Serbian"', add
label define languaged_lbl 2321 `"Bosnian"', add
label define languaged_lbl 2330 `"Dalmatian, Montenegrin"', add
label define languaged_lbl 2331 `"Dalmatian"', add
label define languaged_lbl 2332 `"Montenegrin"', add
label define languaged_lbl 2400 `"Slovene"', add
label define languaged_lbl 2500 `"Lithuanian"', add
label define languaged_lbl 2510 `"Lettish, Latvian"', add
label define languaged_lbl 2600 `"Other Balto-Slavic"', add
label define languaged_lbl 2610 `"Bulgarian"', add
label define languaged_lbl 2620 `"Lusatian, Sorbian, Wendish"', add
label define languaged_lbl 2621 `"Wendish"', add
label define languaged_lbl 2630 `"Macedonian"', add
label define languaged_lbl 2700 `"Slavic unknown"', add
label define languaged_lbl 2800 `"Armenian"', add
label define languaged_lbl 2900 `"Persian, Iranian, Farsi"', add
label define languaged_lbl 2910 `"Persian"', add
label define languaged_lbl 2920 `"Dari"', add
label define languaged_lbl 3000 `"Other Persian dialects"', add
label define languaged_lbl 3010 `"Pashto, Afghan"', add
label define languaged_lbl 3020 `"Kurdish"', add
label define languaged_lbl 3030 `"Balochi"', add
label define languaged_lbl 3040 `"Tadzhik"', add
label define languaged_lbl 3050 `"Ossete"', add
label define languaged_lbl 3100 `"Hindi and related"', add
label define languaged_lbl 3101 `"Hindi, Hindustani, Indic, Jaipuri, Pali, Urdu"', add
label define languaged_lbl 3102 `"Hindi"', add
label define languaged_lbl 3103 `"Urdu"', add
label define languaged_lbl 3104 `"Other Indo-Iranian languages"', add
label define languaged_lbl 3110 `"Other Indo-Aryan"', add
label define languaged_lbl 3111 `"Sanskrit"', add
label define languaged_lbl 3112 `"Bengali"', add
label define languaged_lbl 3113 `"Panjabi"', add
label define languaged_lbl 3114 `"Marathi"', add
label define languaged_lbl 3115 `"Gujarathi"', add
label define languaged_lbl 3116 `"Bihari"', add
label define languaged_lbl 3117 `"Rajasthani"', add
label define languaged_lbl 3118 `"Oriya"', add
label define languaged_lbl 3119 `"Assamese"', add
label define languaged_lbl 3120 `"Kashmiri"', add
label define languaged_lbl 3121 `"Sindhi"', add
label define languaged_lbl 3122 `"Maldivian"', add
label define languaged_lbl 3123 `"Sinhalese"', add
label define languaged_lbl 3130 `"Kannada"', add
label define languaged_lbl 3140 `"India nec"', add
label define languaged_lbl 3150 `"Pakistan nec"', add
label define languaged_lbl 3190 `"Other Indo-European languages"', add
label define languaged_lbl 3200 `"Romany, Gypsy"', add
label define languaged_lbl 3210 `"Gypsy"', add
label define languaged_lbl 3300 `"Finnish"', add
label define languaged_lbl 3400 `"Magyar, Hungarian"', add
label define languaged_lbl 3401 `"Magyar"', add
label define languaged_lbl 3402 `"Hungarian"', add
label define languaged_lbl 3500 `"Uralic"', add
label define languaged_lbl 3510 `"Estonian, Ingrian, Livonian, Vepsian,  Votic"', add
label define languaged_lbl 3511 `"Estonian"', add
label define languaged_lbl 3520 `"Lapp, Inari, Kola, Lule, Pite, Ruija, Skolt, Ume"', add
label define languaged_lbl 3521 `"Lappish"', add
label define languaged_lbl 3530 `"Other Uralic"', add
label define languaged_lbl 3600 `"Turkish"', add
label define languaged_lbl 3700 `"Other Altaic"', add
label define languaged_lbl 3701 `"Chuvash"', add
label define languaged_lbl 3702 `"Karakalpak"', add
label define languaged_lbl 3703 `"Kazakh"', add
label define languaged_lbl 3704 `"Kirghiz"', add
label define languaged_lbl 3705 `"Karachay, Tatar, Balkar, Bashkir, Kumyk"', add
label define languaged_lbl 3706 `"Uzbek, Uighur"', add
label define languaged_lbl 3707 `"Azerbaijani"', add
label define languaged_lbl 3708 `"Turkmen"', add
label define languaged_lbl 3709 `"Yakut"', add
label define languaged_lbl 3710 `"Mongolian"', add
label define languaged_lbl 3711 `"Tungus"', add
label define languaged_lbl 3800 `"Caucasian, Georgian, Avar"', add
label define languaged_lbl 3810 `"Georgian"', add
label define languaged_lbl 3900 `"Basque"', add
label define languaged_lbl 4000 `"Dravidian"', add
label define languaged_lbl 4001 `"Brahui"', add
label define languaged_lbl 4002 `"Gondi"', add
label define languaged_lbl 4003 `"Telugu"', add
label define languaged_lbl 4004 `"Malayalam"', add
label define languaged_lbl 4005 `"Tamil"', add
label define languaged_lbl 4010 `"Bhili"', add
label define languaged_lbl 4011 `"Nepali"', add
label define languaged_lbl 4100 `"Kurukh"', add
label define languaged_lbl 4110 `"Munda"', add
label define languaged_lbl 4200 `"Burushaski"', add
label define languaged_lbl 4300 `"Chinese"', add
label define languaged_lbl 4301 `"Chinese, Cantonese, Min, Yueh"', add
label define languaged_lbl 4302 `"Cantonese"', add
label define languaged_lbl 4303 `"Mandarin"', add
label define languaged_lbl 4310 `"Other Chinese"', add
label define languaged_lbl 4311 `"Hakka, Fukien, Kechia"', add
label define languaged_lbl 4312 `"Kan, Nan Chang"', add
label define languaged_lbl 4313 `"Hsiang, Chansa, Hunan, Iyan"', add
label define languaged_lbl 4314 `"Fuchow, Min Pei"', add
label define languaged_lbl 4315 `"Wu"', add
label define languaged_lbl 4400 `"Tibetan"', add
label define languaged_lbl 4410 `"Miao-Yao, Mien"', add
label define languaged_lbl 4420 `"Miao, Hmong"', add
label define languaged_lbl 4430 `"Iu Mien"', add
label define languaged_lbl 4500 `"Burmese, Lisu, Lolo"', add
label define languaged_lbl 4510 `"Karen"', add
label define languaged_lbl 4520 `"Chin languages"', add
label define languaged_lbl 4600 `"Kachin"', add
label define languaged_lbl 4700 `"Thai, Siamese, Lao"', add
label define languaged_lbl 4710 `"Thai"', add
label define languaged_lbl 4720 `"Laotian"', add
label define languaged_lbl 4800 `"Japanese"', add
label define languaged_lbl 4900 `"Korean"', add
label define languaged_lbl 5000 `"Vietnamese"', add
label define languaged_lbl 5100 `"Other East/Southeast Asian"', add
label define languaged_lbl 5110 `"Ainu"', add
label define languaged_lbl 5120 `"Mon-Khmer, Cambodian"', add
label define languaged_lbl 5130 `"Siberian, n.e.c."', add
label define languaged_lbl 5140 `"Yukagir"', add
label define languaged_lbl 5150 `"Muong"', add
label define languaged_lbl 5200 `"Indonesian"', add
label define languaged_lbl 5210 `"Buginese"', add
label define languaged_lbl 5220 `"Moluccan"', add
label define languaged_lbl 5230 `"Achinese"', add
label define languaged_lbl 5240 `"Balinese"', add
label define languaged_lbl 5250 `"Cham"', add
label define languaged_lbl 5260 `"Madurese"', add
label define languaged_lbl 5270 `"Malay"', add
label define languaged_lbl 5280 `"Minangkabau"', add
label define languaged_lbl 5290 `"Other Asian languages"', add
label define languaged_lbl 5300 `"Other Malayan"', add
label define languaged_lbl 5310 `"Formosan, Taiwanese"', add
label define languaged_lbl 5320 `"Javanese"', add
label define languaged_lbl 5330 `"Malagasy"', add
label define languaged_lbl 5340 `"Sundanese"', add
label define languaged_lbl 5400 `"Filipino, Tagalog"', add
label define languaged_lbl 5410 `"Bisayan"', add
label define languaged_lbl 5420 `"Sebuano"', add
label define languaged_lbl 5430 `"Pangasinan"', add
label define languaged_lbl 5440 `"Llocano, Hocano"', add
label define languaged_lbl 5450 `"Bikol"', add
label define languaged_lbl 5460 `"Pampangan"', add
label define languaged_lbl 5470 `"Gorontalo"', add
label define languaged_lbl 5480 `"Palau"', add
label define languaged_lbl 5500 `"Micronesian, Polynesian"', add
label define languaged_lbl 5501 `"Micronesian"', add
label define languaged_lbl 5502 `"Carolinian"', add
label define languaged_lbl 5503 `"Chamorro, Guamanian"', add
label define languaged_lbl 5504 `"Gilbertese"', add
label define languaged_lbl 5505 `"Kusaiean"', add
label define languaged_lbl 5506 `"Marshallese"', add
label define languaged_lbl 5507 `"Mokilese"', add
label define languaged_lbl 5508 `"Mortlockese"', add
label define languaged_lbl 5509 `"Nauruan"', add
label define languaged_lbl 5510 `"Ponapean"', add
label define languaged_lbl 5511 `"Trukese"', add
label define languaged_lbl 5512 `"Ulithean, Fais"', add
label define languaged_lbl 5513 `"Woleai-Ulithi"', add
label define languaged_lbl 5514 `"Yapese"', add
label define languaged_lbl 5520 `"Melanesian"', add
label define languaged_lbl 5521 `"Polynesian"', add
label define languaged_lbl 5522 `"Samoan"', add
label define languaged_lbl 5523 `"Tongan"', add
label define languaged_lbl 5524 `"Niuean"', add
label define languaged_lbl 5525 `"Tokelauan"', add
label define languaged_lbl 5526 `"Fijian"', add
label define languaged_lbl 5527 `"Marquesan"', add
label define languaged_lbl 5528 `"Rarotongan"', add
label define languaged_lbl 5529 `"Maori"', add
label define languaged_lbl 5530 `"Nukuoro, Kapingarangan"', add
label define languaged_lbl 5590 `"Other Pacific Island languages"', add
label define languaged_lbl 5600 `"Hawaiian"', add
label define languaged_lbl 5700 `"Arabic"', add
label define languaged_lbl 5710 `"Algerian, Moroccan, Tunisian"', add
label define languaged_lbl 5720 `"Egyptian"', add
label define languaged_lbl 5730 `"Iraqi"', add
label define languaged_lbl 5740 `"Libyan"', add
label define languaged_lbl 5750 `"Maltese"', add
label define languaged_lbl 5800 `"Near East Arabic dialect"', add
label define languaged_lbl 5810 `"Syriac, Aramaic, Chaldean"', add
label define languaged_lbl 5820 `"Syrian"', add
label define languaged_lbl 5900 `"Hebrew, Israeli"', add
label define languaged_lbl 6000 `"Amharic, Ethiopian, etc."', add
label define languaged_lbl 6100 `"Hamitic"', add
label define languaged_lbl 6110 `"Berber"', add
label define languaged_lbl 6120 `"Chadic, Hamitic, Hausa"', add
label define languaged_lbl 6130 `"Cushite, Beja, Somali"', add
label define languaged_lbl 6200 `"Other Afro-Asiatic languages"', add
label define languaged_lbl 6300 `"Nilotic"', add
label define languaged_lbl 6301 `"Nilo-Hamitic"', add
label define languaged_lbl 6302 `"Nubian"', add
label define languaged_lbl 6303 `"Saharan"', add
label define languaged_lbl 6304 `"Nilo-Saharan, Fur, Songhai"', add
label define languaged_lbl 6305 `"Khoisan"', add
label define languaged_lbl 6306 `"Sudanic"', add
label define languaged_lbl 6307 `"Bantu (many subheads)"', add
label define languaged_lbl 6308 `"Swahili"', add
label define languaged_lbl 6309 `"Mande"', add
label define languaged_lbl 6310 `"Fulani"', add
label define languaged_lbl 6311 `"Gur"', add
label define languaged_lbl 6312 `"Kru"', add
label define languaged_lbl 6313 `"Efik, Ibibio, Tiv"', add
label define languaged_lbl 6314 `"Mbum, Gbaya, Sango, Zande"', add
label define languaged_lbl 6320 `"Eastern Sudanic and Khoisan"', add
label define languaged_lbl 6321 `"Niger-Congo regions (many subheads)"', add
label define languaged_lbl 6322 `"Congo, Kongo, Luba, Ruanda, Rundi, Santali, Swahili"', add
label define languaged_lbl 6390 `"Other specified African languages"', add
label define languaged_lbl 6400 `"African, n.s."', add
label define languaged_lbl 7000 `"American Indian (all)"', add
label define languaged_lbl 7100 `"Aleut, Eskimo"', add
label define languaged_lbl 7110 `"Aleut"', add
label define languaged_lbl 7120 `"Pacific Gulf Yupik"', add
label define languaged_lbl 7130 `"Eskimo"', add
label define languaged_lbl 7140 `"Inupik, Innuit"', add
label define languaged_lbl 7150 `"St. Lawrence Isl. Yupik"', add
label define languaged_lbl 7160 `"Yupik"', add
label define languaged_lbl 7200 `"Algonquian"', add
label define languaged_lbl 7201 `"Arapaho"', add
label define languaged_lbl 7202 `"Atsina, Gros Ventre"', add
label define languaged_lbl 7203 `"Blackfoot"', add
label define languaged_lbl 7204 `"Cheyenne"', add
label define languaged_lbl 7205 `"Cree"', add
label define languaged_lbl 7206 `"Delaware, Lenni-Lenape"', add
label define languaged_lbl 7207 `"Fox, Sac"', add
label define languaged_lbl 7208 `"Kickapoo"', add
label define languaged_lbl 7209 `"Menomini"', add
label define languaged_lbl 7210 `"Metis, French Cree"', add
label define languaged_lbl 7211 `"Miami"', add
label define languaged_lbl 7212 `"Micmac"', add
label define languaged_lbl 7213 `"Ojibwa, Chippewa"', add
label define languaged_lbl 7214 `"Ottawa"', add
label define languaged_lbl 7215 `"Passamaquoddy, Malecite"', add
label define languaged_lbl 7216 `"Penobscot"', add
label define languaged_lbl 7217 `"Abnaki"', add
label define languaged_lbl 7218 `"Potawatomi"', add
label define languaged_lbl 7219 `"Shawnee"', add
label define languaged_lbl 7300 `"Salish, Flathead"', add
label define languaged_lbl 7301 `"Lower Chehalis"', add
label define languaged_lbl 7302 `"Upper Chehalis, Chelalis, Satsop"', add
label define languaged_lbl 7303 `"Clallam"', add
label define languaged_lbl 7304 `"Coeur dAlene, Skitsamish"', add
label define languaged_lbl 7305 `"Columbia, Chelan, Wenatchee"', add
label define languaged_lbl 7306 `"Cowlitz"', add
label define languaged_lbl 7307 `"Nootsack"', add
label define languaged_lbl 7308 `"Okanogan"', add
label define languaged_lbl 7309 `"Puget Sound Salish"', add
label define languaged_lbl 7310 `"Quinault, Queets"', add
label define languaged_lbl 7311 `"Tillamook"', add
label define languaged_lbl 7312 `"Twana"', add
label define languaged_lbl 7313 `"Kalispel"', add
label define languaged_lbl 7314 `"Spokane"', add
label define languaged_lbl 7400 `"Athapascan"', add
label define languaged_lbl 7401 `"Ahtena"', add
label define languaged_lbl 7402 `"Han"', add
label define languaged_lbl 7403 `"Ingalit"', add
label define languaged_lbl 7404 `"Koyukon"', add
label define languaged_lbl 7405 `"Kuchin"', add
label define languaged_lbl 7406 `"Upper Kuskokwim"', add
label define languaged_lbl 7407 `"Tanaina"', add
label define languaged_lbl 7408 `"Tanana, Minto"', add
label define languaged_lbl 7409 `"Tanacross"', add
label define languaged_lbl 7410 `"Upper Tanana, Nabesena, Tetlin"', add
label define languaged_lbl 7411 `"Tutchone"', add
label define languaged_lbl 7412 `"Chasta Costa, Chetco, Coquille, Smith River Athapascan"', add
label define languaged_lbl 7413 `"Hupa"', add
label define languaged_lbl 7420 `"Apache"', add
label define languaged_lbl 7421 `"Jicarilla, Lipan"', add
label define languaged_lbl 7422 `"Chiricahua, Mescalero"', add
label define languaged_lbl 7423 `"San Carlos, Cibecue, White Mountain"', add
label define languaged_lbl 7424 `"Kiowa-Apache"', add
label define languaged_lbl 7430 `"Kiowa"', add
label define languaged_lbl 7440 `"Eyak"', add
label define languaged_lbl 7450 `"Other Athapascan-Eyak, Cahto, Mattole, Wailaki"', add
label define languaged_lbl 7490 `"Other Algonquin languages"', add
label define languaged_lbl 7500 `"Navajo"', add
label define languaged_lbl 7600 `"Penutian-Sahaptin"', add
label define languaged_lbl 7610 `"Klamath, Modoc"', add
label define languaged_lbl 7620 `"Nez Perce"', add
label define languaged_lbl 7630 `"Sahaptian, Celilo, Klikitat, Palouse, Tenino, Umatilla, Warm"', add
label define languaged_lbl 7700 `"Mountain Maidu, Maidu"', add
label define languaged_lbl 7701 `"Northwest Maidu, Concow"', add
label define languaged_lbl 7702 `"Southern Maidu, Nisenan"', add
label define languaged_lbl 7703 `"Coast Miwok, Bodega, Marin"', add
label define languaged_lbl 7704 `"Plains Miwok"', add
label define languaged_lbl 7705 `"Sierra Miwok, Miwok"', add
label define languaged_lbl 7706 `"Nomlaki, Tehama"', add
label define languaged_lbl 7707 `"Patwin, Colouse, Suisun"', add
label define languaged_lbl 7708 `"Wintun"', add
label define languaged_lbl 7709 `"Foothill North Yokuts"', add
label define languaged_lbl 7710 `"Tachi"', add
label define languaged_lbl 7711 `"Santiam, Calapooya, Wapatu"', add
label define languaged_lbl 7712 `"Siuslaw, Coos, Lower Umpqua"', add
label define languaged_lbl 7713 `"Tsimshian"', add
label define languaged_lbl 7714 `"Upper Chinook, Clackamas, Multnomah, Wasco, Wishram"', add
label define languaged_lbl 7715 `"Chinook Jargon"', add
label define languaged_lbl 7800 `"Zuni"', add
label define languaged_lbl 7900 `"Yuman"', add
label define languaged_lbl 7910 `"Upriver Yuman"', add
label define languaged_lbl 7920 `"Cocomaricopa"', add
label define languaged_lbl 7930 `"Mohave"', add
label define languaged_lbl 7940 `"Diegueno"', add
label define languaged_lbl 7950 `"Delta River Yuman"', add
label define languaged_lbl 7960 `"Upland Yuman"', add
label define languaged_lbl 7970 `"Havasupai"', add
label define languaged_lbl 7980 `"Walapai"', add
label define languaged_lbl 7990 `"Yavapai"', add
label define languaged_lbl 8000 `"Achumawi"', add
label define languaged_lbl 8010 `"Atsugewi"', add
label define languaged_lbl 8020 `"Karok"', add
label define languaged_lbl 8030 `"Pomo"', add
label define languaged_lbl 8040 `"Shastan"', add
label define languaged_lbl 8050 `"Washo"', add
label define languaged_lbl 8060 `"Chumash"', add
label define languaged_lbl 8100 `"Siouan languages"', add
label define languaged_lbl 8101 `"Crow, Absaroke"', add
label define languaged_lbl 8102 `"Hidatsa"', add
label define languaged_lbl 8103 `"Mandan"', add
label define languaged_lbl 8104 `"Dakota, Lakota, Nakota, Sioux"', add
label define languaged_lbl 8105 `"Chiwere"', add
label define languaged_lbl 8106 `"Winnebago"', add
label define languaged_lbl 8107 `"Kansa, Kaw"', add
label define languaged_lbl 8108 `"Omaha"', add
label define languaged_lbl 8109 `"Osage"', add
label define languaged_lbl 8110 `"Ponca"', add
label define languaged_lbl 8111 `"Quapaw, Arkansas"', add
label define languaged_lbl 8120 `"Iowa"', add
label define languaged_lbl 8200 `"Muskogean"', add
label define languaged_lbl 8210 `"Alabama"', add
label define languaged_lbl 8220 `"Choctaw, Chickasaw"', add
label define languaged_lbl 8230 `"Mikasuki"', add
label define languaged_lbl 8240 `"Hichita, Apalachicola"', add
label define languaged_lbl 8250 `"Koasati"', add
label define languaged_lbl 8260 `"Muskogee, Creek, Seminole"', add
label define languaged_lbl 8300 `"Keres"', add
label define languaged_lbl 8400 `"Iroquoian"', add
label define languaged_lbl 8410 `"Mohawk"', add
label define languaged_lbl 8420 `"Oneida"', add
label define languaged_lbl 8430 `"Onondaga"', add
label define languaged_lbl 8440 `"Cayuga"', add
label define languaged_lbl 8450 `"Seneca"', add
label define languaged_lbl 8460 `"Tuscarora"', add
label define languaged_lbl 8470 `"Wyandot, Huron"', add
label define languaged_lbl 8480 `"Cherokee"', add
label define languaged_lbl 8500 `"Caddoan"', add
label define languaged_lbl 8510 `"Arikara"', add
label define languaged_lbl 8520 `"Pawnee"', add
label define languaged_lbl 8530 `"Wichita"', add
label define languaged_lbl 8600 `"Shoshonean/Hopi"', add
label define languaged_lbl 8601 `"Comanche"', add
label define languaged_lbl 8602 `"Mono, Owens Valley Paiute"', add
label define languaged_lbl 8603 `"Paiute"', add
label define languaged_lbl 8604 `"Northern Paiute, Bannock, Num, Snake"', add
label define languaged_lbl 8605 `"Southern Paiute"', add
label define languaged_lbl 8606 `"Chemehuevi"', add
label define languaged_lbl 8607 `"Kawaiisu"', add
label define languaged_lbl 8608 `"Ute"', add
label define languaged_lbl 8609 `"Shoshoni"', add
label define languaged_lbl 8610 `"Panamint"', add
label define languaged_lbl 8620 `"Hopi"', add
label define languaged_lbl 8630 `"Cahuilla"', add
label define languaged_lbl 8631 `"Cupeno"', add
label define languaged_lbl 8632 `"Luiseno"', add
label define languaged_lbl 8633 `"Serrano"', add
label define languaged_lbl 8640 `"Tubatulabal"', add
label define languaged_lbl 8700 `"Pima, Papago"', add
label define languaged_lbl 8800 `"Yaqui"', add
label define languaged_lbl 8810 `"Sonoran n.e.c., Cahita, Guasave, Huichole, Nayit, Tarahumar"', add
label define languaged_lbl 8820 `"Tarahumara"', add
label define languaged_lbl 8900 `"Aztecan, Nahuatl, Uto-Aztecan"', add
label define languaged_lbl 8910 `"Aztecan, Mexicano, Nahua"', add
label define languaged_lbl 9000 `"Tanoan languages"', add
label define languaged_lbl 9010 `"Picuris, Northern Tiwa, Taos"', add
label define languaged_lbl 9020 `"Tiwa, Isleta"', add
label define languaged_lbl 9030 `"Sandia"', add
label define languaged_lbl 9040 `"Tewa, Hano, Hopi-Tewa, San Ildefonso, San Juan, Santa Clara"', add
label define languaged_lbl 9050 `"Towa"', add
label define languaged_lbl 9100 `"Wiyot"', add
label define languaged_lbl 9101 `"Yurok"', add
label define languaged_lbl 9110 `"Kwakiutl"', add
label define languaged_lbl 9111 `"Nootka"', add
label define languaged_lbl 9112 `"Makah"', add
label define languaged_lbl 9120 `"Kutenai"', add
label define languaged_lbl 9130 `"Haida"', add
label define languaged_lbl 9131 `"Tlingit, Chilkat, Sitka, Tongass, Yakutat"', add
label define languaged_lbl 9140 `"Tonkawa"', add
label define languaged_lbl 9150 `"Yuchi"', add
label define languaged_lbl 9160 `"Chetemacha"', add
label define languaged_lbl 9170 `"Yuki"', add
label define languaged_lbl 9171 `"Wappo"', add
label define languaged_lbl 9200 `"Mayan languages"', add
label define languaged_lbl 9210 `"Misumalpan"', add
label define languaged_lbl 9211 `"Cakchiquel"', add
label define languaged_lbl 9212 `"Mam"', add
label define languaged_lbl 9213 `"Maya"', add
label define languaged_lbl 9214 `"Quekchi"', add
label define languaged_lbl 9215 `"Quiche"', add
label define languaged_lbl 9220 `"Tarascan"', add
label define languaged_lbl 9230 `"Mapuche"', add
label define languaged_lbl 9231 `"Araucanian"', add
label define languaged_lbl 9240 `"Oto-Manguen"', add
label define languaged_lbl 9241 `"Mixtec"', add
label define languaged_lbl 9242 `"Zapotec"', add
label define languaged_lbl 9250 `"Quechua"', add
label define languaged_lbl 9260 `"Aymara"', add
label define languaged_lbl 9270 `"Arawakian"', add
label define languaged_lbl 9271 `"Island Caribs"', add
label define languaged_lbl 9280 `"Chibchan"', add
label define languaged_lbl 9281 `"Cuna"', add
label define languaged_lbl 9282 `"Guaymi"', add
label define languaged_lbl 9290 `"Tupi-Guarani"', add
label define languaged_lbl 9291 `"Tupi"', add
label define languaged_lbl 9292 `"Guarani"', add
label define languaged_lbl 9300 `"American Indian, n.s."', add
label define languaged_lbl 9400 `"Native"', add
label define languaged_lbl 9410 `"Other specified American Indian languages"', add
label define languaged_lbl 9420 `"South/Central American Indian"', add
label define languaged_lbl 9500 `"No language"', add
label define languaged_lbl 9600 `"Other or not reported"', add
label define languaged_lbl 9601 `"Other n.e.c."', add
label define languaged_lbl 9602 `"Other n.s."', add
label define languaged_lbl 9700 `"Unknown"', add
label define languaged_lbl 9800 `"Illegible"', add
label define languaged_lbl 9900 `"Not reported, blank"', add
label values languaged languaged_lbl

label define speakeng_lbl 0 `"N/A (Blank)"'
label define speakeng_lbl 1 `"Does not speak English"', add
label define speakeng_lbl 2 `"Yes, speaks English..."', add
label define speakeng_lbl 3 `"Yes, speaks only English"', add
label define speakeng_lbl 4 `"Yes, speaks very well"', add
label define speakeng_lbl 5 `"Yes, speaks well"', add
label define speakeng_lbl 6 `"Yes, but not well"', add
label define speakeng_lbl 7 `"Unknown"', add
label define speakeng_lbl 8 `"Illegible"', add
label define speakeng_lbl 9 `"Blank"', add
label values speakeng speakeng_lbl

label define tribe_lbl 0000 `"Not applicable or blank"'
label define tribe_lbl 1001 `"Alaskan Indian"', add
label define tribe_lbl 1002 `"Alaska Native"', add
label define tribe_lbl 1003 `"Alaskan Athabaskan"', add
label define tribe_lbl 1004 `"Aleut"', add
label define tribe_lbl 1005 `"Eskimo"', add
label define tribe_lbl 1006 `"Tlingit-Haida"', add
label define tribe_lbl 1007 `"Tshimshian"', add
label define tribe_lbl 1008 `"Alaska Native, other or unknown"', add
label define tribe_lbl 2001 `"Abenaki"', add
label define tribe_lbl 2002 `"Algonquian"', add
label define tribe_lbl 2003 `"Apache"', add
label define tribe_lbl 2004 `"Arapaho"', add
label define tribe_lbl 2005 `"Arikara"', add
label define tribe_lbl 2006 `"Assiniboine"', add
label define tribe_lbl 2007 `"Bannock"', add
label define tribe_lbl 2008 `"Blackfoot"', add
label define tribe_lbl 2009 `"Brotherton"', add
label define tribe_lbl 2010 `"Caddo"', add
label define tribe_lbl 2011 `"Cahuilla"', add
label define tribe_lbl 2012 `"California tribes"', add
label define tribe_lbl 2013 `"Canadian Indian"', add
label define tribe_lbl 2014 `"Catawba"', add
label define tribe_lbl 2015 `"Cayuse"', add
label define tribe_lbl 2016 `"Chehalis"', add
label define tribe_lbl 2017 `"Chemakuan"', add
label define tribe_lbl 2018 `"Chemehuevi"', add
label define tribe_lbl 2019 `"Cherokee"', add
label define tribe_lbl 2020 `"Cheyenne"', add
label define tribe_lbl 2021 `"Chickasaw"', add
label define tribe_lbl 2022 `"Chinook"', add
label define tribe_lbl 2023 `"Chippewa"', add
label define tribe_lbl 2024 `"Chitimacha"', add
label define tribe_lbl 2025 `"Choctaw"', add
label define tribe_lbl 2026 `"Chumash"', add
label define tribe_lbl 2027 `"Coeur D'Alene"', add
label define tribe_lbl 2028 `"Colville"', add
label define tribe_lbl 2029 `"Comanche"', add
label define tribe_lbl 2030 `"Coos"', add
label define tribe_lbl 2031 `"Coquilles"', add
label define tribe_lbl 2032 `"Coushatta"', add
label define tribe_lbl 2033 `"Cowlitz"', add
label define tribe_lbl 2034 `"Cree"', add
label define tribe_lbl 2035 `"Creek"', add
label define tribe_lbl 2036 `"Croatan"', add
label define tribe_lbl 2037 `"Crow"', add
label define tribe_lbl 2038 `"Delaware"', add
label define tribe_lbl 2039 `"Diegueno"', add
label define tribe_lbl 2040 `"Eastern tribes"', add
label define tribe_lbl 2041 `"Grand Ronde"', add
label define tribe_lbl 2042 `"Gros Ventres"', add
label define tribe_lbl 2043 `"Hawaiian"', add
label define tribe_lbl 2044 `"Hoopa"', add
label define tribe_lbl 2046 `"Iowa"', add
label define tribe_lbl 2047 `"Iroquois"', add
label define tribe_lbl 2048 `"Kalispel"', add
label define tribe_lbl 2049 `"Karok/Karuk"', add
label define tribe_lbl 2050 `"Kaw"', add
label define tribe_lbl 2051 `"Kickapoo"', add
label define tribe_lbl 2052 `"Kiowa"', add
label define tribe_lbl 2053 `"Klallam"', add
label define tribe_lbl 2054 `"Klamath"', add
label define tribe_lbl 2055 `"Konkow"', add
label define tribe_lbl 2056 `"Kootenai"', add
label define tribe_lbl 2057 `"Latin American"', add
label define tribe_lbl 2058 `"Long Island - Matinecock"', add
label define tribe_lbl 2059 `"Luiseno"', add
label define tribe_lbl 2060 `"Lumbee"', add
label define tribe_lbl 2061 `"Lummi"', add
label define tribe_lbl 2062 `"Makah"', add
label define tribe_lbl 2063 `"Mailseet/Maliseet"', add
label define tribe_lbl 2064 `"Mandan"', add
label define tribe_lbl 2065 `"Menominee"', add
label define tribe_lbl 2066 `"Miami"', add
label define tribe_lbl 2067 `"Micmac"', add
label define tribe_lbl 2068 `"Mission Indians"', add
label define tribe_lbl 2069 `"Miwok"', add
label define tribe_lbl 2070 `"Modoc"', add
label define tribe_lbl 2071 `"Mohegan"', add
label define tribe_lbl 2072 `"Molala"', add
label define tribe_lbl 2073 `"Mono"', add
label define tribe_lbl 2074 `"Narragansett"', add
label define tribe_lbl 2075 `"Navajo"', add
label define tribe_lbl 2076 `"Nez Perce"', add
label define tribe_lbl 2077 `"Nomalaki"', add
label define tribe_lbl 2078 `"Northwest tribes"', add
label define tribe_lbl 2079 `"Omaha"', add
label define tribe_lbl 2080 `"Oregon Athabaskan"', add
label define tribe_lbl 2081 `"Osage"', add
label define tribe_lbl 2082 `"Otoe-Missouria"', add
label define tribe_lbl 2083 `"Ottawa"', add
label define tribe_lbl 2084 `"Paiute"', add
label define tribe_lbl 2085 `"Passamaquoddy"', add
label define tribe_lbl 2086 `"Pawnee"', add
label define tribe_lbl 2087 `"Penobscot"', add
label define tribe_lbl 2088 `"Peoria"', add
label define tribe_lbl 2089 `"Pequot"', add
label define tribe_lbl 2090 `"Pima"', add
label define tribe_lbl 2091 `"Pit River"', add
label define tribe_lbl 2092 `"Pomo"', add
label define tribe_lbl 2093 `"Ponca"', add
label define tribe_lbl 2094 `"Potawatomie"', add
label define tribe_lbl 2095 `"Powhatan"', add
label define tribe_lbl 2096 `"Pueblo"', add
label define tribe_lbl 2097 `"Puget Sound Salish"', add
label define tribe_lbl 2098 `"Quapaw"', add
label define tribe_lbl 2099 `"Quinault"', add
label define tribe_lbl 2100 `"Sac and Fox"', add
label define tribe_lbl 2101 `"Salish"', add
label define tribe_lbl 2102 `"Seminole"', add
label define tribe_lbl 2103 `"Serrano"', add
label define tribe_lbl 2104 `"Shasta"', add
label define tribe_lbl 2105 `"Shawnee"', add
label define tribe_lbl 2106 `"Shinnecock"', add
label define tribe_lbl 2107 `"Shoshone"', add
label define tribe_lbl 2108 `"Shoshone Paiute/Paiute Shoshone"', add
label define tribe_lbl 2109 `"Siletz"', add
label define tribe_lbl 2110 `"Sioux"', add
label define tribe_lbl 2111 `"Spokane"', add
label define tribe_lbl 2112 `"Stockbridge"', add
label define tribe_lbl 2113 `"Tohono O'Odham"', add
label define tribe_lbl 2114 `"Tolowa"', add
label define tribe_lbl 2115 `"Tonkawa"', add
label define tribe_lbl 2116 `"Umatilla"', add
label define tribe_lbl 2117 `"Umpqua"', add
label define tribe_lbl 2118 `"Ute"', add
label define tribe_lbl 2119 `"Wailaki"', add
label define tribe_lbl 2120 `"Walla-Walla"', add
label define tribe_lbl 2121 `"Warm Springs"', add
label define tribe_lbl 2122 `"Washo"', add
label define tribe_lbl 2123 `"Wichita"', add
label define tribe_lbl 2124 `"Winnebago"', add
label define tribe_lbl 2125 `"Wintu/Wintun"', add
label define tribe_lbl 2126 `"Yakima"', add
label define tribe_lbl 2127 `"Yaqui"', add
label define tribe_lbl 2128 `"Yokuts"', add
label define tribe_lbl 2129 `"Yuchi"', add
label define tribe_lbl 2130 `"Yuman"', add
label define tribe_lbl 2131 `"Yurok"', add
label define tribe_lbl 2132 `"American Indian, tribe not elsewhere classified"', add
label define tribe_lbl 2133 `"American Indian, tribe not specified"', add
label define tribe_lbl 2134 `"All other specified American Indian tribe combinations"', add
label define tribe_lbl 3001 `"American Indian and Alaska Native, tribe not elsewhere classified"', add
label define tribe_lbl 3002 `"American Indian and Alaska Native, not specified"', add
label values tribe tribe_lbl

label define tribed_lbl 000000 `"Not applicable or blank"'
label define tribed_lbl 100100 `"Alaska Indian"', add
label define tribed_lbl 100101 `"Alaska Indian"', add
label define tribed_lbl 100200 `"Alaska Native"', add
label define tribed_lbl 100300 `"Alaskan Athabaskan"', add
label define tribed_lbl 100301 `"Alaskan Athabaskan - Tanaina"', add
label define tribed_lbl 100400 `"Aleut"', add
label define tribed_lbl 100500 `"Eskimo"', add
label define tribed_lbl 100510 `"Inupiat"', add
label define tribed_lbl 100520 `"Yup'ik"', add
label define tribed_lbl 100601 `"Haida"', add
label define tribed_lbl 100602 `"Tlingit"', add
label define tribed_lbl 100603 `"Tlingit-Haida"', add
label define tribed_lbl 100700 `"Tsimshian"', add
label define tribed_lbl 100800 `"Alaska Native, other or unknown"', add
label define tribed_lbl 100801 `"Alaska Native, tribe not reported"', add
label define tribed_lbl 200100 `"Abenaki"', add
label define tribed_lbl 200200 `"Algonquian"', add
label define tribed_lbl 200300 `"Apache"', add
label define tribed_lbl 200301 `"Apache - Jicarilla"', add
label define tribed_lbl 200302 `"Apache - Lipan"', add
label define tribed_lbl 200303 `"Apache - Mescalero"', add
label define tribed_lbl 200304 `"Apache - Payson"', add
label define tribed_lbl 200305 `"Apache - White Mountain"', add
label define tribed_lbl 200400 `"Arapaho"', add
label define tribed_lbl 200500 `"Arikara"', add
label define tribed_lbl 200600 `"Assiniboine"', add
label define tribed_lbl 200700 `"Bannock"', add
label define tribed_lbl 200800 `"Blackfoot"', add
label define tribed_lbl 200900 `"Brotherton"', add
label define tribed_lbl 201000 `"Caddo"', add
label define tribed_lbl 201100 `"Cahuilla"', add
label define tribed_lbl 201101 `"Cahuilla - Soboba"', add
label define tribed_lbl 201201 `"California tribe - Digger"', add
label define tribed_lbl 201202 `"California tribe - Kern River"', add
label define tribed_lbl 201203 `"California tribe - Mattole"', add
label define tribed_lbl 201204 `"California tribe - Morongo"', add
label define tribed_lbl 201205 `"California tribe - Red Wood"', add
label define tribed_lbl 201206 `"California tribe - Yuki"', add
label define tribed_lbl 201300 `"Canadian Indian"', add
label define tribed_lbl 201301 `"Canadian Indian - Canadian Athabaskan"', add
label define tribed_lbl 201302 `"Canadian Indian - Tribe not specified, Canadian Indian"', add
label define tribed_lbl 201303 `"French American Indian"', add
label define tribed_lbl 201304 `"Chippewa - French American Indian"', add
label define tribed_lbl 201305 `"Tribe not specified, French American Indian"', add
label define tribed_lbl 201400 `"Catawba"', add
label define tribed_lbl 201500 `"Cayuse"', add
label define tribed_lbl 201600 `"Chehalis"', add
label define tribed_lbl 201701 `"Chemakuan - Hoh"', add
label define tribed_lbl 201702 `"Chemakuan - Quileute"', add
label define tribed_lbl 201800 `"Chemehuevi"', add
label define tribed_lbl 201900 `"Cherokee"', add
label define tribed_lbl 202000 `"Cheyenne"', add
label define tribed_lbl 202100 `"Chickasaw"', add
label define tribed_lbl 202200 `"Chinook"', add
label define tribed_lbl 202201 `"Chinook - Clatsop"', add
label define tribed_lbl 202202 `"Chinook - Upper Chinook"', add
label define tribed_lbl 202203 `"Chinook - Wishram"', add
label define tribed_lbl 202300 `"Chippewa"', add
label define tribed_lbl 202400 `"Chitimacha"', add
label define tribed_lbl 202500 `"Choctaw"', add
label define tribed_lbl 202501 `"Mississippi Choctaw"', add
label define tribed_lbl 202600 `"Chumash"', add
label define tribed_lbl 202700 `"Coeur D'Alene"', add
label define tribed_lbl 202800 `"Colville"', add
label define tribed_lbl 202900 `"Comanche"', add
label define tribed_lbl 203000 `"Coos"', add
label define tribed_lbl 203100 `"Coquilles"', add
label define tribed_lbl 203200 `"Coushatta"', add
label define tribed_lbl 203201 `"Alabama Coushatta"', add
label define tribed_lbl 203300 `"Cowlitz"', add
label define tribed_lbl 203400 `"Cree"', add
label define tribed_lbl 203500 `"Creek"', add
label define tribed_lbl 203501 `"Creek - Hitchiti"', add
label define tribed_lbl 203600 `"Croatan"', add
label define tribed_lbl 203700 `"Crow"', add
label define tribed_lbl 203800 `"Delaware"', add
label define tribed_lbl 203801 `"Deleware - Munsee"', add
label define tribed_lbl 203900 `"Diegueno"', add
label define tribed_lbl 203901 `"Diegueno - Sycuan"', add
label define tribed_lbl 204001 `"Eastern tribe - Georgetown"', add
label define tribed_lbl 204002 `"Eastern tribe - Nansemond"', add
label define tribed_lbl 204003 `"Eastern tribe - Tunica"', add
label define tribed_lbl 204100 `"Grand Ronde"', add
label define tribed_lbl 204200 `"Gros Ventres"', add
label define tribed_lbl 204300 `"Hawaiian"', add
label define tribed_lbl 204400 `"Hoopa"', add
label define tribed_lbl 204401 `"Hoopa - Trinity"', add
label define tribed_lbl 204500 `"Houma"', add
label define tribed_lbl 204600 `"Iowa"', add
label define tribed_lbl 204700 `"Iroquois"', add
label define tribed_lbl 204701 `"Iroquois - Cayuga"', add
label define tribed_lbl 204702 `"Iroquois - Mohawk"', add
label define tribed_lbl 204703 `"Iroquois - Oneida"', add
label define tribed_lbl 204704 `"Iroquois - Onondaga"', add
label define tribed_lbl 204705 `"Iroquois - Seneca"', add
label define tribed_lbl 204706 `"Iroquois - Tuscarora"', add
label define tribed_lbl 204707 `"Iroquois - Wyandotte"', add
label define tribed_lbl 204708 `"Iroquois - Amerind White"', add
label define tribed_lbl 204800 `"Kalispel"', add
label define tribed_lbl 204900 `"Karok/Karuk"', add
label define tribed_lbl 205000 `"Kaw"', add
label define tribed_lbl 205100 `"Kickapoo"', add
label define tribed_lbl 205200 `"Kiowa"', add
label define tribed_lbl 205301 `"Klallam"', add
label define tribed_lbl 205302 `"Port Gamble Klallam"', add
label define tribed_lbl 205400 `"Klamath"', add
label define tribed_lbl 205500 `"Konkow"', add
label define tribed_lbl 205600 `"Kootenai"', add
label define tribed_lbl 205701 `"Central American Indian"', add
label define tribed_lbl 205702 `"Tohono O'Odham - Central American Indian"', add
label define tribed_lbl 205703 `"Mexican American Indian"', add
label define tribed_lbl 205704 `"Tribe not specified, Mexican American Indian"', add
label define tribed_lbl 205705 `"South American Indian"', add
label define tribed_lbl 205706 `"Spanish American Indian"', add
label define tribed_lbl 205710 `"Aztec"', add
label define tribed_lbl 205720 `"Inca"', add
label define tribed_lbl 205730 `"Maya"', add
label define tribed_lbl 205740 `"Mixtec"', add
label define tribed_lbl 205750 `"Taino"', add
label define tribed_lbl 205760 `"Tarasco (Purepecha)"', add
label define tribed_lbl 205790 `"All other Latin American Indian"', add
label define tribed_lbl 205800 `"Long Island - Matinecock"', add
label define tribed_lbl 205900 `"Luiseno"', add
label define tribed_lbl 205901 `"Luiseno - La Jolla"', add
label define tribed_lbl 206000 `"Lumbee"', add
label define tribed_lbl 206100 `"Lummi"', add
label define tribed_lbl 206200 `"Makah"', add
label define tribed_lbl 206300 `"Mailseet/Maliseet"', add
label define tribed_lbl 206400 `"Mandan"', add
label define tribed_lbl 206500 `"Menominee"', add
label define tribed_lbl 206600 `"Miami"', add
label define tribed_lbl 206700 `"Micmac"', add
label define tribed_lbl 206800 `"Mission Indians"', add
label define tribed_lbl 206900 `"Miwok"', add
label define tribed_lbl 207000 `"Modoc"', add
label define tribed_lbl 207100 `"Mohegan"', add
label define tribed_lbl 207200 `"Molala"', add
label define tribed_lbl 207300 `"Mono"', add
label define tribed_lbl 207400 `"Narragansett"', add
label define tribed_lbl 207500 `"Navajo"', add
label define tribed_lbl 207600 `"Nez Perce"', add
label define tribed_lbl 207700 `"Nomalaki"', add
label define tribed_lbl 207801 `"Northweste tribe - Alsea"', add
label define tribed_lbl 207802 `"Northweste tribe - Columbia"', add
label define tribed_lbl 207803 `"Northweste tribe - Kalapuya"', add
label define tribed_lbl 207804 `"Northweste tribe - Tenino"', add
label define tribed_lbl 207805 `"Northweste tribe - Tillamook"', add
label define tribed_lbl 207806 `"Northweste tribe - Wenatchee"', add
label define tribed_lbl 207900 `"Omaha"', add
label define tribed_lbl 208000 `"Oregon Athabaskan"', add
label define tribed_lbl 208100 `"Osage"', add
label define tribed_lbl 208200 `"Otoe-Missouria"', add
label define tribed_lbl 208300 `"Ottawa"', add
label define tribed_lbl 208400 `"Paiute"', add
label define tribed_lbl 208401 `"Paiute - Kaibab"', add
label define tribed_lbl 208500 `"Passamaquoddy"', add
label define tribed_lbl 208600 `"Pawnee"', add
label define tribed_lbl 208700 `"Penobscot"', add
label define tribed_lbl 208800 `"Peoria"', add
label define tribed_lbl 208900 `"Pequot"', add
label define tribed_lbl 209000 `"Pima"', add
label define tribed_lbl 209100 `"Pit River"', add
label define tribed_lbl 209200 `"Pomo"', add
label define tribed_lbl 209201 `"Pomo - Scotts Valley"', add
label define tribed_lbl 209300 `"Ponca"', add
label define tribed_lbl 209400 `"Potawatomie"', add
label define tribed_lbl 209500 `"Powhatan"', add
label define tribed_lbl 209600 `"Pueblo"', add
label define tribed_lbl 209601 `"Pueblo - Acoma"', add
label define tribed_lbl 209602 `"Pueblo - Arizona Tewa"', add
label define tribed_lbl 209603 `"Pueblo - Cochiti"', add
label define tribed_lbl 209604 `"Pueblo - Hopi"', add
label define tribed_lbl 209605 `"Pueblo - Jemez"', add
label define tribed_lbl 209606 `"Pueblo - Keres"', add
label define tribed_lbl 209607 `"Pueblo - Laguna"', add
label define tribed_lbl 209608 `"Pueblo - Taos"', add
label define tribed_lbl 209609 `"Pueblo - Tewa"', add
label define tribed_lbl 209610 `"Pueblo - Tigua"', add
label define tribed_lbl 209611 `"Pueblo - Zuni"', add
label define tribed_lbl 209700 `"Puget Sound Salish"', add
label define tribed_lbl 209701 `"Puget Sound Salish - Duwamish"', add
label define tribed_lbl 209702 `"Puget Sound Salish - Kikiallus"', add
label define tribed_lbl 209703 `"Puget Sound Salish - Muckleshoot"', add
label define tribed_lbl 209704 `"Puget Sound Salish - Nisqually"', add
label define tribed_lbl 209705 `"Puget Sound Salish - Nooksack"', add
label define tribed_lbl 209706 `"Puget Sound Salish - Port Madison"', add
label define tribed_lbl 209707 `"Puget Sound Salish - Puyallup"', add
label define tribed_lbl 209708 `"Puget Sound Salish - Samish"', add
label define tribed_lbl 209709 `"Puget Sound Salish - Sauk-Suiattle"', add
label define tribed_lbl 209710 `"Puget Sound Salish - Skokomish"', add
label define tribed_lbl 209711 `"Puget Sound Salish - Skykomish"', add
label define tribed_lbl 209712 `"Puget Sound Salish - Snohomish"', add
label define tribed_lbl 209713 `"Puget Sound Salish - Snoqualmie"', add
label define tribed_lbl 209714 `"Puget Sound Salish - Steilacoom"', add
label define tribed_lbl 209715 `"Puget Sound Salish - Suquamish"', add
label define tribed_lbl 209716 `"Puget Sound Salish - Swinomish"', add
label define tribed_lbl 209717 `"Puget Sound Salish - Tulalip"', add
label define tribed_lbl 209718 `"Puget Sound Salish - Upper Skagit"', add
label define tribed_lbl 209800 `"Quapaw"', add
label define tribed_lbl 209900 `"Quinault"', add
label define tribed_lbl 210000 `"Sac and Fox"', add
label define tribed_lbl 210100 `"Salish"', add
label define tribed_lbl 210200 `"Seminole"', add
label define tribed_lbl 210300 `"Serrano"', add
label define tribed_lbl 210400 `"Shasta"', add
label define tribed_lbl 210500 `"Shawnee"', add
label define tribed_lbl 210600 `"Shinnecock"', add
label define tribed_lbl 210700 `"Shoshone"', add
label define tribed_lbl 210701 `"Shoshone - Goshute"', add
label define tribed_lbl 210702 `"Shoshone - South Fork"', add
label define tribed_lbl 210800 `"Shoshone Paiute/Paiute Shoshone"', add
label define tribed_lbl 210900 `"Siletz"', add
label define tribed_lbl 211000 `"Sioux"', add
label define tribed_lbl 211001 `"Sioux - Brule"', add
label define tribed_lbl 211002 `"Sioux - Lower Brule"', add
label define tribed_lbl 211003 `"Sioux - Mdewakanton"', add
label define tribed_lbl 211004 `"Sioux - Miniconjou"', add
label define tribed_lbl 211005 `"Sioux - Oglala"', add
label define tribed_lbl 211006 `"Sioux - Rosebud"', add
label define tribed_lbl 211007 `"Sioux - Sans Arc"', add
label define tribed_lbl 211008 `"Sioux - Santee"', add
label define tribed_lbl 211009 `"Sioux - Sisseton"', add
label define tribed_lbl 211010 `"Sioux - Sisseton-Wahpeton"', add
label define tribed_lbl 211011 `"Sioux - Teton"', add
label define tribed_lbl 211012 `"Sioux - Two Kettle"', add
label define tribed_lbl 211013 `"Sioux - Wahpekute"', add
label define tribed_lbl 211014 `"Sioux - Wahpeton"', add
label define tribed_lbl 211015 `"Sioux - Wazhaza"', add
label define tribed_lbl 211016 `"Sioux - Yankton"', add
label define tribed_lbl 211017 `"Sioux - Yanktonai"', add
label define tribed_lbl 211018 `"Sioux - Amerind White"', add
label define tribed_lbl 211019 `"Sious - Cheyenne River"', add
label define tribed_lbl 211100 `"Spokane"', add
label define tribed_lbl 211200 `"Stockbridge"', add
label define tribed_lbl 211300 `"Tohono O'Odham"', add
label define tribed_lbl 211400 `"Tolowa"', add
label define tribed_lbl 211500 `"Tonkawa"', add
label define tribed_lbl 211600 `"Umatilla"', add
label define tribed_lbl 211700 `"Umpqua"', add
label define tribed_lbl 211800 `"Ute"', add
label define tribed_lbl 211801 `"Uintah Ute"', add
label define tribed_lbl 211900 `"Wailaki"', add
label define tribed_lbl 212000 `"Walla-Walla"', add
label define tribed_lbl 212100 `"Warm Springs"', add
label define tribed_lbl 212200 `"Washo"', add
label define tribed_lbl 212300 `"Wichita"', add
label define tribed_lbl 212400 `"Winnebago"', add
label define tribed_lbl 212500 `"Wintu/Wintun"', add
label define tribed_lbl 212600 `"Yakima"', add
label define tribed_lbl 212700 `"Yaqui"', add
label define tribed_lbl 212801 `"Chukchansi"', add
label define tribed_lbl 212802 `"Tule River"', add
label define tribed_lbl 212900 `"Yuchi"', add
label define tribed_lbl 213000 `"Yuman"', add
label define tribed_lbl 213001 `"Yuman - Cocopah"', add
label define tribed_lbl 213002 `"Yuman - Havasupai"', add
label define tribed_lbl 213003 `"Yuman - Hualapai"', add
label define tribed_lbl 213004 `"Yuman - Maricopa"', add
label define tribed_lbl 213005 `"Yuman - Mohave"', add
label define tribed_lbl 213006 `"Yuman - Quechan"', add
label define tribed_lbl 213100 `"Yurok"', add
label define tribed_lbl 213200 `"American Indian, tribe not elsewhere classified"', add
label define tribed_lbl 213300 `"American Indian, tribe not specified"', add
label define tribed_lbl 213301 `"Amerind White"', add
label define tribed_lbl 213302 `"Amerind Black"', add
label define tribed_lbl 213400 `"All other specified American Indian tribe combinations"', add
label define tribed_lbl 300100 `"American Indian and Alaska Native, tribe not elsewhere classified"', add
label define tribed_lbl 300200 `"American Indian and Alaska Native, not specified"', add
label values tribed tribed_lbl

label define racamind_lbl 1 `"No"'
label define racamind_lbl 2 `"Yes"', add
label values racamind racamind_lbl

label define racasian_lbl 1 `"No"'
label define racasian_lbl 2 `"Yes"', add
label values racasian racasian_lbl

label define racblk_lbl 1 `"No"'
label define racblk_lbl 2 `"Yes"', add
label values racblk racblk_lbl

label define racpacis_lbl 1 `"No"'
label define racpacis_lbl 2 `"Yes"', add
label values racpacis racpacis_lbl

label define racwht_lbl 1 `"No"'
label define racwht_lbl 2 `"Yes"', add
label values racwht racwht_lbl

label define racother_lbl 1 `"No"'
label define racother_lbl 2 `"Yes"', add
label values racother racother_lbl

label define racnum_lbl 1 `"1 race group"'
label define racnum_lbl 2 `"2 race groups"', add
label define racnum_lbl 3 `"3 race groups"', add
label define racnum_lbl 4 `"4 race groups"', add
label define racnum_lbl 5 `"5 race groups"', add
label define racnum_lbl 6 `"6 race groups"', add
label values racnum racnum_lbl

label define school_lbl 0 `"N/A"'
label define school_lbl 1 `"No, not in school"', add
label define school_lbl 2 `"Yes, in school"', add
label define school_lbl 8 `"Unknown"', add
label define school_lbl 9 `"Missing"', add
label values school school_lbl

label define educ_lbl 00 `"N/A or no schooling"'
label define educ_lbl 01 `"Nursery school to grade 4"', add
label define educ_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_lbl 03 `"Grade 9"', add
label define educ_lbl 04 `"Grade 10"', add
label define educ_lbl 05 `"Grade 11"', add
label define educ_lbl 06 `"Grade 12"', add
label define educ_lbl 07 `"1 year of college"', add
label define educ_lbl 08 `"2 years of college"', add
label define educ_lbl 09 `"3 years of college"', add
label define educ_lbl 10 `"4 years of college"', add
label define educ_lbl 11 `"5+ years of college"', add
label define educ_lbl 99 `"Missing"', add
label values educ educ_lbl

label define educd_lbl 000 `"N/A or no schooling"'
label define educd_lbl 001 `"N/A"', add
label define educd_lbl 002 `"No schooling completed"', add
label define educd_lbl 010 `"Nursery school to grade 4"', add
label define educd_lbl 011 `"Nursery school, preschool"', add
label define educd_lbl 012 `"Kindergarten"', add
label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_lbl 014 `"Grade 1"', add
label define educd_lbl 015 `"Grade 2"', add
label define educd_lbl 016 `"Grade 3"', add
label define educd_lbl 017 `"Grade 4"', add
label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_lbl 021 `"Grade 5 or 6"', add
label define educd_lbl 022 `"Grade 5"', add
label define educd_lbl 023 `"Grade 6"', add
label define educd_lbl 024 `"Grade 7 or 8"', add
label define educd_lbl 025 `"Grade 7"', add
label define educd_lbl 026 `"Grade 8"', add
label define educd_lbl 030 `"Grade 9"', add
label define educd_lbl 040 `"Grade 10"', add
label define educd_lbl 050 `"Grade 11"', add
label define educd_lbl 060 `"Grade 12"', add
label define educd_lbl 061 `"12th grade, no diploma"', add
label define educd_lbl 062 `"High school graduate or GED"', add
label define educd_lbl 063 `"Regular high school diploma"', add
label define educd_lbl 064 `"GED or alternative credential"', add
label define educd_lbl 065 `"Some college, but less than 1 year"', add
label define educd_lbl 070 `"1 year of college"', add
label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_lbl 080 `"2 years of college"', add
label define educd_lbl 081 `"Associate's degree, type not specified"', add
label define educd_lbl 082 `"Associate's degree, occupational program"', add
label define educd_lbl 083 `"Associate's degree, academic program"', add
label define educd_lbl 090 `"3 years of college"', add
label define educd_lbl 100 `"4 years of college"', add
label define educd_lbl 101 `"Bachelor's degree"', add
label define educd_lbl 110 `"5+ years of college"', add
label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_lbl 112 `"7 years of college"', add
label define educd_lbl 113 `"8+ years of college"', add
label define educd_lbl 114 `"Master's degree"', add
label define educd_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_lbl 116 `"Doctoral degree"', add
label define educd_lbl 999 `"Missing"', add
label values educd educd_lbl

label define gradeatt_lbl 0 `"N/A"'
label define gradeatt_lbl 1 `"Nursery school/preschool"', add
label define gradeatt_lbl 2 `"Kindergarten"', add
label define gradeatt_lbl 3 `"Grade 1 to grade 4"', add
label define gradeatt_lbl 4 `"Grade 5 to grade 8"', add
label define gradeatt_lbl 5 `"Grade 9 to grade 12"', add
label define gradeatt_lbl 6 `"College undergraduate"', add
label define gradeatt_lbl 7 `"Graduate or professional school"', add
label values gradeatt gradeatt_lbl

label define gradeattd_lbl 00 `"N/A"'
label define gradeattd_lbl 10 `"Nursery school/preschool"', add
label define gradeattd_lbl 20 `"Kindergarten"', add
label define gradeattd_lbl 30 `"Grade 1 to grade 4"', add
label define gradeattd_lbl 31 `"Grade 1"', add
label define gradeattd_lbl 32 `"Grade 2"', add
label define gradeattd_lbl 33 `"Grade 3"', add
label define gradeattd_lbl 34 `"Grade 4"', add
label define gradeattd_lbl 40 `"Grade 5 to grade 8"', add
label define gradeattd_lbl 41 `"Grade 5"', add
label define gradeattd_lbl 42 `"Grade 6"', add
label define gradeattd_lbl 43 `"Grade 7"', add
label define gradeattd_lbl 44 `"Grade 8"', add
label define gradeattd_lbl 50 `"Grade 9 to grade 12"', add
label define gradeattd_lbl 51 `"Grade 9"', add
label define gradeattd_lbl 52 `"Grade 10"', add
label define gradeattd_lbl 53 `"Grade 11"', add
label define gradeattd_lbl 54 `"Grade 12"', add
label define gradeattd_lbl 60 `"College undergraduate"', add
label define gradeattd_lbl 61 `"First year of college"', add
label define gradeattd_lbl 62 `"Second year of college"', add
label define gradeattd_lbl 63 `"Third year of college"', add
label define gradeattd_lbl 64 `"Fourth year of college"', add
label define gradeattd_lbl 70 `"Graduate or professional school"', add
label define gradeattd_lbl 71 `"Fifth year of college"', add
label define gradeattd_lbl 72 `"Sixth year of college"', add
label define gradeattd_lbl 73 `"Seventh year of college"', add
label define gradeattd_lbl 74 `"Eighth year of college"', add
label values gradeattd gradeattd_lbl

label define schltype_lbl 0 `"N/A"'
label define schltype_lbl 1 `"Not enrolled"', add
label define schltype_lbl 2 `"Public school"', add
label define schltype_lbl 3 `"Private school (1960,1990-2000,ACS,PRCS)"', add
label define schltype_lbl 4 `"Church-related (1980)"', add
label define schltype_lbl 5 `"Parochial (1970)"', add
label define schltype_lbl 6 `"Other private, 1980"', add
label define schltype_lbl 7 `"Other private, 1970"', add
label values schltype schltype_lbl

label define degfield_lbl 00 `"N/A"'
label define degfield_lbl 11 `"Agriculture"', add
label define degfield_lbl 13 `"Environment and Natural Resources"', add
label define degfield_lbl 14 `"Architecture"', add
label define degfield_lbl 15 `"Area, Ethnic, and Civilization Studies"', add
label define degfield_lbl 19 `"Communications"', add
label define degfield_lbl 20 `"Communication Technologies"', add
label define degfield_lbl 21 `"Computer and Information Sciences"', add
label define degfield_lbl 22 `"Cosmetology Services and Culinary Arts"', add
label define degfield_lbl 23 `"Education Administration and Teaching"', add
label define degfield_lbl 24 `"Engineering"', add
label define degfield_lbl 25 `"Engineering Technologies"', add
label define degfield_lbl 26 `"Linguistics and Foreign Languages"', add
label define degfield_lbl 29 `"Family and Consumer Sciences"', add
label define degfield_lbl 32 `"Law"', add
label define degfield_lbl 33 `"English Language, Literature, and Composition"', add
label define degfield_lbl 34 `"Liberal Arts and Humanities"', add
label define degfield_lbl 35 `"Library Science"', add
label define degfield_lbl 36 `"Biology and Life Sciences"', add
label define degfield_lbl 37 `"Mathematics and Statistics"', add
label define degfield_lbl 38 `"Military Technologies"', add
label define degfield_lbl 40 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define degfield_lbl 41 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define degfield_lbl 48 `"Philosophy and Religious Studies"', add
label define degfield_lbl 49 `"Theology and Religious Vocations"', add
label define degfield_lbl 50 `"Physical Sciences"', add
label define degfield_lbl 51 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define degfield_lbl 52 `"Psychology"', add
label define degfield_lbl 53 `"Criminal Justice and Fire Protection"', add
label define degfield_lbl 54 `"Public Affairs, Policy, and Social Work"', add
label define degfield_lbl 55 `"Social Sciences"', add
label define degfield_lbl 56 `"Construction Services"', add
label define degfield_lbl 57 `"Electrical and Mechanic Repairs and Technologies"', add
label define degfield_lbl 58 `"Precision Production and Industrial Arts"', add
label define degfield_lbl 59 `"Transportation Sciences and Technologies"', add
label define degfield_lbl 60 `"Fine Arts"', add
label define degfield_lbl 61 `"Medical and Health Sciences and Services"', add
label define degfield_lbl 62 `"Business"', add
label define degfield_lbl 64 `"History"', add
label values degfield degfield_lbl

label define degfieldd_lbl 0000 `"N/A"'
label define degfieldd_lbl 1100 `"General Agriculture"', add
label define degfieldd_lbl 1101 `"Agriculture Production and Management"', add
label define degfieldd_lbl 1102 `"Agricultural Economics"', add
label define degfieldd_lbl 1103 `"Animal Sciences"', add
label define degfieldd_lbl 1104 `"Food Science"', add
label define degfieldd_lbl 1105 `"Plant Science and Agronomy"', add
label define degfieldd_lbl 1106 `"Soil Science"', add
label define degfieldd_lbl 1107 `"Veterinary Medicine"', add
label define degfieldd_lbl 1199 `"Miscellaneous Agriculture"', add
label define degfieldd_lbl 1300 `"Environment and Natural Resources"', add
label define degfieldd_lbl 1301 `"Environmental Science"', add
label define degfieldd_lbl 1302 `"Forestry"', add
label define degfieldd_lbl 1303 `"Natural Resources Management"', add
label define degfieldd_lbl 1401 `"Architecture"', add
label define degfieldd_lbl 1501 `"Area, Ethnic, and Civilization Studies"', add
label define degfieldd_lbl 1900 `"Communications"', add
label define degfieldd_lbl 1901 `"Communications"', add
label define degfieldd_lbl 1902 `"Journalism"', add
label define degfieldd_lbl 1903 `"Mass Media"', add
label define degfieldd_lbl 1904 `"Advertising and Public Relations"', add
label define degfieldd_lbl 2001 `"Communication Technologies"', add
label define degfieldd_lbl 2100 `"Computer and Information Systems"', add
label define degfieldd_lbl 2101 `"Computer Programming and Data Processing"', add
label define degfieldd_lbl 2102 `"Computer Science"', add
label define degfieldd_lbl 2105 `"Information Sciences"', add
label define degfieldd_lbl 2106 `"Computer Information Management and Security"', add
label define degfieldd_lbl 2107 `"Computer Networking and Telecommunications"', add
label define degfieldd_lbl 2201 `"Cosmetology Services and Culinary Arts"', add
label define degfieldd_lbl 2300 `"General Education"', add
label define degfieldd_lbl 2301 `"Educational Administration and Supervision"', add
label define degfieldd_lbl 2303 `"School Student Counseling"', add
label define degfieldd_lbl 2304 `"Elementary Education"', add
label define degfieldd_lbl 2305 `"Mathematics Teacher Education"', add
label define degfieldd_lbl 2306 `"Physical and Health Education Teaching"', add
label define degfieldd_lbl 2307 `"Early Childhood Education"', add
label define degfieldd_lbl 2308 `"Science  and Computer Teacher Education"', add
label define degfieldd_lbl 2309 `"Secondary Teacher Education"', add
label define degfieldd_lbl 2310 `"Special Needs Education"', add
label define degfieldd_lbl 2311 `"Social Science or History Teacher Education"', add
label define degfieldd_lbl 2312 `"Teacher Education:  Multiple Levels"', add
label define degfieldd_lbl 2313 `"Language and Drama Education"', add
label define degfieldd_lbl 2314 `"Art and Music Education"', add
label define degfieldd_lbl 2399 `"Miscellaneous Education"', add
label define degfieldd_lbl 2400 `"General Engineering"', add
label define degfieldd_lbl 2401 `"Aerospace Engineering"', add
label define degfieldd_lbl 2402 `"Biological Engineering"', add
label define degfieldd_lbl 2403 `"Architectural Engineering"', add
label define degfieldd_lbl 2404 `"Biomedical Engineering"', add
label define degfieldd_lbl 2405 `"Chemical Engineering"', add
label define degfieldd_lbl 2406 `"Civil Engineering"', add
label define degfieldd_lbl 2407 `"Computer Engineering"', add
label define degfieldd_lbl 2408 `"Electrical Engineering"', add
label define degfieldd_lbl 2409 `"Engineering Mechanics, Physics, and Science"', add
label define degfieldd_lbl 2410 `"Environmental Engineering"', add
label define degfieldd_lbl 2411 `"Geological and Geophysical Engineering"', add
label define degfieldd_lbl 2412 `"Industrial and Manufacturing Engineering"', add
label define degfieldd_lbl 2413 `"Materials Engineering and Materials Science"', add
label define degfieldd_lbl 2414 `"Mechanical Engineering"', add
label define degfieldd_lbl 2415 `"Metallurgical Engineering"', add
label define degfieldd_lbl 2416 `"Mining and Mineral Engineering"', add
label define degfieldd_lbl 2417 `"Naval Architecture and Marine Engineering"', add
label define degfieldd_lbl 2418 `"Nuclear Engineering"', add
label define degfieldd_lbl 2419 `"Petroleum Engineering"', add
label define degfieldd_lbl 2499 `"Miscellaneous Engineering"', add
label define degfieldd_lbl 2500 `"Engineering Technologies"', add
label define degfieldd_lbl 2501 `"Engineering and Industrial Management"', add
label define degfieldd_lbl 2502 `"Electrical Engineering Technology"', add
label define degfieldd_lbl 2503 `"Industrial Production Technologies"', add
label define degfieldd_lbl 2504 `"Mechanical Engineering Related Technologies"', add
label define degfieldd_lbl 2599 `"Miscellaneous Engineering Technologies"', add
label define degfieldd_lbl 2600 `"Linguistics and Foreign Languages"', add
label define degfieldd_lbl 2601 `"Linguistics and Comparative Language and Literature"', add
label define degfieldd_lbl 2602 `"French, German, Latin and Other Common Foreign Language Studies"', add
label define degfieldd_lbl 2603 `"Other Foreign Languages"', add
label define degfieldd_lbl 2901 `"Family and Consumer Sciences"', add
label define degfieldd_lbl 3200 `"Law"', add
label define degfieldd_lbl 3201 `"Court Reporting"', add
label define degfieldd_lbl 3202 `"Pre-Law and Legal Studies"', add
label define degfieldd_lbl 3300 `"English Language, Literature, and Composition"', add
label define degfieldd_lbl 3301 `"English Language and Literature"', add
label define degfieldd_lbl 3302 `"Composition and Speech"', add
label define degfieldd_lbl 3400 `"Liberal Arts and Humanities"', add
label define degfieldd_lbl 3401 `"Liberal Arts"', add
label define degfieldd_lbl 3402 `"Humanities"', add
label define degfieldd_lbl 3501 `"Library Science"', add
label define degfieldd_lbl 3600 `"Biology"', add
label define degfieldd_lbl 3601 `"Biochemical Sciences"', add
label define degfieldd_lbl 3602 `"Botany"', add
label define degfieldd_lbl 3603 `"Molecular Biology"', add
label define degfieldd_lbl 3604 `"Ecology"', add
label define degfieldd_lbl 3605 `"Genetics"', add
label define degfieldd_lbl 3606 `"Microbiology"', add
label define degfieldd_lbl 3607 `"Pharmacology"', add
label define degfieldd_lbl 3608 `"Physiology"', add
label define degfieldd_lbl 3609 `"Zoology"', add
label define degfieldd_lbl 3611 `"Neuroscience"', add
label define degfieldd_lbl 3699 `"Miscellaneous Biology"', add
label define degfieldd_lbl 3700 `"Mathematics"', add
label define degfieldd_lbl 3701 `"Applied Mathematics"', add
label define degfieldd_lbl 3702 `"Statistics and Decision Science"', add
label define degfieldd_lbl 3801 `"Military Technologies"', add
label define degfieldd_lbl 4000 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define degfieldd_lbl 4001 `"Intercultural and International Studies"', add
label define degfieldd_lbl 4002 `"Nutrition Sciences"', add
label define degfieldd_lbl 4003 `"Neuroscience"', add
label define degfieldd_lbl 4005 `"Mathematics and Computer Science"', add
label define degfieldd_lbl 4006 `"Cognitive Science and Biopsychology"', add
label define degfieldd_lbl 4007 `"Interdisciplinary Social Sciences"', add
label define degfieldd_lbl 4008 `"Multi-disciplinary or General Science"', add
label define degfieldd_lbl 4009 `"Data Science and Data Analytics"', add
label define degfieldd_lbl 4101 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define degfieldd_lbl 4801 `"Philosophy and Religious Studies"', add
label define degfieldd_lbl 4901 `"Theology and Religious Vocations"', add
label define degfieldd_lbl 5000 `"Physical Sciences"', add
label define degfieldd_lbl 5001 `"Astronomy and Astrophysics"', add
label define degfieldd_lbl 5002 `"Atmospheric Sciences and Meteorology"', add
label define degfieldd_lbl 5003 `"Chemistry"', add
label define degfieldd_lbl 5004 `"Geology and Earth Science"', add
label define degfieldd_lbl 5005 `"Geosciences"', add
label define degfieldd_lbl 5006 `"Oceanography"', add
label define degfieldd_lbl 5007 `"Physics"', add
label define degfieldd_lbl 5008 `"Materials Science"', add
label define degfieldd_lbl 5098 `"Multi-disciplinary or General Science"', add
label define degfieldd_lbl 5102 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define degfieldd_lbl 5200 `"Psychology"', add
label define degfieldd_lbl 5201 `"Educational Psychology"', add
label define degfieldd_lbl 5202 `"Clinical Psychology"', add
label define degfieldd_lbl 5203 `"Counseling Psychology"', add
label define degfieldd_lbl 5205 `"Industrial and Organizational Psychology"', add
label define degfieldd_lbl 5206 `"Social Psychology"', add
label define degfieldd_lbl 5299 `"Miscellaneous Psychology"', add
label define degfieldd_lbl 5301 `"Criminal Justice and Fire Protection"', add
label define degfieldd_lbl 5400 `"Public Affairs, Policy, and Social Work"', add
label define degfieldd_lbl 5401 `"Public Administration"', add
label define degfieldd_lbl 5402 `"Public Policy"', add
label define degfieldd_lbl 5403 `"Human Services and Community Organization"', add
label define degfieldd_lbl 5404 `"Social Work"', add
label define degfieldd_lbl 5500 `"General Social Sciences"', add
label define degfieldd_lbl 5501 `"Economics"', add
label define degfieldd_lbl 5502 `"Anthropology and Archeology"', add
label define degfieldd_lbl 5503 `"Criminology"', add
label define degfieldd_lbl 5504 `"Geography"', add
label define degfieldd_lbl 5505 `"International Relations"', add
label define degfieldd_lbl 5506 `"Political Science and Government"', add
label define degfieldd_lbl 5507 `"Sociology"', add
label define degfieldd_lbl 5599 `"Miscellaneous Social Sciences"', add
label define degfieldd_lbl 5601 `"Construction Services"', add
label define degfieldd_lbl 5701 `"Electrical and Mechanic Repairs and Technologies"', add
label define degfieldd_lbl 5801 `"Precision Production and Industrial Arts"', add
label define degfieldd_lbl 5901 `"Transportation Sciences and Technologies"', add
label define degfieldd_lbl 6000 `"Fine Arts"', add
label define degfieldd_lbl 6001 `"Drama and Theater Arts"', add
label define degfieldd_lbl 6002 `"Music"', add
label define degfieldd_lbl 6003 `"Visual and Performing Arts"', add
label define degfieldd_lbl 6004 `"Commercial Art and Graphic Design"', add
label define degfieldd_lbl 6005 `"Film, Video and Photographic Arts"', add
label define degfieldd_lbl 6006 `"Art History and Criticism"', add
label define degfieldd_lbl 6007 `"Studio Arts"', add
label define degfieldd_lbl 6099 `"Miscellaneous Fine Arts"', add
label define degfieldd_lbl 6100 `"General Medical and Health Services"', add
label define degfieldd_lbl 6102 `"Communication Disorders Sciences and Services"', add
label define degfieldd_lbl 6103 `"Health and Medical Administrative Services"', add
label define degfieldd_lbl 6104 `"Medical Assisting Services"', add
label define degfieldd_lbl 6105 `"Medical Technologies Technicians"', add
label define degfieldd_lbl 6106 `"Health and Medical Preparatory Programs"', add
label define degfieldd_lbl 6107 `"Nursing"', add
label define degfieldd_lbl 6108 `"Pharmacy, Pharmaceutical Sciences, and Administration"', add
label define degfieldd_lbl 6109 `"Treatment Therapy Professions"', add
label define degfieldd_lbl 6110 `"Community and Public Health"', add
label define degfieldd_lbl 6199 `"Miscellaneous Health Medical Professions"', add
label define degfieldd_lbl 6200 `"General Business"', add
label define degfieldd_lbl 6201 `"Accounting"', add
label define degfieldd_lbl 6202 `"Actuarial Science"', add
label define degfieldd_lbl 6203 `"Business Management and Administration"', add
label define degfieldd_lbl 6204 `"Operations, Logistics and E-Commerce"', add
label define degfieldd_lbl 6205 `"Business Economics"', add
label define degfieldd_lbl 6206 `"Marketing and Marketing Research"', add
label define degfieldd_lbl 6207 `"Finance"', add
label define degfieldd_lbl 6209 `"Human Resources and Personnel Management"', add
label define degfieldd_lbl 6210 `"International Business"', add
label define degfieldd_lbl 6211 `"Hospitality Management"', add
label define degfieldd_lbl 6212 `"Management Information Systems and Statistics"', add
label define degfieldd_lbl 6299 `"Miscellaneous Business and Medical Administration"', add
label define degfieldd_lbl 6402 `"History"', add
label define degfieldd_lbl 6403 `"United States History"', add
label values degfieldd degfieldd_lbl

label define degfield2_lbl 00 `"N/A"'
label define degfield2_lbl 11 `"Agriculture"', add
label define degfield2_lbl 13 `"Environment and Natural Resources"', add
label define degfield2_lbl 14 `"Architecture"', add
label define degfield2_lbl 15 `"Area, Ethnic, and Civilization Studies"', add
label define degfield2_lbl 19 `"Communications"', add
label define degfield2_lbl 20 `"Communication Technologies"', add
label define degfield2_lbl 21 `"Computer and Information Sciences"', add
label define degfield2_lbl 22 `"Cosmetology Services and Culinary Arts"', add
label define degfield2_lbl 23 `"Education Administration and Teaching"', add
label define degfield2_lbl 24 `"Engineering"', add
label define degfield2_lbl 25 `"Engineering Technologies"', add
label define degfield2_lbl 26 `"Linguistics and Foreign Languages"', add
label define degfield2_lbl 29 `"Family and Consumer Sciences"', add
label define degfield2_lbl 32 `"Law"', add
label define degfield2_lbl 33 `"English Language, Literature, and Composition"', add
label define degfield2_lbl 34 `"Liberal Arts and Humanities"', add
label define degfield2_lbl 35 `"Library Science"', add
label define degfield2_lbl 36 `"Biology and Life Sciences"', add
label define degfield2_lbl 37 `"Mathematics and Statistics"', add
label define degfield2_lbl 38 `"Military Technologies"', add
label define degfield2_lbl 40 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define degfield2_lbl 41 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define degfield2_lbl 48 `"Philosophy and Religious Studies"', add
label define degfield2_lbl 49 `"Theology and Religious Vocations"', add
label define degfield2_lbl 50 `"Physical Sciences"', add
label define degfield2_lbl 51 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define degfield2_lbl 52 `"Psychology"', add
label define degfield2_lbl 53 `"Criminal Justice and Fire Protection"', add
label define degfield2_lbl 54 `"Public Affairs, Policy, and Social Work"', add
label define degfield2_lbl 55 `"Social Sciences"', add
label define degfield2_lbl 56 `"Construction Services"', add
label define degfield2_lbl 57 `"Electrical and Mechanic Repairs and Technologies"', add
label define degfield2_lbl 58 `"Precision Production and Industrial Arts"', add
label define degfield2_lbl 59 `"Transportation Sciences and Technologies"', add
label define degfield2_lbl 60 `"Fine Arts"', add
label define degfield2_lbl 61 `"Medical and Health Sciences and Services"', add
label define degfield2_lbl 62 `"Business"', add
label define degfield2_lbl 64 `"History"', add
label values degfield2 degfield2_lbl

label define degfield2d_lbl 0000 `"N/A"'
label define degfield2d_lbl 1100 `"General Agriculture"', add
label define degfield2d_lbl 1101 `"Agriculture Production and Management"', add
label define degfield2d_lbl 1102 `"Agricultural Economics"', add
label define degfield2d_lbl 1103 `"Animal Sciences"', add
label define degfield2d_lbl 1104 `"Food Science"', add
label define degfield2d_lbl 1105 `"Plant Science and Agronomy"', add
label define degfield2d_lbl 1106 `"Soil Science"', add
label define degfield2d_lbl 1107 `"Veterinary Medicine"', add
label define degfield2d_lbl 1199 `"Miscellaneous Agriculture"', add
label define degfield2d_lbl 1300 `"Environment and Natural Resources"', add
label define degfield2d_lbl 1301 `"Environmental Science"', add
label define degfield2d_lbl 1302 `"Forestry"', add
label define degfield2d_lbl 1303 `"Natural Resources Management"', add
label define degfield2d_lbl 1401 `"Architecture"', add
label define degfield2d_lbl 1501 `"Area, Ethnic, and Civilization Studies"', add
label define degfield2d_lbl 1900 `"Communications"', add
label define degfield2d_lbl 1901 `"Communications"', add
label define degfield2d_lbl 1902 `"Journalism"', add
label define degfield2d_lbl 1903 `"Mass Media"', add
label define degfield2d_lbl 1904 `"Advertising and Public Relations"', add
label define degfield2d_lbl 2001 `"Communication Technologies"', add
label define degfield2d_lbl 2100 `"Computer and Information Systems"', add
label define degfield2d_lbl 2101 `"Computer Programming and Data Processing"', add
label define degfield2d_lbl 2102 `"Computer Science"', add
label define degfield2d_lbl 2105 `"Information Sciences"', add
label define degfield2d_lbl 2106 `"Computer Information Management and Security"', add
label define degfield2d_lbl 2107 `"Computer Networking and Telecommunications"', add
label define degfield2d_lbl 2201 `"Cosmetology Services and Culinary Arts"', add
label define degfield2d_lbl 2300 `"General Education"', add
label define degfield2d_lbl 2301 `"Educational Administration and Supervision"', add
label define degfield2d_lbl 2303 `"School Student Counseling"', add
label define degfield2d_lbl 2304 `"Elementary Education"', add
label define degfield2d_lbl 2305 `"Mathematics Teacher Education"', add
label define degfield2d_lbl 2306 `"Physical and Health Education Teaching"', add
label define degfield2d_lbl 2307 `"Early Childhood Education"', add
label define degfield2d_lbl 2308 `"Science  and Computer Teacher Education"', add
label define degfield2d_lbl 2309 `"Secondary Teacher Education"', add
label define degfield2d_lbl 2310 `"Special Needs Education"', add
label define degfield2d_lbl 2311 `"Social Science or History Teacher Education"', add
label define degfield2d_lbl 2312 `"Teacher Education:  Multiple Levels"', add
label define degfield2d_lbl 2313 `"Language and Drama Education"', add
label define degfield2d_lbl 2314 `"Art and Music Education"', add
label define degfield2d_lbl 2399 `"Miscellaneous Education"', add
label define degfield2d_lbl 2400 `"General Engineering"', add
label define degfield2d_lbl 2401 `"Aerospace Engineering"', add
label define degfield2d_lbl 2402 `"Biological Engineering"', add
label define degfield2d_lbl 2403 `"Architectural Engineering"', add
label define degfield2d_lbl 2404 `"Biomedical Engineering"', add
label define degfield2d_lbl 2405 `"Chemical Engineering"', add
label define degfield2d_lbl 2406 `"Civil Engineering"', add
label define degfield2d_lbl 2407 `"Computer Engineering"', add
label define degfield2d_lbl 2408 `"Electrical Engineering"', add
label define degfield2d_lbl 2409 `"Engineering Mechanics, Physics, and Science"', add
label define degfield2d_lbl 2410 `"Environmental Engineering"', add
label define degfield2d_lbl 2411 `"Geological and Geophysical Engineering"', add
label define degfield2d_lbl 2412 `"Industrial and Manufacturing Engineering"', add
label define degfield2d_lbl 2413 `"Materials Engineering and Materials Science"', add
label define degfield2d_lbl 2414 `"Mechanical Engineering"', add
label define degfield2d_lbl 2415 `"Metallurgical Engineering"', add
label define degfield2d_lbl 2416 `"Mining and Mineral Engineering"', add
label define degfield2d_lbl 2417 `"Naval Architecture and Marine Engineering"', add
label define degfield2d_lbl 2418 `"Nuclear Engineering"', add
label define degfield2d_lbl 2419 `"Petroleum Engineering"', add
label define degfield2d_lbl 2499 `"Miscellaneous Engineering"', add
label define degfield2d_lbl 2500 `"Engineering Technologies"', add
label define degfield2d_lbl 2501 `"Engineering and Industrial Management"', add
label define degfield2d_lbl 2502 `"Electrical Engineering Technology"', add
label define degfield2d_lbl 2503 `"Industrial Production Technologies"', add
label define degfield2d_lbl 2504 `"Mechanical Engineering Related Technologies"', add
label define degfield2d_lbl 2599 `"Miscellaneous Engineering Technologies"', add
label define degfield2d_lbl 2600 `"Linguistics and Foreign Languages"', add
label define degfield2d_lbl 2601 `"Linguistics and Comparative Language and Literature"', add
label define degfield2d_lbl 2602 `"French, German, Latin and Other Common Foreign Language Studies"', add
label define degfield2d_lbl 2603 `"Other Foreign Languages"', add
label define degfield2d_lbl 2901 `"Family and Consumer Sciences"', add
label define degfield2d_lbl 3200 `"Law"', add
label define degfield2d_lbl 3201 `"Court Reporting"', add
label define degfield2d_lbl 3202 `"Pre-Law and Legal Studies"', add
label define degfield2d_lbl 3300 `"English Language, Literature, and Composition"', add
label define degfield2d_lbl 3301 `"English Language and Literature"', add
label define degfield2d_lbl 3302 `"Composition and Speech"', add
label define degfield2d_lbl 3400 `"Liberal Arts and Humanities"', add
label define degfield2d_lbl 3401 `"Liberal Arts"', add
label define degfield2d_lbl 3402 `"Humanities"', add
label define degfield2d_lbl 3501 `"Library Science"', add
label define degfield2d_lbl 3600 `"Biology"', add
label define degfield2d_lbl 3601 `"Biochemical Sciences"', add
label define degfield2d_lbl 3602 `"Botany"', add
label define degfield2d_lbl 3603 `"Molecular Biology"', add
label define degfield2d_lbl 3604 `"Ecology"', add
label define degfield2d_lbl 3605 `"Genetics"', add
label define degfield2d_lbl 3606 `"Microbiology"', add
label define degfield2d_lbl 3607 `"Pharmacology"', add
label define degfield2d_lbl 3608 `"Physiology"', add
label define degfield2d_lbl 3609 `"Zoology"', add
label define degfield2d_lbl 3611 `"Neuroscience"', add
label define degfield2d_lbl 3699 `"Miscellaneous Biology"', add
label define degfield2d_lbl 3700 `"Mathematics"', add
label define degfield2d_lbl 3701 `"Applied Mathematics"', add
label define degfield2d_lbl 3702 `"Statistics and Decision Science"', add
label define degfield2d_lbl 3801 `"Military Technologies"', add
label define degfield2d_lbl 4000 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define degfield2d_lbl 4001 `"Intercultural and International Studies"', add
label define degfield2d_lbl 4002 `"Nutrition Sciences"', add
label define degfield2d_lbl 4003 `"Neuroscience"', add
label define degfield2d_lbl 4004 `"Accounting and Computer Science"', add
label define degfield2d_lbl 4005 `"Mathematics and Computer Science"', add
label define degfield2d_lbl 4006 `"Cognitive Science and Biopsychology"', add
label define degfield2d_lbl 4007 `"Interdisciplinary Social Sciences"', add
label define degfield2d_lbl 4008 `"Multi-disciplinary or General Science"', add
label define degfield2d_lbl 4009 `"Data Science and Data Analytics"', add
label define degfield2d_lbl 4101 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define degfield2d_lbl 4801 `"Philosophy and Religious Studies"', add
label define degfield2d_lbl 4901 `"Theology and Religious Vocations"', add
label define degfield2d_lbl 5000 `"Physical Sciences"', add
label define degfield2d_lbl 5001 `"Astronomy and Astrophysics"', add
label define degfield2d_lbl 5002 `"Atmospheric Sciences and Meteorology"', add
label define degfield2d_lbl 5003 `"Chemistry"', add
label define degfield2d_lbl 5004 `"Geology and Earth Science"', add
label define degfield2d_lbl 5005 `"Geosciences"', add
label define degfield2d_lbl 5006 `"Oceanography"', add
label define degfield2d_lbl 5007 `"Physics"', add
label define degfield2d_lbl 5008 `"Materials Science"', add
label define degfield2d_lbl 5098 `"Multi-disciplinary or General Science"', add
label define degfield2d_lbl 5102 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define degfield2d_lbl 5200 `"Psychology"', add
label define degfield2d_lbl 5201 `"Educational Psychology"', add
label define degfield2d_lbl 5202 `"Clinical Psychology"', add
label define degfield2d_lbl 5203 `"Counseling Psychology"', add
label define degfield2d_lbl 5205 `"Industrial and Organizational Psychology"', add
label define degfield2d_lbl 5206 `"Social Psychology"', add
label define degfield2d_lbl 5299 `"Miscellaneous Psychology"', add
label define degfield2d_lbl 5301 `"Criminal Justice and Fire Protection"', add
label define degfield2d_lbl 5400 `"Public Affairs, Policy, and Social Work"', add
label define degfield2d_lbl 5401 `"Public Administration"', add
label define degfield2d_lbl 5402 `"Public Policy"', add
label define degfield2d_lbl 5403 `"Human Services and Community Organization"', add
label define degfield2d_lbl 5404 `"Social Work"', add
label define degfield2d_lbl 5500 `"General Social Sciences"', add
label define degfield2d_lbl 5501 `"Economics"', add
label define degfield2d_lbl 5502 `"Anthropology and Archeology"', add
label define degfield2d_lbl 5503 `"Criminology"', add
label define degfield2d_lbl 5504 `"Geography"', add
label define degfield2d_lbl 5505 `"International Relations"', add
label define degfield2d_lbl 5506 `"Political Science and Government"', add
label define degfield2d_lbl 5507 `"Sociology"', add
label define degfield2d_lbl 5599 `"Miscellaneous Social Sciences"', add
label define degfield2d_lbl 5601 `"Construction Services"', add
label define degfield2d_lbl 5701 `"Electrical and Mechanic Repairs and Technologies"', add
label define degfield2d_lbl 5801 `"Precision Production and Industrial Arts"', add
label define degfield2d_lbl 5901 `"Transportation Sciences and Technologies"', add
label define degfield2d_lbl 6000 `"Fine Arts"', add
label define degfield2d_lbl 6001 `"Drama and Theater Arts"', add
label define degfield2d_lbl 6002 `"Music"', add
label define degfield2d_lbl 6003 `"Visual and Performing Arts"', add
label define degfield2d_lbl 6004 `"Commercial Art and Graphic Design"', add
label define degfield2d_lbl 6005 `"Film, Video and Photographic Arts"', add
label define degfield2d_lbl 6006 `"Art History and Criticism"', add
label define degfield2d_lbl 6007 `"Studio Arts"', add
label define degfield2d_lbl 6008 `"Video Game Design and Development"', add
label define degfield2d_lbl 6099 `"Miscellaneous Fine Arts"', add
label define degfield2d_lbl 6100 `"General Medical and Health Services"', add
label define degfield2d_lbl 6102 `"Communication Disorders Sciences and Services"', add
label define degfield2d_lbl 6103 `"Health and Medical Administrative Services"', add
label define degfield2d_lbl 6104 `"Medical Assisting Services"', add
label define degfield2d_lbl 6105 `"Medical Technologies Technicians"', add
label define degfield2d_lbl 6106 `"Health and Medical Preparatory Programs"', add
label define degfield2d_lbl 6107 `"Nursing"', add
label define degfield2d_lbl 6108 `"Pharmacy, Pharmaceutical Sciences, and Administration"', add
label define degfield2d_lbl 6109 `"Treatment Therapy Professions"', add
label define degfield2d_lbl 6110 `"Community and Public Health"', add
label define degfield2d_lbl 6199 `"Miscellaneous Health Medical Professions"', add
label define degfield2d_lbl 6200 `"General Business"', add
label define degfield2d_lbl 6201 `"Accounting"', add
label define degfield2d_lbl 6202 `"Actuarial Science"', add
label define degfield2d_lbl 6203 `"Business Management and Administration"', add
label define degfield2d_lbl 6204 `"Operations, Logistics and E-Commerce"', add
label define degfield2d_lbl 6205 `"Business Economics"', add
label define degfield2d_lbl 6206 `"Marketing and Marketing Research"', add
label define degfield2d_lbl 6207 `"Finance"', add
label define degfield2d_lbl 6209 `"Human Resources and Personnel Management"', add
label define degfield2d_lbl 6210 `"International Business"', add
label define degfield2d_lbl 6211 `"Hospitality Management"', add
label define degfield2d_lbl 6212 `"Management Information Systems and Statistics"', add
label define degfield2d_lbl 6299 `"Miscellaneous Business and Medical Administration"', add
label define degfield2d_lbl 6402 `"History"', add
label define degfield2d_lbl 6403 `"United States History"', add
label values degfield2d degfield2d_lbl

label define empstat_lbl 0 `"N/A"'
label define empstat_lbl 1 `"Employed"', add
label define empstat_lbl 2 `"Unemployed"', add
label define empstat_lbl 3 `"Not in labor force"', add
label define empstat_lbl 9 `"Unknown/Illegible"', add
label values empstat empstat_lbl

label define empstatd_lbl 00 `"N/A"'
label define empstatd_lbl 10 `"At work"', add
label define empstatd_lbl 11 `"At work, public emerg"', add
label define empstatd_lbl 12 `"Has job, not working"', add
label define empstatd_lbl 13 `"Armed forces"', add
label define empstatd_lbl 14 `"Armed forces--at work"', add
label define empstatd_lbl 15 `"Armed forces--not at work but with job"', add
label define empstatd_lbl 20 `"Unemployed"', add
label define empstatd_lbl 21 `"Unemp, exper worker"', add
label define empstatd_lbl 22 `"Unemp, new worker"', add
label define empstatd_lbl 30 `"Not in Labor Force"', add
label define empstatd_lbl 31 `"NILF, housework"', add
label define empstatd_lbl 32 `"NILF, unable to work"', add
label define empstatd_lbl 33 `"NILF, school"', add
label define empstatd_lbl 34 `"NILF, other"', add
label define empstatd_lbl 99 `"Unknown/Illegible"', add
label values empstatd empstatd_lbl

label define labforce_lbl 0 `"N/A"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label define labforce_lbl 9 `"Unclassifiable (employment status unknown)"', add
label values labforce labforce_lbl

label define classwkr_lbl 0 `"N/A"'
label define classwkr_lbl 1 `"Self-employed"', add
label define classwkr_lbl 2 `"Works for wages"', add
label define classwkr_lbl 9 `"Unknown"', add
label values classwkr classwkr_lbl

label define classwkrd_lbl 00 `"N/A"'
label define classwkrd_lbl 10 `"Self-employed"', add
label define classwkrd_lbl 11 `"Employer"', add
label define classwkrd_lbl 12 `"Working on own account"', add
label define classwkrd_lbl 13 `"Self-employed, not incorporated"', add
label define classwkrd_lbl 14 `"Self-employed, incorporated"', add
label define classwkrd_lbl 20 `"Works for wages"', add
label define classwkrd_lbl 21 `"Works on salary (1920)"', add
label define classwkrd_lbl 22 `"Wage/salary, private"', add
label define classwkrd_lbl 23 `"Wage/salary at non-profit"', add
label define classwkrd_lbl 24 `"Wage/salary, government"', add
label define classwkrd_lbl 25 `"Federal govt employee"', add
label define classwkrd_lbl 26 `"Armed forces"', add
label define classwkrd_lbl 27 `"State govt employee"', add
label define classwkrd_lbl 28 `"Local govt employee"', add
label define classwkrd_lbl 29 `"Unpaid family worker"', add
label define classwkrd_lbl 98 `"Illegible"', add
label define classwkrd_lbl 99 `"Unknown"', add
label values classwkrd classwkrd_lbl

label define occ_lbl 0000 `"0000"'
label define occ_lbl 0001 `"0001"', add
label define occ_lbl 0002 `"0002"', add
label define occ_lbl 0003 `"0003"', add
label define occ_lbl 0004 `"0004"', add
label define occ_lbl 0005 `"0005"', add
label define occ_lbl 0006 `"0006"', add
label define occ_lbl 0007 `"0007"', add
label define occ_lbl 0008 `"0008"', add
label define occ_lbl 0009 `"0009"', add
label define occ_lbl 0010 `"0010"', add
label define occ_lbl 0011 `"0011"', add
label define occ_lbl 0012 `"0012"', add
label define occ_lbl 0013 `"0013"', add
label define occ_lbl 0014 `"0014"', add
label define occ_lbl 0015 `"0015"', add
label define occ_lbl 0016 `"0016"', add
label define occ_lbl 0017 `"0017"', add
label define occ_lbl 0018 `"0018"', add
label define occ_lbl 0019 `"0019"', add
label define occ_lbl 0020 `"0020"', add
label define occ_lbl 0021 `"0021"', add
label define occ_lbl 0022 `"0022"', add
label define occ_lbl 0023 `"0023"', add
label define occ_lbl 0024 `"0024"', add
label define occ_lbl 0025 `"0025"', add
label define occ_lbl 0026 `"0026"', add
label define occ_lbl 0027 `"0027"', add
label define occ_lbl 0028 `"0028"', add
label define occ_lbl 0029 `"0029"', add
label define occ_lbl 0030 `"0030"', add
label define occ_lbl 0031 `"0031"', add
label define occ_lbl 0032 `"0032"', add
label define occ_lbl 0033 `"0033"', add
label define occ_lbl 0034 `"0034"', add
label define occ_lbl 0035 `"0035"', add
label define occ_lbl 0036 `"0036"', add
label define occ_lbl 0037 `"0037"', add
label define occ_lbl 0038 `"0038"', add
label define occ_lbl 0039 `"0039"', add
label define occ_lbl 0040 `"0040"', add
label define occ_lbl 0041 `"0041"', add
label define occ_lbl 0042 `"0042"', add
label define occ_lbl 0043 `"0043"', add
label define occ_lbl 0044 `"0044"', add
label define occ_lbl 0045 `"0045"', add
label define occ_lbl 0046 `"0046"', add
label define occ_lbl 0047 `"0047"', add
label define occ_lbl 0048 `"0048"', add
label define occ_lbl 0049 `"0049"', add
label define occ_lbl 0050 `"0050"', add
label define occ_lbl 0051 `"0051"', add
label define occ_lbl 0052 `"0052"', add
label define occ_lbl 0053 `"0053"', add
label define occ_lbl 0054 `"0054"', add
label define occ_lbl 0055 `"0055"', add
label define occ_lbl 0056 `"0056"', add
label define occ_lbl 0057 `"0057"', add
label define occ_lbl 0058 `"0058"', add
label define occ_lbl 0059 `"0059"', add
label define occ_lbl 0060 `"0060"', add
label define occ_lbl 0061 `"0061"', add
label define occ_lbl 0062 `"0062"', add
label define occ_lbl 0063 `"0063"', add
label define occ_lbl 0064 `"0064"', add
label define occ_lbl 0065 `"0065"', add
label define occ_lbl 0066 `"0066"', add
label define occ_lbl 0067 `"0067"', add
label define occ_lbl 0068 `"0068"', add
label define occ_lbl 0069 `"0069"', add
label define occ_lbl 0070 `"0070"', add
label define occ_lbl 0071 `"0071"', add
label define occ_lbl 0072 `"0072"', add
label define occ_lbl 0073 `"0073"', add
label define occ_lbl 0074 `"0074"', add
label define occ_lbl 0075 `"0075"', add
label define occ_lbl 0076 `"0076"', add
label define occ_lbl 0077 `"0077"', add
label define occ_lbl 0078 `"0078"', add
label define occ_lbl 0079 `"0079"', add
label define occ_lbl 0080 `"0080"', add
label define occ_lbl 0081 `"0081"', add
label define occ_lbl 0082 `"0082"', add
label define occ_lbl 0083 `"0083"', add
label define occ_lbl 0084 `"0084"', add
label define occ_lbl 0085 `"0085"', add
label define occ_lbl 0086 `"0086"', add
label define occ_lbl 0087 `"0087"', add
label define occ_lbl 0088 `"0088"', add
label define occ_lbl 0089 `"0089"', add
label define occ_lbl 0090 `"0090"', add
label define occ_lbl 0091 `"0091"', add
label define occ_lbl 0092 `"0092"', add
label define occ_lbl 0093 `"0093"', add
label define occ_lbl 0094 `"0094"', add
label define occ_lbl 0095 `"0095"', add
label define occ_lbl 0096 `"0096"', add
label define occ_lbl 0097 `"0097"', add
label define occ_lbl 0098 `"0098"', add
label define occ_lbl 0099 `"0099"', add
label define occ_lbl 0100 `"0100"', add
label define occ_lbl 0101 `"0101"', add
label define occ_lbl 0102 `"0102"', add
label define occ_lbl 0103 `"0103"', add
label define occ_lbl 0104 `"0104"', add
label define occ_lbl 0105 `"0105"', add
label define occ_lbl 0106 `"0106"', add
label define occ_lbl 0107 `"0107"', add
label define occ_lbl 0108 `"0108"', add
label define occ_lbl 0109 `"0109"', add
label define occ_lbl 0110 `"0110"', add
label define occ_lbl 0111 `"0111"', add
label define occ_lbl 0112 `"0112"', add
label define occ_lbl 0113 `"0113"', add
label define occ_lbl 0114 `"0114"', add
label define occ_lbl 0115 `"0115"', add
label define occ_lbl 0116 `"0116"', add
label define occ_lbl 0117 `"0117"', add
label define occ_lbl 0118 `"0118"', add
label define occ_lbl 0119 `"0119"', add
label define occ_lbl 0120 `"0120"', add
label define occ_lbl 0121 `"0121"', add
label define occ_lbl 0122 `"0122"', add
label define occ_lbl 0123 `"0123"', add
label define occ_lbl 0124 `"0124"', add
label define occ_lbl 0125 `"0125"', add
label define occ_lbl 0126 `"0126"', add
label define occ_lbl 0127 `"0127"', add
label define occ_lbl 0128 `"0128"', add
label define occ_lbl 0129 `"0129"', add
label define occ_lbl 0130 `"0130"', add
label define occ_lbl 0131 `"0131"', add
label define occ_lbl 0132 `"0132"', add
label define occ_lbl 0133 `"0133"', add
label define occ_lbl 0134 `"0134"', add
label define occ_lbl 0135 `"0135"', add
label define occ_lbl 0136 `"0136"', add
label define occ_lbl 0137 `"0137"', add
label define occ_lbl 0138 `"0138"', add
label define occ_lbl 0139 `"0139"', add
label define occ_lbl 0140 `"0140"', add
label define occ_lbl 0141 `"0141"', add
label define occ_lbl 0142 `"0142"', add
label define occ_lbl 0143 `"0143"', add
label define occ_lbl 0144 `"0144"', add
label define occ_lbl 0145 `"0145"', add
label define occ_lbl 0146 `"0146"', add
label define occ_lbl 0147 `"0147"', add
label define occ_lbl 0148 `"0148"', add
label define occ_lbl 0149 `"0149"', add
label define occ_lbl 0150 `"0150"', add
label define occ_lbl 0151 `"0151"', add
label define occ_lbl 0152 `"0152"', add
label define occ_lbl 0153 `"0153"', add
label define occ_lbl 0154 `"0154"', add
label define occ_lbl 0155 `"0155"', add
label define occ_lbl 0156 `"0156"', add
label define occ_lbl 0157 `"0157"', add
label define occ_lbl 0158 `"0158"', add
label define occ_lbl 0159 `"0159"', add
label define occ_lbl 0160 `"0160"', add
label define occ_lbl 0161 `"0161"', add
label define occ_lbl 0162 `"0162"', add
label define occ_lbl 0163 `"0163"', add
label define occ_lbl 0164 `"0164"', add
label define occ_lbl 0165 `"0165"', add
label define occ_lbl 0166 `"0166"', add
label define occ_lbl 0167 `"0167"', add
label define occ_lbl 0168 `"0168"', add
label define occ_lbl 0169 `"0169"', add
label define occ_lbl 0170 `"0170"', add
label define occ_lbl 0171 `"0171"', add
label define occ_lbl 0172 `"0172"', add
label define occ_lbl 0173 `"0173"', add
label define occ_lbl 0174 `"0174"', add
label define occ_lbl 0175 `"0175"', add
label define occ_lbl 0176 `"0176"', add
label define occ_lbl 0177 `"0177"', add
label define occ_lbl 0178 `"0178"', add
label define occ_lbl 0179 `"0179"', add
label define occ_lbl 0180 `"0180"', add
label define occ_lbl 0181 `"0181"', add
label define occ_lbl 0182 `"0182"', add
label define occ_lbl 0183 `"0183"', add
label define occ_lbl 0184 `"0184"', add
label define occ_lbl 0185 `"0185"', add
label define occ_lbl 0186 `"0186"', add
label define occ_lbl 0187 `"0187"', add
label define occ_lbl 0188 `"0188"', add
label define occ_lbl 0189 `"0189"', add
label define occ_lbl 0190 `"0190"', add
label define occ_lbl 0191 `"0191"', add
label define occ_lbl 0192 `"0192"', add
label define occ_lbl 0193 `"0193"', add
label define occ_lbl 0194 `"0194"', add
label define occ_lbl 0195 `"0195"', add
label define occ_lbl 0196 `"0196"', add
label define occ_lbl 0197 `"0197"', add
label define occ_lbl 0198 `"0198"', add
label define occ_lbl 0199 `"0199"', add
label define occ_lbl 0200 `"0200"', add
label define occ_lbl 0201 `"0201"', add
label define occ_lbl 0202 `"0202"', add
label define occ_lbl 0203 `"0203"', add
label define occ_lbl 0204 `"0204"', add
label define occ_lbl 0205 `"0205"', add
label define occ_lbl 0206 `"0206"', add
label define occ_lbl 0207 `"0207"', add
label define occ_lbl 0208 `"0208"', add
label define occ_lbl 0209 `"0209"', add
label define occ_lbl 0210 `"0210"', add
label define occ_lbl 0211 `"0211"', add
label define occ_lbl 0212 `"0212"', add
label define occ_lbl 0213 `"0213"', add
label define occ_lbl 0214 `"0214"', add
label define occ_lbl 0215 `"0215"', add
label define occ_lbl 0216 `"0216"', add
label define occ_lbl 0217 `"0217"', add
label define occ_lbl 0218 `"0218"', add
label define occ_lbl 0219 `"0219"', add
label define occ_lbl 0220 `"0220"', add
label define occ_lbl 0221 `"0221"', add
label define occ_lbl 0222 `"0222"', add
label define occ_lbl 0223 `"0223"', add
label define occ_lbl 0224 `"0224"', add
label define occ_lbl 0225 `"0225"', add
label define occ_lbl 0226 `"0226"', add
label define occ_lbl 0227 `"0227"', add
label define occ_lbl 0228 `"0228"', add
label define occ_lbl 0229 `"0229"', add
label define occ_lbl 0230 `"0230"', add
label define occ_lbl 0231 `"0231"', add
label define occ_lbl 0232 `"0232"', add
label define occ_lbl 0233 `"0233"', add
label define occ_lbl 0234 `"0234"', add
label define occ_lbl 0235 `"0235"', add
label define occ_lbl 0236 `"0236"', add
label define occ_lbl 0237 `"0237"', add
label define occ_lbl 0238 `"0238"', add
label define occ_lbl 0239 `"0239"', add
label define occ_lbl 0240 `"0240"', add
label define occ_lbl 0241 `"0241"', add
label define occ_lbl 0242 `"0242"', add
label define occ_lbl 0243 `"0243"', add
label define occ_lbl 0244 `"0244"', add
label define occ_lbl 0245 `"0245"', add
label define occ_lbl 0246 `"0246"', add
label define occ_lbl 0247 `"0247"', add
label define occ_lbl 0248 `"0248"', add
label define occ_lbl 0249 `"0249"', add
label define occ_lbl 0250 `"0250"', add
label define occ_lbl 0251 `"0251"', add
label define occ_lbl 0252 `"0252"', add
label define occ_lbl 0253 `"0253"', add
label define occ_lbl 0254 `"0254"', add
label define occ_lbl 0255 `"0255"', add
label define occ_lbl 0256 `"0256"', add
label define occ_lbl 0257 `"0257"', add
label define occ_lbl 0258 `"0258"', add
label define occ_lbl 0259 `"0259"', add
label define occ_lbl 0260 `"0260"', add
label define occ_lbl 0261 `"0261"', add
label define occ_lbl 0262 `"0262"', add
label define occ_lbl 0263 `"0263"', add
label define occ_lbl 0264 `"0264"', add
label define occ_lbl 0265 `"0265"', add
label define occ_lbl 0266 `"0266"', add
label define occ_lbl 0267 `"0267"', add
label define occ_lbl 0268 `"0268"', add
label define occ_lbl 0269 `"0269"', add
label define occ_lbl 0270 `"0270"', add
label define occ_lbl 0271 `"0271"', add
label define occ_lbl 0272 `"0272"', add
label define occ_lbl 0273 `"0273"', add
label define occ_lbl 0274 `"0274"', add
label define occ_lbl 0275 `"0275"', add
label define occ_lbl 0276 `"0276"', add
label define occ_lbl 0277 `"0277"', add
label define occ_lbl 0278 `"0278"', add
label define occ_lbl 0279 `"0279"', add
label define occ_lbl 0280 `"0280"', add
label define occ_lbl 0281 `"0281"', add
label define occ_lbl 0282 `"0282"', add
label define occ_lbl 0283 `"0283"', add
label define occ_lbl 0284 `"0284"', add
label define occ_lbl 0285 `"0285"', add
label define occ_lbl 0286 `"0286"', add
label define occ_lbl 0287 `"0287"', add
label define occ_lbl 0288 `"0288"', add
label define occ_lbl 0289 `"0289"', add
label define occ_lbl 0290 `"0290"', add
label define occ_lbl 0291 `"0291"', add
label define occ_lbl 0292 `"0292"', add
label define occ_lbl 0293 `"0293"', add
label define occ_lbl 0294 `"0294"', add
label define occ_lbl 0295 `"0295"', add
label define occ_lbl 0296 `"0296"', add
label define occ_lbl 0297 `"0297"', add
label define occ_lbl 0298 `"0298"', add
label define occ_lbl 0299 `"0299"', add
label define occ_lbl 0300 `"0300"', add
label define occ_lbl 0301 `"0301"', add
label define occ_lbl 0302 `"0302"', add
label define occ_lbl 0303 `"0303"', add
label define occ_lbl 0304 `"0304"', add
label define occ_lbl 0305 `"0305"', add
label define occ_lbl 0306 `"0306"', add
label define occ_lbl 0307 `"0307"', add
label define occ_lbl 0308 `"0308"', add
label define occ_lbl 0309 `"0309"', add
label define occ_lbl 0310 `"0310"', add
label define occ_lbl 0311 `"0311"', add
label define occ_lbl 0312 `"0312"', add
label define occ_lbl 0313 `"0313"', add
label define occ_lbl 0314 `"0314"', add
label define occ_lbl 0315 `"0315"', add
label define occ_lbl 0316 `"0316"', add
label define occ_lbl 0317 `"0317"', add
label define occ_lbl 0318 `"0318"', add
label define occ_lbl 0319 `"0319"', add
label define occ_lbl 0320 `"0320"', add
label define occ_lbl 0321 `"0321"', add
label define occ_lbl 0322 `"0322"', add
label define occ_lbl 0323 `"0323"', add
label define occ_lbl 0324 `"0324"', add
label define occ_lbl 0325 `"0325"', add
label define occ_lbl 0326 `"0326"', add
label define occ_lbl 0327 `"0327"', add
label define occ_lbl 0328 `"0328"', add
label define occ_lbl 0329 `"0329"', add
label define occ_lbl 0330 `"0330"', add
label define occ_lbl 0331 `"0331"', add
label define occ_lbl 0332 `"0332"', add
label define occ_lbl 0333 `"0333"', add
label define occ_lbl 0334 `"0334"', add
label define occ_lbl 0335 `"0335"', add
label define occ_lbl 0336 `"0336"', add
label define occ_lbl 0337 `"0337"', add
label define occ_lbl 0338 `"0338"', add
label define occ_lbl 0339 `"0339"', add
label define occ_lbl 0340 `"0340"', add
label define occ_lbl 0341 `"0341"', add
label define occ_lbl 0342 `"0342"', add
label define occ_lbl 0343 `"0343"', add
label define occ_lbl 0344 `"0344"', add
label define occ_lbl 0345 `"0345"', add
label define occ_lbl 0346 `"0346"', add
label define occ_lbl 0347 `"0347"', add
label define occ_lbl 0348 `"0348"', add
label define occ_lbl 0349 `"0349"', add
label define occ_lbl 0350 `"0350"', add
label define occ_lbl 0351 `"0351"', add
label define occ_lbl 0352 `"0352"', add
label define occ_lbl 0353 `"0353"', add
label define occ_lbl 0354 `"0354"', add
label define occ_lbl 0355 `"0355"', add
label define occ_lbl 0356 `"0356"', add
label define occ_lbl 0357 `"0357"', add
label define occ_lbl 0358 `"0358"', add
label define occ_lbl 0359 `"0359"', add
label define occ_lbl 0360 `"0360"', add
label define occ_lbl 0361 `"0361"', add
label define occ_lbl 0362 `"0362"', add
label define occ_lbl 0363 `"0363"', add
label define occ_lbl 0364 `"0364"', add
label define occ_lbl 0365 `"0365"', add
label define occ_lbl 0366 `"0366"', add
label define occ_lbl 0367 `"0367"', add
label define occ_lbl 0368 `"0368"', add
label define occ_lbl 0369 `"0369"', add
label define occ_lbl 0370 `"0370"', add
label define occ_lbl 0371 `"0371"', add
label define occ_lbl 0372 `"0372"', add
label define occ_lbl 0373 `"0373"', add
label define occ_lbl 0374 `"0374"', add
label define occ_lbl 0375 `"0375"', add
label define occ_lbl 0376 `"0376"', add
label define occ_lbl 0377 `"0377"', add
label define occ_lbl 0378 `"0378"', add
label define occ_lbl 0379 `"0379"', add
label define occ_lbl 0380 `"0380"', add
label define occ_lbl 0381 `"0381"', add
label define occ_lbl 0382 `"0382"', add
label define occ_lbl 0383 `"0383"', add
label define occ_lbl 0384 `"0384"', add
label define occ_lbl 0385 `"0385"', add
label define occ_lbl 0386 `"0386"', add
label define occ_lbl 0387 `"0387"', add
label define occ_lbl 0388 `"0388"', add
label define occ_lbl 0389 `"0389"', add
label define occ_lbl 0390 `"0390"', add
label define occ_lbl 0391 `"0391"', add
label define occ_lbl 0392 `"0392"', add
label define occ_lbl 0393 `"0393"', add
label define occ_lbl 0394 `"0394"', add
label define occ_lbl 0395 `"0395"', add
label define occ_lbl 0396 `"0396"', add
label define occ_lbl 0397 `"0397"', add
label define occ_lbl 0398 `"0398"', add
label define occ_lbl 0399 `"0399"', add
label define occ_lbl 0400 `"0400"', add
label define occ_lbl 0401 `"0401"', add
label define occ_lbl 0402 `"0402"', add
label define occ_lbl 0403 `"0403"', add
label define occ_lbl 0404 `"0404"', add
label define occ_lbl 0405 `"0405"', add
label define occ_lbl 0406 `"0406"', add
label define occ_lbl 0407 `"0407"', add
label define occ_lbl 0408 `"0408"', add
label define occ_lbl 0409 `"0409"', add
label define occ_lbl 0410 `"0410"', add
label define occ_lbl 0411 `"0411"', add
label define occ_lbl 0412 `"0412"', add
label define occ_lbl 0413 `"0413"', add
label define occ_lbl 0414 `"0414"', add
label define occ_lbl 0415 `"0415"', add
label define occ_lbl 0416 `"0416"', add
label define occ_lbl 0417 `"0417"', add
label define occ_lbl 0418 `"0418"', add
label define occ_lbl 0419 `"0419"', add
label define occ_lbl 0420 `"0420"', add
label define occ_lbl 0421 `"0421"', add
label define occ_lbl 0422 `"0422"', add
label define occ_lbl 0423 `"0423"', add
label define occ_lbl 0424 `"0424"', add
label define occ_lbl 0425 `"0425"', add
label define occ_lbl 0426 `"0426"', add
label define occ_lbl 0427 `"0427"', add
label define occ_lbl 0428 `"0428"', add
label define occ_lbl 0429 `"0429"', add
label define occ_lbl 0430 `"0430"', add
label define occ_lbl 0431 `"0431"', add
label define occ_lbl 0432 `"0432"', add
label define occ_lbl 0433 `"0433"', add
label define occ_lbl 0434 `"0434"', add
label define occ_lbl 0435 `"0435"', add
label define occ_lbl 0436 `"0436"', add
label define occ_lbl 0437 `"0437"', add
label define occ_lbl 0438 `"0438"', add
label define occ_lbl 0439 `"0439"', add
label define occ_lbl 0440 `"0440"', add
label define occ_lbl 0441 `"0441"', add
label define occ_lbl 0442 `"0442"', add
label define occ_lbl 0443 `"0443"', add
label define occ_lbl 0444 `"0444"', add
label define occ_lbl 0445 `"0445"', add
label define occ_lbl 0446 `"0446"', add
label define occ_lbl 0447 `"0447"', add
label define occ_lbl 0448 `"0448"', add
label define occ_lbl 0449 `"0449"', add
label define occ_lbl 0450 `"0450"', add
label define occ_lbl 0451 `"0451"', add
label define occ_lbl 0452 `"0452"', add
label define occ_lbl 0453 `"0453"', add
label define occ_lbl 0454 `"0454"', add
label define occ_lbl 0455 `"0455"', add
label define occ_lbl 0456 `"0456"', add
label define occ_lbl 0457 `"0457"', add
label define occ_lbl 0458 `"0458"', add
label define occ_lbl 0459 `"0459"', add
label define occ_lbl 0460 `"0460"', add
label define occ_lbl 0461 `"0461"', add
label define occ_lbl 0462 `"0462"', add
label define occ_lbl 0463 `"0463"', add
label define occ_lbl 0464 `"0464"', add
label define occ_lbl 0465 `"0465"', add
label define occ_lbl 0466 `"0466"', add
label define occ_lbl 0467 `"0467"', add
label define occ_lbl 0468 `"0468"', add
label define occ_lbl 0469 `"0469"', add
label define occ_lbl 0470 `"0470"', add
label define occ_lbl 0471 `"0471"', add
label define occ_lbl 0472 `"0472"', add
label define occ_lbl 0473 `"0473"', add
label define occ_lbl 0474 `"0474"', add
label define occ_lbl 0475 `"0475"', add
label define occ_lbl 0476 `"0476"', add
label define occ_lbl 0477 `"0477"', add
label define occ_lbl 0478 `"0478"', add
label define occ_lbl 0479 `"0479"', add
label define occ_lbl 0480 `"0480"', add
label define occ_lbl 0481 `"0481"', add
label define occ_lbl 0482 `"0482"', add
label define occ_lbl 0483 `"0483"', add
label define occ_lbl 0484 `"0484"', add
label define occ_lbl 0485 `"0485"', add
label define occ_lbl 0486 `"0486"', add
label define occ_lbl 0487 `"0487"', add
label define occ_lbl 0488 `"0488"', add
label define occ_lbl 0489 `"0489"', add
label define occ_lbl 0490 `"0490"', add
label define occ_lbl 0491 `"0491"', add
label define occ_lbl 0492 `"0492"', add
label define occ_lbl 0493 `"0493"', add
label define occ_lbl 0494 `"0494"', add
label define occ_lbl 0495 `"0495"', add
label define occ_lbl 0496 `"0496"', add
label define occ_lbl 0497 `"0497"', add
label define occ_lbl 0498 `"0498"', add
label define occ_lbl 0499 `"0499"', add
label define occ_lbl 0500 `"0500"', add
label define occ_lbl 0501 `"0501"', add
label define occ_lbl 0502 `"0502"', add
label define occ_lbl 0503 `"0503"', add
label define occ_lbl 0504 `"0504"', add
label define occ_lbl 0505 `"0505"', add
label define occ_lbl 0506 `"0506"', add
label define occ_lbl 0507 `"0507"', add
label define occ_lbl 0508 `"0508"', add
label define occ_lbl 0509 `"0509"', add
label define occ_lbl 0510 `"0510"', add
label define occ_lbl 0511 `"0511"', add
label define occ_lbl 0512 `"0512"', add
label define occ_lbl 0513 `"0513"', add
label define occ_lbl 0514 `"0514"', add
label define occ_lbl 0515 `"0515"', add
label define occ_lbl 0516 `"0516"', add
label define occ_lbl 0517 `"0517"', add
label define occ_lbl 0518 `"0518"', add
label define occ_lbl 0519 `"0519"', add
label define occ_lbl 0520 `"0520"', add
label define occ_lbl 0521 `"0521"', add
label define occ_lbl 0522 `"0522"', add
label define occ_lbl 0523 `"0523"', add
label define occ_lbl 0524 `"0524"', add
label define occ_lbl 0525 `"0525"', add
label define occ_lbl 0526 `"0526"', add
label define occ_lbl 0527 `"0527"', add
label define occ_lbl 0528 `"0528"', add
label define occ_lbl 0529 `"0529"', add
label define occ_lbl 0530 `"0530"', add
label define occ_lbl 0531 `"0531"', add
label define occ_lbl 0532 `"0532"', add
label define occ_lbl 0533 `"0533"', add
label define occ_lbl 0534 `"0534"', add
label define occ_lbl 0535 `"0535"', add
label define occ_lbl 0536 `"0536"', add
label define occ_lbl 0537 `"0537"', add
label define occ_lbl 0538 `"0538"', add
label define occ_lbl 0539 `"0539"', add
label define occ_lbl 0540 `"0540"', add
label define occ_lbl 0541 `"0541"', add
label define occ_lbl 0542 `"0542"', add
label define occ_lbl 0543 `"0543"', add
label define occ_lbl 0544 `"0544"', add
label define occ_lbl 0545 `"0545"', add
label define occ_lbl 0546 `"0546"', add
label define occ_lbl 0547 `"0547"', add
label define occ_lbl 0548 `"0548"', add
label define occ_lbl 0549 `"0549"', add
label define occ_lbl 0550 `"0550"', add
label define occ_lbl 0551 `"0551"', add
label define occ_lbl 0552 `"0552"', add
label define occ_lbl 0553 `"0553"', add
label define occ_lbl 0554 `"0554"', add
label define occ_lbl 0555 `"0555"', add
label define occ_lbl 0556 `"0556"', add
label define occ_lbl 0557 `"0557"', add
label define occ_lbl 0558 `"0558"', add
label define occ_lbl 0559 `"0559"', add
label define occ_lbl 0560 `"0560"', add
label define occ_lbl 0561 `"0561"', add
label define occ_lbl 0562 `"0562"', add
label define occ_lbl 0563 `"0563"', add
label define occ_lbl 0564 `"0564"', add
label define occ_lbl 0565 `"0565"', add
label define occ_lbl 0566 `"0566"', add
label define occ_lbl 0567 `"0567"', add
label define occ_lbl 0568 `"0568"', add
label define occ_lbl 0569 `"0569"', add
label define occ_lbl 0570 `"0570"', add
label define occ_lbl 0571 `"0571"', add
label define occ_lbl 0572 `"0572"', add
label define occ_lbl 0573 `"0573"', add
label define occ_lbl 0574 `"0574"', add
label define occ_lbl 0575 `"0575"', add
label define occ_lbl 0576 `"0576"', add
label define occ_lbl 0577 `"0577"', add
label define occ_lbl 0578 `"0578"', add
label define occ_lbl 0579 `"0579"', add
label define occ_lbl 0580 `"0580"', add
label define occ_lbl 0581 `"0581"', add
label define occ_lbl 0582 `"0582"', add
label define occ_lbl 0583 `"0583"', add
label define occ_lbl 0584 `"0584"', add
label define occ_lbl 0585 `"0585"', add
label define occ_lbl 0586 `"0586"', add
label define occ_lbl 0587 `"0587"', add
label define occ_lbl 0588 `"0588"', add
label define occ_lbl 0589 `"0589"', add
label define occ_lbl 0590 `"0590"', add
label define occ_lbl 0591 `"0591"', add
label define occ_lbl 0592 `"0592"', add
label define occ_lbl 0593 `"0593"', add
label define occ_lbl 0594 `"0594"', add
label define occ_lbl 0595 `"0595"', add
label define occ_lbl 0596 `"0596"', add
label define occ_lbl 0597 `"0597"', add
label define occ_lbl 0598 `"0598"', add
label define occ_lbl 0599 `"0599"', add
label define occ_lbl 0600 `"0600"', add
label define occ_lbl 0601 `"0601"', add
label define occ_lbl 0602 `"0602"', add
label define occ_lbl 0603 `"0603"', add
label define occ_lbl 0604 `"0604"', add
label define occ_lbl 0605 `"0605"', add
label define occ_lbl 0606 `"0606"', add
label define occ_lbl 0607 `"0607"', add
label define occ_lbl 0608 `"0608"', add
label define occ_lbl 0609 `"0609"', add
label define occ_lbl 0610 `"0610"', add
label define occ_lbl 0611 `"0611"', add
label define occ_lbl 0612 `"0612"', add
label define occ_lbl 0613 `"0613"', add
label define occ_lbl 0614 `"0614"', add
label define occ_lbl 0615 `"0615"', add
label define occ_lbl 0616 `"0616"', add
label define occ_lbl 0617 `"0617"', add
label define occ_lbl 0618 `"0618"', add
label define occ_lbl 0619 `"0619"', add
label define occ_lbl 0620 `"0620"', add
label define occ_lbl 0621 `"0621"', add
label define occ_lbl 0622 `"0622"', add
label define occ_lbl 0623 `"0623"', add
label define occ_lbl 0624 `"0624"', add
label define occ_lbl 0625 `"0625"', add
label define occ_lbl 0626 `"0626"', add
label define occ_lbl 0627 `"0627"', add
label define occ_lbl 0628 `"0628"', add
label define occ_lbl 0629 `"0629"', add
label define occ_lbl 0630 `"0630"', add
label define occ_lbl 0631 `"0631"', add
label define occ_lbl 0632 `"0632"', add
label define occ_lbl 0633 `"0633"', add
label define occ_lbl 0634 `"0634"', add
label define occ_lbl 0635 `"0635"', add
label define occ_lbl 0636 `"0636"', add
label define occ_lbl 0637 `"0637"', add
label define occ_lbl 0638 `"0638"', add
label define occ_lbl 0639 `"0639"', add
label define occ_lbl 0640 `"0640"', add
label define occ_lbl 0641 `"0641"', add
label define occ_lbl 0642 `"0642"', add
label define occ_lbl 0643 `"0643"', add
label define occ_lbl 0644 `"0644"', add
label define occ_lbl 0645 `"0645"', add
label define occ_lbl 0646 `"0646"', add
label define occ_lbl 0647 `"0647"', add
label define occ_lbl 0648 `"0648"', add
label define occ_lbl 0649 `"0649"', add
label define occ_lbl 0650 `"0650"', add
label define occ_lbl 0651 `"0651"', add
label define occ_lbl 0652 `"0652"', add
label define occ_lbl 0653 `"0653"', add
label define occ_lbl 0654 `"0654"', add
label define occ_lbl 0655 `"0655"', add
label define occ_lbl 0656 `"0656"', add
label define occ_lbl 0657 `"0657"', add
label define occ_lbl 0658 `"0658"', add
label define occ_lbl 0659 `"0659"', add
label define occ_lbl 0660 `"0660"', add
label define occ_lbl 0661 `"0661"', add
label define occ_lbl 0662 `"0662"', add
label define occ_lbl 0663 `"0663"', add
label define occ_lbl 0664 `"0664"', add
label define occ_lbl 0665 `"0665"', add
label define occ_lbl 0666 `"0666"', add
label define occ_lbl 0667 `"0667"', add
label define occ_lbl 0668 `"0668"', add
label define occ_lbl 0669 `"0669"', add
label define occ_lbl 0670 `"0670"', add
label define occ_lbl 0671 `"0671"', add
label define occ_lbl 0672 `"0672"', add
label define occ_lbl 0673 `"0673"', add
label define occ_lbl 0674 `"0674"', add
label define occ_lbl 0675 `"0675"', add
label define occ_lbl 0676 `"0676"', add
label define occ_lbl 0677 `"0677"', add
label define occ_lbl 0678 `"0678"', add
label define occ_lbl 0679 `"0679"', add
label define occ_lbl 0680 `"0680"', add
label define occ_lbl 0681 `"0681"', add
label define occ_lbl 0682 `"0682"', add
label define occ_lbl 0683 `"0683"', add
label define occ_lbl 0684 `"0684"', add
label define occ_lbl 0685 `"0685"', add
label define occ_lbl 0686 `"0686"', add
label define occ_lbl 0687 `"0687"', add
label define occ_lbl 0688 `"0688"', add
label define occ_lbl 0689 `"0689"', add
label define occ_lbl 0690 `"0690"', add
label define occ_lbl 0691 `"0691"', add
label define occ_lbl 0692 `"0692"', add
label define occ_lbl 0693 `"0693"', add
label define occ_lbl 0694 `"0694"', add
label define occ_lbl 0695 `"0695"', add
label define occ_lbl 0696 `"0696"', add
label define occ_lbl 0697 `"0697"', add
label define occ_lbl 0698 `"0698"', add
label define occ_lbl 0699 `"0699"', add
label define occ_lbl 0700 `"0700"', add
label define occ_lbl 0701 `"0701"', add
label define occ_lbl 0702 `"0702"', add
label define occ_lbl 0703 `"0703"', add
label define occ_lbl 0704 `"0704"', add
label define occ_lbl 0705 `"0705"', add
label define occ_lbl 0706 `"0706"', add
label define occ_lbl 0707 `"0707"', add
label define occ_lbl 0708 `"0708"', add
label define occ_lbl 0709 `"0709"', add
label define occ_lbl 0710 `"0710"', add
label define occ_lbl 0711 `"0711"', add
label define occ_lbl 0712 `"0712"', add
label define occ_lbl 0713 `"0713"', add
label define occ_lbl 0714 `"0714"', add
label define occ_lbl 0715 `"0715"', add
label define occ_lbl 0716 `"0716"', add
label define occ_lbl 0717 `"0717"', add
label define occ_lbl 0718 `"0718"', add
label define occ_lbl 0719 `"0719"', add
label define occ_lbl 0720 `"0720"', add
label define occ_lbl 0721 `"0721"', add
label define occ_lbl 0722 `"0722"', add
label define occ_lbl 0723 `"0723"', add
label define occ_lbl 0724 `"0724"', add
label define occ_lbl 0725 `"0725"', add
label define occ_lbl 0726 `"0726"', add
label define occ_lbl 0727 `"0727"', add
label define occ_lbl 0728 `"0728"', add
label define occ_lbl 0729 `"0729"', add
label define occ_lbl 0730 `"0730"', add
label define occ_lbl 0731 `"0731"', add
label define occ_lbl 0732 `"0732"', add
label define occ_lbl 0733 `"0733"', add
label define occ_lbl 0734 `"0734"', add
label define occ_lbl 0735 `"0735"', add
label define occ_lbl 0736 `"0736"', add
label define occ_lbl 0737 `"0737"', add
label define occ_lbl 0738 `"0738"', add
label define occ_lbl 0739 `"0739"', add
label define occ_lbl 0740 `"0740"', add
label define occ_lbl 0741 `"0741"', add
label define occ_lbl 0742 `"0742"', add
label define occ_lbl 0743 `"0743"', add
label define occ_lbl 0744 `"0744"', add
label define occ_lbl 0745 `"0745"', add
label define occ_lbl 0746 `"0746"', add
label define occ_lbl 0747 `"0747"', add
label define occ_lbl 0748 `"0748"', add
label define occ_lbl 0749 `"0749"', add
label define occ_lbl 0750 `"0750"', add
label define occ_lbl 0751 `"0751"', add
label define occ_lbl 0752 `"0752"', add
label define occ_lbl 0753 `"0753"', add
label define occ_lbl 0754 `"0754"', add
label define occ_lbl 0755 `"0755"', add
label define occ_lbl 0756 `"0756"', add
label define occ_lbl 0757 `"0757"', add
label define occ_lbl 0758 `"0758"', add
label define occ_lbl 0759 `"0759"', add
label define occ_lbl 0760 `"0760"', add
label define occ_lbl 0761 `"0761"', add
label define occ_lbl 0762 `"0762"', add
label define occ_lbl 0763 `"0763"', add
label define occ_lbl 0764 `"0764"', add
label define occ_lbl 0765 `"0765"', add
label define occ_lbl 0766 `"0766"', add
label define occ_lbl 0767 `"0767"', add
label define occ_lbl 0768 `"0768"', add
label define occ_lbl 0769 `"0769"', add
label define occ_lbl 0770 `"0770"', add
label define occ_lbl 0771 `"0771"', add
label define occ_lbl 0772 `"0772"', add
label define occ_lbl 0773 `"0773"', add
label define occ_lbl 0774 `"0774"', add
label define occ_lbl 0775 `"0775"', add
label define occ_lbl 0776 `"0776"', add
label define occ_lbl 0777 `"0777"', add
label define occ_lbl 0778 `"0778"', add
label define occ_lbl 0779 `"0779"', add
label define occ_lbl 0780 `"0780"', add
label define occ_lbl 0781 `"0781"', add
label define occ_lbl 0782 `"0782"', add
label define occ_lbl 0783 `"0783"', add
label define occ_lbl 0784 `"0784"', add
label define occ_lbl 0785 `"0785"', add
label define occ_lbl 0786 `"0786"', add
label define occ_lbl 0787 `"0787"', add
label define occ_lbl 0788 `"0788"', add
label define occ_lbl 0789 `"0789"', add
label define occ_lbl 0790 `"0790"', add
label define occ_lbl 0791 `"0791"', add
label define occ_lbl 0792 `"0792"', add
label define occ_lbl 0793 `"0793"', add
label define occ_lbl 0794 `"0794"', add
label define occ_lbl 0795 `"0795"', add
label define occ_lbl 0796 `"0796"', add
label define occ_lbl 0797 `"0797"', add
label define occ_lbl 0798 `"0798"', add
label define occ_lbl 0799 `"0799"', add
label define occ_lbl 0800 `"0800"', add
label define occ_lbl 0801 `"0801"', add
label define occ_lbl 0802 `"0802"', add
label define occ_lbl 0803 `"0803"', add
label define occ_lbl 0804 `"0804"', add
label define occ_lbl 0805 `"0805"', add
label define occ_lbl 0806 `"0806"', add
label define occ_lbl 0807 `"0807"', add
label define occ_lbl 0808 `"0808"', add
label define occ_lbl 0809 `"0809"', add
label define occ_lbl 0810 `"0810"', add
label define occ_lbl 0811 `"0811"', add
label define occ_lbl 0812 `"0812"', add
label define occ_lbl 0813 `"0813"', add
label define occ_lbl 0814 `"0814"', add
label define occ_lbl 0815 `"0815"', add
label define occ_lbl 0816 `"0816"', add
label define occ_lbl 0817 `"0817"', add
label define occ_lbl 0818 `"0818"', add
label define occ_lbl 0819 `"0819"', add
label define occ_lbl 0820 `"0820"', add
label define occ_lbl 0821 `"0821"', add
label define occ_lbl 0822 `"0822"', add
label define occ_lbl 0823 `"0823"', add
label define occ_lbl 0824 `"0824"', add
label define occ_lbl 0825 `"0825"', add
label define occ_lbl 0826 `"0826"', add
label define occ_lbl 0827 `"0827"', add
label define occ_lbl 0828 `"0828"', add
label define occ_lbl 0829 `"0829"', add
label define occ_lbl 0830 `"0830"', add
label define occ_lbl 0831 `"0831"', add
label define occ_lbl 0832 `"0832"', add
label define occ_lbl 0833 `"0833"', add
label define occ_lbl 0834 `"0834"', add
label define occ_lbl 0835 `"0835"', add
label define occ_lbl 0836 `"0836"', add
label define occ_lbl 0837 `"0837"', add
label define occ_lbl 0838 `"0838"', add
label define occ_lbl 0839 `"0839"', add
label define occ_lbl 0840 `"0840"', add
label define occ_lbl 0841 `"0841"', add
label define occ_lbl 0842 `"0842"', add
label define occ_lbl 0843 `"0843"', add
label define occ_lbl 0844 `"0844"', add
label define occ_lbl 0845 `"0845"', add
label define occ_lbl 0846 `"0846"', add
label define occ_lbl 0847 `"0847"', add
label define occ_lbl 0848 `"0848"', add
label define occ_lbl 0849 `"0849"', add
label define occ_lbl 0850 `"0850"', add
label define occ_lbl 0851 `"0851"', add
label define occ_lbl 0852 `"0852"', add
label define occ_lbl 0853 `"0853"', add
label define occ_lbl 0854 `"0854"', add
label define occ_lbl 0855 `"0855"', add
label define occ_lbl 0856 `"0856"', add
label define occ_lbl 0857 `"0857"', add
label define occ_lbl 0858 `"0858"', add
label define occ_lbl 0859 `"0859"', add
label define occ_lbl 0860 `"0860"', add
label define occ_lbl 0861 `"0861"', add
label define occ_lbl 0862 `"0862"', add
label define occ_lbl 0863 `"0863"', add
label define occ_lbl 0864 `"0864"', add
label define occ_lbl 0865 `"0865"', add
label define occ_lbl 0866 `"0866"', add
label define occ_lbl 0867 `"0867"', add
label define occ_lbl 0868 `"0868"', add
label define occ_lbl 0869 `"0869"', add
label define occ_lbl 0870 `"0870"', add
label define occ_lbl 0871 `"0871"', add
label define occ_lbl 0872 `"0872"', add
label define occ_lbl 0873 `"0873"', add
label define occ_lbl 0874 `"0874"', add
label define occ_lbl 0875 `"0875"', add
label define occ_lbl 0876 `"0876"', add
label define occ_lbl 0877 `"0877"', add
label define occ_lbl 0878 `"0878"', add
label define occ_lbl 0879 `"0879"', add
label define occ_lbl 0880 `"0880"', add
label define occ_lbl 0881 `"0881"', add
label define occ_lbl 0882 `"0882"', add
label define occ_lbl 0883 `"0883"', add
label define occ_lbl 0884 `"0884"', add
label define occ_lbl 0885 `"0885"', add
label define occ_lbl 0886 `"0886"', add
label define occ_lbl 0887 `"0887"', add
label define occ_lbl 0888 `"0888"', add
label define occ_lbl 0889 `"0889"', add
label define occ_lbl 0890 `"0890"', add
label define occ_lbl 0891 `"0891"', add
label define occ_lbl 0892 `"0892"', add
label define occ_lbl 0893 `"0893"', add
label define occ_lbl 0894 `"0894"', add
label define occ_lbl 0895 `"0895"', add
label define occ_lbl 0896 `"0896"', add
label define occ_lbl 0897 `"0897"', add
label define occ_lbl 0898 `"0898"', add
label define occ_lbl 0899 `"0899"', add
label define occ_lbl 0900 `"0900"', add
label define occ_lbl 0901 `"0901"', add
label define occ_lbl 0902 `"0902"', add
label define occ_lbl 0903 `"0903"', add
label define occ_lbl 0904 `"0904"', add
label define occ_lbl 0905 `"0905"', add
label define occ_lbl 0906 `"0906"', add
label define occ_lbl 0907 `"0907"', add
label define occ_lbl 0908 `"0908"', add
label define occ_lbl 0909 `"0909"', add
label define occ_lbl 0910 `"0910"', add
label define occ_lbl 0911 `"0911"', add
label define occ_lbl 0912 `"0912"', add
label define occ_lbl 0913 `"0913"', add
label define occ_lbl 0914 `"0914"', add
label define occ_lbl 0915 `"0915"', add
label define occ_lbl 0916 `"0916"', add
label define occ_lbl 0917 `"0917"', add
label define occ_lbl 0918 `"0918"', add
label define occ_lbl 0919 `"0919"', add
label define occ_lbl 0920 `"0920"', add
label define occ_lbl 0921 `"0921"', add
label define occ_lbl 0922 `"0922"', add
label define occ_lbl 0923 `"0923"', add
label define occ_lbl 0924 `"0924"', add
label define occ_lbl 0925 `"0925"', add
label define occ_lbl 0926 `"0926"', add
label define occ_lbl 0927 `"0927"', add
label define occ_lbl 0928 `"0928"', add
label define occ_lbl 0929 `"0929"', add
label define occ_lbl 0930 `"0930"', add
label define occ_lbl 0931 `"0931"', add
label define occ_lbl 0932 `"0932"', add
label define occ_lbl 0933 `"0933"', add
label define occ_lbl 0934 `"0934"', add
label define occ_lbl 0935 `"0935"', add
label define occ_lbl 0936 `"0936"', add
label define occ_lbl 0937 `"0937"', add
label define occ_lbl 0938 `"0938"', add
label define occ_lbl 0939 `"0939"', add
label define occ_lbl 0940 `"0940"', add
label define occ_lbl 0941 `"0941"', add
label define occ_lbl 0942 `"0942"', add
label define occ_lbl 0943 `"0943"', add
label define occ_lbl 0944 `"0944"', add
label define occ_lbl 0945 `"0945"', add
label define occ_lbl 0946 `"0946"', add
label define occ_lbl 0947 `"0947"', add
label define occ_lbl 0948 `"0948"', add
label define occ_lbl 0949 `"0949"', add
label define occ_lbl 0950 `"0950"', add
label define occ_lbl 0951 `"0951"', add
label define occ_lbl 0952 `"0952"', add
label define occ_lbl 0953 `"0953"', add
label define occ_lbl 0954 `"0954"', add
label define occ_lbl 0955 `"0955"', add
label define occ_lbl 0956 `"0956"', add
label define occ_lbl 0957 `"0957"', add
label define occ_lbl 0958 `"0958"', add
label define occ_lbl 0959 `"0959"', add
label define occ_lbl 0960 `"0960"', add
label define occ_lbl 0961 `"0961"', add
label define occ_lbl 0962 `"0962"', add
label define occ_lbl 0963 `"0963"', add
label define occ_lbl 0964 `"0964"', add
label define occ_lbl 0965 `"0965"', add
label define occ_lbl 0966 `"0966"', add
label define occ_lbl 0967 `"0967"', add
label define occ_lbl 0968 `"0968"', add
label define occ_lbl 0969 `"0969"', add
label define occ_lbl 0970 `"0970"', add
label define occ_lbl 0971 `"0971"', add
label define occ_lbl 0972 `"0972"', add
label define occ_lbl 0973 `"0973"', add
label define occ_lbl 0974 `"0974"', add
label define occ_lbl 0975 `"0975"', add
label define occ_lbl 0976 `"0976"', add
label define occ_lbl 0977 `"0977"', add
label define occ_lbl 0978 `"0978"', add
label define occ_lbl 0979 `"0979"', add
label define occ_lbl 0980 `"0980"', add
label define occ_lbl 0981 `"0981"', add
label define occ_lbl 0982 `"0982"', add
label define occ_lbl 0983 `"0983"', add
label define occ_lbl 0984 `"0984"', add
label define occ_lbl 0985 `"0985"', add
label define occ_lbl 0986 `"0986"', add
label define occ_lbl 0987 `"0987"', add
label define occ_lbl 0988 `"0988"', add
label define occ_lbl 0989 `"0989"', add
label define occ_lbl 0990 `"0990"', add
label define occ_lbl 0991 `"0991"', add
label define occ_lbl 0992 `"0992"', add
label define occ_lbl 0993 `"0993"', add
label define occ_lbl 0994 `"0994"', add
label define occ_lbl 0995 `"0995"', add
label define occ_lbl 0996 `"0996"', add
label define occ_lbl 0997 `"0997"', add
label define occ_lbl 0998 `"0998"', add
label define occ_lbl 0999 `"0999"', add
label values occ occ_lbl

label define occ1950_lbl 000 `"Accountants and auditors"'
label define occ1950_lbl 001 `"Actors and actresses"', add
label define occ1950_lbl 002 `"Airplane pilots and navigators"', add
label define occ1950_lbl 003 `"Architects"', add
label define occ1950_lbl 004 `"Artists and art teachers"', add
label define occ1950_lbl 005 `"Athletes"', add
label define occ1950_lbl 006 `"Authors"', add
label define occ1950_lbl 007 `"Chemists"', add
label define occ1950_lbl 008 `"Chiropractors"', add
label define occ1950_lbl 009 `"Clergymen"', add
label define occ1950_lbl 010 `"College presidents and deans"', add
label define occ1950_lbl 012 `"Agricultural sciences-Professors and instructors"', add
label define occ1950_lbl 013 `"Biological sciences-Professors and instructors"', add
label define occ1950_lbl 014 `"Chemistry-Professors and instructors"', add
label define occ1950_lbl 015 `"Economics-Professors and instructors"', add
label define occ1950_lbl 016 `"Engineering-Professors and instructors"', add
label define occ1950_lbl 017 `"Geology and geophysics-Professors and instructors"', add
label define occ1950_lbl 018 `"Mathematics-Professors and instructors"', add
label define occ1950_lbl 019 `"Medical Sciences-Professors and instructors"', add
label define occ1950_lbl 023 `"Physics-Professors and instructors"', add
label define occ1950_lbl 024 `"Psychology-Professors and instructors"', add
label define occ1950_lbl 025 `"Statistics-Professors and instructors"', add
label define occ1950_lbl 026 `"Natural science (nec)-Professors and instructors"', add
label define occ1950_lbl 027 `"Social sciences (nec)-Professors and instructors"', add
label define occ1950_lbl 028 `"Non-scientific subjects-Professors and instructors"', add
label define occ1950_lbl 029 `"Subject not specified-Professors and instructors"', add
label define occ1950_lbl 031 `"Dancers and dancing teachers"', add
label define occ1950_lbl 032 `"Dentists"', add
label define occ1950_lbl 033 `"Designers"', add
label define occ1950_lbl 034 `"Dietitians and nutritionists"', add
label define occ1950_lbl 035 `"Draftsmen"', add
label define occ1950_lbl 036 `"Editors and reporters"', add
label define occ1950_lbl 041 `"Aeronautical-Engineers"', add
label define occ1950_lbl 042 `"Chemical-Engineers"', add
label define occ1950_lbl 043 `"Civil-Engineers"', add
label define occ1950_lbl 044 `"Electrical-Engineers"', add
label define occ1950_lbl 045 `"Industrial-Engineers"', add
label define occ1950_lbl 046 `"Mechanical-Engineers"', add
label define occ1950_lbl 047 `"Metallurgical, metallurgists-Engineers"', add
label define occ1950_lbl 048 `"Mining-Engineers"', add
label define occ1950_lbl 049 `"Engineers (nec)"', add
label define occ1950_lbl 051 `"Entertainers (nec)"', add
label define occ1950_lbl 052 `"Farm and home management advisors"', add
label define occ1950_lbl 053 `"Foresters and conservationists"', add
label define occ1950_lbl 054 `"Funeral directors and embalmers"', add
label define occ1950_lbl 055 `"Lawyers and judges"', add
label define occ1950_lbl 056 `"Librarians"', add
label define occ1950_lbl 057 `"Musicians and music teachers"', add
label define occ1950_lbl 058 `"Nurses, professional"', add
label define occ1950_lbl 059 `"Nurses, student professional"', add
label define occ1950_lbl 061 `"Agricultural scientists"', add
label define occ1950_lbl 062 `"Biological scientists"', add
label define occ1950_lbl 063 `"Geologists and geophysicists"', add
label define occ1950_lbl 067 `"Mathematicians"', add
label define occ1950_lbl 068 `"Physicists"', add
label define occ1950_lbl 069 `"Misc. natural scientists"', add
label define occ1950_lbl 070 `"Optometrists"', add
label define occ1950_lbl 071 `"Osteopaths"', add
label define occ1950_lbl 072 `"Personnel and labor relations workers"', add
label define occ1950_lbl 073 `"Pharmacists"', add
label define occ1950_lbl 074 `"Photographers"', add
label define occ1950_lbl 075 `"Physicians and surgeons"', add
label define occ1950_lbl 076 `"Radio operators"', add
label define occ1950_lbl 077 `"Recreation and group workers"', add
label define occ1950_lbl 078 `"Religious workers"', add
label define occ1950_lbl 079 `"Social and welfare workers, except group"', add
label define occ1950_lbl 081 `"Economists"', add
label define occ1950_lbl 082 `"Psychologists"', add
label define occ1950_lbl 083 `"Statisticians and actuaries"', add
label define occ1950_lbl 084 `"Misc social scientists"', add
label define occ1950_lbl 091 `"Sports instructors and officials"', add
label define occ1950_lbl 092 `"Surveyors"', add
label define occ1950_lbl 093 `"Teachers (n.e.c.)"', add
label define occ1950_lbl 094 `"Medical and dental-technicians"', add
label define occ1950_lbl 095 `"Testing-technicians"', add
label define occ1950_lbl 096 `"Technicians (nec)"', add
label define occ1950_lbl 097 `"Therapists and healers (nec)"', add
label define occ1950_lbl 098 `"Veterinarians"', add
label define occ1950_lbl 099 `"Professional, technical and kindred workers (nec)"', add
label define occ1950_lbl 100 `"Farmers (owners and tenants)"', add
label define occ1950_lbl 123 `"Farm managers"', add
label define occ1950_lbl 200 `"Buyers and dept heads, store"', add
label define occ1950_lbl 201 `"Buyers and shippers, farm products"', add
label define occ1950_lbl 203 `"Conductors, railroad"', add
label define occ1950_lbl 204 `"Credit men"', add
label define occ1950_lbl 205 `"Floormen and floor managers, store"', add
label define occ1950_lbl 210 `"Inspectors, public administration"', add
label define occ1950_lbl 230 `"Managers and superintendants, building"', add
label define occ1950_lbl 240 `"Officers, pilots, pursers and engineers, ship"', add
label define occ1950_lbl 250 `"Officials and administratators (nec), public administration"', add
label define occ1950_lbl 260 `"Officials, lodge, society, union, etc."', add
label define occ1950_lbl 270 `"Postmasters"', add
label define occ1950_lbl 280 `"Purchasing agents and buyers (nec)"', add
label define occ1950_lbl 290 `"Managers, officials, and proprietors (nec)"', add
label define occ1950_lbl 300 `"Agents (nec)"', add
label define occ1950_lbl 301 `"Attendants and assistants, library"', add
label define occ1950_lbl 302 `"Attendants, physicians and dentists office"', add
label define occ1950_lbl 304 `"Baggagemen, transportation"', add
label define occ1950_lbl 305 `"Bank tellers"', add
label define occ1950_lbl 310 `"Bookkeepers"', add
label define occ1950_lbl 320 `"Cashiers"', add
label define occ1950_lbl 321 `"Collectors, bill and account"', add
label define occ1950_lbl 322 `"Dispatchers and starters, vehicle"', add
label define occ1950_lbl 325 `"Express messengers and railway mail clerks"', add
label define occ1950_lbl 335 `"Mail carriers"', add
label define occ1950_lbl 340 `"Messengers and office boys"', add
label define occ1950_lbl 341 `"Office machine operators"', add
label define occ1950_lbl 342 `"Shipping and receiving clerks"', add
label define occ1950_lbl 350 `"Stenographers, typists, and secretaries"', add
label define occ1950_lbl 360 `"Telegraph messengers"', add
label define occ1950_lbl 365 `"Telegraph operators"', add
label define occ1950_lbl 370 `"Telephone operators"', add
label define occ1950_lbl 380 `"Ticket, station, and express agents"', add
label define occ1950_lbl 390 `"Clerical and kindred workers (n.e.c.)"', add
label define occ1950_lbl 400 `"Advertising agents and salesmen"', add
label define occ1950_lbl 410 `"Auctioneers"', add
label define occ1950_lbl 420 `"Demonstrators"', add
label define occ1950_lbl 430 `"Hucksters and peddlers"', add
label define occ1950_lbl 450 `"Insurance agents and brokers"', add
label define occ1950_lbl 460 `"Newsboys"', add
label define occ1950_lbl 470 `"Real estate agents and brokers"', add
label define occ1950_lbl 480 `"Stock and bond salesmen"', add
label define occ1950_lbl 490 `"Salesmen and sales clerks (nec)"', add
label define occ1950_lbl 500 `"Bakers"', add
label define occ1950_lbl 501 `"Blacksmiths"', add
label define occ1950_lbl 502 `"Bookbinders"', add
label define occ1950_lbl 503 `"Boilermakers"', add
label define occ1950_lbl 504 `"Brickmasons,stonemasons, and tile setters"', add
label define occ1950_lbl 505 `"Cabinetmakers"', add
label define occ1950_lbl 510 `"Carpenters"', add
label define occ1950_lbl 511 `"Cement and concrete finishers"', add
label define occ1950_lbl 512 `"Compositors and typesetters"', add
label define occ1950_lbl 513 `"Cranemen,derrickmen, and hoistmen"', add
label define occ1950_lbl 514 `"Decorators and window dressers"', add
label define occ1950_lbl 515 `"Electricians"', add
label define occ1950_lbl 520 `"Electrotypers and stereotypers"', add
label define occ1950_lbl 521 `"Engravers, except photoengravers"', add
label define occ1950_lbl 522 `"Excavating, grading, and road machinery operators"', add
label define occ1950_lbl 523 `"Foremen (nec)"', add
label define occ1950_lbl 524 `"Forgemen and hammermen"', add
label define occ1950_lbl 525 `"Furriers"', add
label define occ1950_lbl 530 `"Glaziers"', add
label define occ1950_lbl 531 `"Heat treaters, annealers, temperers"', add
label define occ1950_lbl 532 `"Inspectors, scalers, and graders log and lumber"', add
label define occ1950_lbl 533 `"Inspectors (nec)"', add
label define occ1950_lbl 534 `"Jewelers, watchmakers, goldsmiths, and silversmiths"', add
label define occ1950_lbl 535 `"Job setters, metal"', add
label define occ1950_lbl 540 `"Linemen and servicemen, telegraph, telephone, and power"', add
label define occ1950_lbl 541 `"Locomotive engineers"', add
label define occ1950_lbl 542 `"Locomotive firemen"', add
label define occ1950_lbl 543 `"Loom fixers"', add
label define occ1950_lbl 544 `"Machinists"', add
label define occ1950_lbl 545 `"Airplane-mechanics and repairmen"', add
label define occ1950_lbl 550 `"Automobile-mechanics and repairmen"', add
label define occ1950_lbl 551 `"Office machine-mechanics and repairmen"', add
label define occ1950_lbl 552 `"Radio and television-mechanics and repairmen"', add
label define occ1950_lbl 553 `"Railroad and car shop-mechanics and repairmen"', add
label define occ1950_lbl 554 `"Mechanics and repairmen (nec)"', add
label define occ1950_lbl 555 `"Millers, grain, flour, feed, etc"', add
label define occ1950_lbl 560 `"Millwrights"', add
label define occ1950_lbl 561 `"Molders, metal"', add
label define occ1950_lbl 562 `"Motion picture projectionists"', add
label define occ1950_lbl 563 `"Opticians and lens grinders and polishers"', add
label define occ1950_lbl 564 `"Painters, construction and maintenance"', add
label define occ1950_lbl 565 `"Paperhangers"', add
label define occ1950_lbl 570 `"Pattern and model makers, except paper"', add
label define occ1950_lbl 571 `"Photoengravers and lithographers"', add
label define occ1950_lbl 572 `"Piano and organ tuners and repairmen"', add
label define occ1950_lbl 573 `"Plasterers"', add
label define occ1950_lbl 574 `"Plumbers and pipe fitters"', add
label define occ1950_lbl 575 `"Pressmen and plate printers, printing"', add
label define occ1950_lbl 580 `"Rollers and roll hands, metal"', add
label define occ1950_lbl 581 `"Roofers and slaters"', add
label define occ1950_lbl 582 `"Shoemakers and repairers, except factory"', add
label define occ1950_lbl 583 `"Stationary engineers"', add
label define occ1950_lbl 584 `"Stone cutters and stone carvers"', add
label define occ1950_lbl 585 `"Structural metal workers"', add
label define occ1950_lbl 590 `"Tailors and tailoresses"', add
label define occ1950_lbl 591 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ1950_lbl 592 `"Tool makers, and die makers and setters"', add
label define occ1950_lbl 593 `"Upholsterers"', add
label define occ1950_lbl 594 `"Craftsmen and kindred workers (nec)"', add
label define occ1950_lbl 595 `"Members of the armed services"', add
label define occ1950_lbl 600 `"Auto mechanics apprentice"', add
label define occ1950_lbl 601 `"Bricklayers and masons apprentice"', add
label define occ1950_lbl 602 `"Carpenters apprentice"', add
label define occ1950_lbl 603 `"Electricians apprentice"', add
label define occ1950_lbl 604 `"Machinists and toolmakers apprentice"', add
label define occ1950_lbl 605 `"Mechanics, except auto apprentice"', add
label define occ1950_lbl 610 `"Plumbers and pipe fitters apprentice"', add
label define occ1950_lbl 611 `"Apprentices, building trades (nec)"', add
label define occ1950_lbl 612 `"Apprentices, metalworking trades (nec)"', add
label define occ1950_lbl 613 `"Apprentices, printing  trades"', add
label define occ1950_lbl 614 `"Apprentices, other specified trades"', add
label define occ1950_lbl 615 `"Apprentices, trade not specified"', add
label define occ1950_lbl 620 `"Asbestos and insulation workers"', add
label define occ1950_lbl 621 `"Attendants, auto service and parking"', add
label define occ1950_lbl 622 `"Blasters and powdermen"', add
label define occ1950_lbl 623 `"Boatmen, canalmen, and lock keepers"', add
label define occ1950_lbl 624 `"Brakemen, railroad"', add
label define occ1950_lbl 625 `"Bus drivers"', add
label define occ1950_lbl 630 `"Chainmen, rodmen, and axmen, surveying"', add
label define occ1950_lbl 631 `"Conductors, bus and street railway"', add
label define occ1950_lbl 632 `"Deliverymen and routemen"', add
label define occ1950_lbl 633 `"Dressmakers and seamstresses, except factory"', add
label define occ1950_lbl 634 `"Dyers"', add
label define occ1950_lbl 635 `"Filers, grinders, and polishers, metal"', add
label define occ1950_lbl 640 `"Fruit, nut, and vegetable graders, and packers, except facto"', add
label define occ1950_lbl 641 `"Furnacemen, smeltermen and pourers"', add
label define occ1950_lbl 642 `"Heaters, metal"', add
label define occ1950_lbl 643 `"Laundry and dry cleaning Operatives"', add
label define occ1950_lbl 644 `"Meat cutters, except slaughter and packing house"', add
label define occ1950_lbl 645 `"Milliners"', add
label define occ1950_lbl 650 `"Mine operatives and laborers"', add
label define occ1950_lbl 660 `"Motormen, mine, factory, logging camp, etc"', add
label define occ1950_lbl 661 `"Motormen, street, subway, and elevated railway"', add
label define occ1950_lbl 662 `"Oilers and greaser, except auto"', add
label define occ1950_lbl 670 `"Painters, except construction or maintenance"', add
label define occ1950_lbl 671 `"Photographic process workers"', add
label define occ1950_lbl 672 `"Power station operators"', add
label define occ1950_lbl 673 `"Sailors and deck hands"', add
label define occ1950_lbl 674 `"Sawyers"', add
label define occ1950_lbl 675 `"Spinners, textile"', add
label define occ1950_lbl 680 `"Stationary firemen"', add
label define occ1950_lbl 681 `"Switchmen, railroad"', add
label define occ1950_lbl 682 `"Taxicab drivers and chauffeurs"', add
label define occ1950_lbl 683 `"Truck and tractor drivers"', add
label define occ1950_lbl 684 `"Weavers, textile"', add
label define occ1950_lbl 685 `"Welders and flame cutters"', add
label define occ1950_lbl 690 `"Operative and kindred workers (nec)"', add
label define occ1950_lbl 700 `"Housekeepers, private household"', add
label define occ1950_lbl 710 `"Laundresses, private household"', add
label define occ1950_lbl 720 `"Private household workers (nec)"', add
label define occ1950_lbl 730 `"Attendants, hospital and other institution"', add
label define occ1950_lbl 731 `"Attendants, professional and personal service (nec)"', add
label define occ1950_lbl 732 `"Attendants, recreation and amusement"', add
label define occ1950_lbl 740 `"Barbers, beauticians, and manicurists"', add
label define occ1950_lbl 750 `"Bartenders"', add
label define occ1950_lbl 751 `"Bootblacks"', add
label define occ1950_lbl 752 `"Boarding and lodging house keepers"', add
label define occ1950_lbl 753 `"Charwomen and cleaners"', add
label define occ1950_lbl 754 `"Cooks, except private household"', add
label define occ1950_lbl 760 `"Counter and fountain workers"', add
label define occ1950_lbl 761 `"Elevator operators"', add
label define occ1950_lbl 762 `"Firemen, fire protection"', add
label define occ1950_lbl 763 `"Guards, watchmen, and doorkeepers"', add
label define occ1950_lbl 764 `"Housekeepers and stewards, except private household"', add
label define occ1950_lbl 770 `"Janitors and sextons"', add
label define occ1950_lbl 771 `"Marshals and constables"', add
label define occ1950_lbl 772 `"Midwives"', add
label define occ1950_lbl 773 `"Policemen and detectives"', add
label define occ1950_lbl 780 `"Porters"', add
label define occ1950_lbl 781 `"Practical nurses"', add
label define occ1950_lbl 782 `"Sheriffs and bailiffs"', add
label define occ1950_lbl 783 `"Ushers, recreation and amusement"', add
label define occ1950_lbl 784 `"Waiters and waitresses"', add
label define occ1950_lbl 785 `"Watchmen (crossing) and bridge tenders"', add
label define occ1950_lbl 790 `"Service workers, except private household (nec)"', add
label define occ1950_lbl 810 `"Farm foremen"', add
label define occ1950_lbl 820 `"Farm laborers, wage workers"', add
label define occ1950_lbl 830 `"Farm laborers, unpaid family workers"', add
label define occ1950_lbl 840 `"Farm service laborers, self-employed"', add
label define occ1950_lbl 910 `"Fishermen and oystermen"', add
label define occ1950_lbl 920 `"Garage laborers and car washers and greasers"', add
label define occ1950_lbl 930 `"Gardeners, except farm and groundskeepers"', add
label define occ1950_lbl 940 `"Longshoremen and stevedores"', add
label define occ1950_lbl 950 `"Lumbermen, raftsmen, and woodchoppers"', add
label define occ1950_lbl 960 `"Teamsters"', add
label define occ1950_lbl 970 `"Laborers (nec)"', add
label define occ1950_lbl 979 `"Not yet classified"', add
label define occ1950_lbl 980 `"Keeps house/housekeeping at home/housewife"', add
label define occ1950_lbl 981 `"Imputed keeping house (1850-1900)"', add
label define occ1950_lbl 982 `"Helping at home/helps parents/housework"', add
label define occ1950_lbl 983 `"At school/student"', add
label define occ1950_lbl 984 `"Retired"', add
label define occ1950_lbl 985 `"Unemployed/without occupation"', add
label define occ1950_lbl 986 `"Invalid/disabled w/ no occupation reported"', add
label define occ1950_lbl 987 `"Inmate"', add
label define occ1950_lbl 990 `"New Worker"', add
label define occ1950_lbl 991 `"Gentleman/lady/at leisure"', add
label define occ1950_lbl 995 `"Other non-occupation"', add
label define occ1950_lbl 997 `"Occupation missing/unknown"', add
label define occ1950_lbl 999 `"N/A (blank)"', add
label values occ1950 occ1950_lbl

label define occ1990_lbl 003 `"Legislators"'
label define occ1990_lbl 004 `"Chief executives and public administrators"', add
label define occ1990_lbl 007 `"Financial managers"', add
label define occ1990_lbl 008 `"Human resources and labor relations managers"', add
label define occ1990_lbl 013 `"Managers and specialists in marketing, advertising, and public relations"', add
label define occ1990_lbl 014 `"Managers in education and related fields"', add
label define occ1990_lbl 015 `"Managers of medicine and health occupations"', add
label define occ1990_lbl 016 `"Postmasters and mail superintendents"', add
label define occ1990_lbl 017 `"Managers of food-serving and lodging establishments"', add
label define occ1990_lbl 018 `"Managers of properties and real estate"', add
label define occ1990_lbl 019 `"Funeral directors"', add
label define occ1990_lbl 021 `"Managers of service organizations, n.e.c."', add
label define occ1990_lbl 022 `"Managers and administrators, n.e.c."', add
label define occ1990_lbl 023 `"Accountants and auditors"', add
label define occ1990_lbl 024 `"Insurance underwriters"', add
label define occ1990_lbl 025 `"Other financial specialists"', add
label define occ1990_lbl 026 `"Management analysts"', add
label define occ1990_lbl 027 `"Personnel, HR, training, and labor relations specialists"', add
label define occ1990_lbl 028 `"Purchasing agents and buyers, of farm products"', add
label define occ1990_lbl 029 `"Buyers, wholesale and retail trade"', add
label define occ1990_lbl 033 `"Purchasing managers, agents and buyers, n.e.c."', add
label define occ1990_lbl 034 `"Business and promotion agents"', add
label define occ1990_lbl 035 `"Construction inspectors"', add
label define occ1990_lbl 036 `"Inspectors and compliance officers, outside construction"', add
label define occ1990_lbl 037 `"Management support occupations"', add
label define occ1990_lbl 043 `"Architects"', add
label define occ1990_lbl 044 `"Aerospace engineer"', add
label define occ1990_lbl 045 `"Metallurgical and materials engineers, variously phrased"', add
label define occ1990_lbl 047 `"Petroleum, mining, and geological engineers"', add
label define occ1990_lbl 048 `"Chemical engineers"', add
label define occ1990_lbl 053 `"Civil engineers"', add
label define occ1990_lbl 055 `"Electrical engineer"', add
label define occ1990_lbl 056 `"Industrial engineers"', add
label define occ1990_lbl 057 `"Mechanical engineers"', add
label define occ1990_lbl 059 `"Not-elsewhere-classified engineers"', add
label define occ1990_lbl 064 `"Computer systems analysts and computer scientists"', add
label define occ1990_lbl 065 `"Operations and systems researchers and analysts"', add
label define occ1990_lbl 066 `"Actuaries"', add
label define occ1990_lbl 067 `"Statisticians"', add
label define occ1990_lbl 068 `"Mathematicians and mathematical scientists"', add
label define occ1990_lbl 069 `"Physicists and astronomers"', add
label define occ1990_lbl 073 `"Chemists"', add
label define occ1990_lbl 074 `"Atmospheric and space scientists"', add
label define occ1990_lbl 075 `"Geologists"', add
label define occ1990_lbl 076 `"Physical scientists, n.e.c."', add
label define occ1990_lbl 077 `"Agricultural and food scientists"', add
label define occ1990_lbl 078 `"Biological scientists"', add
label define occ1990_lbl 079 `"Foresters and conservation scientists"', add
label define occ1990_lbl 083 `"Medical scientists"', add
label define occ1990_lbl 084 `"Physicians"', add
label define occ1990_lbl 085 `"Dentists"', add
label define occ1990_lbl 086 `"Veterinarians"', add
label define occ1990_lbl 087 `"Optometrists"', add
label define occ1990_lbl 088 `"Podiatrists"', add
label define occ1990_lbl 089 `"Other health and therapy"', add
label define occ1990_lbl 095 `"Registered nurses"', add
label define occ1990_lbl 096 `"Pharmacists"', add
label define occ1990_lbl 097 `"Dietitians and nutritionists"', add
label define occ1990_lbl 098 `"Respiratory therapists"', add
label define occ1990_lbl 099 `"Occupational therapists"', add
label define occ1990_lbl 103 `"Physical therapists"', add
label define occ1990_lbl 104 `"Speech therapists"', add
label define occ1990_lbl 105 `"Therapists, n.e.c."', add
label define occ1990_lbl 106 `"Physicians' assistants"', add
label define occ1990_lbl 113 `"Earth, environmental, and marine science instructors"', add
label define occ1990_lbl 114 `"Biological science instructors"', add
label define occ1990_lbl 115 `"Chemistry instructors"', add
label define occ1990_lbl 116 `"Physics instructors"', add
label define occ1990_lbl 118 `"Psychology instructors"', add
label define occ1990_lbl 119 `"Economics instructors"', add
label define occ1990_lbl 123 `"History instructors"', add
label define occ1990_lbl 125 `"Sociology instructors"', add
label define occ1990_lbl 127 `"Engineering instructors"', add
label define occ1990_lbl 128 `"Math instructors"', add
label define occ1990_lbl 139 `"Education instructors"', add
label define occ1990_lbl 145 `"Law instructors"', add
label define occ1990_lbl 147 `"Theology instructors"', add
label define occ1990_lbl 149 `"Home economics instructors"', add
label define occ1990_lbl 150 `"Humanities profs/instructors, college, nec"', add
label define occ1990_lbl 154 `"Subject instructors (HS/college)"', add
label define occ1990_lbl 155 `"Kindergarten and earlier school teachers"', add
label define occ1990_lbl 156 `"Primary school teachers"', add
label define occ1990_lbl 157 `"Secondary school teachers"', add
label define occ1990_lbl 158 `"Special education teachers"', add
label define occ1990_lbl 159 `"Teachers , n.e.c."', add
label define occ1990_lbl 163 `"Vocational and educational counselors"', add
label define occ1990_lbl 164 `"Librarians"', add
label define occ1990_lbl 165 `"Archivists and curators"', add
label define occ1990_lbl 166 `"Economists, market researchers, and survey researchers"', add
label define occ1990_lbl 167 `"Psychologists"', add
label define occ1990_lbl 168 `"Sociologists"', add
label define occ1990_lbl 169 `"Social scientists, n.e.c."', add
label define occ1990_lbl 173 `"Urban and regional planners"', add
label define occ1990_lbl 174 `"Social workers"', add
label define occ1990_lbl 175 `"Recreation workers"', add
label define occ1990_lbl 176 `"Clergy and religious workers"', add
label define occ1990_lbl 178 `"Lawyers"', add
label define occ1990_lbl 179 `"Judges"', add
label define occ1990_lbl 183 `"Writers and authors"', add
label define occ1990_lbl 184 `"Technical writers"', add
label define occ1990_lbl 185 `"Designers"', add
label define occ1990_lbl 186 `"Musician or composer"', add
label define occ1990_lbl 187 `"Actors, directors, producers"', add
label define occ1990_lbl 188 `"Art makers: painters, sculptors, craft-artists, and print-makers"', add
label define occ1990_lbl 189 `"Photographers"', add
label define occ1990_lbl 193 `"Dancers"', add
label define occ1990_lbl 194 `"Art/entertainment performers and related"', add
label define occ1990_lbl 195 `"Editors and reporters"', add
label define occ1990_lbl 198 `"Announcers"', add
label define occ1990_lbl 199 `"Athletes, sports instructors, and officials"', add
label define occ1990_lbl 200 `"Professionals, n.e.c."', add
label define occ1990_lbl 203 `"Clinical laboratory technologies and technicians"', add
label define occ1990_lbl 204 `"Dental hygenists"', add
label define occ1990_lbl 205 `"Health record tech specialists"', add
label define occ1990_lbl 206 `"Radiologic tech specialists"', add
label define occ1990_lbl 207 `"Licensed practical nurses"', add
label define occ1990_lbl 208 `"Health technologists and technicians, n.e.c."', add
label define occ1990_lbl 213 `"Electrical and electronic (engineering) technicians"', add
label define occ1990_lbl 214 `"Engineering technicians, n.e.c."', add
label define occ1990_lbl 215 `"Mechanical engineering technicians"', add
label define occ1990_lbl 217 `"Drafters"', add
label define occ1990_lbl 218 `"Surveyors, cartographers, mapping scientists and technicians"', add
label define occ1990_lbl 223 `"Biological technicians"', add
label define occ1990_lbl 224 `"Chemical technicians"', add
label define occ1990_lbl 225 `"Other science technicians"', add
label define occ1990_lbl 226 `"Airplane pilots and navigators"', add
label define occ1990_lbl 227 `"Air traffic controllers"', add
label define occ1990_lbl 228 `"Broadcast equipment operators"', add
label define occ1990_lbl 229 `"Computer software developers"', add
label define occ1990_lbl 233 `"Programmers of numerically controlled machine tools"', add
label define occ1990_lbl 234 `"Legal assistants, paralegals, legal support, etc"', add
label define occ1990_lbl 235 `"Technicians, n.e.c."', add
label define occ1990_lbl 243 `"Supervisors and proprietors of sales jobs"', add
label define occ1990_lbl 253 `"Insurance sales occupations"', add
label define occ1990_lbl 254 `"Real estate sales occupations"', add
label define occ1990_lbl 255 `"Financial services sales occupations"', add
label define occ1990_lbl 256 `"Advertising and related sales jobs"', add
label define occ1990_lbl 258 `"Sales engineers"', add
label define occ1990_lbl 274 `"Salespersons, n.e.c."', add
label define occ1990_lbl 275 `"Retail sales clerks"', add
label define occ1990_lbl 276 `"Cashiers"', add
label define occ1990_lbl 277 `"Door-to-door sales, street sales, and news vendors"', add
label define occ1990_lbl 283 `"Sales demonstrators / promoters / models"', add
label define occ1990_lbl 303 `"Office supervisors"', add
label define occ1990_lbl 308 `"Computer and peripheral equipment operators"', add
label define occ1990_lbl 313 `"Secretaries"', add
label define occ1990_lbl 314 `"Stenographers"', add
label define occ1990_lbl 315 `"Typists"', add
label define occ1990_lbl 316 `"Interviewers, enumerators, and surveyors"', add
label define occ1990_lbl 317 `"Hotel clerks"', add
label define occ1990_lbl 318 `"Transportation ticket and reservation agents"', add
label define occ1990_lbl 319 `"Receptionists"', add
label define occ1990_lbl 323 `"Information clerks, nec"', add
label define occ1990_lbl 326 `"Correspondence and order clerks"', add
label define occ1990_lbl 328 `"Human resources clerks, except payroll and timekeeping"', add
label define occ1990_lbl 329 `"Library assistants"', add
label define occ1990_lbl 335 `"File clerks"', add
label define occ1990_lbl 336 `"Records clerks"', add
label define occ1990_lbl 337 `"Bookkeepers and accounting and auditing clerks"', add
label define occ1990_lbl 338 `"Payroll and timekeeping clerks"', add
label define occ1990_lbl 343 `"Cost and rate clerks (financial records processing)"', add
label define occ1990_lbl 344 `"Billing clerks and related financial records processing"', add
label define occ1990_lbl 345 `"Duplication machine operators / office machine operators"', add
label define occ1990_lbl 346 `"Mail and paper handlers"', add
label define occ1990_lbl 347 `"Office machine operators, n.e.c."', add
label define occ1990_lbl 348 `"Telephone operators"', add
label define occ1990_lbl 349 `"Other telecom operators"', add
label define occ1990_lbl 354 `"Postal clerks, excluding mail carriers"', add
label define occ1990_lbl 355 `"Mail carriers for postal service"', add
label define occ1990_lbl 356 `"Mail clerks, outside of post office"', add
label define occ1990_lbl 357 `"Messengers"', add
label define occ1990_lbl 359 `"Dispatchers"', add
label define occ1990_lbl 361 `"Inspectors, n.e.c."', add
label define occ1990_lbl 364 `"Shipping and receiving clerks"', add
label define occ1990_lbl 365 `"Stock and inventory clerks"', add
label define occ1990_lbl 366 `"Meter readers"', add
label define occ1990_lbl 368 `"Weighers, measurers, and checkers"', add
label define occ1990_lbl 373 `"Material recording, scheduling, production, planning, and expediting clerks"', add
label define occ1990_lbl 375 `"Insurance adjusters, examiners, and investigators"', add
label define occ1990_lbl 376 `"Customer service reps, investigators and adjusters, except insurance"', add
label define occ1990_lbl 377 `"Eligibility clerks for government programs; social welfare"', add
label define occ1990_lbl 378 `"Bill and account collectors"', add
label define occ1990_lbl 379 `"General office clerks"', add
label define occ1990_lbl 383 `"Bank tellers"', add
label define occ1990_lbl 384 `"Proofreaders"', add
label define occ1990_lbl 385 `"Data entry keyers"', add
label define occ1990_lbl 386 `"Statistical clerks"', add
label define occ1990_lbl 387 `"Teacher's aides"', add
label define occ1990_lbl 389 `"Administrative support jobs, n.e.c."', add
label define occ1990_lbl 405 `"Housekeepers, maids, butlers, stewards, and lodging quarters cleaners"', add
label define occ1990_lbl 407 `"Private household cleaners and servants"', add
label define occ1990_lbl 415 `"Supervisors of guards"', add
label define occ1990_lbl 417 `"Fire fighting, prevention, and inspection"', add
label define occ1990_lbl 418 `"Police, detectives, and private investigators"', add
label define occ1990_lbl 423 `"Other law enforcement: sheriffs, bailiffs, correctional institution officers"', add
label define occ1990_lbl 425 `"Crossing guards and bridge tenders"', add
label define occ1990_lbl 426 `"Guards, watchmen, doorkeepers"', add
label define occ1990_lbl 427 `"Protective services, n.e.c."', add
label define occ1990_lbl 434 `"Bartenders"', add
label define occ1990_lbl 435 `"Waiter/waitress"', add
label define occ1990_lbl 436 `"Cooks, variously defined"', add
label define occ1990_lbl 438 `"Food counter and fountain workers"', add
label define occ1990_lbl 439 `"Kitchen workers"', add
label define occ1990_lbl 443 `"Waiter's assistant"', add
label define occ1990_lbl 444 `"Misc food prep workers"', add
label define occ1990_lbl 445 `"Dental assistants"', add
label define occ1990_lbl 446 `"Health aides, except nursing"', add
label define occ1990_lbl 447 `"Nursing aides, orderlies, and attendants"', add
label define occ1990_lbl 448 `"Supervisors of cleaning and building service"', add
label define occ1990_lbl 453 `"Janitors"', add
label define occ1990_lbl 454 `"Elevator operators"', add
label define occ1990_lbl 455 `"Pest control occupations"', add
label define occ1990_lbl 456 `"Supervisors of personal service jobs, n.e.c."', add
label define occ1990_lbl 457 `"Barbers"', add
label define occ1990_lbl 458 `"Hairdressers and cosmetologists"', add
label define occ1990_lbl 459 `"Recreation facility attendants"', add
label define occ1990_lbl 461 `"Guides"', add
label define occ1990_lbl 462 `"Ushers"', add
label define occ1990_lbl 463 `"Public transportation attendants and inspectors"', add
label define occ1990_lbl 464 `"Baggage porters"', add
label define occ1990_lbl 465 `"Welfare service aides"', add
label define occ1990_lbl 468 `"Child care workers"', add
label define occ1990_lbl 469 `"Personal service occupations, nec"', add
label define occ1990_lbl 473 `"Farmers (owners and tenants)"', add
label define occ1990_lbl 474 `"Horticultural specialty farmers"', add
label define occ1990_lbl 475 `"Farm managers, except for horticultural farms"', add
label define occ1990_lbl 476 `"Managers of horticultural specialty farms"', add
label define occ1990_lbl 479 `"Farm workers"', add
label define occ1990_lbl 483 `"Marine life cultivation workers"', add
label define occ1990_lbl 484 `"Nursery farming workers"', add
label define occ1990_lbl 485 `"Supervisors of agricultural occupations"', add
label define occ1990_lbl 486 `"Gardeners and groundskeepers"', add
label define occ1990_lbl 487 `"Animal caretakers except on farms"', add
label define occ1990_lbl 488 `"Graders and sorters of agricultural products"', add
label define occ1990_lbl 489 `"Inspectors of agricultural products"', add
label define occ1990_lbl 496 `"Timber, logging, and forestry workers"', add
label define occ1990_lbl 498 `"Fishers, hunters, and kindred"', add
label define occ1990_lbl 503 `"Supervisors of mechanics and repairers"', add
label define occ1990_lbl 505 `"Automobile mechanics"', add
label define occ1990_lbl 507 `"Bus, truck, and stationary engine mechanics"', add
label define occ1990_lbl 508 `"Aircraft mechanics"', add
label define occ1990_lbl 509 `"Small engine repairers"', add
label define occ1990_lbl 514 `"Auto body repairers"', add
label define occ1990_lbl 516 `"Heavy equipment and farm equipment mechanics"', add
label define occ1990_lbl 518 `"Industrial machinery repairers"', add
label define occ1990_lbl 519 `"Machinery maintenance occupations"', add
label define occ1990_lbl 523 `"Repairers of industrial electrical equipment"', add
label define occ1990_lbl 525 `"Repairers of data processing equipment"', add
label define occ1990_lbl 526 `"Repairers of household appliances and power tools"', add
label define occ1990_lbl 527 `"Telecom and line installers and repairers"', add
label define occ1990_lbl 533 `"Repairers of electrical equipment, n.e.c."', add
label define occ1990_lbl 534 `"Heating, air conditioning, and refigeration mechanics"', add
label define occ1990_lbl 535 `"Precision makers, repairers, and smiths"', add
label define occ1990_lbl 536 `"Locksmiths and safe repairers"', add
label define occ1990_lbl 538 `"Office machine repairers and mechanics"', add
label define occ1990_lbl 539 `"Repairers of mechanical controls and valves"', add
label define occ1990_lbl 543 `"Elevator installers and repairers"', add
label define occ1990_lbl 544 `"Millwrights"', add
label define occ1990_lbl 549 `"Mechanics and repairers, n.e.c."', add
label define occ1990_lbl 558 `"Supervisors of construction work"', add
label define occ1990_lbl 563 `"Masons, tilers, and carpet installers"', add
label define occ1990_lbl 567 `"Carpenters"', add
label define occ1990_lbl 573 `"Drywall installers"', add
label define occ1990_lbl 575 `"Electricians"', add
label define occ1990_lbl 577 `"Electric power installers and repairers"', add
label define occ1990_lbl 579 `"Painters, construction and maintenance"', add
label define occ1990_lbl 583 `"Paperhangers"', add
label define occ1990_lbl 584 `"Plasterers"', add
label define occ1990_lbl 585 `"Plumbers, pipe fitters, and steamfitters"', add
label define occ1990_lbl 588 `"Concrete and cement workers"', add
label define occ1990_lbl 589 `"Glaziers"', add
label define occ1990_lbl 593 `"Insulation workers"', add
label define occ1990_lbl 594 `"Paving, surfacing, and tamping equipment operators"', add
label define occ1990_lbl 595 `"Roofers and slaters"', add
label define occ1990_lbl 596 `"Sheet metal duct installers"', add
label define occ1990_lbl 597 `"Structural metal workers"', add
label define occ1990_lbl 598 `"Drillers of earth"', add
label define occ1990_lbl 599 `"Construction trades, n.e.c."', add
label define occ1990_lbl 614 `"Drillers of oil wells"', add
label define occ1990_lbl 615 `"Explosives workers"', add
label define occ1990_lbl 616 `"Miners"', add
label define occ1990_lbl 617 `"Other mining occupations"', add
label define occ1990_lbl 628 `"Production supervisors or foremen"', add
label define occ1990_lbl 634 `"Tool and die makers and die setters"', add
label define occ1990_lbl 637 `"Machinists"', add
label define occ1990_lbl 643 `"Boilermakers"', add
label define occ1990_lbl 644 `"Precision grinders and filers"', add
label define occ1990_lbl 645 `"Patternmakers and model makers"', add
label define occ1990_lbl 646 `"Lay-out workers"', add
label define occ1990_lbl 649 `"Engravers"', add
label define occ1990_lbl 653 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ1990_lbl 657 `"Cabinetmakers and bench carpenters"', add
label define occ1990_lbl 658 `"Furniture and wood finishers"', add
label define occ1990_lbl 659 `"Other precision woodworkers"', add
label define occ1990_lbl 666 `"Dressmakers and seamstresses"', add
label define occ1990_lbl 667 `"Tailors"', add
label define occ1990_lbl 668 `"Upholsterers"', add
label define occ1990_lbl 669 `"Shoe repairers"', add
label define occ1990_lbl 674 `"Other precision apparel and fabric workers"', add
label define occ1990_lbl 675 `"Hand molders and shapers, except jewelers"', add
label define occ1990_lbl 677 `"Optical goods workers"', add
label define occ1990_lbl 678 `"Dental laboratory and medical appliance technicians"', add
label define occ1990_lbl 679 `"Bookbinders"', add
label define occ1990_lbl 684 `"Other precision and craft workers"', add
label define occ1990_lbl 686 `"Butchers and meat cutters"', add
label define occ1990_lbl 687 `"Bakers"', add
label define occ1990_lbl 688 `"Batch food makers"', add
label define occ1990_lbl 693 `"Adjusters and calibrators"', add
label define occ1990_lbl 694 `"Water and sewage treatment plant operators"', add
label define occ1990_lbl 695 `"Power plant operators"', add
label define occ1990_lbl 696 `"Plant and system operators, stationary engineers"', add
label define occ1990_lbl 699 `"Other plant and system operators"', add
label define occ1990_lbl 703 `"Lathe, milling, and turning machine operatives"', add
label define occ1990_lbl 706 `"Punching and stamping press operatives"', add
label define occ1990_lbl 707 `"Rollers, roll hands, and finishers of metal"', add
label define occ1990_lbl 708 `"Drilling and boring machine operators"', add
label define occ1990_lbl 709 `"Grinding, abrading, buffing, and polishing workers"', add
label define occ1990_lbl 713 `"Forge and hammer operators"', add
label define occ1990_lbl 717 `"Fabricating machine operators, n.e.c."', add
label define occ1990_lbl 719 `"Molders, and casting machine operators"', add
label define occ1990_lbl 723 `"Metal platers"', add
label define occ1990_lbl 724 `"Heat treating equipment operators"', add
label define occ1990_lbl 726 `"Wood lathe, routing, and planing machine operators"', add
label define occ1990_lbl 727 `"Sawing machine operators and sawyers"', add
label define occ1990_lbl 728 `"Shaping and joining machine operator (woodworking)"', add
label define occ1990_lbl 729 `"Nail and tacking machine operators  (woodworking)"', add
label define occ1990_lbl 733 `"Other woodworking machine operators"', add
label define occ1990_lbl 734 `"Printing machine operators, n.e.c."', add
label define occ1990_lbl 735 `"Photoengravers and lithographers"', add
label define occ1990_lbl 736 `"Typesetters and compositors"', add
label define occ1990_lbl 738 `"Winding and twisting textile/apparel operatives"', add
label define occ1990_lbl 739 `"Knitters, loopers, and toppers textile operatives"', add
label define occ1990_lbl 743 `"Textile cutting machine operators"', add
label define occ1990_lbl 744 `"Textile sewing machine operators"', add
label define occ1990_lbl 745 `"Shoemaking machine operators"', add
label define occ1990_lbl 747 `"Pressing machine operators (clothing)"', add
label define occ1990_lbl 748 `"Laundry workers"', add
label define occ1990_lbl 749 `"Misc textile machine operators"', add
label define occ1990_lbl 753 `"Cementing and gluing maching operators"', add
label define occ1990_lbl 754 `"Packers, fillers, and wrappers"', add
label define occ1990_lbl 755 `"Extruding and forming machine operators"', add
label define occ1990_lbl 756 `"Mixing and blending machine operatives"', add
label define occ1990_lbl 757 `"Separating, filtering, and clarifying machine operators"', add
label define occ1990_lbl 759 `"Painting machine operators"', add
label define occ1990_lbl 763 `"Roasting and baking machine operators (food)"', add
label define occ1990_lbl 764 `"Washing, cleaning, and pickling machine operators"', add
label define occ1990_lbl 765 `"Paper folding machine operators"', add
label define occ1990_lbl 766 `"Furnace, kiln, and oven operators, apart from food"', add
label define occ1990_lbl 768 `"Crushing and grinding machine operators"', add
label define occ1990_lbl 769 `"Slicing and cutting machine operators"', add
label define occ1990_lbl 773 `"Motion picture projectionists"', add
label define occ1990_lbl 774 `"Photographic process workers"', add
label define occ1990_lbl 779 `"Machine operators, n.e.c."', add
label define occ1990_lbl 783 `"Welders and metal cutters"', add
label define occ1990_lbl 784 `"Solderers"', add
label define occ1990_lbl 785 `"Assemblers of electrical equipment"', add
label define occ1990_lbl 789 `"Hand painting, coating, and decorating occupations"', add
label define occ1990_lbl 796 `"Production checkers and inspectors"', add
label define occ1990_lbl 799 `"Graders and sorters in manufacturing"', add
label define occ1990_lbl 803 `"Supervisors of motor vehicle transportation"', add
label define occ1990_lbl 804 `"Truck, delivery, and tractor drivers"', add
label define occ1990_lbl 808 `"Bus drivers"', add
label define occ1990_lbl 809 `"Taxi cab drivers and chauffeurs"', add
label define occ1990_lbl 813 `"Parking lot attendants"', add
label define occ1990_lbl 823 `"Railroad conductors and yardmasters"', add
label define occ1990_lbl 824 `"Locomotive operators (engineers and firemen)"', add
label define occ1990_lbl 825 `"Railroad brake, coupler, and switch operators"', add
label define occ1990_lbl 829 `"Ship crews and marine engineers"', add
label define occ1990_lbl 834 `"Water transport infrastructure tenders and crossing guards"', add
label define occ1990_lbl 844 `"Operating engineers of construction equipment"', add
label define occ1990_lbl 848 `"Crane, derrick, winch, and hoist operators"', add
label define occ1990_lbl 853 `"Excavating and loading machine operators"', add
label define occ1990_lbl 859 `"Misc material moving occupations"', add
label define occ1990_lbl 865 `"Helpers, constructions"', add
label define occ1990_lbl 866 `"Helpers, surveyors"', add
label define occ1990_lbl 869 `"Construction laborers"', add
label define occ1990_lbl 874 `"Production helpers"', add
label define occ1990_lbl 875 `"Garbage and recyclable material collectors"', add
label define occ1990_lbl 876 `"Materials movers: stevedores and longshore workers"', add
label define occ1990_lbl 877 `"Stock handlers"', add
label define occ1990_lbl 878 `"Machine feeders and offbearers"', add
label define occ1990_lbl 883 `"Freight, stock, and materials handlers"', add
label define occ1990_lbl 885 `"Garage and service station related occupations"', add
label define occ1990_lbl 887 `"Vehicle washers and equipment cleaners"', add
label define occ1990_lbl 888 `"Packers and packagers by hand"', add
label define occ1990_lbl 889 `"Laborers outside construction"', add
label define occ1990_lbl 905 `"Military"', add
label define occ1990_lbl 991 `"Unemployed"', add
label define occ1990_lbl 999 `"Unknown"', add
label values occ1990 occ1990_lbl

label define occ2010_lbl 0010 `"Chief executives and legislators"'
label define occ2010_lbl 0020 `"General and Operations Managers"', add
label define occ2010_lbl 0040 `"Advertising and Promotions Managers"', add
label define occ2010_lbl 0050 `"Marketing and Sales Managers"', add
label define occ2010_lbl 0060 `"Public Relations and Fundraising Managers"', add
label define occ2010_lbl 0100 `"Administrative Services Managers"', add
label define occ2010_lbl 0110 `"Computer and Information Systems Managers"', add
label define occ2010_lbl 0120 `"Financial Managers"', add
label define occ2010_lbl 0135 `"Compensation and benefits managers"', add
label define occ2010_lbl 0136 `"Human Resources Managers"', add
label define occ2010_lbl 0137 `"Training and development managers"', add
label define occ2010_lbl 0140 `"Industrial Production Managers"', add
label define occ2010_lbl 0150 `"Purchasing Managers"', add
label define occ2010_lbl 0160 `"Transportation, Storage, and Distribution Managers"', add
label define occ2010_lbl 0205 `"Farmers, Ranchers, and Other Agricultural Managers"', add
label define occ2010_lbl 0220 `"Construction Managers"', add
label define occ2010_lbl 0230 `"Education Administrators"', add
label define occ2010_lbl 0300 `"Architectural and Engineering Managers"', add
label define occ2010_lbl 0310 `"Food Service Managers"', add
label define occ2010_lbl 0330 `"Gaming Managers"', add
label define occ2010_lbl 0340 `"Lodging Managers"', add
label define occ2010_lbl 0350 `"Medical and Health Services Managers"', add
label define occ2010_lbl 0360 `"Natural Sciences Managers"', add
label define occ2010_lbl 0410 `"Property, Real Estate, and Community Association Managers"', add
label define occ2010_lbl 0420 `"Social and Community Service Managers"', add
label define occ2010_lbl 0425 `"Emergency management directors"', add
label define occ2010_lbl 0430 `"Miscellaneous managers, including funeral service managers and postmasters and mail superintendents"', add
label define occ2010_lbl 0500 `"Agents and Business Managers of Artists, Performers, and Athletes"', add
label define occ2010_lbl 0510 `"Buyers and Purchasing Agents, Farm Products"', add
label define occ2010_lbl 0520 `"Wholesale and Retail Buyers, Except Farm Products"', add
label define occ2010_lbl 0530 `"Purchasing Agents, Except Wholesale, Retail, and Farm Products"', add
label define occ2010_lbl 0540 `"Claims Adjusters, Appraisers, Examiners, and Investigators"', add
label define occ2010_lbl 0565 `"Compliance Officers"', add
label define occ2010_lbl 0600 `"Cost Estimators"', add
label define occ2010_lbl 0630 `"Human Resources Workers"', add
label define occ2010_lbl 0640 `"Compensation, benefits, and job analysis specialists"', add
label define occ2010_lbl 0650 `"Training and development specialists"', add
label define occ2010_lbl 0700 `"Logisticians"', add
label define occ2010_lbl 0710 `"Management Analysts"', add
label define occ2010_lbl 0725 `"Meeting, Convention, and Event Planners"', add
label define occ2010_lbl 0726 `"Fundraisers"', add
label define occ2010_lbl 0735 `"Market Research Analysts and Marketing Specialists"', add
label define occ2010_lbl 0740 `"Business Operations Specialists, All Other"', add
label define occ2010_lbl 0800 `"Accountants and Auditors"', add
label define occ2010_lbl 0810 `"Appraisers and Assessors of Real Estate"', add
label define occ2010_lbl 0820 `"Budget Analysts"', add
label define occ2010_lbl 0830 `"Credit Analysts"', add
label define occ2010_lbl 0840 `"Financial Analysts"', add
label define occ2010_lbl 0850 `"Personal Financial Advisors"', add
label define occ2010_lbl 0860 `"Insurance Underwriters"', add
label define occ2010_lbl 0900 `"Financial Examiners"', add
label define occ2010_lbl 0910 `"Credit Counselors and Loan Officers"', add
label define occ2010_lbl 0930 `"Tax Examiners and Collectors, and Revenue Agents"', add
label define occ2010_lbl 0940 `"Tax Preparers"', add
label define occ2010_lbl 0950 `"Financial Specialists, All Other"', add
label define occ2010_lbl 1005 `"Computer and information research scientists"', add
label define occ2010_lbl 1006 `"Computer Systems Analysts"', add
label define occ2010_lbl 1007 `"Information security analysts"', add
label define occ2010_lbl 1010 `"Computer Programmers"', add
label define occ2010_lbl 1020 `"Software Developers, Applications and Systems Software"', add
label define occ2010_lbl 1030 `"Web Developers"', add
label define occ2010_lbl 1050 `"Computer Support Specialists"', add
label define occ2010_lbl 1060 `"Database Administrators"', add
label define occ2010_lbl 1105 `"Network and Computer Systems Administrators"', add
label define occ2010_lbl 1106 `"Computer network architects"', add
label define occ2010_lbl 1107 `"Computer occupations, all other"', add
label define occ2010_lbl 1200 `"Actuaries"', add
label define occ2010_lbl 1220 `"Operations Research Analysts"', add
label define occ2010_lbl 1240 `"Miscellaneous mathematical science occupations, including mathematicians and statisticians"', add
label define occ2010_lbl 1300 `"Architects, Except Naval"', add
label define occ2010_lbl 1310 `"Surveyors, Cartographers, and Photogrammetrists"', add
label define occ2010_lbl 1320 `"Aerospace Engineers"', add
label define occ2010_lbl 1340 `"Biomedical and agricultural engineers"', add
label define occ2010_lbl 1350 `"Chemical Engineers"', add
label define occ2010_lbl 1360 `"Civil Engineers"', add
label define occ2010_lbl 1400 `"Computer Hardware Engineers"', add
label define occ2010_lbl 1410 `"Electrical and Electronics Engineers"', add
label define occ2010_lbl 1420 `"Environmental Engineers"', add
label define occ2010_lbl 1430 `"Industrial Engineers, including Health and Safety"', add
label define occ2010_lbl 1440 `"Marine Engineers and Naval Architects"', add
label define occ2010_lbl 1450 `"Materials Engineers"', add
label define occ2010_lbl 1460 `"Mechanical Engineers"', add
label define occ2010_lbl 1520 `"Petroleum, mining and geological engineers, including mining safety engineers"', add
label define occ2010_lbl 1530 `"Miscellaneous engineers, including nuclear engineers"', add
label define occ2010_lbl 1540 `"Drafters"', add
label define occ2010_lbl 1550 `"Engineering Technicians, Except Drafters"', add
label define occ2010_lbl 1560 `"Surveying and Mapping Technicians"', add
label define occ2010_lbl 1600 `"Agricultural and Food Scientists"', add
label define occ2010_lbl 1610 `"Biological Scientists"', add
label define occ2010_lbl 1640 `"Conservation Scientists and Foresters"', add
label define occ2010_lbl 1650 `"Medical scientists, and life scientists, all other"', add
label define occ2010_lbl 1700 `"Astronomers and Physicists"', add
label define occ2010_lbl 1710 `"Atmospheric and Space Scientists"', add
label define occ2010_lbl 1720 `"Chemists and Materials Scientists"', add
label define occ2010_lbl 1740 `"Environmental Scientists and Geoscientists"', add
label define occ2010_lbl 1760 `"Physical Scientists, All Other"', add
label define occ2010_lbl 1800 `"Economists"', add
label define occ2010_lbl 1820 `"Psychologists"', add
label define occ2010_lbl 1840 `"Urban and Regional Planners"', add
label define occ2010_lbl 1860 `"Miscellaneous social scientists, including survey researchers and sociologists"', add
label define occ2010_lbl 1900 `"Agricultural and Food Science Technicians"', add
label define occ2010_lbl 1910 `"Biological Technicians"', add
label define occ2010_lbl 1920 `"Chemical Technicians"', add
label define occ2010_lbl 1930 `"Geological and petroleum technicians, and nuclear technicians"', add
label define occ2010_lbl 1965 `"Miscellaneous life, physical, and social science technicians, including social science research assistants"', add
label define occ2010_lbl 2000 `"Counselors"', add
label define occ2010_lbl 2010 `"Social Workers"', add
label define occ2010_lbl 2015 `"Probation officers and correctional treatment specialists"', add
label define occ2010_lbl 2016 `"Social and human service assistants"', add
label define occ2010_lbl 2025 `"Miscellaneous community and social service specialists, including health educators and community health workers"', add
label define occ2010_lbl 2040 `"Clergy"', add
label define occ2010_lbl 2050 `"Directors, Religious Activities and Education"', add
label define occ2010_lbl 2060 `"Religious Workers, All Other"', add
label define occ2010_lbl 2100 `"Lawyers, and judges, magistrates, and other judicial workers"', add
label define occ2010_lbl 2105 `"Judicial law clerks"', add
label define occ2010_lbl 2145 `"Paralegals and Legal Assistants"', add
label define occ2010_lbl 2160 `"Miscellaneous Legal Support Workers"', add
label define occ2010_lbl 2200 `"Postsecondary Teachers"', add
label define occ2010_lbl 2300 `"Preschool and Kindergarten Teachers"', add
label define occ2010_lbl 2310 `"Elementary and Middle School Teachers"', add
label define occ2010_lbl 2320 `"Secondary School Teachers"', add
label define occ2010_lbl 2330 `"Special Education Teachers"', add
label define occ2010_lbl 2340 `"Other Teachers and Instructors"', add
label define occ2010_lbl 2400 `"Archivists, Curators, and Museum Technicians"', add
label define occ2010_lbl 2430 `"Librarians"', add
label define occ2010_lbl 2440 `"Library Technicians"', add
label define occ2010_lbl 2540 `"Teacher Assistants"', add
label define occ2010_lbl 2550 `"Other Education, Training, and Library Workers"', add
label define occ2010_lbl 2600 `"Artists and Related Workers"', add
label define occ2010_lbl 2630 `"Designers"', add
label define occ2010_lbl 2700 `"Actors"', add
label define occ2010_lbl 2710 `"Producers and Directors"', add
label define occ2010_lbl 2720 `"Athletes, Coaches, Umpires, and Related Workers"', add
label define occ2010_lbl 2740 `"Dancers and Choreographers"', add
label define occ2010_lbl 2750 `"Musicians, Singers, and Related Workers"', add
label define occ2010_lbl 2760 `"Entertainers and Performers, Sports and Related Workers, All Other"', add
label define occ2010_lbl 2800 `"Announcers"', add
label define occ2010_lbl 2810 `"News Analysts, Reporters and Correspondents"', add
label define occ2010_lbl 2825 `"Public Relations Specialists"', add
label define occ2010_lbl 2830 `"Editors"', add
label define occ2010_lbl 2840 `"Technical Writers"', add
label define occ2010_lbl 2850 `"Writers and Authors"', add
label define occ2010_lbl 2860 `"Miscellaneous Media and Communication Workers"', add
label define occ2010_lbl 2900 `"Broadcast and sound engineering technicians and radio operators, and media and communication equipment workers, all other"', add
label define occ2010_lbl 2910 `"Photographers"', add
label define occ2010_lbl 2920 `"Television, Video, and Motion Picture Camera Operators and Editors"', add
label define occ2010_lbl 3000 `"Chiropractors"', add
label define occ2010_lbl 3010 `"Dentists"', add
label define occ2010_lbl 3030 `"Dietitians and Nutritionists"', add
label define occ2010_lbl 3040 `"Optometrists"', add
label define occ2010_lbl 3050 `"Pharmacists"', add
label define occ2010_lbl 3060 `"Physicians and Surgeons"', add
label define occ2010_lbl 3110 `"Physician Assistants"', add
label define occ2010_lbl 3120 `"Podiatrists"', add
label define occ2010_lbl 3140 `"Audiologists"', add
label define occ2010_lbl 3150 `"Occupational Therapists"', add
label define occ2010_lbl 3160 `"Physical Therapists"', add
label define occ2010_lbl 3200 `"Radiation Therapists"', add
label define occ2010_lbl 3210 `"Recreational Therapists"', add
label define occ2010_lbl 3220 `"Respiratory Therapists"', add
label define occ2010_lbl 3230 `"Speech-Language Pathologists"', add
label define occ2010_lbl 3245 `"Other therapists, including exercise physiologists"', add
label define occ2010_lbl 3250 `"Veterinarians"', add
label define occ2010_lbl 3255 `"Registered Nurses"', add
label define occ2010_lbl 3256 `"Nurse anesthetists"', add
label define occ2010_lbl 3258 `"Nurse practitioners and nurse midwives"', add
label define occ2010_lbl 3260 `"Health Diagnosing and Treating Practitioners, All Other"', add
label define occ2010_lbl 3300 `"Clinical Laboratory Technologists and Technicians"', add
label define occ2010_lbl 3310 `"Dental Hygienists"', add
label define occ2010_lbl 3320 `"Diagnostic Related Technologists and Technicians"', add
label define occ2010_lbl 3400 `"Emergency Medical Technicians and Paramedics"', add
label define occ2010_lbl 3420 `"Health Practitioner Support Technologists and  Technicians"', add
label define occ2010_lbl 3500 `"Licensed Practical and Licensed Vocational Nurses"', add
label define occ2010_lbl 3510 `"Medical Records and Health Information Technicians"', add
label define occ2010_lbl 3520 `"Opticians, Dispensing"', add
label define occ2010_lbl 3535 `"Miscellaneous Health Technologists and Technicians"', add
label define occ2010_lbl 3540 `"Other Healthcare Practitioners and Technical Occupations"', add
label define occ2010_lbl 3600 `"Nursing, Psychiatric, and Home Health Aides"', add
label define occ2010_lbl 3610 `"Occupational Therapy Assistants and Aides"', add
label define occ2010_lbl 3620 `"Physical Therapist Assistants and Aides"', add
label define occ2010_lbl 3630 `"Massage Therapists"', add
label define occ2010_lbl 3640 `"Dental Assistants"', add
label define occ2010_lbl 3645 `"Medical Assistants"', add
label define occ2010_lbl 3646 `"Medical transcriptionists"', add
label define occ2010_lbl 3647 `"Pharmacy aides"', add
label define occ2010_lbl 3648 `"Veterinary assistants and laboratory animal caretakers"', add
label define occ2010_lbl 3649 `"Phlebotomists"', add
label define occ2010_lbl 3655 `"Healthcare support workers, all other, including medical equipment preparers"', add
label define occ2010_lbl 3700 `"First-Line Supervisors of Correctional Officers"', add
label define occ2010_lbl 3710 `"First-Line Supervisors of Police and Detectives"', add
label define occ2010_lbl 3720 `"First-Line Supervisors of Fire Fighting and Prevention Workers"', add
label define occ2010_lbl 3730 `"First-Line Supervisors of Protective Service Workers, All Other"', add
label define occ2010_lbl 3740 `"Firefighters"', add
label define occ2010_lbl 3750 `"Fire Inspectors"', add
label define occ2010_lbl 3800 `"Bailiffs, Correctional Officers, and Jailers"', add
label define occ2010_lbl 3820 `"Detectives and Criminal Investigators"', add
label define occ2010_lbl 3840 `"Miscellaneous law enforcement workers"', add
label define occ2010_lbl 3850 `"Police officers"', add
label define occ2010_lbl 3900 `"Animal Control Workers"', add
label define occ2010_lbl 3910 `"Private Detectives and Investigators"', add
label define occ2010_lbl 3930 `"Security Guards and Gaming Surveillance Officers"', add
label define occ2010_lbl 3940 `"Crossing Guards"', add
label define occ2010_lbl 3945 `"Transportation security screeners"', add
label define occ2010_lbl 3955 `"Lifeguards and Other Recreational, and All Other Protective Service Workers"', add
label define occ2010_lbl 4000 `"Chefs and Head Cooks"', add
label define occ2010_lbl 4010 `"First-Line Supervisors of Food Preparation and Serving Workers"', add
label define occ2010_lbl 4020 `"Cooks"', add
label define occ2010_lbl 4030 `"Food Preparation Workers"', add
label define occ2010_lbl 4040 `"Bartenders"', add
label define occ2010_lbl 4050 `"Combined Food Preparation and Serving Workers, Including Fast Food"', add
label define occ2010_lbl 4060 `"Counter Attendants, Cafeteria, Food Concession, and Coffee Shop"', add
label define occ2010_lbl 4110 `"Waiters and Waitresses"', add
label define occ2010_lbl 4120 `"Food Servers, Nonrestaurant"', add
label define occ2010_lbl 4130 `"Miscellaneous food preparation and serving related workers, including dining room and cafeteria attendants and bartender helpers"', add
label define occ2010_lbl 4140 `"Dishwashers"', add
label define occ2010_lbl 4150 `"Hosts and Hostesses, Restaurant, Lounge, and Coffee Shop"', add
label define occ2010_lbl 4200 `"First-Line Supervisors of Housekeeping and Janitorial Workers"', add
label define occ2010_lbl 4210 `"First-Line Supervisors of Landscaping, Lawn Service, and Groundskeeping Workers"', add
label define occ2010_lbl 4220 `"Janitors and Building Cleaners"', add
label define occ2010_lbl 4230 `"Maids and housekeeping cleaners"', add
label define occ2010_lbl 4240 `"Pest Control Workers"', add
label define occ2010_lbl 4250 `"Grounds Maintenance Workers"', add
label define occ2010_lbl 4300 `"First-Line Supervisors of Gaming Workers"', add
label define occ2010_lbl 4320 `"First-Line Supervisors of Personal Service Workers"', add
label define occ2010_lbl 4340 `"Animal Trainers"', add
label define occ2010_lbl 4350 `"Nonfarm Animal Caretakers"', add
label define occ2010_lbl 4400 `"Gaming Services Workers"', add
label define occ2010_lbl 4410 `"Motion Picture Projectionists"', add
label define occ2010_lbl 4420 `"Ushers, Lobby Attendants, and Ticket Takers"', add
label define occ2010_lbl 4430 `"Miscellaneous Entertainment Attendants and Related Workers"', add
label define occ2010_lbl 4460 `"Embalmers and Funeral Attendants"', add
label define occ2010_lbl 4465 `"Morticians, undertakers, and funeral directors"', add
label define occ2010_lbl 4500 `"Barbers"', add
label define occ2010_lbl 4510 `"Hairdressers, Hairstylists, and Cosmetologists"', add
label define occ2010_lbl 4520 `"Miscellaneous Personal Appearance Workers"', add
label define occ2010_lbl 4530 `"Baggage Porters, Bellhops, and Concierges"', add
label define occ2010_lbl 4540 `"Tour and Travel Guides"', add
label define occ2010_lbl 4600 `"Childcare Workers"', add
label define occ2010_lbl 4610 `"Personal Care Aides"', add
label define occ2010_lbl 4620 `"Recreation and Fitness Workers"', add
label define occ2010_lbl 4640 `"Residential Advisors"', add
label define occ2010_lbl 4650 `"Personal Care and Service Workers, All Other"', add
label define occ2010_lbl 4700 `"First-Line Supervisors of Retail Sales Workers"', add
label define occ2010_lbl 4710 `"First-Line Supervisors of Non-Retail Sales Workers"', add
label define occ2010_lbl 4720 `"Cashiers"', add
label define occ2010_lbl 4740 `"Counter and Rental Clerks"', add
label define occ2010_lbl 4750 `"Parts Salespersons"', add
label define occ2010_lbl 4760 `"Retail Salespersons"', add
label define occ2010_lbl 4800 `"Advertising Sales Agents"', add
label define occ2010_lbl 4810 `"Insurance Sales Agents"', add
label define occ2010_lbl 4820 `"Securities, Commodities, and Financial Services Sales Agents"', add
label define occ2010_lbl 4830 `"Travel Agents"', add
label define occ2010_lbl 4840 `"Sales Representatives, Services, All Other"', add
label define occ2010_lbl 4850 `"Sales Representatives, Wholesale and Manufacturing"', add
label define occ2010_lbl 4900 `"Models, Demonstrators, and Product Promoters"', add
label define occ2010_lbl 4920 `"Real Estate Brokers and Sales Agents"', add
label define occ2010_lbl 4930 `"Sales Engineers"', add
label define occ2010_lbl 4940 `"Telemarketers"', add
label define occ2010_lbl 4950 `"Door-to-Door Sales Workers, News and Street Vendors, and Related Workers"', add
label define occ2010_lbl 4965 `"Sales and Related Workers, All Other"', add
label define occ2010_lbl 5000 `"First-Line Supervisors of Office and Administrative Support Workers"', add
label define occ2010_lbl 5010 `"Switchboard Operators, Including Answering Service"', add
label define occ2010_lbl 5020 `"Telephone Operators"', add
label define occ2010_lbl 5030 `"Communications Equipment Operators, All Other"', add
label define occ2010_lbl 5100 `"Bill and Account Collectors"', add
label define occ2010_lbl 5110 `"Billing and Posting Clerks"', add
label define occ2010_lbl 5120 `"Bookkeeping, Accounting, and Auditing Clerks"', add
label define occ2010_lbl 5130 `"Gaming Cage Workers"', add
label define occ2010_lbl 5140 `"Payroll and Timekeeping Clerks"', add
label define occ2010_lbl 5150 `"Procurement Clerks"', add
label define occ2010_lbl 5160 `"Tellers"', add
label define occ2010_lbl 5165 `"Financial clerks, all other"', add
label define occ2010_lbl 5200 `"Brokerage Clerks"', add
label define occ2010_lbl 5220 `"Court, Municipal, and License Clerks"', add
label define occ2010_lbl 5230 `"Credit Authorizers, Checkers, and Clerks"', add
label define occ2010_lbl 5240 `"Customer Service Representatives"', add
label define occ2010_lbl 5250 `"Eligibility Interviewers, Government Programs"', add
label define occ2010_lbl 5260 `"File Clerks"', add
label define occ2010_lbl 5300 `"Hotel, Motel, and Resort Desk Clerks"', add
label define occ2010_lbl 5310 `"Interviewers, Except Eligibility and Loan"', add
label define occ2010_lbl 5320 `"Library Assistants, Clerical"', add
label define occ2010_lbl 5330 `"Loan Interviewers and Clerks"', add
label define occ2010_lbl 5340 `"New Accounts Clerks"', add
label define occ2010_lbl 5350 `"Correspondence clerks and order clerks"', add
label define occ2010_lbl 5360 `"Human resources assistants, except payroll and timekeeping"', add
label define occ2010_lbl 5400 `"Receptionists and Information Clerks"', add
label define occ2010_lbl 5410 `"Reservation and Transportation Ticket Agents and Travel Clerks"', add
label define occ2010_lbl 5420 `"Information and Record Clerks, All Other"', add
label define occ2010_lbl 5500 `"Cargo and Freight Agents"', add
label define occ2010_lbl 5510 `"Couriers and Messengers"', add
label define occ2010_lbl 5520 `"Dispatchers"', add
label define occ2010_lbl 5530 `"Meter Readers, Utilities"', add
label define occ2010_lbl 5540 `"Postal Service Clerks"', add
label define occ2010_lbl 5550 `"Postal Service Mail Carriers"', add
label define occ2010_lbl 5560 `"Postal Service Mail Sorters, Processors, and Processing Machine Operators"', add
label define occ2010_lbl 5600 `"Production, Planning, and Expediting Clerks"', add
label define occ2010_lbl 5610 `"Shipping, Receiving, and Traffic Clerks"', add
label define occ2010_lbl 5620 `"Stock Clerks and Order Fillers"', add
label define occ2010_lbl 5630 `"Weighers, Measurers, Checkers, and Samplers, Recordkeeping"', add
label define occ2010_lbl 5700 `"Secretaries and Administrative Assistants"', add
label define occ2010_lbl 5800 `"Computer Operators"', add
label define occ2010_lbl 5810 `"Data Entry Keyers"', add
label define occ2010_lbl 5820 `"Word Processors and Typists"', add
label define occ2010_lbl 5840 `"Insurance Claims and Policy Processing Clerks"', add
label define occ2010_lbl 5850 `"Mail Clerks and Mail Machine Operators, Except Postal Service"', add
label define occ2010_lbl 5860 `"Office Clerks, General"', add
label define occ2010_lbl 5900 `"Office Machine Operators, Except Computer"', add
label define occ2010_lbl 5910 `"Proofreaders and Copy Markers"', add
label define occ2010_lbl 5920 `"Statistical Assistants"', add
label define occ2010_lbl 5940 `"Miscellaneous office and administrative support workers, including desktop publishers"', add
label define occ2010_lbl 6005 `"First-line supervisors of farming, fishing, and forestry workers"', add
label define occ2010_lbl 6010 `"Agricultural Inspectors"', add
label define occ2010_lbl 6040 `"Graders and Sorters, Agricultural Products"', add
label define occ2010_lbl 6050 `"Miscellaneous agricultural workers, including animal breeders"', add
label define occ2010_lbl 6100 `"Fishing and hunting workers"', add
label define occ2010_lbl 6120 `"Forest and Conservation Workers"', add
label define occ2010_lbl 6130 `"Logging Workers"', add
label define occ2010_lbl 6200 `"First-Line Supervisors of Construction Trades and Extraction Workers"', add
label define occ2010_lbl 6210 `"Boilermakers"', add
label define occ2010_lbl 6220 `"Brickmasons, blockmasons, stonemasons, and reinforcing iron and rebar workers"', add
label define occ2010_lbl 6230 `"Carpenters"', add
label define occ2010_lbl 6240 `"Carpet, Floor, and Tile Installers and Finishers"', add
label define occ2010_lbl 6250 `"Cement Masons, Concrete Finishers, and Terrazzo Workers"', add
label define occ2010_lbl 6260 `"Construction Laborers"', add
label define occ2010_lbl 6300 `"Paving, Surfacing, and Tamping Equipment Operators"', add
label define occ2010_lbl 6320 `"Construction equipment operators except paving, surfacing, and tamping equipment operators"', add
label define occ2010_lbl 6330 `"Drywall Installers, Ceiling Tile Installers, and Tapers"', add
label define occ2010_lbl 6355 `"Electricians"', add
label define occ2010_lbl 6360 `"Glaziers"', add
label define occ2010_lbl 6400 `"Insulation Workers"', add
label define occ2010_lbl 6420 `"Painters and paperhangers"', add
label define occ2010_lbl 6440 `"Pipelayers, Plumbers, Pipefitters, and Steamfitters"', add
label define occ2010_lbl 6460 `"Plasterers and Stucco Masons"', add
label define occ2010_lbl 6515 `"Roofers"', add
label define occ2010_lbl 6520 `"Sheet Metal Workers"', add
label define occ2010_lbl 6530 `"Structural Iron and Steel Workers"', add
label define occ2010_lbl 6600 `"Helpers, Construction Trades"', add
label define occ2010_lbl 6660 `"Construction and Building Inspectors"', add
label define occ2010_lbl 6700 `"Elevator Installers and Repairers"', add
label define occ2010_lbl 6710 `"Fence Erectors"', add
label define occ2010_lbl 6720 `"Hazardous Materials Removal Workers"', add
label define occ2010_lbl 6730 `"Highway Maintenance Workers"', add
label define occ2010_lbl 6740 `"Rail-Track Laying and Maintenance Equipment Operators"', add
label define occ2010_lbl 6765 `"Miscellaneous construction workers, including solar photovoltaic installers, septic tank servicers and sewer pipe cleaners"', add
label define occ2010_lbl 6800 `"Derrick, rotary drill, and service unit operators, and roustabouts, oil, gas, and mining"', add
label define occ2010_lbl 6820 `"Earth Drillers, Except Oil and Gas"', add
label define occ2010_lbl 6830 `"Explosives Workers, Ordnance Handling Experts, and Blasters"', add
label define occ2010_lbl 6840 `"Mining Machine Operators"', add
label define occ2010_lbl 6940 `"Miscellaneous extraction workers, including roof bolters and helpers"', add
label define occ2010_lbl 7000 `"First-Line Supervisors of Mechanics, Installers, and Repairers"', add
label define occ2010_lbl 7010 `"Computer, Automated Teller, and Office Machine Repairers"', add
label define occ2010_lbl 7020 `"Radio and Telecommunications Equipment Installers and Repairers"', add
label define occ2010_lbl 7030 `"Avionics Technicians"', add
label define occ2010_lbl 7040 `"Electric Motor, Power Tool, and Related Repairers"', add
label define occ2010_lbl 7100 `"Electrical and electronics repairers, transportation equipment, and industrial and utility"', add
label define occ2010_lbl 7110 `"Electronic Equipment Installers and Repairers, Motor Vehicles"', add
label define occ2010_lbl 7120 `"Electronic Home Entertainment Equipment Installers and Repairers"', add
label define occ2010_lbl 7130 `"Security and Fire Alarm Systems Installers"', add
label define occ2010_lbl 7140 `"Aircraft Mechanics and Service Technicians"', add
label define occ2010_lbl 7150 `"Automotive Body and Related Repairers"', add
label define occ2010_lbl 7160 `"Automotive Glass Installers and Repairers"', add
label define occ2010_lbl 7200 `"Automotive Service Technicians and Mechanics"', add
label define occ2010_lbl 7210 `"Bus and Truck Mechanics and Diesel Engine Specialists"', add
label define occ2010_lbl 7220 `"Heavy Vehicle and Mobile Equipment Service Technicians and Mechanics"', add
label define occ2010_lbl 7240 `"Small Engine Mechanics"', add
label define occ2010_lbl 7260 `"Miscellaneous Vehicle and Mobile Equipment Mechanics, Installers, and Repairers"', add
label define occ2010_lbl 7300 `"Control and Valve Installers and Repairers"', add
label define occ2010_lbl 7315 `"Heating, Air Conditioning, and Refrigeration Mechanics and Installers"', add
label define occ2010_lbl 7320 `"Home Appliance Repairers"', add
label define occ2010_lbl 7330 `"Industrial and Refractory Machinery Mechanics"', add
label define occ2010_lbl 7340 `"Maintenance and Repair Workers, General"', add
label define occ2010_lbl 7350 `"Maintenance Workers, Machinery"', add
label define occ2010_lbl 7360 `"Millwrights"', add
label define occ2010_lbl 7410 `"Electrical Power-Line Installers and Repairers"', add
label define occ2010_lbl 7420 `"Telecommunications Line Installers and Repairers"', add
label define occ2010_lbl 7430 `"Precision Instrument and Equipment Repairers"', add
label define occ2010_lbl 7510 `"Coin, Vending, and Amusement Machine Servicers and Repairers"', add
label define occ2010_lbl 7540 `"Locksmiths and Safe Repairers"', add
label define occ2010_lbl 7560 `"Riggers"', add
label define occ2010_lbl 7610 `"Helpers--Installation, Maintenance, and Repair Workers"', add
label define occ2010_lbl 7630 `"Miscellaneous installation, maintenance, and repair workers, including wind turbine service technicians"', add
label define occ2010_lbl 7700 `"First-Line Supervisors of Production and Operating Workers"', add
label define occ2010_lbl 7710 `"Aircraft Structure, Surfaces, Rigging, and Systems Assemblers"', add
label define occ2010_lbl 7720 `"Electrical, Electronics, and Electromechanical Assemblers"', add
label define occ2010_lbl 7730 `"Engine and Other Machine Assemblers"', add
label define occ2010_lbl 7740 `"Structural Metal Fabricators and Fitters"', add
label define occ2010_lbl 7750 `"Miscellaneous Assemblers and Fabricators"', add
label define occ2010_lbl 7800 `"Bakers"', add
label define occ2010_lbl 7810 `"Butchers and Other Meat, Poultry, and Fish Processing Workers"', add
label define occ2010_lbl 7830 `"Food and Tobacco Roasting, Baking, and Drying Machine Operators and Tenders"', add
label define occ2010_lbl 7840 `"Food Batchmakers"', add
label define occ2010_lbl 7850 `"Food Cooking Machine Operators and Tenders"', add
label define occ2010_lbl 7855 `"Food processing workers, all other"', add
label define occ2010_lbl 7900 `"Computer Control Programmers and Operators"', add
label define occ2010_lbl 7920 `"Extruding and Drawing Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 7930 `"Forging Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 7940 `"Rolling Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 7950 `"Machine tool cutting setters, operators, and tenders, metal and plastic"', add
label define occ2010_lbl 8030 `"Machinists"', add
label define occ2010_lbl 8040 `"Metal Furnace Operators, Tenders, Pourers, and Casters"', add
label define occ2010_lbl 8100 `"Model makers, patternmakers, and molding machine setters, metal and plastic"', add
label define occ2010_lbl 8130 `"Tool and Die Makers"', add
label define occ2010_lbl 8140 `"Welding, Soldering, and Brazing Workers"', add
label define occ2010_lbl 8220 `"Miscellaneous metal workers and plastic workers, including multiple machine tool setters"', add
label define occ2010_lbl 8250 `"Prepress Technicians and Workers"', add
label define occ2010_lbl 8255 `"Printing Press Operators"', add
label define occ2010_lbl 8256 `"Print Binding and Finishing Workers"', add
label define occ2010_lbl 8300 `"Laundry and Dry-Cleaning Workers"', add
label define occ2010_lbl 8310 `"Pressers, Textile, Garment, and Related Materials"', add
label define occ2010_lbl 8320 `"Sewing Machine Operators"', add
label define occ2010_lbl 8330 `"Shoe and leather workers"', add
label define occ2010_lbl 8350 `"Tailors, Dressmakers, and Sewers"', add
label define occ2010_lbl 8400 `"Textile bleaching and dyeing, and cutting machine setters, operators, and tenders"', add
label define occ2010_lbl 8410 `"Textile Knitting and Weaving Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8420 `"Textile Winding, Twisting, and Drawing Out Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8450 `"Upholsterers"', add
label define occ2010_lbl 8460 `"Miscellaneous textile, apparel, and furnishings workers except upholsterers"', add
label define occ2010_lbl 8500 `"Cabinetmakers and Bench Carpenters"', add
label define occ2010_lbl 8510 `"Furniture Finishers"', add
label define occ2010_lbl 8530 `"Sawing Machine Setters, Operators, and Tenders, Wood"', add
label define occ2010_lbl 8540 `"Woodworking Machine Setters, Operators, and Tenders, Except Sawing"', add
label define occ2010_lbl 8550 `"Miscellaneous woodworkers, including model makers and patternmakers"', add
label define occ2010_lbl 8600 `"Power Plant Operators, Distributors, and Dispatchers"', add
label define occ2010_lbl 8610 `"Stationary Engineers and Boiler Operators"', add
label define occ2010_lbl 8620 `"Water and Wastewater Treatment Plant and System Operators"', add
label define occ2010_lbl 8630 `"Miscellaneous Plant and System Operators"', add
label define occ2010_lbl 8640 `"Chemical Processing Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8650 `"Crushing, Grinding, Polishing, Mixing, and Blending Workers"', add
label define occ2010_lbl 8710 `"Cutting Workers"', add
label define occ2010_lbl 8720 `"Extruding, Forming, Pressing, and Compacting Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8730 `"Furnace, Kiln, Oven, Drier, and Kettle Operators and Tenders"', add
label define occ2010_lbl 8740 `"Inspectors, Testers, Sorters, Samplers, and Weighers"', add
label define occ2010_lbl 8750 `"Jewelers and Precious Stone and Metal Workers"', add
label define occ2010_lbl 8760 `"Medical, Dental, and Ophthalmic Laboratory Technicians"', add
label define occ2010_lbl 8800 `"Packaging and Filling Machine Operators and Tenders"', add
label define occ2010_lbl 8810 `"Painting Workers"', add
label define occ2010_lbl 8830 `"Photographic Process Workers and Processing Machine Operators"', add
label define occ2010_lbl 8850 `"Adhesive Bonding Machine Operators and Tenders"', add
label define occ2010_lbl 8910 `"Etchers and Engravers"', add
label define occ2010_lbl 8920 `"Molders, Shapers, and Casters, Except Metal and Plastic"', add
label define occ2010_lbl 8930 `"Paper Goods Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8940 `"Tire Builders"', add
label define occ2010_lbl 8950 `"Helpers--Production Workers"', add
label define occ2010_lbl 8965 `"Miscellaneous production workers, including semiconductor processors"', add
label define occ2010_lbl 9000 `"Supervisors of Transportation and Material Moving Workers"', add
label define occ2010_lbl 9030 `"Aircraft Pilots and Flight Engineers"', add
label define occ2010_lbl 9040 `"Air Traffic Controllers and Airfield Operations Specialists"', add
label define occ2010_lbl 9050 `"Flight Attendants"', add
label define occ2010_lbl 9110 `"Ambulance Drivers and Attendants, Except Emergency Medical Technicians"', add
label define occ2010_lbl 9120 `"Bus Drivers"', add
label define occ2010_lbl 9130 `"Driver/Sales Workers and Truck Drivers"', add
label define occ2010_lbl 9140 `"Taxi Drivers and Chauffeurs"', add
label define occ2010_lbl 9150 `"Motor Vehicle Operators, All Other"', add
label define occ2010_lbl 9200 `"Locomotive Engineers and Operators"', add
label define occ2010_lbl 9240 `"Railroad Conductors and Yardmasters"', add
label define occ2010_lbl 9260 `"Subway, streetcar, and other rail transportation workers"', add
label define occ2010_lbl 9300 `"Sailors and marine oilers, and ship engineers"', add
label define occ2010_lbl 9310 `"Ship and Boat Captains and Operators"', add
label define occ2010_lbl 9350 `"Parking Lot Attendants"', add
label define occ2010_lbl 9360 `"Automotive and Watercraft Service Attendants"', add
label define occ2010_lbl 9410 `"Transportation Inspectors"', add
label define occ2010_lbl 9415 `"Transportation attendants, except flight attendants"', add
label define occ2010_lbl 9420 `"Miscellaneous transportation workers, including bridge and lock tenders and traffic technicians"', add
label define occ2010_lbl 9510 `"Crane and Tower Operators"', add
label define occ2010_lbl 9520 `"Dredge, Excavating, and Loading Machine Operators"', add
label define occ2010_lbl 9560 `"Conveyor operators and tenders, and hoist and winch operators"', add
label define occ2010_lbl 9600 `"Industrial Truck and Tractor Operators"', add
label define occ2010_lbl 9610 `"Cleaners of Vehicles and Equipment"', add
label define occ2010_lbl 9620 `"Laborers and Freight, Stock, and Material Movers, Hand"', add
label define occ2010_lbl 9630 `"Machine Feeders and Offbearers"', add
label define occ2010_lbl 9640 `"Packers and Packagers, Hand"', add
label define occ2010_lbl 9650 `"Pumping Station Operators"', add
label define occ2010_lbl 9720 `"Refuse and Recyclable Material Collectors"', add
label define occ2010_lbl 9750 `"Miscellaneous material moving workers, including mine shuttle car operators, and tank car, truck, and ship loaders"', add
label define occ2010_lbl 9800 `"Military Officer Special and Tactical Operations Leaders"', add
label define occ2010_lbl 9810 `"First-Line Enlisted Military Supervisors"', add
label define occ2010_lbl 9820 `"Military Enlisted Tactical Operations and Air/Weapons Specialists and Crew Members"', add
label define occ2010_lbl 9830 `"Military, Rank Not Specified"', add
label define occ2010_lbl 9920 `"Unemployed, with No Work Experience in the Last 5 Years or Earlier or Never Worked"', add
label define occ2010_lbl 9999 `"NIU"', add
label values occ2010 occ2010_lbl

label define ind_lbl 0000 `"0000"'
label define ind_lbl 0001 `"0001"', add
label define ind_lbl 0002 `"0002"', add
label define ind_lbl 0003 `"0003"', add
label define ind_lbl 0004 `"0004"', add
label define ind_lbl 0005 `"0005"', add
label define ind_lbl 0006 `"0006"', add
label define ind_lbl 0007 `"0007"', add
label define ind_lbl 0008 `"0008"', add
label define ind_lbl 0009 `"0009"', add
label define ind_lbl 0010 `"0010"', add
label define ind_lbl 0011 `"0011"', add
label define ind_lbl 0012 `"0012"', add
label define ind_lbl 0013 `"0013"', add
label define ind_lbl 0014 `"0014"', add
label define ind_lbl 0015 `"0015"', add
label define ind_lbl 0016 `"0016"', add
label define ind_lbl 0017 `"0017"', add
label define ind_lbl 0018 `"0018"', add
label define ind_lbl 0019 `"0019"', add
label define ind_lbl 0020 `"0020"', add
label define ind_lbl 0021 `"0021"', add
label define ind_lbl 0022 `"0022"', add
label define ind_lbl 0023 `"0023"', add
label define ind_lbl 0024 `"0024"', add
label define ind_lbl 0025 `"0025"', add
label define ind_lbl 0026 `"0026"', add
label define ind_lbl 0027 `"0027"', add
label define ind_lbl 0028 `"0028"', add
label define ind_lbl 0029 `"0029"', add
label define ind_lbl 0030 `"0030"', add
label define ind_lbl 0031 `"0031"', add
label define ind_lbl 0032 `"0032"', add
label define ind_lbl 0033 `"0033"', add
label define ind_lbl 0034 `"0034"', add
label define ind_lbl 0035 `"0035"', add
label define ind_lbl 0036 `"0036"', add
label define ind_lbl 0037 `"0037"', add
label define ind_lbl 0038 `"0038"', add
label define ind_lbl 0039 `"0039"', add
label define ind_lbl 0040 `"0040"', add
label define ind_lbl 0041 `"0041"', add
label define ind_lbl 0042 `"0042"', add
label define ind_lbl 0043 `"0043"', add
label define ind_lbl 0044 `"0044"', add
label define ind_lbl 0045 `"0045"', add
label define ind_lbl 0046 `"0046"', add
label define ind_lbl 0047 `"0047"', add
label define ind_lbl 0048 `"0048"', add
label define ind_lbl 0049 `"0049"', add
label define ind_lbl 0050 `"0050"', add
label define ind_lbl 0051 `"0051"', add
label define ind_lbl 0052 `"0052"', add
label define ind_lbl 0053 `"0053"', add
label define ind_lbl 0054 `"0054"', add
label define ind_lbl 0055 `"0055"', add
label define ind_lbl 0056 `"0056"', add
label define ind_lbl 0057 `"0057"', add
label define ind_lbl 0058 `"0058"', add
label define ind_lbl 0059 `"0059"', add
label define ind_lbl 0060 `"0060"', add
label define ind_lbl 0061 `"0061"', add
label define ind_lbl 0062 `"0062"', add
label define ind_lbl 0063 `"0063"', add
label define ind_lbl 0064 `"0064"', add
label define ind_lbl 0065 `"0065"', add
label define ind_lbl 0066 `"0066"', add
label define ind_lbl 0067 `"0067"', add
label define ind_lbl 0068 `"0068"', add
label define ind_lbl 0069 `"0069"', add
label define ind_lbl 0070 `"0070"', add
label define ind_lbl 0071 `"0071"', add
label define ind_lbl 0072 `"0072"', add
label define ind_lbl 0073 `"0073"', add
label define ind_lbl 0074 `"0074"', add
label define ind_lbl 0075 `"0075"', add
label define ind_lbl 0076 `"0076"', add
label define ind_lbl 0077 `"0077"', add
label define ind_lbl 0078 `"0078"', add
label define ind_lbl 0079 `"0079"', add
label define ind_lbl 0080 `"0080"', add
label define ind_lbl 0081 `"0081"', add
label define ind_lbl 0082 `"0082"', add
label define ind_lbl 0083 `"0083"', add
label define ind_lbl 0084 `"0084"', add
label define ind_lbl 0085 `"0085"', add
label define ind_lbl 0086 `"0086"', add
label define ind_lbl 0087 `"0087"', add
label define ind_lbl 0088 `"0088"', add
label define ind_lbl 0089 `"0089"', add
label define ind_lbl 0090 `"0090"', add
label define ind_lbl 0091 `"0091"', add
label define ind_lbl 0092 `"0092"', add
label define ind_lbl 0093 `"0093"', add
label define ind_lbl 0094 `"0094"', add
label define ind_lbl 0095 `"0095"', add
label define ind_lbl 0096 `"0096"', add
label define ind_lbl 0097 `"0097"', add
label define ind_lbl 0098 `"0098"', add
label define ind_lbl 0099 `"0099"', add
label define ind_lbl 0100 `"0100"', add
label define ind_lbl 0101 `"0101"', add
label define ind_lbl 0102 `"0102"', add
label define ind_lbl 0103 `"0103"', add
label define ind_lbl 0104 `"0104"', add
label define ind_lbl 0105 `"0105"', add
label define ind_lbl 0106 `"0106"', add
label define ind_lbl 0107 `"0107"', add
label define ind_lbl 0108 `"0108"', add
label define ind_lbl 0109 `"0109"', add
label define ind_lbl 0110 `"0110"', add
label define ind_lbl 0111 `"0111"', add
label define ind_lbl 0112 `"0112"', add
label define ind_lbl 0113 `"0113"', add
label define ind_lbl 0114 `"0114"', add
label define ind_lbl 0115 `"0115"', add
label define ind_lbl 0116 `"0116"', add
label define ind_lbl 0117 `"0117"', add
label define ind_lbl 0118 `"0118"', add
label define ind_lbl 0119 `"0119"', add
label define ind_lbl 0120 `"0120"', add
label define ind_lbl 0121 `"0121"', add
label define ind_lbl 0122 `"0122"', add
label define ind_lbl 0123 `"0123"', add
label define ind_lbl 0124 `"0124"', add
label define ind_lbl 0125 `"0125"', add
label define ind_lbl 0126 `"0126"', add
label define ind_lbl 0127 `"0127"', add
label define ind_lbl 0128 `"0128"', add
label define ind_lbl 0129 `"0129"', add
label define ind_lbl 0130 `"0130"', add
label define ind_lbl 0131 `"0131"', add
label define ind_lbl 0137 `"0137"', add
label define ind_lbl 0138 `"0138"', add
label define ind_lbl 0139 `"0139"', add
label define ind_lbl 0146 `"0146"', add
label define ind_lbl 0147 `"0147"', add
label define ind_lbl 0148 `"0148"', add
label define ind_lbl 0149 `"0149"', add
label define ind_lbl 0157 `"0157"', add
label define ind_lbl 0158 `"0158"', add
label define ind_lbl 0159 `"0159"', add
label define ind_lbl 0166 `"0166"', add
label define ind_lbl 0167 `"0167"', add
label define ind_lbl 0168 `"0168"', add
label define ind_lbl 0169 `"0169"', add
label define ind_lbl 0176 `"0176"', add
label define ind_lbl 0177 `"0177"', add
label define ind_lbl 0178 `"0178"', add
label define ind_lbl 0179 `"0179"', add
label define ind_lbl 0186 `"0186"', add
label define ind_lbl 0187 `"0187"', add
label define ind_lbl 0188 `"0188"', add
label define ind_lbl 0197 `"0197"', add
label define ind_lbl 0198 `"0198"', add
label define ind_lbl 0199 `"0199"', add
label define ind_lbl 0206 `"0206"', add
label define ind_lbl 0207 `"0207"', add
label define ind_lbl 0208 `"0208"', add
label define ind_lbl 0209 `"0209"', add
label define ind_lbl 0219 `"0219"', add
label define ind_lbl 0227 `"0227"', add
label define ind_lbl 0228 `"0228"', add
label define ind_lbl 0229 `"0229"', add
label define ind_lbl 0236 `"0236"', add
label define ind_lbl 0237 `"0237"', add
label define ind_lbl 0238 `"0238"', add
label define ind_lbl 0239 `"0239"', add
label define ind_lbl 0246 `"0246"', add
label define ind_lbl 0247 `"0247"', add
label define ind_lbl 0248 `"0248"', add
label define ind_lbl 0249 `"0249"', add
label define ind_lbl 0257 `"0257"', add
label define ind_lbl 0258 `"0258"', add
label define ind_lbl 0259 `"0259"', add
label define ind_lbl 0267 `"0267"', add
label define ind_lbl 0268 `"0268"', add
label define ind_lbl 0269 `"0269"', add
label define ind_lbl 0278 `"0278"', add
label define ind_lbl 0279 `"0279"', add
label define ind_lbl 0287 `"0287"', add
label define ind_lbl 0288 `"0288"', add
label define ind_lbl 0289 `"0289"', add
label define ind_lbl 0293 `"0293"', add
label define ind_lbl 0297 `"0297"', add
label define ind_lbl 0298 `"0298"', add
label define ind_lbl 0299 `"0299"', add
label define ind_lbl 0307 `"0307"', add
label define ind_lbl 0308 `"0308"', add
label define ind_lbl 0309 `"0309"', add
label define ind_lbl 0317 `"0317"', add
label define ind_lbl 0318 `"0318"', add
label define ind_lbl 0319 `"0319"', add
label define ind_lbl 0327 `"0327"', add
label define ind_lbl 0328 `"0328"', add
label define ind_lbl 0329 `"0329"', add
label define ind_lbl 0337 `"0337"', add
label define ind_lbl 0338 `"0338"', add
label define ind_lbl 0339 `"0339"', add
label define ind_lbl 0346 `"0346"', add
label define ind_lbl 0347 `"0347"', add
label define ind_lbl 0348 `"0348"', add
label define ind_lbl 0349 `"0349"', add
label define ind_lbl 0357 `"0357"', add
label define ind_lbl 0358 `"0358"', add
label define ind_lbl 0359 `"0359"', add
label define ind_lbl 0367 `"0367"', add
label define ind_lbl 0368 `"0368"', add
label define ind_lbl 0369 `"0369"', add
label define ind_lbl 0377 `"0377"', add
label define ind_lbl 0378 `"0378"', add
label define ind_lbl 0379 `"0379"', add
label define ind_lbl 0387 `"0387"', add
label define ind_lbl 0388 `"0388"', add
label define ind_lbl 0389 `"0389"', add
label define ind_lbl 0397 `"0397"', add
label define ind_lbl 0398 `"0398"', add
label define ind_lbl 0399 `"0399"', add
label define ind_lbl 0407 `"0407"', add
label define ind_lbl 0408 `"0408"', add
label define ind_lbl 0409 `"0409"', add
label define ind_lbl 0417 `"0417"', add
label define ind_lbl 0418 `"0418"', add
label define ind_lbl 0419 `"0419"', add
label define ind_lbl 0427 `"0427"', add
label define ind_lbl 0428 `"0428"', add
label define ind_lbl 0429 `"0429"', add
label define ind_lbl 0447 `"0447"', add
label define ind_lbl 0448 `"0448"', add
label define ind_lbl 0449 `"0449"', add
label define ind_lbl 0467 `"0467"', add
label define ind_lbl 0468 `"0468"', add
label define ind_lbl 0469 `"0469"', add
label define ind_lbl 0477 `"0477"', add
label define ind_lbl 0478 `"0478"', add
label define ind_lbl 0479 `"0479"', add
label define ind_lbl 0499 `"0499"', add
label define ind_lbl 0507 `"0507"', add
label define ind_lbl 0508 `"0508"', add
label define ind_lbl 0509 `"0509"', add
label define ind_lbl 0527 `"0527"', add
label define ind_lbl 0528 `"0528"', add
label define ind_lbl 0529 `"0529"', add
label define ind_lbl 0536 `"0536"', add
label define ind_lbl 0537 `"0537"', add
label define ind_lbl 0538 `"0538"', add
label define ind_lbl 0539 `"0539"', add
label define ind_lbl 0557 `"0557"', add
label define ind_lbl 0558 `"0558"', add
label define ind_lbl 0559 `"0559"', add
label define ind_lbl 0566 `"0566"', add
label define ind_lbl 0567 `"0567"', add
label define ind_lbl 0568 `"0568"', add
label define ind_lbl 0569 `"0569"', add
label define ind_lbl 0587 `"0587"', add
label define ind_lbl 0588 `"0588"', add
label define ind_lbl 0599 `"0599"', add
label define ind_lbl 0607 `"0607"', add
label define ind_lbl 0608 `"0608"', add
label define ind_lbl 0609 `"0609"', add
label define ind_lbl 0617 `"0617"', add
label define ind_lbl 0618 `"0618"', add
label define ind_lbl 0619 `"0619"', add
label define ind_lbl 0626 `"0626"', add
label define ind_lbl 0627 `"0627"', add
label define ind_lbl 0628 `"0628"', add
label define ind_lbl 0629 `"0629"', add
label define ind_lbl 0636 `"0636"', add
label define ind_lbl 0637 `"0637"', add
label define ind_lbl 0638 `"0638"', add
label define ind_lbl 0639 `"0639"', add
label define ind_lbl 0646 `"0646"', add
label define ind_lbl 0647 `"0647"', add
label define ind_lbl 0648 `"0648"', add
label define ind_lbl 0649 `"0649"', add
label define ind_lbl 0657 `"0657"', add
label define ind_lbl 0658 `"0658"', add
label define ind_lbl 0667 `"0667"', add
label define ind_lbl 0668 `"0668"', add
label define ind_lbl 0669 `"0669"', add
label define ind_lbl 0676 `"0676"', add
label define ind_lbl 0677 `"0677"', add
label define ind_lbl 0678 `"0678"', add
label define ind_lbl 0679 `"0679"', add
label define ind_lbl 0687 `"0687"', add
label define ind_lbl 0688 `"0688"', add
label define ind_lbl 0689 `"0689"', add
label define ind_lbl 0696 `"0696"', add
label define ind_lbl 0697 `"0697"', add
label define ind_lbl 0698 `"0698"', add
label define ind_lbl 0699 `"0699"', add
label define ind_lbl 0706 `"0706"', add
label define ind_lbl 0707 `"0707"', add
label define ind_lbl 0708 `"0708"', add
label define ind_lbl 0709 `"0709"', add
label define ind_lbl 0717 `"0717"', add
label define ind_lbl 0718 `"0718"', add
label define ind_lbl 0719 `"0719"', add
label define ind_lbl 0727 `"0727"', add
label define ind_lbl 0728 `"0728"', add
label define ind_lbl 0729 `"0729"', add
label define ind_lbl 0736 `"0736"', add
label define ind_lbl 0737 `"0737"', add
label define ind_lbl 0738 `"0738"', add
label define ind_lbl 0739 `"0739"', add
label define ind_lbl 0747 `"0747"', add
label define ind_lbl 0748 `"0748"', add
label define ind_lbl 0749 `"0749"', add
label define ind_lbl 0756 `"0756"', add
label define ind_lbl 0757 `"0757"', add
label define ind_lbl 0758 `"0758"', add
label define ind_lbl 0759 `"0759"', add
label define ind_lbl 0766 `"0766"', add
label define ind_lbl 0767 `"0767"', add
label define ind_lbl 0769 `"0769"', add
label define ind_lbl 0776 `"0776"', add
label define ind_lbl 0777 `"0777"', add
label define ind_lbl 0778 `"0778"', add
label define ind_lbl 0779 `"0779"', add
label define ind_lbl 0786 `"0786"', add
label define ind_lbl 0787 `"0787"', add
label define ind_lbl 0788 `"0788"', add
label define ind_lbl 0789 `"0789"', add
label define ind_lbl 0797 `"0797"', add
label define ind_lbl 0798 `"0798"', add
label define ind_lbl 0799 `"0799"', add
label define ind_lbl 0807 `"0807"', add
label define ind_lbl 0808 `"0808"', add
label define ind_lbl 0809 `"0809"', add
label define ind_lbl 0817 `"0817"', add
label define ind_lbl 0826 `"0826"', add
label define ind_lbl 0828 `"0828"', add
label define ind_lbl 0829 `"0829"', add
label define ind_lbl 0837 `"0837"', add
label define ind_lbl 0838 `"0838"', add
label define ind_lbl 0839 `"0839"', add
label define ind_lbl 0847 `"0847"', add
label define ind_lbl 0848 `"0848"', add
label define ind_lbl 0849 `"0849"', add
label define ind_lbl 0856 `"0856"', add
label define ind_lbl 0857 `"0857"', add
label define ind_lbl 0858 `"0858"', add
label define ind_lbl 0859 `"0859"', add
label define ind_lbl 0867 `"0867"', add
label define ind_lbl 0868 `"0868"', add
label define ind_lbl 0869 `"0869"', add
label define ind_lbl 0876 `"0876"', add
label define ind_lbl 0877 `"0877"', add
label define ind_lbl 0878 `"0878"', add
label define ind_lbl 0879 `"0879"', add
label define ind_lbl 0887 `"0887"', add
label define ind_lbl 0888 `"0888"', add
label define ind_lbl 0889 `"0889"', add
label define ind_lbl 0897 `"0897"', add
label define ind_lbl 0899 `"0899"', add
label define ind_lbl 0907 `"0907"', add
label define ind_lbl 0917 `"0917"', add
label define ind_lbl 0927 `"0927"', add
label define ind_lbl 0937 `"0937"', add
label define ind_lbl 0947 `"0947"', add
label define ind_lbl 0995 `"0995"', add
label define ind_lbl 0996 `"0996"', add
label define ind_lbl 0997 `"0997"', add
label define ind_lbl 0998 `"0998"', add
label define ind_lbl 0999 `"0999"', add
label values ind ind_lbl

label define ind1950_lbl 000 `"N/A or none reported"'
label define ind1950_lbl 105 `"Agriculture"', add
label define ind1950_lbl 116 `"Forestry"', add
label define ind1950_lbl 126 `"Fisheries"', add
label define ind1950_lbl 206 `"Metal mining"', add
label define ind1950_lbl 216 `"Coal mining"', add
label define ind1950_lbl 226 `"Crude petroleum and natural gas extraction"', add
label define ind1950_lbl 236 `"Nonmettalic  mining and quarrying, except fuel"', add
label define ind1950_lbl 239 `"Mining, not specified"', add
label define ind1950_lbl 246 `"Construction"', add
label define ind1950_lbl 306 `"Logging"', add
label define ind1950_lbl 307 `"Sawmills, planing mills, and mill work"', add
label define ind1950_lbl 308 `"Misc wood products"', add
label define ind1950_lbl 309 `"Furniture and fixtures"', add
label define ind1950_lbl 316 `"Glass and glass products"', add
label define ind1950_lbl 317 `"Cement, concrete, gypsum and plaster products"', add
label define ind1950_lbl 318 `"Structural clay products"', add
label define ind1950_lbl 319 `"Pottery and related prods"', add
label define ind1950_lbl 326 `"Misc nonmetallic mineral and stone products"', add
label define ind1950_lbl 336 `"Blast furnaces, steel works, and rolling mills"', add
label define ind1950_lbl 337 `"Other primary iron and steel industries"', add
label define ind1950_lbl 338 `"Primary nonferrous industries"', add
label define ind1950_lbl 346 `"Fabricated steel products"', add
label define ind1950_lbl 347 `"Fabricated nonferrous metal products"', add
label define ind1950_lbl 348 `"Not specified metal industries"', add
label define ind1950_lbl 356 `"Agricultural machinery and tractors"', add
label define ind1950_lbl 357 `"Office and store machines"', add
label define ind1950_lbl 358 `"Misc machinery"', add
label define ind1950_lbl 367 `"Electrical machinery, equipment and supplies"', add
label define ind1950_lbl 376 `"Motor vehicles and motor vehicle equipment"', add
label define ind1950_lbl 377 `"Aircraft and parts"', add
label define ind1950_lbl 378 `"Ship and boat building and repairing"', add
label define ind1950_lbl 379 `"Railroad and misc transportation equipment"', add
label define ind1950_lbl 386 `"Professional equipment"', add
label define ind1950_lbl 387 `"Photographic equipment and supplies"', add
label define ind1950_lbl 388 `"Watches, clocks, and clockwork-operated devices"', add
label define ind1950_lbl 399 `"Misc manufacturing industries"', add
label define ind1950_lbl 406 `"Meat products"', add
label define ind1950_lbl 407 `"Dairy products"', add
label define ind1950_lbl 408 `"Canning and preserving fruits, vegetables, and seafoods"', add
label define ind1950_lbl 409 `"Grain-mill products"', add
label define ind1950_lbl 416 `"Bakery products"', add
label define ind1950_lbl 417 `"Confectionery and related products"', add
label define ind1950_lbl 418 `"Beverage industries"', add
label define ind1950_lbl 419 `"Misc food preparations and kindred products"', add
label define ind1950_lbl 426 `"Not specified food industries"', add
label define ind1950_lbl 429 `"Tobacco manufactures"', add
label define ind1950_lbl 436 `"Knitting mills"', add
label define ind1950_lbl 437 `"Dyeing and finishing textiles, except knit goods"', add
label define ind1950_lbl 438 `"Carpets, rugs, and other floor coverings"', add
label define ind1950_lbl 439 `"Yarn, thread, and fabric"', add
label define ind1950_lbl 446 `"Misc textile mill products"', add
label define ind1950_lbl 448 `"Apparel and accessories"', add
label define ind1950_lbl 449 `"Misc fabricated textile products"', add
label define ind1950_lbl 456 `"Pulp, paper, and paper-board mills"', add
label define ind1950_lbl 457 `"Paperboard containers and boxes"', add
label define ind1950_lbl 458 `"Misc paper and pulp products"', add
label define ind1950_lbl 459 `"Printing, publishing, and allied industries"', add
label define ind1950_lbl 466 `"Synthetic fibers"', add
label define ind1950_lbl 467 `"Drugs and medicines"', add
label define ind1950_lbl 468 `"Paints, varnishes, and related products"', add
label define ind1950_lbl 469 `"Misc chemicals and allied products"', add
label define ind1950_lbl 476 `"Petroleum refining"', add
label define ind1950_lbl 477 `"Misc petroleum and coal products"', add
label define ind1950_lbl 478 `"Rubber products"', add
label define ind1950_lbl 487 `"Leather: tanned, curried, and finished"', add
label define ind1950_lbl 488 `"Footwear, except rubber"', add
label define ind1950_lbl 489 `"Leather products, except footwear"', add
label define ind1950_lbl 499 `"Not specified manufacturing industries"', add
label define ind1950_lbl 506 `"Railroads and railway"', add
label define ind1950_lbl 516 `"Street railways and bus lines"', add
label define ind1950_lbl 526 `"Trucking service"', add
label define ind1950_lbl 527 `"Warehousing and storage"', add
label define ind1950_lbl 536 `"Taxicab service"', add
label define ind1950_lbl 546 `"Water transportation"', add
label define ind1950_lbl 556 `"Air transportation"', add
label define ind1950_lbl 567 `"Petroleum and gasoline pipe lines"', add
label define ind1950_lbl 568 `"Services incidental to transportation"', add
label define ind1950_lbl 578 `"Telephone"', add
label define ind1950_lbl 579 `"Telegraph"', add
label define ind1950_lbl 586 `"Electric light and power"', add
label define ind1950_lbl 587 `"Gas and steam supply systems"', add
label define ind1950_lbl 588 `"Electric-gas utilities"', add
label define ind1950_lbl 596 `"Water supply"', add
label define ind1950_lbl 597 `"Sanitary services"', add
label define ind1950_lbl 598 `"Other and not specified utilities"', add
label define ind1950_lbl 606 `"Motor vehicles and equipment"', add
label define ind1950_lbl 607 `"Drugs, chemicals, and allied products"', add
label define ind1950_lbl 608 `"Dry goods apparel"', add
label define ind1950_lbl 609 `"Food and related products"', add
label define ind1950_lbl 616 `"Electrical goods, hardware, and plumbing equipment"', add
label define ind1950_lbl 617 `"Machinery, equipment, and supplies"', add
label define ind1950_lbl 618 `"Petroleum products"', add
label define ind1950_lbl 619 `"Farm prods--raw materials"', add
label define ind1950_lbl 626 `"Misc wholesale trade"', add
label define ind1950_lbl 627 `"Not specified wholesale trade"', add
label define ind1950_lbl 636 `"Food stores, except dairy"', add
label define ind1950_lbl 637 `"Dairy prods stores and milk retailing"', add
label define ind1950_lbl 646 `"General merchandise"', add
label define ind1950_lbl 647 `"Five and ten cent stores"', add
label define ind1950_lbl 656 `"Apparel and accessories stores, except shoe"', add
label define ind1950_lbl 657 `"Shoe stores"', add
label define ind1950_lbl 658 `"Furniture and house furnishings stores"', add
label define ind1950_lbl 659 `"Household appliance and radio stores"', add
label define ind1950_lbl 667 `"Motor vehicles and accessories retailing"', add
label define ind1950_lbl 668 `"Gasoline service stations"', add
label define ind1950_lbl 669 `"Drug stores"', add
label define ind1950_lbl 679 `"Eating and drinking  places"', add
label define ind1950_lbl 686 `"Hardware and farm implement stores"', add
label define ind1950_lbl 687 `"Lumber and building material retailing"', add
label define ind1950_lbl 688 `"Liquor stores"', add
label define ind1950_lbl 689 `"Retail florists"', add
label define ind1950_lbl 696 `"Jewelry stores"', add
label define ind1950_lbl 697 `"Fuel and ice retailing"', add
label define ind1950_lbl 698 `"Misc retail stores"', add
label define ind1950_lbl 699 `"Not specified retail trade"', add
label define ind1950_lbl 716 `"Banking and credit"', add
label define ind1950_lbl 726 `"Security and commodity brokerage and invest companies"', add
label define ind1950_lbl 736 `"Insurance"', add
label define ind1950_lbl 746 `"Real estate"', add
label define ind1950_lbl 756 `"Real estate-insurance-law  offices"', add
label define ind1950_lbl 806 `"Advertising"', add
label define ind1950_lbl 807 `"Accounting, auditing, and bookkeeping services"', add
label define ind1950_lbl 808 `"Misc business services"', add
label define ind1950_lbl 816 `"Auto repair services and garages"', add
label define ind1950_lbl 817 `"Misc repair services"', add
label define ind1950_lbl 826 `"Private households"', add
label define ind1950_lbl 836 `"Hotels and lodging places"', add
label define ind1950_lbl 846 `"Laundering, cleaning, and dyeing"', add
label define ind1950_lbl 847 `"Dressmaking shops"', add
label define ind1950_lbl 848 `"Shoe repair shops"', add
label define ind1950_lbl 849 `"Misc personal services"', add
label define ind1950_lbl 856 `"Radio broadcasting and television"', add
label define ind1950_lbl 857 `"Theaters and motion pictures"', add
label define ind1950_lbl 858 `"Bowling alleys, and billiard and pool parlors"', add
label define ind1950_lbl 859 `"Misc entertainment and recreation services"', add
label define ind1950_lbl 868 `"Medical and other health services, except hospitals"', add
label define ind1950_lbl 869 `"Hospitals"', add
label define ind1950_lbl 879 `"Legal services"', add
label define ind1950_lbl 888 `"Educational services"', add
label define ind1950_lbl 896 `"Welfare and religious services"', add
label define ind1950_lbl 897 `"Nonprofit membership organizs."', add
label define ind1950_lbl 898 `"Engineering and architectural services"', add
label define ind1950_lbl 899 `"Misc professional and related"', add
label define ind1950_lbl 906 `"Postal service"', add
label define ind1950_lbl 916 `"Federal public administration"', add
label define ind1950_lbl 926 `"State public administration"', add
label define ind1950_lbl 936 `"Local public administration"', add
label define ind1950_lbl 946 `"Public Administration, level not specified"', add
label define ind1950_lbl 976 `"Common or general laborer"', add
label define ind1950_lbl 979 `"Not yet specified"', add
label define ind1950_lbl 980 `"Unpaid domestic work"', add
label define ind1950_lbl 982 `"Housework at home"', add
label define ind1950_lbl 983 `"School response (students, etc.)"', add
label define ind1950_lbl 984 `"Retired"', add
label define ind1950_lbl 986 `"Sick/disabled"', add
label define ind1950_lbl 987 `"Institution response"', add
label define ind1950_lbl 991 `"Lady/Man of leisure"', add
label define ind1950_lbl 995 `"Non-industrial response"', add
label define ind1950_lbl 997 `"Nonclassifiable"', add
label define ind1950_lbl 998 `"Industry not reported"', add
label define ind1950_lbl 999 `"Blank or blank equivalent"', add
label values ind1950 ind1950_lbl

label define ind1990_lbl 000 `"N/A (not applicable)"'
label define ind1990_lbl 010 `"Agricultural production, crops"', add
label define ind1990_lbl 011 `"Agricultural production, livestock"', add
label define ind1990_lbl 012 `"Veterinary services"', add
label define ind1990_lbl 020 `"Landscape and horticultural services"', add
label define ind1990_lbl 030 `"Agricultural services, n.e.c."', add
label define ind1990_lbl 031 `"Forestry"', add
label define ind1990_lbl 032 `"Fishing, hunting, and trapping"', add
label define ind1990_lbl 040 `"Metal mining"', add
label define ind1990_lbl 041 `"Coal mining"', add
label define ind1990_lbl 042 `"Oil and gas extraction"', add
label define ind1990_lbl 050 `"Nonmetallic mining and quarrying, except fuels"', add
label define ind1990_lbl 060 `"All construction"', add
label define ind1990_lbl 100 `"Meat products"', add
label define ind1990_lbl 101 `"Dairy products"', add
label define ind1990_lbl 102 `"Canned, frozen, and preserved fruits and vegetables"', add
label define ind1990_lbl 110 `"Grain mill products"', add
label define ind1990_lbl 111 `"Bakery products"', add
label define ind1990_lbl 112 `"Sugar and confectionery products"', add
label define ind1990_lbl 120 `"Beverage industries"', add
label define ind1990_lbl 121 `"Misc. food preparations and kindred products"', add
label define ind1990_lbl 122 `"Food industries, n.s."', add
label define ind1990_lbl 130 `"Tobacco manufactures"', add
label define ind1990_lbl 132 `"Knitting mills"', add
label define ind1990_lbl 140 `"Dyeing and finishing textiles, except wool and knit goods"', add
label define ind1990_lbl 141 `"Carpets and rugs"', add
label define ind1990_lbl 142 `"Yarn, thread, and fabric mills"', add
label define ind1990_lbl 150 `"Miscellaneous textile mill products"', add
label define ind1990_lbl 151 `"Apparel and accessories, except knit"', add
label define ind1990_lbl 152 `"Miscellaneous fabricated textile products"', add
label define ind1990_lbl 160 `"Pulp, paper, and paperboard mills"', add
label define ind1990_lbl 161 `"Miscellaneous paper and pulp products"', add
label define ind1990_lbl 162 `"Paperboard containers and boxes"', add
label define ind1990_lbl 171 `"Newspaper publishing and printing"', add
label define ind1990_lbl 172 `"Printing, publishing, and allied industries, except newspapers"', add
label define ind1990_lbl 180 `"Plastics, synthetics, and resins"', add
label define ind1990_lbl 181 `"Drugs"', add
label define ind1990_lbl 182 `"Soaps and cosmetics"', add
label define ind1990_lbl 190 `"Paints, varnishes, and related products"', add
label define ind1990_lbl 191 `"Agricultural chemicals"', add
label define ind1990_lbl 192 `"Industrial and miscellaneous chemicals"', add
label define ind1990_lbl 200 `"Petroleum refining"', add
label define ind1990_lbl 201 `"Miscellaneous petroleum and coal products"', add
label define ind1990_lbl 210 `"Tires and inner tubes"', add
label define ind1990_lbl 211 `"Other rubber products, and plastics footwear and belting"', add
label define ind1990_lbl 212 `"Miscellaneous plastics products"', add
label define ind1990_lbl 220 `"Leather tanning and finishing"', add
label define ind1990_lbl 221 `"Footwear, except rubber and plastic"', add
label define ind1990_lbl 222 `"Leather products, except footwear"', add
label define ind1990_lbl 230 `"Logging"', add
label define ind1990_lbl 231 `"Sawmills, planing mills, and millwork"', add
label define ind1990_lbl 232 `"Wood buildings and mobile homes"', add
label define ind1990_lbl 241 `"Miscellaneous wood products"', add
label define ind1990_lbl 242 `"Furniture and fixtures"', add
label define ind1990_lbl 250 `"Glass and glass products"', add
label define ind1990_lbl 251 `"Cement, concrete, gypsum, and plaster products"', add
label define ind1990_lbl 252 `"Structural clay products"', add
label define ind1990_lbl 261 `"Pottery and related products"', add
label define ind1990_lbl 262 `"Misc. nonmetallic mineral and stone products"', add
label define ind1990_lbl 270 `"Blast furnaces, steelworks, rolling and finishing mills"', add
label define ind1990_lbl 271 `"Iron and steel foundries"', add
label define ind1990_lbl 272 `"Primary aluminum industries"', add
label define ind1990_lbl 280 `"Other primary metal industries"', add
label define ind1990_lbl 281 `"Cutlery, handtools, and general hardware"', add
label define ind1990_lbl 282 `"Fabricated structural metal products"', add
label define ind1990_lbl 290 `"Screw machine products"', add
label define ind1990_lbl 291 `"Metal forgings and stampings"', add
label define ind1990_lbl 292 `"Ordnance"', add
label define ind1990_lbl 300 `"Miscellaneous fabricated metal products"', add
label define ind1990_lbl 301 `"Metal industries, n.s."', add
label define ind1990_lbl 310 `"Engines and turbines"', add
label define ind1990_lbl 311 `"Farm machinery and equipment"', add
label define ind1990_lbl 312 `"Construction and material handling machines"', add
label define ind1990_lbl 320 `"Metalworking machinery"', add
label define ind1990_lbl 321 `"Office and accounting machines"', add
label define ind1990_lbl 322 `"Computers and related equipment"', add
label define ind1990_lbl 331 `"Machinery, except electrical, n.e.c."', add
label define ind1990_lbl 332 `"Machinery, n.s."', add
label define ind1990_lbl 340 `"Household appliances"', add
label define ind1990_lbl 341 `"Radio, TV, and communication equipment"', add
label define ind1990_lbl 342 `"Electrical machinery, equipment, and supplies, n.e.c."', add
label define ind1990_lbl 350 `"Electrical machinery, equipment, and supplies, n.s."', add
label define ind1990_lbl 351 `"Motor vehicles and motor vehicle equipment"', add
label define ind1990_lbl 352 `"Aircraft and parts"', add
label define ind1990_lbl 360 `"Ship and boat building and repairing"', add
label define ind1990_lbl 361 `"Railroad locomotives and equipment"', add
label define ind1990_lbl 362 `"Guided missiles, space vehicles, and parts"', add
label define ind1990_lbl 370 `"Cycles and miscellaneous transportation equipment"', add
label define ind1990_lbl 371 `"Scientific and controlling instruments"', add
label define ind1990_lbl 372 `"Medical, dental, and optical instruments and supplies"', add
label define ind1990_lbl 380 `"Photographic equipment and supplies"', add
label define ind1990_lbl 381 `"Watches, clocks, and clockwork operated devices"', add
label define ind1990_lbl 390 `"Toys, amusement, and sporting goods"', add
label define ind1990_lbl 391 `"Miscellaneous manufacturing industries"', add
label define ind1990_lbl 392 `"Manufacturing industries, n.s."', add
label define ind1990_lbl 400 `"Railroads"', add
label define ind1990_lbl 401 `"Bus service and urban transit"', add
label define ind1990_lbl 402 `"Taxicab service"', add
label define ind1990_lbl 410 `"Trucking service"', add
label define ind1990_lbl 411 `"Warehousing and storage"', add
label define ind1990_lbl 412 `"U.S. Postal Service"', add
label define ind1990_lbl 420 `"Water transportation"', add
label define ind1990_lbl 421 `"Air transportation"', add
label define ind1990_lbl 422 `"Pipe lines, except natural gas"', add
label define ind1990_lbl 432 `"Services incidental to transportation"', add
label define ind1990_lbl 440 `"Radio and television broadcasting and cable"', add
label define ind1990_lbl 441 `"Telephone communications"', add
label define ind1990_lbl 442 `"Telegraph and miscellaneous communications services"', add
label define ind1990_lbl 450 `"Electric light and power"', add
label define ind1990_lbl 451 `"Gas and steam supply systems"', add
label define ind1990_lbl 452 `"Electric and gas, and other combinations"', add
label define ind1990_lbl 470 `"Water supply and irrigation"', add
label define ind1990_lbl 471 `"Sanitary services"', add
label define ind1990_lbl 472 `"Utilities, n.s."', add
label define ind1990_lbl 500 `"Motor vehicles and equipment"', add
label define ind1990_lbl 501 `"Furniture and home furnishings"', add
label define ind1990_lbl 502 `"Lumber and construction materials"', add
label define ind1990_lbl 510 `"Professional and commercial equipment and supplies"', add
label define ind1990_lbl 511 `"Metals and minerals, except petroleum"', add
label define ind1990_lbl 512 `"Electrical goods"', add
label define ind1990_lbl 521 `"Hardware, plumbing and heating supplies"', add
label define ind1990_lbl 530 `"Machinery, equipment, and supplies"', add
label define ind1990_lbl 531 `"Scrap and waste materials"', add
label define ind1990_lbl 532 `"Miscellaneous wholesale, durable goods"', add
label define ind1990_lbl 540 `"Paper and paper products"', add
label define ind1990_lbl 541 `"Drugs, chemicals, and allied products"', add
label define ind1990_lbl 542 `"Apparel, fabrics, and notions"', add
label define ind1990_lbl 550 `"Groceries and related products"', add
label define ind1990_lbl 551 `"Farm-product raw materials"', add
label define ind1990_lbl 552 `"Petroleum products"', add
label define ind1990_lbl 560 `"Alcoholic beverages"', add
label define ind1990_lbl 561 `"Farm supplies"', add
label define ind1990_lbl 562 `"Miscellaneous wholesale, nondurable goods"', add
label define ind1990_lbl 571 `"Wholesale trade, n.s."', add
label define ind1990_lbl 580 `"Lumber and building material retailing"', add
label define ind1990_lbl 581 `"Hardware stores"', add
label define ind1990_lbl 582 `"Retail nurseries and garden stores"', add
label define ind1990_lbl 590 `"Mobile home dealers"', add
label define ind1990_lbl 591 `"Department stores"', add
label define ind1990_lbl 592 `"Variety stores"', add
label define ind1990_lbl 600 `"Miscellaneous general merchandise stores"', add
label define ind1990_lbl 601 `"Grocery stores"', add
label define ind1990_lbl 602 `"Dairy products stores"', add
label define ind1990_lbl 610 `"Retail bakeries"', add
label define ind1990_lbl 611 `"Food stores, n.e.c."', add
label define ind1990_lbl 612 `"Motor vehicle dealers"', add
label define ind1990_lbl 620 `"Auto and home supply stores"', add
label define ind1990_lbl 621 `"Gasoline service stations"', add
label define ind1990_lbl 622 `"Miscellaneous vehicle dealers"', add
label define ind1990_lbl 623 `"Apparel and accessory stores, except shoe"', add
label define ind1990_lbl 630 `"Shoe stores"', add
label define ind1990_lbl 631 `"Furniture and home furnishings stores"', add
label define ind1990_lbl 632 `"Household appliance stores"', add
label define ind1990_lbl 633 `"Radio, TV, and computer stores"', add
label define ind1990_lbl 640 `"Music stores"', add
label define ind1990_lbl 641 `"Eating and drinking places"', add
label define ind1990_lbl 642 `"Drug stores"', add
label define ind1990_lbl 650 `"Liquor stores"', add
label define ind1990_lbl 651 `"Sporting goods, bicycles, and hobby stores"', add
label define ind1990_lbl 652 `"Book and stationery stores"', add
label define ind1990_lbl 660 `"Jewelry stores"', add
label define ind1990_lbl 661 `"Gift, novelty, and souvenir shops"', add
label define ind1990_lbl 662 `"Sewing, needlework, and piece goods stores"', add
label define ind1990_lbl 663 `"Catalog and mail order houses"', add
label define ind1990_lbl 670 `"Vending machine operators"', add
label define ind1990_lbl 671 `"Direct selling establishments"', add
label define ind1990_lbl 672 `"Fuel dealers"', add
label define ind1990_lbl 681 `"Retail florists"', add
label define ind1990_lbl 682 `"Miscellaneous retail stores"', add
label define ind1990_lbl 691 `"Retail trade, n.s."', add
label define ind1990_lbl 700 `"Banking"', add
label define ind1990_lbl 701 `"Savings institutions, including credit unions"', add
label define ind1990_lbl 702 `"Credit agencies, n.e.c."', add
label define ind1990_lbl 710 `"Security, commodity brokerage, and investment companies"', add
label define ind1990_lbl 711 `"Insurance"', add
label define ind1990_lbl 712 `"Real estate, including real estate-insurance offices"', add
label define ind1990_lbl 721 `"Advertising"', add
label define ind1990_lbl 722 `"Services to dwellings and other buildings"', add
label define ind1990_lbl 731 `"Personnel supply services"', add
label define ind1990_lbl 732 `"Computer and data processing services"', add
label define ind1990_lbl 740 `"Detective and protective services"', add
label define ind1990_lbl 741 `"Business services, n.e.c."', add
label define ind1990_lbl 742 `"Automotive rental and leasing, without drivers"', add
label define ind1990_lbl 750 `"Automobile parking and carwashes"', add
label define ind1990_lbl 751 `"Automotive repair and related services"', add
label define ind1990_lbl 752 `"Electrical repair shops"', add
label define ind1990_lbl 760 `"Miscellaneous repair services"', add
label define ind1990_lbl 761 `"Private households"', add
label define ind1990_lbl 762 `"Hotels and motels"', add
label define ind1990_lbl 770 `"Lodging places, except hotels and motels"', add
label define ind1990_lbl 771 `"Laundry, cleaning, and garment services"', add
label define ind1990_lbl 772 `"Beauty shops"', add
label define ind1990_lbl 780 `"Barber shops"', add
label define ind1990_lbl 781 `"Funeral service and crematories"', add
label define ind1990_lbl 782 `"Shoe repair shops"', add
label define ind1990_lbl 790 `"Dressmaking shops"', add
label define ind1990_lbl 791 `"Miscellaneous personal services"', add
label define ind1990_lbl 800 `"Theaters and motion pictures"', add
label define ind1990_lbl 801 `"Video tape rental"', add
label define ind1990_lbl 802 `"Bowling centers"', add
label define ind1990_lbl 810 `"Miscellaneous entertainment and recreation services"', add
label define ind1990_lbl 812 `"Offices and clinics of physicians"', add
label define ind1990_lbl 820 `"Offices and clinics of dentists"', add
label define ind1990_lbl 821 `"Offices and clinics of chiropractors"', add
label define ind1990_lbl 822 `"Offices and clinics of optometrists"', add
label define ind1990_lbl 830 `"Offices and clinics of health practitioners, n.e.c."', add
label define ind1990_lbl 831 `"Hospitals"', add
label define ind1990_lbl 832 `"Nursing and personal care facilities"', add
label define ind1990_lbl 840 `"Health services, n.e.c."', add
label define ind1990_lbl 841 `"Legal services"', add
label define ind1990_lbl 842 `"Elementary and secondary schools"', add
label define ind1990_lbl 850 `"Colleges and universities"', add
label define ind1990_lbl 851 `"Vocational schools"', add
label define ind1990_lbl 852 `"Libraries"', add
label define ind1990_lbl 860 `"Educational services, n.e.c."', add
label define ind1990_lbl 861 `"Job training and vocational rehabilitation services"', add
label define ind1990_lbl 862 `"Child day care services"', add
label define ind1990_lbl 863 `"Family child care homes"', add
label define ind1990_lbl 870 `"Residential care facilities, without nursing"', add
label define ind1990_lbl 871 `"Social services, n.e.c."', add
label define ind1990_lbl 872 `"Museums, art galleries, and zoos"', add
label define ind1990_lbl 873 `"Labor unions"', add
label define ind1990_lbl 880 `"Religious organizations"', add
label define ind1990_lbl 881 `"Membership organizations, n.e.c."', add
label define ind1990_lbl 882 `"Engineering, architectural, and surveying services"', add
label define ind1990_lbl 890 `"Accounting, auditing, and bookkeeping services"', add
label define ind1990_lbl 891 `"Research, development, and testing services"', add
label define ind1990_lbl 892 `"Management and public relations services"', add
label define ind1990_lbl 893 `"Miscellaneous professional and related services"', add
label define ind1990_lbl 900 `"Executive and legislative offices"', add
label define ind1990_lbl 901 `"General government, n.e.c."', add
label define ind1990_lbl 910 `"Justice, public order, and safety"', add
label define ind1990_lbl 921 `"Public finance, taxation, and monetary policy"', add
label define ind1990_lbl 922 `"Administration of human resources programs"', add
label define ind1990_lbl 930 `"Administration of environmental quality and housing programs"', add
label define ind1990_lbl 931 `"Administration of economic programs"', add
label define ind1990_lbl 932 `"National security and international affairs"', add
label define ind1990_lbl 940 `"Army"', add
label define ind1990_lbl 941 `"Air Force"', add
label define ind1990_lbl 942 `"Navy"', add
label define ind1990_lbl 950 `"Marines"', add
label define ind1990_lbl 951 `"Coast Guard"', add
label define ind1990_lbl 952 `"Armed Forces, branch not specified"', add
label define ind1990_lbl 960 `"Military Reserves or National Guard"', add
label define ind1990_lbl 992 `"Last worked 5+ years ago(1980-2007)/10+ years ago (1970 only) or never worked(2008-2017)"', add
label define ind1990_lbl 999 `"DID NOT RESPOND"', add
label values ind1990 ind1990_lbl

label define wkswork2_lbl 0 `"N/A"'
label define wkswork2_lbl 1 `"1-13 weeks"', add
label define wkswork2_lbl 2 `"14-26 weeks"', add
label define wkswork2_lbl 3 `"27-39 weeks"', add
label define wkswork2_lbl 4 `"40-47 weeks"', add
label define wkswork2_lbl 5 `"48-49 weeks"', add
label define wkswork2_lbl 6 `"50-52 weeks"', add
label values wkswork2 wkswork2_lbl

label define uhrswork_lbl 00 `"N/A"'
label define uhrswork_lbl 01 `"1"', add
label define uhrswork_lbl 02 `"2"', add
label define uhrswork_lbl 03 `"3"', add
label define uhrswork_lbl 04 `"4"', add
label define uhrswork_lbl 05 `"5"', add
label define uhrswork_lbl 06 `"6"', add
label define uhrswork_lbl 07 `"7"', add
label define uhrswork_lbl 08 `"8"', add
label define uhrswork_lbl 09 `"9"', add
label define uhrswork_lbl 10 `"10"', add
label define uhrswork_lbl 11 `"11"', add
label define uhrswork_lbl 12 `"12"', add
label define uhrswork_lbl 13 `"13"', add
label define uhrswork_lbl 14 `"14"', add
label define uhrswork_lbl 15 `"15"', add
label define uhrswork_lbl 16 `"16"', add
label define uhrswork_lbl 17 `"17"', add
label define uhrswork_lbl 18 `"18"', add
label define uhrswork_lbl 19 `"19"', add
label define uhrswork_lbl 20 `"20"', add
label define uhrswork_lbl 21 `"21"', add
label define uhrswork_lbl 22 `"22"', add
label define uhrswork_lbl 23 `"23"', add
label define uhrswork_lbl 24 `"24"', add
label define uhrswork_lbl 25 `"25"', add
label define uhrswork_lbl 26 `"26"', add
label define uhrswork_lbl 27 `"27"', add
label define uhrswork_lbl 28 `"28"', add
label define uhrswork_lbl 29 `"29"', add
label define uhrswork_lbl 30 `"30"', add
label define uhrswork_lbl 31 `"31"', add
label define uhrswork_lbl 32 `"32"', add
label define uhrswork_lbl 33 `"33"', add
label define uhrswork_lbl 34 `"34"', add
label define uhrswork_lbl 35 `"35"', add
label define uhrswork_lbl 36 `"36"', add
label define uhrswork_lbl 37 `"37"', add
label define uhrswork_lbl 38 `"38"', add
label define uhrswork_lbl 39 `"39"', add
label define uhrswork_lbl 40 `"40"', add
label define uhrswork_lbl 41 `"41"', add
label define uhrswork_lbl 42 `"42"', add
label define uhrswork_lbl 43 `"43"', add
label define uhrswork_lbl 44 `"44"', add
label define uhrswork_lbl 45 `"45"', add
label define uhrswork_lbl 46 `"46"', add
label define uhrswork_lbl 47 `"47"', add
label define uhrswork_lbl 48 `"48"', add
label define uhrswork_lbl 49 `"49"', add
label define uhrswork_lbl 50 `"50"', add
label define uhrswork_lbl 51 `"51"', add
label define uhrswork_lbl 52 `"52"', add
label define uhrswork_lbl 53 `"53"', add
label define uhrswork_lbl 54 `"54"', add
label define uhrswork_lbl 55 `"55"', add
label define uhrswork_lbl 56 `"56"', add
label define uhrswork_lbl 57 `"57"', add
label define uhrswork_lbl 58 `"58"', add
label define uhrswork_lbl 59 `"59"', add
label define uhrswork_lbl 60 `"60"', add
label define uhrswork_lbl 61 `"61"', add
label define uhrswork_lbl 62 `"62"', add
label define uhrswork_lbl 63 `"63"', add
label define uhrswork_lbl 64 `"64"', add
label define uhrswork_lbl 65 `"65"', add
label define uhrswork_lbl 66 `"66"', add
label define uhrswork_lbl 67 `"67"', add
label define uhrswork_lbl 68 `"68"', add
label define uhrswork_lbl 69 `"69"', add
label define uhrswork_lbl 70 `"70"', add
label define uhrswork_lbl 71 `"71"', add
label define uhrswork_lbl 72 `"72"', add
label define uhrswork_lbl 73 `"73"', add
label define uhrswork_lbl 74 `"74"', add
label define uhrswork_lbl 75 `"75"', add
label define uhrswork_lbl 76 `"76"', add
label define uhrswork_lbl 77 `"77"', add
label define uhrswork_lbl 78 `"78"', add
label define uhrswork_lbl 79 `"79"', add
label define uhrswork_lbl 80 `"80"', add
label define uhrswork_lbl 81 `"81"', add
label define uhrswork_lbl 82 `"82"', add
label define uhrswork_lbl 83 `"83"', add
label define uhrswork_lbl 84 `"84"', add
label define uhrswork_lbl 85 `"85"', add
label define uhrswork_lbl 86 `"86"', add
label define uhrswork_lbl 87 `"87"', add
label define uhrswork_lbl 88 `"88"', add
label define uhrswork_lbl 89 `"89"', add
label define uhrswork_lbl 90 `"90"', add
label define uhrswork_lbl 91 `"91"', add
label define uhrswork_lbl 92 `"92"', add
label define uhrswork_lbl 93 `"93"', add
label define uhrswork_lbl 94 `"94"', add
label define uhrswork_lbl 95 `"95"', add
label define uhrswork_lbl 96 `"96"', add
label define uhrswork_lbl 97 `"97"', add
label define uhrswork_lbl 98 `"98"', add
label define uhrswork_lbl 99 `"99 (Topcode)"', add
label values uhrswork uhrswork_lbl

label define wrklstwk_lbl 0 `"N/A"'
label define wrklstwk_lbl 1 `"Did not work"', add
label define wrklstwk_lbl 2 `"Worked"', add
label define wrklstwk_lbl 3 `"Not Reported"', add
label values wrklstwk wrklstwk_lbl

label define absent_lbl 0 `"N/A"'
label define absent_lbl 1 `"No"', add
label define absent_lbl 2 `"Yes, laid off"', add
label define absent_lbl 3 `"Yes, other reason (vacation, illness, labor dispute, etc.)"', add
label define absent_lbl 4 `"Not reported"', add
label values absent absent_lbl

label define looking_lbl 0 `"N/A"'
label define looking_lbl 1 `"No, did not look for work"', add
label define looking_lbl 2 `"Yes, looked for work"', add
label define looking_lbl 3 `"Not reported"', add
label values looking looking_lbl

label define availble_lbl 0 `"N/A"'
label define availble_lbl 1 `"No, already has job"', add
label define availble_lbl 2 `"No, temporarily ill"', add
label define availble_lbl 3 `"No, other reason(s)"', add
label define availble_lbl 4 `"Yes, available for work"', add
label define availble_lbl 5 `"Not reported"', add
label values availble availble_lbl

label define wrkrecal_lbl 0 `"N/A"'
label define wrkrecal_lbl 1 `"No"', add
label define wrkrecal_lbl 2 `"Yes"', add
label define wrkrecal_lbl 3 `"Not reported"', add
label values wrkrecal wrkrecal_lbl

label define workedyr_lbl 0 `"N/A"'
label define workedyr_lbl 1 `"No"', add
label define workedyr_lbl 2 `"No, but worked 1-5 years ago (ACS only)"', add
label define workedyr_lbl 3 `"Yes"', add
label values workedyr workedyr_lbl

label define incwage_lbl 000000 `"000000"'
label define incwage_lbl 000100 `"000100"', add
label define incwage_lbl 000200 `"000200"', add
label define incwage_lbl 000300 `"000300"', add
label define incwage_lbl 000400 `"000400"', add
label define incwage_lbl 000500 `"000500"', add
label define incwage_lbl 000600 `"000600"', add
label define incwage_lbl 000700 `"000700"', add
label define incwage_lbl 000800 `"000800"', add
label define incwage_lbl 000900 `"000900"', add
label define incwage_lbl 001000 `"001000"', add
label define incwage_lbl 001100 `"001100"', add
label define incwage_lbl 001200 `"001200"', add
label define incwage_lbl 001300 `"001300"', add
label define incwage_lbl 001400 `"001400"', add
label define incwage_lbl 001500 `"001500"', add
label define incwage_lbl 001600 `"001600"', add
label define incwage_lbl 001700 `"001700"', add
label define incwage_lbl 001800 `"001800"', add
label define incwage_lbl 001900 `"001900"', add
label define incwage_lbl 002000 `"002000"', add
label define incwage_lbl 002100 `"002100"', add
label define incwage_lbl 002200 `"002200"', add
label define incwage_lbl 002300 `"002300"', add
label define incwage_lbl 002400 `"002400"', add
label define incwage_lbl 002500 `"002500"', add
label define incwage_lbl 002600 `"002600"', add
label define incwage_lbl 002700 `"002700"', add
label define incwage_lbl 002800 `"002800"', add
label define incwage_lbl 002900 `"002900"', add
label define incwage_lbl 003000 `"003000"', add
label define incwage_lbl 003100 `"003100"', add
label define incwage_lbl 003200 `"003200"', add
label define incwage_lbl 003300 `"003300"', add
label define incwage_lbl 003400 `"003400"', add
label define incwage_lbl 003500 `"003500"', add
label define incwage_lbl 003600 `"003600"', add
label define incwage_lbl 003700 `"003700"', add
label define incwage_lbl 003800 `"003800"', add
label define incwage_lbl 003900 `"003900"', add
label define incwage_lbl 004000 `"004000"', add
label define incwage_lbl 004100 `"004100"', add
label define incwage_lbl 004200 `"004200"', add
label define incwage_lbl 004300 `"004300"', add
label define incwage_lbl 004400 `"004400"', add
label define incwage_lbl 004500 `"004500"', add
label define incwage_lbl 004600 `"004600"', add
label define incwage_lbl 004700 `"004700"', add
label define incwage_lbl 004800 `"004800"', add
label define incwage_lbl 004900 `"004900"', add
label define incwage_lbl 005000 `"005000"', add
label define incwage_lbl 005100 `"005100"', add
label define incwage_lbl 005200 `"005200"', add
label define incwage_lbl 005300 `"005300"', add
label define incwage_lbl 005400 `"005400"', add
label define incwage_lbl 005500 `"005500"', add
label define incwage_lbl 005600 `"005600"', add
label define incwage_lbl 005700 `"005700"', add
label define incwage_lbl 005800 `"005800"', add
label define incwage_lbl 005900 `"005900"', add
label define incwage_lbl 006000 `"006000"', add
label define incwage_lbl 006100 `"006100"', add
label define incwage_lbl 006200 `"006200"', add
label define incwage_lbl 006300 `"006300"', add
label define incwage_lbl 006400 `"006400"', add
label define incwage_lbl 006500 `"006500"', add
label define incwage_lbl 006600 `"006600"', add
label define incwage_lbl 006700 `"006700"', add
label define incwage_lbl 006800 `"006800"', add
label define incwage_lbl 006900 `"006900"', add
label define incwage_lbl 007000 `"007000"', add
label define incwage_lbl 007100 `"007100"', add
label define incwage_lbl 007200 `"007200"', add
label define incwage_lbl 007300 `"007300"', add
label define incwage_lbl 007400 `"007400"', add
label define incwage_lbl 007500 `"007500"', add
label define incwage_lbl 007600 `"007600"', add
label define incwage_lbl 007700 `"007700"', add
label define incwage_lbl 007800 `"007800"', add
label define incwage_lbl 007900 `"007900"', add
label define incwage_lbl 008000 `"008000"', add
label define incwage_lbl 008100 `"008100"', add
label define incwage_lbl 008200 `"008200"', add
label define incwage_lbl 008300 `"008300"', add
label define incwage_lbl 008400 `"008400"', add
label define incwage_lbl 008500 `"008500"', add
label define incwage_lbl 008600 `"008600"', add
label define incwage_lbl 008700 `"008700"', add
label define incwage_lbl 008800 `"008800"', add
label define incwage_lbl 008900 `"008900"', add
label define incwage_lbl 009000 `"009000"', add
label define incwage_lbl 009100 `"009100"', add
label define incwage_lbl 009200 `"009200"', add
label define incwage_lbl 009300 `"009300"', add
label define incwage_lbl 009400 `"009400"', add
label define incwage_lbl 009500 `"009500"', add
label define incwage_lbl 009600 `"009600"', add
label define incwage_lbl 009700 `"009700"', add
label define incwage_lbl 009800 `"009800"', add
label define incwage_lbl 009900 `"009900"', add
label define incwage_lbl 010000 `"010000"', add
label define incwage_lbl 999998 `"Missing"', add
label define incwage_lbl 999999 `"N/A"', add
label values incwage incwage_lbl

label define incbus00_lbl 999999 `"NIU"'
label define incbus00_lbl 999998 `"$1 or break even (2000, 2005-2007 ACS)"', add
label values incbus00 incbus00_lbl

label define incwelfr_lbl 99999 `"NIU"'
label define incwelfr_lbl 99998 `"99998"', add
label define incwelfr_lbl 00000 `"00000"', add
label values incwelfr incwelfr_lbl

label define incinvst_lbl 999999 `"N/A"'
label define incinvst_lbl 999998 `"999998"', add
label values incinvst incinvst_lbl

label define incretir_lbl 999999 `"NIU"'
label values incretir incretir_lbl

label define incsupp_lbl 99998 `"99998"'
label define incsupp_lbl 99999 `"NIU"', add
label values incsupp incsupp_lbl

label define incother_lbl -9900 `"-9900"'
label define incother_lbl -0050 `"-0050"', add
label define incother_lbl -0001 `"Net Loss (1950)"', add
label define incother_lbl 00000 `"00000"', add
label define incother_lbl 00100 `"00100"', add
label define incother_lbl 00200 `"00200"', add
label define incother_lbl 00300 `"00300"', add
label define incother_lbl 00400 `"00400"', add
label define incother_lbl 00500 `"00500"', add
label define incother_lbl 00600 `"00600"', add
label define incother_lbl 00700 `"00700"', add
label define incother_lbl 00800 `"00800"', add
label define incother_lbl 00900 `"00900"', add
label define incother_lbl 01000 `"01000"', add
label define incother_lbl 01100 `"01100"', add
label define incother_lbl 01200 `"01200"', add
label define incother_lbl 01300 `"01300"', add
label define incother_lbl 01400 `"01400"', add
label define incother_lbl 01500 `"01500"', add
label define incother_lbl 01600 `"01600"', add
label define incother_lbl 01700 `"01700"', add
label define incother_lbl 01800 `"01800"', add
label define incother_lbl 01900 `"01900"', add
label define incother_lbl 02000 `"02000"', add
label define incother_lbl 02100 `"02100"', add
label define incother_lbl 02200 `"02200"', add
label define incother_lbl 02300 `"02300"', add
label define incother_lbl 02400 `"02400"', add
label define incother_lbl 02500 `"02500"', add
label define incother_lbl 02600 `"02600"', add
label define incother_lbl 02700 `"02700"', add
label define incother_lbl 02800 `"02800"', add
label define incother_lbl 02900 `"02900"', add
label define incother_lbl 03000 `"03000"', add
label define incother_lbl 03100 `"03100"', add
label define incother_lbl 03200 `"03200"', add
label define incother_lbl 03300 `"03300"', add
label define incother_lbl 03400 `"03400"', add
label define incother_lbl 03500 `"03500"', add
label define incother_lbl 03600 `"03600"', add
label define incother_lbl 03700 `"03700"', add
label define incother_lbl 03800 `"03800"', add
label define incother_lbl 03900 `"03900"', add
label define incother_lbl 04000 `"04000"', add
label define incother_lbl 04100 `"04100"', add
label define incother_lbl 04200 `"04200"', add
label define incother_lbl 04300 `"04300"', add
label define incother_lbl 04400 `"04400"', add
label define incother_lbl 04500 `"04500"', add
label define incother_lbl 04600 `"04600"', add
label define incother_lbl 04700 `"04700"', add
label define incother_lbl 04800 `"04800"', add
label define incother_lbl 04900 `"04900"', add
label define incother_lbl 05000 `"05000"', add
label define incother_lbl 05100 `"05100"', add
label define incother_lbl 05200 `"05200"', add
label define incother_lbl 05300 `"05300"', add
label define incother_lbl 05400 `"05400"', add
label define incother_lbl 05500 `"05500"', add
label define incother_lbl 05600 `"05600"', add
label define incother_lbl 05700 `"05700"', add
label define incother_lbl 05800 `"05800"', add
label define incother_lbl 05900 `"05900"', add
label define incother_lbl 06000 `"06000"', add
label define incother_lbl 06100 `"06100"', add
label define incother_lbl 06200 `"06200"', add
label define incother_lbl 06300 `"06300"', add
label define incother_lbl 06400 `"06400"', add
label define incother_lbl 06500 `"06500"', add
label define incother_lbl 06600 `"06600"', add
label define incother_lbl 06700 `"06700"', add
label define incother_lbl 06800 `"06800"', add
label define incother_lbl 06900 `"06900"', add
label define incother_lbl 07000 `"07000"', add
label define incother_lbl 07100 `"07100"', add
label define incother_lbl 07200 `"07200"', add
label define incother_lbl 07300 `"07300"', add
label define incother_lbl 07400 `"07400"', add
label define incother_lbl 07500 `"07500"', add
label define incother_lbl 07600 `"07600"', add
label define incother_lbl 07700 `"07700"', add
label define incother_lbl 07800 `"07800"', add
label define incother_lbl 07900 `"07900"', add
label define incother_lbl 08000 `"08000"', add
label define incother_lbl 08100 `"08100"', add
label define incother_lbl 08200 `"08200"', add
label define incother_lbl 08300 `"08300"', add
label define incother_lbl 08400 `"08400"', add
label define incother_lbl 08500 `"08500"', add
label define incother_lbl 08600 `"08600"', add
label define incother_lbl 08700 `"08700"', add
label define incother_lbl 08800 `"08800"', add
label define incother_lbl 08900 `"08900"', add
label define incother_lbl 09000 `"09000"', add
label define incother_lbl 09100 `"09100"', add
label define incother_lbl 09200 `"09200"', add
label define incother_lbl 09300 `"09300"', add
label define incother_lbl 09400 `"09400"', add
label define incother_lbl 09500 `"09500"', add
label define incother_lbl 09600 `"09600"', add
label define incother_lbl 09700 `"09700"', add
label define incother_lbl 09800 `"09800"', add
label define incother_lbl 09900 `"09900"', add
label define incother_lbl 10000 `"10000"', add
label define incother_lbl 25000 `"25000"', add
label define incother_lbl 50000 `"50000"', add
label define incother_lbl 99998 `"Unknown"', add
label define incother_lbl 99999 `"NIU"', add
label values incother incother_lbl

label define incearn_lbl 0000000 `"0000000"'
label define incearn_lbl 0000001 `"$1 or breakeven"', add
label values incearn incearn_lbl

label define vetdisab_lbl 0 `"N/A"'
label define vetdisab_lbl 1 `"No disability rating"', add
label define vetdisab_lbl 2 `"0 percent disability rating"', add
label define vetdisab_lbl 3 `"10 or 20 percent disability rating"', add
label define vetdisab_lbl 4 `"30 or 40 percent"', add
label define vetdisab_lbl 5 `"50 or 60 percent"', add
label define vetdisab_lbl 6 `"70 percent or higher"', add
label define vetdisab_lbl 9 `"Has disability rating, level not reported"', add
label values vetdisab vetdisab_lbl

label define diffrem_lbl 0 `"N/A"'
label define diffrem_lbl 1 `"No cognitive difficulty"', add
label define diffrem_lbl 2 `"Has cognitive difficulty"', add
label values diffrem diffrem_lbl

label define diffphys_lbl 0 `"N/A"'
label define diffphys_lbl 1 `"No ambulatory difficulty"', add
label define diffphys_lbl 2 `"Has ambulatory difficulty"', add
label values diffphys diffphys_lbl

label define diffmob_lbl 0 `"N/A"'
label define diffmob_lbl 1 `"No independent living difficulty"', add
label define diffmob_lbl 2 `"Has independent living difficulty"', add
label values diffmob diffmob_lbl

label define diffcare_lbl 0 `"N/A"'
label define diffcare_lbl 1 `"No"', add
label define diffcare_lbl 2 `"Yes"', add
label values diffcare diffcare_lbl

label define diffsens_lbl 0 `"N/A"'
label define diffsens_lbl 1 `"No vision or hearing difficulty"', add
label define diffsens_lbl 2 `"Has vision or hearing difficulty"', add
label values diffsens diffsens_lbl

label define diffeye_lbl 0 `"N/A"'
label define diffeye_lbl 1 `"No"', add
label define diffeye_lbl 2 `"Yes"', add
label values diffeye diffeye_lbl

label define diffhear_lbl 0 `"N/A"'
label define diffhear_lbl 1 `"No"', add
label define diffhear_lbl 2 `"Yes"', add
label values diffhear diffhear_lbl


save "$data/ACS_Prelim_Nov27", replace
