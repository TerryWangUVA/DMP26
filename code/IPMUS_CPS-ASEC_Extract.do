
/*--------------------------------------------------
IPMUS supplementary code for CPS-ASEC data extraction (edited)

					Edit history
	11-20-2025: Change import & export directory
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

///////////////////////////////////////////////////////////


set more off

clear
quietly infix                      ///
  int     year          1-4        ///
  long    serial        5-9        ///
  byte    month         10-11      ///
  double  cpsid         12-25      ///
  byte    asecflag      26-26      ///
  double  asecwth       27-37      ///
  byte    pernum        38-39      ///
  double  cpsidp        40-53      ///
  double  cpsidv        54-68      ///
  double  asecwt        69-79      ///
  double  earnweek2     80-87      ///
  double  hourwage2     88-92      ///
  int     relate        93-96      ///
  byte    age           97-98      ///
  byte    sex           99-99      ///
  int     race          100-102    ///
  byte    marst         103-103    ///
  byte    popstat       104-104    ///
  byte    asian         105-106    ///
  byte    vetstat       107-107    ///
  byte    momloc        108-109    ///
  byte    momloc2       110-111    ///
  byte    momrule       112-113    ///
  byte    mom2rule      114-115    ///
  byte    poploc        116-117    ///
  byte    poploc2       118-119    ///
  byte    poprule       120-121    ///
  byte    pop2rule      122-123    ///
  byte    sploc         124-125    ///
  byte    sprule        126-127    ///
  byte    famsize       128-129    ///
  byte    nchild        130-130    ///
  byte    nchlt5        131-131    ///
  byte    famunit       132-133    ///
  byte    eldch         134-135    ///
  byte    yngch         136-137    ///
  byte    nsibs         138-138    ///
  byte    aspouse       139-140    ///
  byte    pecohab       141-142    ///
  byte    pelnmom       143-144    ///
  byte    pelndad       145-146    ///
  byte    pemomtyp      147-148    ///
  byte    pedadtyp      149-150    ///
  byte    ftype         151-151    ///
  byte    famkind       152-152    ///
  byte    famrel        153-153    ///
  byte    pelnpar1      154-155    ///
  byte    pelnpar2      156-157    ///
  byte    pepar1typ     158-158    ///
  byte    pepar2typ     159-159    ///
  long    bpl           160-164    ///
  int     yrimmig       165-168    ///
  byte    citizen       169-169    ///
  long    mbpl          170-174    ///
  long    fbpl          175-179    ///
  byte    nativity      180-180    ///
  int     hispan        181-183    ///
  byte    empstat       184-185    ///
  byte    labforce      186-186    ///
  int     occ           187-190    ///
  int     occ2010       191-194    ///
  int     occ1990       195-197    ///
  int     ind1990       198-200    ///
  int     occ1950       201-203    ///
  int     ind           204-207    ///
  int     ind1950       208-210    ///
  byte    classwkr      211-212    ///
  int     uhrsworkt     213-215    ///
  int     uhrswork1     216-218    ///
  int     ahrsworkt     219-221    ///
  byte    absent        222-222    ///
  byte    durunem2      223-224    ///
  int     durunemp      225-227    ///
  byte    whyunemp      228-228    ///
  byte    whyabsnt      229-230    ///
  int     whyptlwk      231-233    ///
  byte    wnftlook      234-235    ///
  byte    wkstat        236-237    ///
  int     educ          238-240    ///
  byte    educ99        241-242    ///
  byte    schlcoll      243-243    ///
  byte    diffhear      244-244    ///
  byte    diffeye       245-245    ///
  byte    diffrem       246-246    ///
  byte    diffphys      247-247    ///
  byte    diffmob       248-248    ///
  byte    diffcare      249-249    ///
  byte    diffany       250-250    ///
  int     occly         251-254    ///
  int     occ50ly       255-257    ///
  int     indly         258-261    ///
  int     ind50ly       262-264    ///
  int     occ90ly       265-267    ///
  int     ind90ly       268-270    ///
  int     occ10ly       271-274    ///
  byte    classwly      275-276    ///
  byte    workly        277-278    ///
  byte    wkswork1      279-280    ///
  byte    wkswork2      281-281    ///
  int     uhrsworkly    282-284    ///
  byte    wksunem1      285-286    ///
  byte    wksunem2      287-287    ///
  byte    fullpart      288-288    ///
  int     wkxpns        289-292    ///
  byte    nwlookwk      293-294    ///
  byte    pension       295-295    ///
  byte    firmsize      296-296    ///
  byte    wantjob       297-297    ///
  byte    whyptly       298-298    ///
  byte    usftptlw      299-299    ///
  byte    payifabs      300-300    ///
  byte    numemps       301-301    ///
  byte    wnlwnilf      302-303    ///
  byte    strechlk      304-304    ///
  byte    whynwly       305-305    ///
  byte    actnlfly      306-307    ///
  byte    ptweeks       308-309    ///
  double  ftotval       310-319    ///
  double  inctot        320-328    ///
  double  incwage       329-336    ///
  double  incbus        337-344    ///
  double  incfarm       345-352    ///
  long    incss         353-358    ///
  long    incwelfr      359-364    ///
  double  incretir      365-372    ///
  long    incssi        373-378    ///
  long    incint        379-385    ///
  long    incunemp      386-391    ///
  long    incwkcom      392-397    ///
  long    incvet        398-404    ///
  long    incsurv       405-411    ///
  long    incdisab      412-418    ///
  long    incdivid      419-425    ///
  long    incrent       426-432    ///
  long    inceduc       433-439    ///
  long    incchild      440-445    ///
  long    incasist      446-452    ///
  long    incother      453-459    ///
  long    incrann       460-466    ///
  long    incpens       467-473    ///
  double  inclongj      474-481    ///
  double  oincbus       482-489    ///
  double  oincfarm      490-497    ///
  double  oincwage      498-505    ///
  byte    srcreti1      506-506    ///
  byte    srcreti2      507-507    ///
  long    increti1      508-514    ///
  long    increti2      515-521    ///
  byte    srcsurv1      522-523    ///
  byte    srcsurv2      524-525    ///
  double  incsurv1      526-533    ///
  double  incsurv2      534-541    ///
  byte    srcdisa1      542-543    ///
  byte    srcdisa2      544-545    ///
  long    incdisa1      546-552    ///
  long    incdisa2      553-559    ///
  byte    srcret1       560-561    ///
  byte    srcret2       562-563    ///
  long    incret1       564-570    ///
  long    incret2       571-577    ///
  byte    srcpen1       578-579    ///
  byte    srcpen2       580-581    ///
  long    incpen1       582-588    ///
  long    incpen2       589-595    ///
  long    retcont       596-601    ///
  byte    srcrint1      602-603    ///
  byte    srcrint2      604-605    ///
  long    incrint1      606-612    ///
  long    incrint2      613-619    ///
  long    inccapg       620-626    ///
  byte    srcearn       627-627    ///
  byte    srceduc       628-628    ///
  byte    srcunemp      629-629    ///
  byte    srcwelfr      630-630    ///
  byte    srcwkcom      631-631    ///
  long    mthwelfr      632-636    ///
  byte    ssikid        637-637    ///
  byte    sskid         638-638    ///
  byte    vetqa         639-639    ///
  byte    whyss1        640-640    ///
  byte    whyss2        641-641    ///
  byte    whyssi1       642-642    ///
  byte    whyssi2       643-643    ///
  byte    gotvdisa      644-644    ///
  byte    gotveduc      645-645    ///
  byte    gotvothe      646-646    ///
  byte    gotvpens      647-647    ///
  byte    gotvsurv      648-648    ///
  long    ctccrd        649-654    ///
  long    actccrd       655-659    ///
  double  adjginc       660-667    ///
  int     eitcred       668-671    ///
  long    fedretir      672-677    ///
  double  fedtax        678-685    ///
  double  fedtaxac      686-693    ///
  long    fica          694-698    ///
  byte    filestat      699-699    ///
  byte    depstat       700-701    ///
  byte    margtax       702-703    ///
  long    statetax      704-710    ///
  long    stataxac      711-717    ///
  long    taxinc        718-724    ///
  byte    offpov        725-726    ///
  byte    offpovuniv    727-728    ///
  double  offtotval     729-738    ///
  long    offcutoff     739-744    ///
  byte    offreason     745-746    ///
  byte    poverty       747-748    ///
  long    cutoff        749-754    ///
  long    foodstamp     755-759    ///
  long    schllunch     760-764    ///
  double  spmlunch      765-772    ///
  double  spmcaphous    773-790    ///
  byte    spmnewfam     791-791    ///
  byte    spmpov        792-792    ///
  byte    spmmort       793-793    ///
  double  spmeqscale    794-812    ///
  double  spmwt         813-820    ///
  double  spmmedxpns    821-830    ///
  double  spmchxpns     831-850    ///
  double  spmcapxpns    851-872    ///
  long    spmchsup      873-877    ///
  double  spmsttax      878-887    ///
  double  spmfedtaxac   888-907    ///
  double  spmeitc       908-913    ///
  double  spmfica       914-928    ///
  double  spmfedtaxbc   929-948    ///
  double  spmwic        949-957    ///
  double  spmheat       958-979    ///
  double  spmsnap       980-987    ///
  long    spmftotval    988-994    ///
  double  spmtotres     995-1016   ///
  byte    spmnadults    1017-1018  ///
  byte    spmnchild     1019-1020  ///
  byte    spmnpers      1021-1022  ///
  double  spmgeoadj     1023-1044  ///
  double  spmthresh     1045-1066  ///
  double  spmfamunit    1067-1081  ///
  double  spmwkxpns     1082-1098  ///
  byte    migsta1       1099-1100  ///
  byte    migsta5       1101-1102  ///
  byte    whymove       1103-1104  ///
  byte    migrate1      1105-1105  ///
  byte    migrate5      1106-1107  ///
  byte    mig5diffarea  1108-1108  ///
  byte    mig5diffreg   1109-1109  ///
  byte    mig5diffcbst  1110-1110  ///
  byte    mig5cbst      1111-1111  ///
  byte    mig5div       1112-1113  ///
  byte    mig5cityst    1114-1114  ///
  byte    mig5region    1115-1115  ///
  byte    qmig5same     1116-1116  ///
  byte    disabwrk      1117-1117  ///
  byte    health        1118-1118  ///
  byte    quitsick      1119-1119  ///
  double  hourwage      1120-1124  ///
  byte    paidhour      1125-1125  ///
  byte    union         1126-1126  ///
  double  earnweek      1127-1134  ///
  byte    eligorg       1135-1135  ///
  byte    telwrkpay     1136-1136  ///
  int     telwrkhr      1137-1139  ///
  using `"$raw/IPMUS CPS ASEC/cps-asec_Nov20.dat"'

replace asecwth      = asecwth      / 10000
replace asecwt       = asecwt       / 10000
replace earnweek2    = earnweek2    / 100
replace hourwage2    = hourwage2    / 100
replace hourwage     = hourwage     / 100
replace earnweek     = earnweek     / 100

format cpsid        %14.0f
format asecwth      %11.4f
format cpsidp       %14.0f
format cpsidv       %15.0f
format asecwt       %11.4f
format earnweek2    %8.2f
format hourwage2    %5.2f
format ftotval      %10.0f
format inctot       %9.0f
format incwage      %8.0f
format incbus       %8.0f
format incfarm      %8.0f
format incretir     %8.0f
format inclongj     %8.0f
format oincbus      %8.0f
format oincfarm     %8.0f
format oincwage     %8.0f
format incsurv1     %8.0f
format incsurv2     %8.0f
format adjginc      %8.0f
format fedtax       %8.0f
format fedtaxac     %8.0f
format offtotval    %10.0f
format spmlunch     %8.0g
format spmcaphous   %18.0g
format spmeqscale   %19.0g
format spmwt        %8.0g
format spmmedxpns   %10.0g
format spmchxpns    %20.0g
format spmcapxpns   %22.0g
format spmsttax     %10.0g
format spmfedtaxac  %20.0g
format spmeitc      %6.0g
format spmfica      %15.0g
format spmfedtaxbc  %20.0g
format spmwic       %9.0g
format spmheat      %22.0g
format spmsnap      %8.0g
format spmtotres    %22.0g
format spmgeoadj    %22.0g
format spmthresh    %22.0g
format spmfamunit   %15.0f
format spmwkxpns    %17.0g
format hourwage     %5.2f
format earnweek     %8.2f

label var year         `"Survey year"'
label var serial       `"Household serial number"'
label var month        `"Month"'
label var cpsid        `"CPSID, household record"'
label var asecflag     `"Flag for ASEC"'
label var asecwth      `"Annual Social and Economic Supplement Household weight"'
label var pernum       `"Person number in sample unit"'
label var cpsidp       `"CPSID, person record"'
label var cpsidv       `"Validated Longitudinal Identifier"'
label var asecwt       `"Annual Social and Economic Supplement Weight"'
label var earnweek2    `"Weekly earnings (rounded)"'
label var hourwage2    `"Hourly wage (rounded)"'
label var relate       `"Relationship to household head"'
label var age          `"Age"'
label var sex          `"Sex"'
label var race         `"Race"'
label var marst        `"Marital status"'
label var popstat      `"Adult civilian, armed forces, or child"'
label var asian        `"Asian subgroup"'
label var vetstat      `"Veteran status"'
label var momloc       `"Person number of first mother (from programming)"'
label var momloc2      `"Person number of second mother (from programming)"'
label var momrule      `"Rule for linking first mother"'
label var mom2rule     `"Rule for linking second mother"'
label var poploc       `"Person number of first father (from programming)"'
label var poploc2      `"Person number of second father (from programming)"'
label var poprule      `"Rule for linking first father"'
label var pop2rule     `"Rule for linking second father"'
label var sploc        `"Person number of spouse (from programming)"'
label var sprule       `"Rule for linking spouse"'
label var famsize      `"Number of own family members in hh"'
label var nchild       `"Number of own children in household"'
label var nchlt5       `"Number of own children under age 5 in hh"'
label var famunit      `"Family unit membership"'
label var eldch        `"Age of eldest own child in household"'
label var yngch        `"Age of youngest own child in household"'
label var nsibs        `"Number of own siblings in household"'
label var aspouse      `"Spouse line number (self-reported)"'
label var pecohab      `"Cohabiting partner line number (self-reported)"'
label var pelnmom      `"Mother's line number (self-reported)"'
label var pelndad      `"Father's line number (self-reported)"'
label var pemomtyp     `"Mother's relationship to child (self-reported)"'
label var pedadtyp     `"Father's relationship to child (self-reported)"'
label var ftype        `"Family Type"'
label var famkind      `"Kind of family"'
label var famrel       `"Relationship to family"'
label var pelnpar1     `"Parent 1 line number (self-reported)"'
label var pelnpar2     `"Parent 2 line number (self-reported)"'
label var pepar1typ    `"First parent's relationship to child (self-reported)"'
label var pepar2typ    `"Second parent's relationship to child (self-reported)"'
label var bpl          `"Birthplace"'
label var yrimmig      `"Year of immigration"'
label var citizen      `"Citizenship status"'
label var mbpl         `"Mother's birthplace "'
label var fbpl         `"Father's birthplace"'
label var nativity     `"Foreign birthplace or parentage"'
label var hispan       `"Hispanic origin"'
label var empstat      `"Employment status"'
label var labforce     `"Labor force status"'
label var occ          `"Occupation"'
label var occ2010      `"Occupation, 2010 basis"'
label var occ1990      `"Occupation, 1990 basis"'
label var ind1990      `"Industry, 1990 basis"'
label var occ1950      `"Occupation, 1950 basis"'
label var ind          `"Industry"'
label var ind1950      `"Industry, 1950 basis"'
label var classwkr     `"Class of worker "'
label var uhrsworkt    `"Hours usually worked per week at all jobs"'
label var uhrswork1    `"Hours usually worked per week at main job"'
label var ahrsworkt    `"Hours worked last week"'
label var absent       `"Absent from work last week"'
label var durunem2     `"Continuous weeks unemployed, intervalled"'
label var durunemp     `"Continuous weeks unemployed"'
label var whyunemp     `"Reason for unemployment"'
label var whyabsnt     `"Reason for absence from work"'
label var whyptlwk     `"Reason for working part time last week"'
label var wnftlook     `"When last worked full time 2 consecutive weeks (looking last week)"'
label var wkstat       `"Full or part time status"'
label var educ         `"Educational attainment recode"'
label var educ99       `"Educational attainment, 1990"'
label var schlcoll     `"School or college attendance"'
label var diffhear     `"Hearing difficulty"'
label var diffeye      `"Vision difficulty"'
label var diffrem      `"Difficulty remembering"'
label var diffphys     `"Physical difficulty"'
label var diffmob      `"Disability limiting mobility"'
label var diffcare     `"Personal care limitation"'
label var diffany      `"Any difficulty"'
label var occly        `"Occupation last year"'
label var occ50ly      `"Occupation last year, 1950 basis"'
label var indly        `"Industry last year"'
label var ind50ly      `"Industry last year, 1950 basis"'
label var occ90ly      `"Occupation last year, 1990 basis"'
label var ind90ly      `"Industry last year, 1990 basis"'
label var occ10ly      `"Occupation last year, 2010 basis"'
label var classwly     `"Class of worker last year"'
label var workly       `"Worked last year"'
label var wkswork1     `"Weeks worked last year"'
label var wkswork2     `"Weeks worked last year, intervalled"'
label var uhrsworkly   `"Usual hours worked per week (last yr)"'
label var wksunem1     `"Weeks unemployed last year"'
label var wksunem2     `"Weeks unemployed last year, intervalled"'
label var fullpart     `"Worked full or part time last year"'
label var wkxpns       `"Work expenses"'
label var nwlookwk     `"Weeks looked for work last year (didn't work)"'
label var pension      `"Pension plan at work"'
label var firmsize     `"Number of employees"'
label var wantjob      `"Want regular job now"'
label var whyptly      `"Reason for working part-time last year"'
label var usftptlw     `"Usually work full time (part time last week)"'
label var payifabs     `"Paid if absent from work last week"'
label var numemps      `"Number of employers last year"'
label var wnlwnilf     `"When last worked for pay (NILF last week)"'
label var strechlk     `"Stretches of looking for work last year"'
label var whynwly      `"Reason not working last year"'
label var actnlfly     `"Activity when not in labor force last year (part-year workers)"'
label var ptweeks      `"Weeks working part time last year"'
label var ftotval      `"Total family income"'
label var inctot       `"Total personal income"'
label var incwage      `"Wage and salary income"'
label var incbus       `"Non-farm business income"'
label var incfarm      `"Farm income"'
label var incss        `"Social Security income"'
label var incwelfr     `"Welfare (public assistance) income"'
label var incretir     `"Retirement income"'
label var incssi       `"Income from SSI"'
label var incint       `"Income from interest"'
label var incunemp     `"Income from unemployment benefits"'
label var incwkcom     `"Income from worker's compensation"'
label var incvet       `"Income from veteran's benefits"'
label var incsurv      `"Income from survivor's benefits"'
label var incdisab     `"Income from disability benefits"'
label var incdivid     `"Income from dividends"'
label var incrent      `"Income from rent"'
label var inceduc      `"Income from educational assistance"'
label var incchild     `"Income from child support"'
label var incasist     `"Income from assistance"'
label var incother     `"Income from other Source not specified"'
label var incrann      `"Retirement income from annuities"'
label var incpens      `"Pension income"'
label var inclongj     `"Earnings from longest job"'
label var oincbus      `"Earnings from other work included business self-employment earnings"'
label var oincfarm     `"Earnings from other work included farm self-employment earnings"'
label var oincwage     `"Earnings from other work included wage and salary earnings"'
label var srcreti1     `"First source of retirement income"'
label var srcreti2     `"Second source of retirement income"'
label var increti1     `"Retirement income from first source"'
label var increti2     `"Retirement income from second source"'
label var srcsurv1     `"First source of survivor benefits"'
label var srcsurv2     `"Second source of survivor benefits"'
label var incsurv1     `"Survivor benefits income from first source"'
label var incsurv2     `"Survivor benefits income from second source"'
label var srcdisa1     `"First source of disability income"'
label var srcdisa2     `"Second source of disability income"'
label var incdisa1     `"Disability income from first source"'
label var incdisa2     `"Disability income from second source"'
label var srcret1      `"First source of retirement income"'
label var srcret2      `"Second source of retirement income"'
label var incret1      `"Retirement income from first source"'
label var incret2      `"Retirement income from second source"'
label var srcpen1      `"First source of pension income"'
label var srcpen2      `"Second source of pension income"'
label var incpen1      `"Pension income from first source"'
label var incpen2      `"Pension income from second source"'
label var retcont      `"Contribution to a retirement account last year"'
label var srcrint1     `"First source of interest income from a retirement account."'
label var srcrint2     `"Second source of interest income from a retirement account."'
label var incrint1     `"Interest income from a retirement account from first source"'
label var incrint2     `"Interest income from a retirement account from second source"'
label var inccapg      `"Capital gains received from shares of stocks or mutual funds last year"'
label var srcearn      `"Source of earnings from longest job"'
label var srceduc      `"Source of educational assistance"'
label var srcunemp     `"Source of unemployment income"'
label var srcwelfr     `"Source of welfare income"'
label var srcwkcom     `"Source of workmen's compensation"'
label var mthwelfr     `"Number of months received welfare income"'
label var ssikid       `"Child under 18 received SSI income"'
label var sskid        `"Child under 19 received SS income"'
label var vetqa        `"Required to fill out annual income questionnaire for veterans' administration"'
label var whyss1       `"First reason for receiving social security income"'
label var whyss2       `"Second reason for receiving social security income"'
label var whyssi1      `"First reason for receiving supplementary security income"'
label var whyssi2      `"Second reason for receiving supplementary security income"'
label var gotvdisa     `"Received veterans' disability compensation"'
label var gotveduc     `"Received veterans' education assistance"'
label var gotvothe     `"Received other veterans' payments"'
label var gotvpens     `"Received veterans' pension"'
label var gotvsurv     `"Received veterans' survivor benefits"'
label var ctccrd       `"Child Tax Credit"'
label var actccrd      `"Additional Child Tax Credit"'
label var adjginc      `"Adjusted gross income"'
label var eitcred      `"Earned income tax credit"'
label var fedretir     `"Federal retirement payroll deduction"'
label var fedtax       `"Federal income tax liability, before credits"'
label var fedtaxac     `"Federal income tax liability, after all credits"'
label var fica         `"Social security retirement payroll deduction"'
label var filestat     `"Tax filer status"'
label var depstat      `"Dependency status pointer"'
label var margtax      `"Federal income marginal tax rate"'
label var statetax     `"State income tax liability, before credits"'
label var stataxac     `"State income tax liability, after all credits"'
label var taxinc       `"Taxable income amount"'
label var offpov       `"Official Poverty Status (IPUMS constructed)"'
label var offpovuniv   `"Official Poverty Rate Universe"'
label var offtotval    `"Total Family Income for Replicating Official Poverty Rates"'
label var offcutoff    `"Official Poverty Rate Cutoff"'
label var offreason    `"Reason for Discrepancy between OFFPOV and POVERTY"'
label var poverty      `"Original poverty status (PUMS original)"'
label var cutoff       `"Cutoff for original poverty status, in dollars"'
label var foodstamp    `"Family market value of food stamps"'
label var schllunch    `"Family market value of school lunch"'
label var spmlunch     `"SPM unit's school lunch value"'
label var spmcaphous   `"SPM unit's capped housing subsidy"'
label var spmnewfam    `"SPM unit's new family status"'
label var spmpov       `"SPM unit's poverty status"'
label var spmmort      `"SPM unit's tenure/mortgage status"'
label var spmeqscale   `"SPM unit's equivalence scale"'
label var spmwt        `"SPM unit's weight"'
label var spmmedxpns   `"SPM unit's medical out-of-pocket and Medicare B subsidy"'
label var spmchxpns    `"SPM unit's child care expenses - not capped"'
label var spmcapxpns   `"SPM unit's capped work and child care expenses"'
label var spmchsup     `"SPM unit's child support paid"'
label var spmsttax     `"SPM unit's state tax"'
label var spmfedtaxac  `"SPM unit's federal tax"'
label var spmeitc      `"SPM unit's federal EITC"'
label var spmfica      `"SPM unit's FICA and federal retirement"'
label var spmfedtaxbc  `"SPM unit's federal tax before the EITC"'
label var spmwic       `"SPM unit's WIC value"'
label var spmheat      `"SPM unit's energy subsidy"'
label var spmsnap      `"SPM unit's SNAP subsidy"'
label var spmftotval   `"SPM unit's cash income"'
label var spmtotres    `"Total SPM resources for SPM unit"'
label var spmnadults   `"SPM unit's number of adults"'
label var spmnchild    `"SPM unit's number of chidren"'
label var spmnpers     `"SPM unit's number of persons"'
label var spmgeoadj    `"SPM unit's geographic adjustment"'
label var spmthresh    `"SPM unit's threshold"'
label var spmfamunit   `"SPM unit's ID"'
label var spmwkxpns    `"SPM unit's work expenses - not capped"'
label var migsta1      `"State of residence 1 year ago"'
label var migsta5      `"State of residence 5 years ago"'
label var whymove      `"Reason for moving"'
label var migrate1     `"Migration status, 1 year"'
label var migrate5     `"Migration status, 5 years"'
label var mig5diffarea `"Geographic area different from previous residence, 5 years ago"'
label var mig5diffreg  `"Census region different from previous residence, 5 years ago"'
label var mig5diffcbst `"Metropolitan status different from previous residence, 5 years ago"'
label var mig5cbst     `"Metropolitan CBSA status of residence, 5 years ago"'
label var mig5div      `"Census division of residence, 5 years ago"'
label var mig5cityst   `"Principal city status of residence, 5 years ago"'
label var mig5region   `"Census region of residence, 5 years ago"'
label var qmig5same    `"Imputation flag: Same residence as 5 years ago"'
label var disabwrk     `"Work disability"'
label var health       `"Health status"'
label var quitsick     `"Quit job or retired for health reasons"'
label var hourwage     `"Hourly wage"'
label var paidhour     `"Paid by the hour"'
label var union        `"Union membership"'
label var earnweek     `"Weekly earnings"'
label var eligorg      `"(Earnings) eligibility flag"'
label var telwrkpay    `"In the last week, telework or work at home for pay"'
label var telwrkhr     `"In the last week, total number of hours telework or work at home for pay"'

label define month_lbl 01 `"January"'
label define month_lbl 02 `"February"', add
label define month_lbl 03 `"March"', add
label define month_lbl 04 `"April"', add
label define month_lbl 05 `"May"', add
label define month_lbl 06 `"June"', add
label define month_lbl 07 `"July"', add
label define month_lbl 08 `"August"', add
label define month_lbl 09 `"September"', add
label define month_lbl 10 `"October"', add
label define month_lbl 11 `"November"', add
label define month_lbl 12 `"December"', add
label values month month_lbl

label define asecflag_lbl 1 `"ASEC"'
label define asecflag_lbl 2 `"March Basic"', add
label values asecflag asecflag_lbl

label define earnweek2_lbl 99999999 `"NIU"'
label values earnweek2 earnweek2_lbl

label define hourwage2_lbl 99999 `"NIU"'
label values hourwage2 hourwage2_lbl

label define relate_lbl 0101 `"Head/householder"'
label define relate_lbl 0201 `"Spouse"', add
label define relate_lbl 0202 `"Opposite sex spouse"', add
label define relate_lbl 0203 `"Same sex spouse"', add
label define relate_lbl 0301 `"Child"', add
label define relate_lbl 0303 `"Stepchild"', add
label define relate_lbl 0501 `"Parent"', add
label define relate_lbl 0701 `"Sibling"', add
label define relate_lbl 0901 `"Grandchild"', add
label define relate_lbl 1001 `"Other relatives, n.s."', add
label define relate_lbl 1113 `"Partner/roommate"', add
label define relate_lbl 1114 `"Unmarried partner"', add
label define relate_lbl 1116 `"Opposite sex unmarried partner"', add
label define relate_lbl 1117 `"Same sex unmarried partner"', add
label define relate_lbl 1115 `"Housemate/roomate"', add
label define relate_lbl 1241 `"Roomer/boarder/lodger"', add
label define relate_lbl 1242 `"Foster children"', add
label define relate_lbl 1260 `"Other nonrelatives"', add
label define relate_lbl 9900 `"Relationship unknown"', add
label define relate_lbl 9999 `"NIU"', add
label values relate relate_lbl

label define age_lbl 00 `"Under 1 year"'
label define age_lbl 01 `"1"', add
label define age_lbl 02 `"2"', add
label define age_lbl 03 `"3"', add
label define age_lbl 04 `"4"', add
label define age_lbl 05 `"5"', add
label define age_lbl 06 `"6"', add
label define age_lbl 07 `"7"', add
label define age_lbl 08 `"8"', add
label define age_lbl 09 `"9"', add
label define age_lbl 10 `"10"', add
label define age_lbl 11 `"11"', add
label define age_lbl 12 `"12"', add
label define age_lbl 13 `"13"', add
label define age_lbl 14 `"14"', add
label define age_lbl 15 `"15"', add
label define age_lbl 16 `"16"', add
label define age_lbl 17 `"17"', add
label define age_lbl 18 `"18"', add
label define age_lbl 19 `"19"', add
label define age_lbl 20 `"20"', add
label define age_lbl 21 `"21"', add
label define age_lbl 22 `"22"', add
label define age_lbl 23 `"23"', add
label define age_lbl 24 `"24"', add
label define age_lbl 25 `"25"', add
label define age_lbl 26 `"26"', add
label define age_lbl 27 `"27"', add
label define age_lbl 28 `"28"', add
label define age_lbl 29 `"29"', add
label define age_lbl 30 `"30"', add
label define age_lbl 31 `"31"', add
label define age_lbl 32 `"32"', add
label define age_lbl 33 `"33"', add
label define age_lbl 34 `"34"', add
label define age_lbl 35 `"35"', add
label define age_lbl 36 `"36"', add
label define age_lbl 37 `"37"', add
label define age_lbl 38 `"38"', add
label define age_lbl 39 `"39"', add
label define age_lbl 40 `"40"', add
label define age_lbl 41 `"41"', add
label define age_lbl 42 `"42"', add
label define age_lbl 43 `"43"', add
label define age_lbl 44 `"44"', add
label define age_lbl 45 `"45"', add
label define age_lbl 46 `"46"', add
label define age_lbl 47 `"47"', add
label define age_lbl 48 `"48"', add
label define age_lbl 49 `"49"', add
label define age_lbl 50 `"50"', add
label define age_lbl 51 `"51"', add
label define age_lbl 52 `"52"', add
label define age_lbl 53 `"53"', add
label define age_lbl 54 `"54"', add
label define age_lbl 55 `"55"', add
label define age_lbl 56 `"56"', add
label define age_lbl 57 `"57"', add
label define age_lbl 58 `"58"', add
label define age_lbl 59 `"59"', add
label define age_lbl 60 `"60"', add
label define age_lbl 61 `"61"', add
label define age_lbl 62 `"62"', add
label define age_lbl 63 `"63"', add
label define age_lbl 64 `"64"', add
label define age_lbl 65 `"65"', add
label define age_lbl 66 `"66"', add
label define age_lbl 67 `"67"', add
label define age_lbl 68 `"68"', add
label define age_lbl 69 `"69"', add
label define age_lbl 70 `"70"', add
label define age_lbl 71 `"71"', add
label define age_lbl 72 `"72"', add
label define age_lbl 73 `"73"', add
label define age_lbl 74 `"74"', add
label define age_lbl 75 `"75"', add
label define age_lbl 76 `"76"', add
label define age_lbl 77 `"77"', add
label define age_lbl 78 `"78"', add
label define age_lbl 79 `"79"', add
label define age_lbl 80 `"80"', add
label define age_lbl 81 `"81"', add
label define age_lbl 82 `"82"', add
label define age_lbl 83 `"83"', add
label define age_lbl 84 `"84"', add
label define age_lbl 85 `"85"', add
label define age_lbl 86 `"86"', add
label define age_lbl 87 `"87"', add
label define age_lbl 88 `"88"', add
label define age_lbl 89 `"89"', add
label define age_lbl 90 `"90 (90+, 1988-2002)"', add
label define age_lbl 91 `"91"', add
label define age_lbl 92 `"92"', add
label define age_lbl 93 `"93"', add
label define age_lbl 94 `"94"', add
label define age_lbl 95 `"95"', add
label define age_lbl 96 `"96"', add
label define age_lbl 97 `"97"', add
label define age_lbl 98 `"98"', add
label define age_lbl 99 `"99+"', add
label values age age_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"NIU"', add
label values sex sex_lbl

label define race_lbl 100 `"White"'
label define race_lbl 200 `"Black"', add
label define race_lbl 300 `"American Indian/Aleut/Eskimo"', add
label define race_lbl 650 `"Asian or Pacific Islander"', add
label define race_lbl 651 `"Asian only"', add
label define race_lbl 652 `"Hawaiian/Pacific Islander only"', add
label define race_lbl 700 `"Other (single) race, n.e.c."', add
label define race_lbl 801 `"White-Black"', add
label define race_lbl 802 `"White-American Indian"', add
label define race_lbl 803 `"White-Asian"', add
label define race_lbl 804 `"White-Hawaiian/Pacific Islander"', add
label define race_lbl 805 `"Black-American Indian"', add
label define race_lbl 806 `"Black-Asian"', add
label define race_lbl 807 `"Black-Hawaiian/Pacific Islander"', add
label define race_lbl 808 `"American Indian-Asian"', add
label define race_lbl 809 `"Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 810 `"White-Black-American Indian"', add
label define race_lbl 811 `"White-Black-Asian"', add
label define race_lbl 812 `"White-American Indian-Asian"', add
label define race_lbl 813 `"White-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 814 `"White-Black-American Indian-Asian"', add
label define race_lbl 815 `"American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 816 `"White-Black--Hawaiian/Pacific Islander"', add
label define race_lbl 817 `"White-American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 818 `"Black-American Indian-Asian"', add
label define race_lbl 819 `"White-American Indian-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 820 `"Two or three races, unspecified"', add
label define race_lbl 830 `"Four or five races, unspecified"', add
label define race_lbl 999 `"Blank"', add
label values race race_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label define marst_lbl 7 `"Widowed or Divorced"', add
label define marst_lbl 9 `"NIU"', add
label values marst marst_lbl

label define popstat_lbl 1 `"Adult civilian"'
label define popstat_lbl 2 `"Armed Forces"', add
label define popstat_lbl 3 `"Child"', add
label values popstat popstat_lbl

label define asian_lbl 10 `"Asian Indian"'
label define asian_lbl 20 `"Chinese"', add
label define asian_lbl 30 `"Filipino"', add
label define asian_lbl 40 `"Japanese"', add
label define asian_lbl 50 `"Korean"', add
label define asian_lbl 60 `"Vietnamese"', add
label define asian_lbl 70 `"Other Asian"', add
label define asian_lbl 99 `"NIU"', add
label values asian asian_lbl

label define vetstat_lbl 0 `"NIU"'
label define vetstat_lbl 1 `"No service"', add
label define vetstat_lbl 2 `"Yes"', add
label define vetstat_lbl 9 `"Unknown"', add
label values vetstat vetstat_lbl

label define momrule_lbl 00 `"No mother link"'
label define momrule_lbl 01 `"Unambiguous mother link"', add
label define momrule_lbl 02 `"Daughter/granchild link"', add
label define momrule_lbl 03 `"Preceding male (no intervening person)"', add
label define momrule_lbl 07 `"Spouse of father becomes stepmother"', add
label values momrule momrule_lbl

label define mom2rule_lbl 00 `"No mother link"'
label define mom2rule_lbl 01 `"Unambiguous mother link"', add
label define mom2rule_lbl 02 `"Daughter/granchild link"', add
label define mom2rule_lbl 03 `"Preceding male (no intervening person)"', add
label define mom2rule_lbl 07 `"Spouse of father becomes stepmother"', add
label values mom2rule mom2rule_lbl

label define poprule_lbl 00 `"No father link"'
label define poprule_lbl 01 `"Unambiguous father link"', add
label define poprule_lbl 02 `"Son/granchild link"', add
label define poprule_lbl 03 `"Preceding male (no intervening person)"', add
label define poprule_lbl 07 `"Husband of mother becomes stepfather"', add
label values poprule poprule_lbl

label define pop2rule_lbl 00 `"No father link"'
label define pop2rule_lbl 01 `"Unambiguous father link"', add
label define pop2rule_lbl 02 `"Son/granchild link"', add
label define pop2rule_lbl 03 `"Preceding male (no intervening person)"', add
label define pop2rule_lbl 07 `"Husband of mother becomes stepfather"', add
label values pop2rule pop2rule_lbl

label define sprule_lbl 00 `"No spouse link"'
label define sprule_lbl 11 `"Rule 11 is used to identify spouse/partner"', add
label define sprule_lbl 12 `"Rule 12 is used to identify spouse/partner"', add
label define sprule_lbl 13 `"Rule 13 is used to identify spouse/partner"', add
label define sprule_lbl 14 `"Rule 14 is used to identify spouse/partner"', add
label define sprule_lbl 15 `"Rule 15 is used to identify spouse/partner"', add
label define sprule_lbl 16 `"Rule 16 is used to identify spouse/partner"', add
label define sprule_lbl 21 `"Rule 21 is used to identify spouse/partner"', add
label define sprule_lbl 22 `"Rule 22 is used to identify spouse/partner"', add
label define sprule_lbl 23 `"Rule 23 is used to identify spouse/partner"', add
label define sprule_lbl 24 `"Rule 24 is used to identify spouse/partner"', add
label define sprule_lbl 25 `"Rule 25 is used to identify spouse/partner"', add
label define sprule_lbl 26 `"Rule 26 is used to identify spouse/partner"', add
label define sprule_lbl 31 `"Rule 31 is used to identify spouse/partner"', add
label define sprule_lbl 32 `"Rule 32 is used to identify spouse/partner"', add
label define sprule_lbl 33 `"Rule 33 is used to identify spouse/partner"', add
label define sprule_lbl 34 `"Rule 34 is used to identify spouse/partner"', add
label define sprule_lbl 35 `"Rule 35 is used to identify spouse/partner"', add
label define sprule_lbl 36 `"Rule 36 is used to identify spouse/partner"', add
label define sprule_lbl 41 `"Rule 41 is used to identify spouse/partner"', add
label define sprule_lbl 42 `"Rule 42 is used to identify spouse/partner"', add
label define sprule_lbl 43 `"Rule 43 is used to identify spouse/partner"', add
label define sprule_lbl 44 `"Rule 44 is used to identify spouse/partner"', add
label define sprule_lbl 45 `"Rule 45 is used to identify spouse/partner"', add
label define sprule_lbl 46 `"Rule 46 is used to identify spouse/partner"', add
label values sprule sprule_lbl

label define famsize_lbl 00 `"Missing"'
label define famsize_lbl 01 `"1 family member present"', add
label define famsize_lbl 02 `"2 family members present"', add
label define famsize_lbl 03 `"3 family members present"', add
label define famsize_lbl 04 `"4 family members present"', add
label define famsize_lbl 05 `"5 family members present"', add
label define famsize_lbl 06 `"6 family members present"', add
label define famsize_lbl 07 `"7 family members present"', add
label define famsize_lbl 08 `"8 family members present"', add
label define famsize_lbl 09 `"9 family members present"', add
label define famsize_lbl 10 `"10 family members present"', add
label define famsize_lbl 11 `"11 family members present"', add
label define famsize_lbl 12 `"12 family members present"', add
label define famsize_lbl 13 `"13 family members present"', add
label define famsize_lbl 14 `"14 family members present"', add
label define famsize_lbl 15 `"15 family members present"', add
label define famsize_lbl 16 `"16 family members present"', add
label define famsize_lbl 17 `"17 family members present"', add
label define famsize_lbl 18 `"18 family members present"', add
label define famsize_lbl 19 `"19 family members present"', add
label define famsize_lbl 20 `"20 family members present"', add
label define famsize_lbl 21 `"21 family members present"', add
label define famsize_lbl 22 `"22 family members present"', add
label define famsize_lbl 23 `"23 family members present"', add
label define famsize_lbl 24 `"24 family members present"', add
label define famsize_lbl 25 `"25 family members present"', add
label define famsize_lbl 26 `"26 family members present"', add
label define famsize_lbl 27 `"27 family members present"', add
label define famsize_lbl 28 `"28 family members present"', add
label define famsize_lbl 29 `"29 family members present"', add
label values famsize famsize_lbl

label define nchild_lbl 0 `"0 children present"'
label define nchild_lbl 1 `"1 child present"', add
label define nchild_lbl 2 `"2"', add
label define nchild_lbl 3 `"3"', add
label define nchild_lbl 4 `"4"', add
label define nchild_lbl 5 `"5"', add
label define nchild_lbl 6 `"6"', add
label define nchild_lbl 7 `"7"', add
label define nchild_lbl 8 `"8"', add
label define nchild_lbl 9 `"9+"', add
label values nchild nchild_lbl

label define nchlt5_lbl 0 `"No children under age 5"'
label define nchlt5_lbl 1 `"1 child under age 5"', add
label define nchlt5_lbl 2 `"2"', add
label define nchlt5_lbl 3 `"3"', add
label define nchlt5_lbl 4 `"4"', add
label define nchlt5_lbl 5 `"5"', add
label define nchlt5_lbl 6 `"6"', add
label define nchlt5_lbl 7 `"7"', add
label define nchlt5_lbl 8 `"8"', add
label define nchlt5_lbl 9 `"9+"', add
label values nchlt5 nchlt5_lbl

label define famunit_lbl 01 `"1st family in household or group quarters"'
label define famunit_lbl 02 `"2nd family in household or group quarters"', add
label define famunit_lbl 03 `"3rd"', add
label define famunit_lbl 04 `"4th"', add
label define famunit_lbl 05 `"5th"', add
label define famunit_lbl 06 `"6th"', add
label define famunit_lbl 07 `"7th"', add
label define famunit_lbl 08 `"8th"', add
label define famunit_lbl 09 `"9th"', add
label define famunit_lbl 10 `"10"', add
label define famunit_lbl 11 `"11"', add
label define famunit_lbl 12 `"12"', add
label define famunit_lbl 13 `"13"', add
label define famunit_lbl 14 `"14"', add
label define famunit_lbl 15 `"15"', add
label define famunit_lbl 16 `"16"', add
label define famunit_lbl 17 `"17"', add
label define famunit_lbl 18 `"18"', add
label define famunit_lbl 19 `"19"', add
label define famunit_lbl 20 `"20"', add
label define famunit_lbl 21 `"21"', add
label define famunit_lbl 22 `"22"', add
label define famunit_lbl 23 `"23"', add
label define famunit_lbl 24 `"24"', add
label define famunit_lbl 25 `"25"', add
label define famunit_lbl 26 `"26"', add
label define famunit_lbl 27 `"27"', add
label define famunit_lbl 28 `"28"', add
label define famunit_lbl 29 `"29"', add
label values famunit famunit_lbl

label define eldch_lbl 00 `"Less than 1 year old"'
label define eldch_lbl 01 `"1"', add
label define eldch_lbl 02 `"2"', add
label define eldch_lbl 03 `"3"', add
label define eldch_lbl 04 `"4"', add
label define eldch_lbl 05 `"5"', add
label define eldch_lbl 06 `"6"', add
label define eldch_lbl 07 `"7"', add
label define eldch_lbl 08 `"8"', add
label define eldch_lbl 09 `"9"', add
label define eldch_lbl 10 `"10"', add
label define eldch_lbl 11 `"11"', add
label define eldch_lbl 12 `"12"', add
label define eldch_lbl 13 `"13"', add
label define eldch_lbl 14 `"14"', add
label define eldch_lbl 15 `"15"', add
label define eldch_lbl 16 `"16"', add
label define eldch_lbl 17 `"17"', add
label define eldch_lbl 18 `"18"', add
label define eldch_lbl 19 `"19"', add
label define eldch_lbl 20 `"20"', add
label define eldch_lbl 21 `"21"', add
label define eldch_lbl 22 `"22"', add
label define eldch_lbl 23 `"23"', add
label define eldch_lbl 24 `"24"', add
label define eldch_lbl 25 `"25"', add
label define eldch_lbl 26 `"26"', add
label define eldch_lbl 27 `"27"', add
label define eldch_lbl 28 `"28"', add
label define eldch_lbl 29 `"29"', add
label define eldch_lbl 30 `"30"', add
label define eldch_lbl 31 `"31"', add
label define eldch_lbl 32 `"32"', add
label define eldch_lbl 33 `"33"', add
label define eldch_lbl 34 `"34"', add
label define eldch_lbl 35 `"35"', add
label define eldch_lbl 36 `"36"', add
label define eldch_lbl 37 `"37"', add
label define eldch_lbl 38 `"38"', add
label define eldch_lbl 39 `"39"', add
label define eldch_lbl 40 `"40"', add
label define eldch_lbl 41 `"41"', add
label define eldch_lbl 42 `"42"', add
label define eldch_lbl 43 `"43"', add
label define eldch_lbl 44 `"44"', add
label define eldch_lbl 45 `"45"', add
label define eldch_lbl 46 `"46"', add
label define eldch_lbl 47 `"47"', add
label define eldch_lbl 48 `"48"', add
label define eldch_lbl 49 `"49"', add
label define eldch_lbl 50 `"50"', add
label define eldch_lbl 51 `"51"', add
label define eldch_lbl 52 `"52"', add
label define eldch_lbl 53 `"53"', add
label define eldch_lbl 54 `"54"', add
label define eldch_lbl 55 `"55"', add
label define eldch_lbl 56 `"56"', add
label define eldch_lbl 57 `"57"', add
label define eldch_lbl 58 `"58"', add
label define eldch_lbl 59 `"59"', add
label define eldch_lbl 60 `"60"', add
label define eldch_lbl 61 `"61"', add
label define eldch_lbl 62 `"62"', add
label define eldch_lbl 63 `"63"', add
label define eldch_lbl 64 `"64"', add
label define eldch_lbl 65 `"65"', add
label define eldch_lbl 66 `"66"', add
label define eldch_lbl 67 `"67"', add
label define eldch_lbl 68 `"68"', add
label define eldch_lbl 69 `"69"', add
label define eldch_lbl 70 `"70"', add
label define eldch_lbl 71 `"71"', add
label define eldch_lbl 72 `"72"', add
label define eldch_lbl 73 `"73"', add
label define eldch_lbl 74 `"74"', add
label define eldch_lbl 75 `"75"', add
label define eldch_lbl 76 `"76"', add
label define eldch_lbl 77 `"77"', add
label define eldch_lbl 78 `"78"', add
label define eldch_lbl 79 `"79"', add
label define eldch_lbl 80 `"80"', add
label define eldch_lbl 81 `"81"', add
label define eldch_lbl 82 `"82"', add
label define eldch_lbl 83 `"83"', add
label define eldch_lbl 84 `"84"', add
label define eldch_lbl 85 `"85"', add
label define eldch_lbl 86 `"86"', add
label define eldch_lbl 87 `"87"', add
label define eldch_lbl 88 `"88"', add
label define eldch_lbl 89 `"89"', add
label define eldch_lbl 90 `"90"', add
label define eldch_lbl 91 `"91"', add
label define eldch_lbl 92 `"92"', add
label define eldch_lbl 93 `"93"', add
label define eldch_lbl 94 `"94"', add
label define eldch_lbl 95 `"95"', add
label define eldch_lbl 96 `"96"', add
label define eldch_lbl 97 `"97"', add
label define eldch_lbl 98 `"98"', add
label define eldch_lbl 99 `"NIU"', add
label values eldch eldch_lbl

label define yngch_lbl 00 `"Less than 1 year old"'
label define yngch_lbl 01 `"1"', add
label define yngch_lbl 02 `"2"', add
label define yngch_lbl 03 `"3"', add
label define yngch_lbl 04 `"4"', add
label define yngch_lbl 05 `"5"', add
label define yngch_lbl 06 `"6"', add
label define yngch_lbl 07 `"7"', add
label define yngch_lbl 08 `"8"', add
label define yngch_lbl 09 `"9"', add
label define yngch_lbl 10 `"10"', add
label define yngch_lbl 11 `"11"', add
label define yngch_lbl 12 `"12"', add
label define yngch_lbl 13 `"13"', add
label define yngch_lbl 14 `"14"', add
label define yngch_lbl 15 `"15"', add
label define yngch_lbl 16 `"16"', add
label define yngch_lbl 17 `"17"', add
label define yngch_lbl 18 `"18"', add
label define yngch_lbl 19 `"19"', add
label define yngch_lbl 20 `"20"', add
label define yngch_lbl 21 `"21"', add
label define yngch_lbl 22 `"22"', add
label define yngch_lbl 23 `"23"', add
label define yngch_lbl 24 `"24"', add
label define yngch_lbl 25 `"25"', add
label define yngch_lbl 26 `"26"', add
label define yngch_lbl 27 `"27"', add
label define yngch_lbl 28 `"28"', add
label define yngch_lbl 29 `"29"', add
label define yngch_lbl 30 `"30"', add
label define yngch_lbl 31 `"31"', add
label define yngch_lbl 32 `"32"', add
label define yngch_lbl 33 `"33"', add
label define yngch_lbl 34 `"34"', add
label define yngch_lbl 35 `"35"', add
label define yngch_lbl 36 `"36"', add
label define yngch_lbl 37 `"37"', add
label define yngch_lbl 38 `"38"', add
label define yngch_lbl 39 `"39"', add
label define yngch_lbl 40 `"40"', add
label define yngch_lbl 41 `"41"', add
label define yngch_lbl 42 `"42"', add
label define yngch_lbl 43 `"43"', add
label define yngch_lbl 44 `"44"', add
label define yngch_lbl 45 `"45"', add
label define yngch_lbl 46 `"46"', add
label define yngch_lbl 47 `"47"', add
label define yngch_lbl 48 `"48"', add
label define yngch_lbl 49 `"49"', add
label define yngch_lbl 50 `"50"', add
label define yngch_lbl 51 `"51"', add
label define yngch_lbl 52 `"52"', add
label define yngch_lbl 53 `"53"', add
label define yngch_lbl 54 `"54"', add
label define yngch_lbl 55 `"55"', add
label define yngch_lbl 56 `"56"', add
label define yngch_lbl 57 `"57"', add
label define yngch_lbl 58 `"58"', add
label define yngch_lbl 59 `"59"', add
label define yngch_lbl 60 `"60"', add
label define yngch_lbl 61 `"61"', add
label define yngch_lbl 62 `"62"', add
label define yngch_lbl 63 `"63"', add
label define yngch_lbl 64 `"64"', add
label define yngch_lbl 65 `"65"', add
label define yngch_lbl 66 `"66"', add
label define yngch_lbl 67 `"67"', add
label define yngch_lbl 68 `"68"', add
label define yngch_lbl 69 `"69"', add
label define yngch_lbl 70 `"70"', add
label define yngch_lbl 71 `"71"', add
label define yngch_lbl 72 `"72"', add
label define yngch_lbl 73 `"73"', add
label define yngch_lbl 74 `"74"', add
label define yngch_lbl 75 `"75"', add
label define yngch_lbl 76 `"76"', add
label define yngch_lbl 77 `"77"', add
label define yngch_lbl 78 `"78"', add
label define yngch_lbl 79 `"79"', add
label define yngch_lbl 80 `"80"', add
label define yngch_lbl 81 `"81"', add
label define yngch_lbl 82 `"82"', add
label define yngch_lbl 83 `"83"', add
label define yngch_lbl 84 `"84"', add
label define yngch_lbl 85 `"85"', add
label define yngch_lbl 86 `"86"', add
label define yngch_lbl 87 `"87"', add
label define yngch_lbl 88 `"88"', add
label define yngch_lbl 89 `"89"', add
label define yngch_lbl 90 `"90"', add
label define yngch_lbl 91 `"91"', add
label define yngch_lbl 92 `"92"', add
label define yngch_lbl 93 `"93"', add
label define yngch_lbl 94 `"94"', add
label define yngch_lbl 95 `"95"', add
label define yngch_lbl 96 `"96"', add
label define yngch_lbl 97 `"97"', add
label define yngch_lbl 98 `"98"', add
label define yngch_lbl 99 `"NIU"', add
label values yngch yngch_lbl

label define nsibs_lbl 0 `"0 Siblings"'
label define nsibs_lbl 1 `"1 Sibling"', add
label define nsibs_lbl 2 `"2 Siblings"', add
label define nsibs_lbl 3 `"3 Siblings"', add
label define nsibs_lbl 4 `"4 Siblings"', add
label define nsibs_lbl 5 `"5 Siblings"', add
label define nsibs_lbl 6 `"6 Siblings"', add
label define nsibs_lbl 7 `"7 Siblings"', add
label define nsibs_lbl 8 `"8 Siblings"', add
label define nsibs_lbl 9 `"9 or more Siblings"', add
label values nsibs nsibs_lbl

label define pemomtyp_lbl 00 `"No mother present"'
label define pemomtyp_lbl 01 `"Biological"', add
label define pemomtyp_lbl 02 `"Step"', add
label define pemomtyp_lbl 03 `"Adopted"', add
label values pemomtyp pemomtyp_lbl

label define pedadtyp_lbl 00 `"No father present"'
label define pedadtyp_lbl 01 `"Biological"', add
label define pedadtyp_lbl 02 `"Step"', add
label define pedadtyp_lbl 03 `"Adopted"', add
label values pedadtyp pedadtyp_lbl

label define ftype_lbl 1 `"Primary family"'
label define ftype_lbl 2 `"Nonfamily householder"', add
label define ftype_lbl 3 `"Related subfamily"', add
label define ftype_lbl 4 `"Unrelated subfamily"', add
label define ftype_lbl 5 `"Secondary individual"', add
label define ftype_lbl 9 `"Missing"', add
label values ftype ftype_lbl

label define famkind_lbl 1 `"Husband/wife family"'
label define famkind_lbl 2 `"Male reference person"', add
label define famkind_lbl 3 `"Female reference person"', add
label values famkind famkind_lbl

label define famrel_lbl 0 `"Not a family member"'
label define famrel_lbl 1 `"Reference person"', add
label define famrel_lbl 2 `"Spouse"', add
label define famrel_lbl 3 `"Child"', add
label define famrel_lbl 4 `"Other relative (primary family only)"', add
label define famrel_lbl 9 `"Missing"', add
label values famrel famrel_lbl

label define pepar1typ_lbl 0 `"No first parent present"'
label define pepar1typ_lbl 1 `"Biological"', add
label define pepar1typ_lbl 2 `"Step"', add
label define pepar1typ_lbl 3 `"Adopted"', add
label values pepar1typ pepar1typ_lbl

label define pepar2typ_lbl 0 `"No second parent present"'
label define pepar2typ_lbl 1 `"Biological"', add
label define pepar2typ_lbl 2 `"Step"', add
label define pepar2typ_lbl 3 `"Adopted"', add
label values pepar2typ pepar2typ_lbl

label define bpl_lbl 09900 `"United States, n.s."'
label define bpl_lbl 10000 `"American Samoa"', add
label define bpl_lbl 10500 `"Guam"', add
label define bpl_lbl 10750 `"Northern Mariana Islands"', add
label define bpl_lbl 11000 `"Puerto Rico"', add
label define bpl_lbl 11500 `"U.S. Virgin Islands"', add
label define bpl_lbl 12090 `"U.S. outlying areas, n.s."', add
label define bpl_lbl 15000 `"Canada"', add
label define bpl_lbl 16010 `"Bermuda"', add
label define bpl_lbl 19900 `"North America, n.s."', add
label define bpl_lbl 20000 `"Mexico"', add
label define bpl_lbl 21010 `"Belize/British Honduras"', add
label define bpl_lbl 21020 `"Costa Rica"', add
label define bpl_lbl 21030 `"El Salvador"', add
label define bpl_lbl 21040 `"Guatemala"', add
label define bpl_lbl 21050 `"Honduras"', add
label define bpl_lbl 21060 `"Nicaragua"', add
label define bpl_lbl 21070 `"Panama"', add
label define bpl_lbl 21090 `"Central America, n.s."', add
label define bpl_lbl 25000 `"Cuba"', add
label define bpl_lbl 26010 `"Dominican Republic"', add
label define bpl_lbl 26020 `"Haiti"', add
label define bpl_lbl 26030 `"Jamaica"', add
label define bpl_lbl 26043 `"Bahamas"', add
label define bpl_lbl 26044 `"Barbados"', add
label define bpl_lbl 26054 `"Dominica"', add
label define bpl_lbl 26055 `"Grenada"', add
label define bpl_lbl 26060 `"Trinidad and Tobago"', add
label define bpl_lbl 26065 `"Antigua and Barbuda"', add
label define bpl_lbl 26070 `"St. Kitts--Nevis"', add
label define bpl_lbl 26075 `"St. Lucia"', add
label define bpl_lbl 26080 `"St. Vincent and the Grenadi"', add
label define bpl_lbl 26091 `"Caribbean, n.s."', add
label define bpl_lbl 30005 `"Argentina"', add
label define bpl_lbl 30010 `"Bolivia"', add
label define bpl_lbl 30015 `"Brazil"', add
label define bpl_lbl 30020 `"Chile"', add
label define bpl_lbl 30025 `"Colombia"', add
label define bpl_lbl 30030 `"Ecuador"', add
label define bpl_lbl 30040 `"Guyana/British Guiana"', add
label define bpl_lbl 30050 `"Peru"', add
label define bpl_lbl 30060 `"Uruguay"', add
label define bpl_lbl 30065 `"Venezuela"', add
label define bpl_lbl 30070 `"Paraguay"', add
label define bpl_lbl 30090 `"South America, n.s."', add
label define bpl_lbl 31000 `"Americas, n.s."', add
label define bpl_lbl 40000 `"Denmark"', add
label define bpl_lbl 40100 `"Finland"', add
label define bpl_lbl 40200 `"Iceland"', add
label define bpl_lbl 40400 `"Norway"', add
label define bpl_lbl 40500 `"Sweden"', add
label define bpl_lbl 41000 `"England"', add
label define bpl_lbl 41100 `"Scotland"', add
label define bpl_lbl 41200 `"Wales"', add
label define bpl_lbl 41300 `"United Kingdom, n.s."', add
label define bpl_lbl 41400 `"Ireland"', add
label define bpl_lbl 41410 `"Northern Ireland"', add
label define bpl_lbl 42000 `"Belgium"', add
label define bpl_lbl 42100 `"France"', add
label define bpl_lbl 42500 `"Netherlands"', add
label define bpl_lbl 42600 `"Switzerland"', add
label define bpl_lbl 43300 `"Greece"', add
label define bpl_lbl 43400 `"Italy"', add
label define bpl_lbl 43600 `"Portugal"', add
label define bpl_lbl 43610 `"Azores"', add
label define bpl_lbl 43800 `"Spain"', add
label define bpl_lbl 45000 `"Austria"', add
label define bpl_lbl 45200 `"Czechoslavakia"', add
label define bpl_lbl 45212 `"Slovakia"', add
label define bpl_lbl 45213 `"Czech Republic"', add
label define bpl_lbl 45300 `"Germany"', add
label define bpl_lbl 45400 `"Hungary"', add
label define bpl_lbl 45500 `"Poland"', add
label define bpl_lbl 45600 `"Romania"', add
label define bpl_lbl 45650 `"Bulgaria"', add
label define bpl_lbl 45675 `"Albania"', add
label define bpl_lbl 45700 `"Yugoslavia"', add
label define bpl_lbl 45720 `"Bosnia and Herzegovina"', add
label define bpl_lbl 45730 `"Croatia"', add
label define bpl_lbl 45740 `"Macedonia"', add
label define bpl_lbl 45750 `"Serbia"', add
label define bpl_lbl 45760 `"Kosovo"', add
label define bpl_lbl 45770 `"Montenego"', add
label define bpl_lbl 46100 `"Estonia"', add
label define bpl_lbl 46200 `"Latvia"', add
label define bpl_lbl 46300 `"Lithuania"', add
label define bpl_lbl 46500 `"Other USSR/Russia"', add
label define bpl_lbl 46530 `"Ukraine"', add
label define bpl_lbl 46535 `"Belarus"', add
label define bpl_lbl 46540 `"Moldova"', add
label define bpl_lbl 46590 `"USSR, n.s."', add
label define bpl_lbl 49900 `"Europe, n.s."', add
label define bpl_lbl 50000 `"China"', add
label define bpl_lbl 50010 `"Hong Kong"', add
label define bpl_lbl 50040 `"Taiwan"', add
label define bpl_lbl 50100 `"Japan"', add
label define bpl_lbl 50200 `"Korea"', add
label define bpl_lbl 50220 `"South Korea"', add
label define bpl_lbl 50300 `"Mongolia"', add
label define bpl_lbl 51100 `"Cambodia"', add
label define bpl_lbl 51200 `"Indonesia"', add
label define bpl_lbl 51300 `"Laos"', add
label define bpl_lbl 51400 `"Malaysia"', add
label define bpl_lbl 51500 `"Philippines"', add
label define bpl_lbl 51600 `"Singapore"', add
label define bpl_lbl 51700 `"Thailand"', add
label define bpl_lbl 51800 `"Vietnam"', add
label define bpl_lbl 52000 `"Afghanistan"', add
label define bpl_lbl 52100 `"India"', add
label define bpl_lbl 52110 `"Bangladesh"', add
label define bpl_lbl 52120 `"Bhutan"', add
label define bpl_lbl 52130 `"Burma"', add
label define bpl_lbl 52140 `"Pakistan"', add
label define bpl_lbl 52150 `"Sri Lanka"', add
label define bpl_lbl 52200 `"Nepal"', add
label define bpl_lbl 55100 `"Armenia"', add
label define bpl_lbl 55200 `"Azerbaijan"', add
label define bpl_lbl 55300 `"Georgia"', add
label define bpl_lbl 55400 `"Uzbekistan"', add
label define bpl_lbl 55500 `"Kazakhstan"', add
label define bpl_lbl 53000 `"Iran"', add
label define bpl_lbl 53200 `"Iraq"', add
label define bpl_lbl 53400 `"Israel"', add
label define bpl_lbl 53420 `"Palestine"', add
label define bpl_lbl 53500 `"Jordan"', add
label define bpl_lbl 53700 `"Lebanon"', add
label define bpl_lbl 54000 `"Saudi Arabia"', add
label define bpl_lbl 54100 `"Syria"', add
label define bpl_lbl 54200 `"Turkey"', add
label define bpl_lbl 54300 `"Cyprus"', add
label define bpl_lbl 54350 `"Kuwait"', add
label define bpl_lbl 54400 `"Yemen"', add
label define bpl_lbl 54500 `"United Arab Emirates"', add
label define bpl_lbl 54700 `"Middle East, n.s."', add
label define bpl_lbl 59900 `"Asia, n.e.c./n.s."', add
label define bpl_lbl 60010 `"Northern Africa"', add
label define bpl_lbl 60012 `"Egypt/United Arab Rep."', add
label define bpl_lbl 60014 `"Morocco"', add
label define bpl_lbl 60016 `"Algeria"', add
label define bpl_lbl 60018 `"Sudan"', add
label define bpl_lbl 60019 `"Libya"', add
label define bpl_lbl 60023 `"Ghana"', add
label define bpl_lbl 60031 `"Nigeria"', add
label define bpl_lbl 60032 `"Cameroon"', add
label define bpl_lbl 60033 `"Cape Verde"', add
label define bpl_lbl 60034 `"Liberia"', add
label define bpl_lbl 60035 `"Senegal"', add
label define bpl_lbl 60036 `"Sierra Leone"', add
label define bpl_lbl 60037 `"Guinea"', add
label define bpl_lbl 60038 `"Ivory Coast"', add
label define bpl_lbl 60039 `"Togo"', add
label define bpl_lbl 60040 `"Eritrea"', add
label define bpl_lbl 60044 `"Ethiopia"', add
label define bpl_lbl 60045 `"Kenya"', add
label define bpl_lbl 60050 `"Somalia"', add
label define bpl_lbl 60060 `"Tanzania"', add
label define bpl_lbl 60065 `"Uganda"', add
label define bpl_lbl 60070 `"Zimbabwe"', add
label define bpl_lbl 60094 `"South Africa (Union of)"', add
label define bpl_lbl 60095 `"Zaire"', add
label define bpl_lbl 60096 `"Congo"', add
label define bpl_lbl 60097 `"Zambia"', add
label define bpl_lbl 60099 `"Africa, n.s./n.e.c."', add
label define bpl_lbl 70010 `"Australia"', add
label define bpl_lbl 70020 `"New Zealand"', add
label define bpl_lbl 71000 `"Pacific Islands"', add
label define bpl_lbl 71021 `"Fiji"', add
label define bpl_lbl 71022 `"Tonga"', add
label define bpl_lbl 71023 `"Samoa"', add
label define bpl_lbl 71024 `"Marshall Islands"', add
label define bpl_lbl 72000 `"Micronesia"', add
label define bpl_lbl 96000 `"Other, n.e.c. and unknown"', add
label define bpl_lbl 99999 `"NIU"', add
label values bpl bpl_lbl

label define yrimmig_lbl 0000 `"NIU"'
label define yrimmig_lbl 0001 `"1949 or earlier"', add
label define yrimmig_lbl 0002 `"1950-1959"', add
label define yrimmig_lbl 0003 `"1960-1964"', add
label define yrimmig_lbl 0004 `"1965-1969"', add
label define yrimmig_lbl 0005 `"1970-1974"', add
label define yrimmig_lbl 0006 `"1975-1979"', add
label define yrimmig_lbl 0007 `"1980-1981"', add
label define yrimmig_lbl 0008 `"1982-1983"', add
label define yrimmig_lbl 0009 `"1984-1985"', add
label define yrimmig_lbl 0010 `"1986-1987"', add
label define yrimmig_lbl 0011 `"1988-1989"', add
label define yrimmig_lbl 0012 `"1990-1991"', add
label define yrimmig_lbl 0013 `"1992-1993"', add
label define yrimmig_lbl 0014 `"1992-1994"', add
label define yrimmig_lbl 0015 `"1992-1995"', add
label define yrimmig_lbl 0016 `"1994-1995"', add
label define yrimmig_lbl 0017 `"1994-1996"', add
label define yrimmig_lbl 0018 `"1994-1997"', add
label define yrimmig_lbl 0019 `"1996-1997"', add
label define yrimmig_lbl 0020 `"1996-1998"', add
label define yrimmig_lbl 0021 `"1996-1999"', add
label define yrimmig_lbl 0022 `"1998"', add
label define yrimmig_lbl 0023 `"1998-1999"', add
label define yrimmig_lbl 0024 `"1998-2000"', add
label define yrimmig_lbl 0025 `"1998-2001"', add
label define yrimmig_lbl 0026 `"2000-2001"', add
label define yrimmig_lbl 0027 `"2000-2002"', add
label define yrimmig_lbl 0028 `"2000-2003"', add
label define yrimmig_lbl 0029 `"2002-2003"', add
label define yrimmig_lbl 0030 `"2002-2004"', add
label define yrimmig_lbl 0031 `"2002-2005"', add
label define yrimmig_lbl 0032 `"2004-2005"', add
label define yrimmig_lbl 0033 `"2004-2006"', add
label define yrimmig_lbl 0034 `"2004-2007"', add
label define yrimmig_lbl 0035 `"2006-2007"', add
label define yrimmig_lbl 0036 `"2006-2008"', add
label define yrimmig_lbl 0037 `"2006-2009"', add
label define yrimmig_lbl 0038 `"2008-2009"', add
label define yrimmig_lbl 0039 `"2008-2010"', add
label define yrimmig_lbl 0040 `"2008-2011"', add
label define yrimmig_lbl 0041 `"2010-2011"', add
label define yrimmig_lbl 0042 `"2010-2012"', add
label define yrimmig_lbl 0043 `"2010-2013"', add
label define yrimmig_lbl 0044 `"2012-2013"', add
label define yrimmig_lbl 0045 `"2012-2014"', add
label define yrimmig_lbl 0046 `"2012-2015"', add
label define yrimmig_lbl 0047 `"2014-2015"', add
label define yrimmig_lbl 0048 `"2014-2016"', add
label define yrimmig_lbl 0049 `"2014-2017"', add
label define yrimmig_lbl 0050 `"2016-2017"', add
label define yrimmig_lbl 0051 `"2016-2018"', add
label define yrimmig_lbl 0052 `"2016-2019"', add
label define yrimmig_lbl 0053 `"2018-2019"', add
label define yrimmig_lbl 0054 `"2018-2020"', add
label define yrimmig_lbl 0055 `"2018-2021"', add
label define yrimmig_lbl 0056 `"2020-2021"', add
label define yrimmig_lbl 0057 `"2020-2022"', add
label define yrimmig_lbl 0058 `"2020-2023"', add
label define yrimmig_lbl 0059 `"2022-2023"', add
label define yrimmig_lbl 0060 `"2022-2024"', add
label define yrimmig_lbl 0061 `"2022-2025"', add
label values yrimmig yrimmig_lbl

label define citizen_lbl 1 `"Born in U.S"'
label define citizen_lbl 2 `"Born in U.S. outlying"', add
label define citizen_lbl 3 `"Born abroad of American parents"', add
label define citizen_lbl 4 `"Naturalized citizen"', add
label define citizen_lbl 5 `"Not a citizen"', add
label define citizen_lbl 9 `"NIU"', add
label values citizen citizen_lbl

label define mbpl_lbl 09900 `"U.S., n.s."'
label define mbpl_lbl 10000 `"American Samoa"', add
label define mbpl_lbl 10500 `"Guam"', add
label define mbpl_lbl 11000 `"Puerto Rico"', add
label define mbpl_lbl 11500 `"U.S. Virgin Islands"', add
label define mbpl_lbl 12090 `"U.S. outlying areas, n.s."', add
label define mbpl_lbl 15000 `"Canada"', add
label define mbpl_lbl 16010 `"Bermuda"', add
label define mbpl_lbl 10750 `"Northern Mariana Islands"', add
label define mbpl_lbl 19900 `"North America, n.s."', add
label define mbpl_lbl 20000 `"Mexico"', add
label define mbpl_lbl 21010 `"Belize/British Honduras"', add
label define mbpl_lbl 21020 `"Costa Rica"', add
label define mbpl_lbl 21030 `"El Salvador"', add
label define mbpl_lbl 21040 `"Guatemala"', add
label define mbpl_lbl 21050 `"Honduras"', add
label define mbpl_lbl 21060 `"Nicaragua"', add
label define mbpl_lbl 21070 `"Panama"', add
label define mbpl_lbl 21090 `"Central America, n.s."', add
label define mbpl_lbl 25000 `"Cuba"', add
label define mbpl_lbl 26000 `"West Indies"', add
label define mbpl_lbl 26010 `"Dominican Republic"', add
label define mbpl_lbl 26020 `"Haiti"', add
label define mbpl_lbl 26030 `"Jamaica"', add
label define mbpl_lbl 26043 `"Bahamas"', add
label define mbpl_lbl 26044 `"Barbados"', add
label define mbpl_lbl 26054 `"Dominica"', add
label define mbpl_lbl 26055 `"Grenada"', add
label define mbpl_lbl 26060 `"Trinidad and Tobago"', add
label define mbpl_lbl 26065 `"Antigua and Barbuda"', add
label define mbpl_lbl 26070 `"St. Kitts--Nevis"', add
label define mbpl_lbl 26075 `"St. Lucia"', add
label define mbpl_lbl 26080 `"St. Vincent and the Grenadi"', add
label define mbpl_lbl 30000 `"South America"', add
label define mbpl_lbl 30005 `"Argentina"', add
label define mbpl_lbl 30010 `"Bolivia"', add
label define mbpl_lbl 30015 `"Brazil"', add
label define mbpl_lbl 30020 `"Chile"', add
label define mbpl_lbl 30025 `"Colombia"', add
label define mbpl_lbl 30030 `"Ecuador"', add
label define mbpl_lbl 30040 `"Guyana/British Guiana"', add
label define mbpl_lbl 30050 `"Peru"', add
label define mbpl_lbl 30060 `"Uruguay"', add
label define mbpl_lbl 30065 `"Venezuala"', add
label define mbpl_lbl 30070 `"Paraguay"', add
label define mbpl_lbl 31000 `"Americas, n.s."', add
label define mbpl_lbl 40000 `"Denmark"', add
label define mbpl_lbl 40100 `"Finland"', add
label define mbpl_lbl 40200 `"Iceland"', add
label define mbpl_lbl 40400 `"Norway"', add
label define mbpl_lbl 40500 `"Sweden"', add
label define mbpl_lbl 41000 `"England"', add
label define mbpl_lbl 41100 `"Scotland"', add
label define mbpl_lbl 41200 `"Wales"', add
label define mbpl_lbl 41300 `"United Kingdom, n.s."', add
label define mbpl_lbl 41400 `"Ireland"', add
label define mbpl_lbl 41410 `"Northern Ireland"', add
label define mbpl_lbl 42000 `"Belgium"', add
label define mbpl_lbl 42100 `"France"', add
label define mbpl_lbl 42500 `"Netherlands"', add
label define mbpl_lbl 42600 `"Switzerland"', add
label define mbpl_lbl 43300 `"Greece"', add
label define mbpl_lbl 43400 `"Italy"', add
label define mbpl_lbl 43600 `"Portugal"', add
label define mbpl_lbl 43610 `"Azores"', add
label define mbpl_lbl 43800 `"Spain"', add
label define mbpl_lbl 45000 `"Austria"', add
label define mbpl_lbl 45200 `"Czechoslavakia"', add
label define mbpl_lbl 45212 `"Slovakia"', add
label define mbpl_lbl 45213 `"Czech Republic"', add
label define mbpl_lbl 45300 `"Germany"', add
label define mbpl_lbl 45400 `"Hungary"', add
label define mbpl_lbl 45500 `"Poland"', add
label define mbpl_lbl 45600 `"Romania"', add
label define mbpl_lbl 45650 `"Bulgaria"', add
label define mbpl_lbl 45675 `"Albania"', add
label define mbpl_lbl 45700 `"Yugoslavia"', add
label define mbpl_lbl 45720 `"Bosnia and Herzegovina"', add
label define mbpl_lbl 45730 `"Croatia"', add
label define mbpl_lbl 45740 `"Macedonia"', add
label define mbpl_lbl 45750 `"Serbia"', add
label define mbpl_lbl 45760 `"Kosovo"', add
label define mbpl_lbl 45770 `"Montenego"', add
label define mbpl_lbl 46100 `"Estonia"', add
label define mbpl_lbl 46200 `"Latvia"', add
label define mbpl_lbl 46300 `"Lithuania"', add
label define mbpl_lbl 46500 `"Other USSR/Russia"', add
label define mbpl_lbl 46530 `"Ukraine"', add
label define mbpl_lbl 46535 `"Belarus"', add
label define mbpl_lbl 46540 `"Moldova"', add
label define mbpl_lbl 46590 `"USSR, n.s."', add
label define mbpl_lbl 49900 `"Europe, n.s."', add
label define mbpl_lbl 50000 `"China"', add
label define mbpl_lbl 50010 `"Hong Kong"', add
label define mbpl_lbl 50040 `"Taiwan"', add
label define mbpl_lbl 50100 `"Japan"', add
label define mbpl_lbl 50200 `"Korea"', add
label define mbpl_lbl 50220 `"South Korea"', add
label define mbpl_lbl 50300 `"Mongolia"', add
label define mbpl_lbl 51100 `"Cambodia"', add
label define mbpl_lbl 51200 `"Indonesia"', add
label define mbpl_lbl 51300 `"Laos"', add
label define mbpl_lbl 51400 `"Malaysia"', add
label define mbpl_lbl 51500 `"Philippines"', add
label define mbpl_lbl 51600 `"Singapore"', add
label define mbpl_lbl 51700 `"Thailand"', add
label define mbpl_lbl 51800 `"Vietnam"', add
label define mbpl_lbl 52000 `"Afghanistan"', add
label define mbpl_lbl 52100 `"India"', add
label define mbpl_lbl 52110 `"Bangladesh"', add
label define mbpl_lbl 52120 `"Bhutan"', add
label define mbpl_lbl 52130 `"Burma (Myanmar)"', add
label define mbpl_lbl 52140 `"Pakistan"', add
label define mbpl_lbl 52150 `"Sri Lanka"', add
label define mbpl_lbl 52200 `"Nepal"', add
label define mbpl_lbl 55100 `"Armenia"', add
label define mbpl_lbl 55200 `"Azerbaijan"', add
label define mbpl_lbl 55300 `"Georgia"', add
label define mbpl_lbl 55400 `"Uzbekistan"', add
label define mbpl_lbl 55500 `"Kazakhstan"', add
label define mbpl_lbl 53000 `"Iran"', add
label define mbpl_lbl 53200 `"Iraq"', add
label define mbpl_lbl 53400 `"Israel"', add
label define mbpl_lbl 53420 `"Palestine"', add
label define mbpl_lbl 53500 `"Jordan"', add
label define mbpl_lbl 53700 `"Lebanon"', add
label define mbpl_lbl 54000 `"Saudi Arabia"', add
label define mbpl_lbl 54100 `"Syria"', add
label define mbpl_lbl 54200 `"Turkey"', add
label define mbpl_lbl 54300 `"Cyprus"', add
label define mbpl_lbl 54350 `"Kuwait"', add
label define mbpl_lbl 54400 `"Yemen"', add
label define mbpl_lbl 54500 `"United Arab Emirates"', add
label define mbpl_lbl 54700 `"Middle East, n.s."', add
label define mbpl_lbl 59900 `"Asia, n.e.c, /n.s."', add
label define mbpl_lbl 60000 `"Africa"', add
label define mbpl_lbl 60010 `"Northern Africa"', add
label define mbpl_lbl 60012 `"Egypt/United Arab Rep."', add
label define mbpl_lbl 60014 `"Morocco"', add
label define mbpl_lbl 60016 `"Algeria"', add
label define mbpl_lbl 60018 `"Sudan"', add
label define mbpl_lbl 60019 `"Libya"', add
label define mbpl_lbl 60023 `"Ghana"', add
label define mbpl_lbl 60031 `"Nigeria"', add
label define mbpl_lbl 60032 `"Cameroon"', add
label define mbpl_lbl 60033 `"Cape Verde"', add
label define mbpl_lbl 60034 `"Liberia"', add
label define mbpl_lbl 60035 `"Sengal"', add
label define mbpl_lbl 60036 `"Sierra Leone"', add
label define mbpl_lbl 60037 `"Guinea"', add
label define mbpl_lbl 60038 `"Ivory Coast"', add
label define mbpl_lbl 60039 `"Togo"', add
label define mbpl_lbl 60040 `"Eritrea"', add
label define mbpl_lbl 60044 `"Ethiopia"', add
label define mbpl_lbl 60045 `"Kenya"', add
label define mbpl_lbl 60050 `"Somalia"', add
label define mbpl_lbl 60060 `"Tanzania"', add
label define mbpl_lbl 60065 `"Uganda"', add
label define mbpl_lbl 60070 `"Zimbabwe"', add
label define mbpl_lbl 60095 `"Zaire"', add
label define mbpl_lbl 60096 `"Congo"', add
label define mbpl_lbl 60097 `"Zambia"', add
label define mbpl_lbl 60094 `"South Africa (Union of)"', add
label define mbpl_lbl 70010 `"Australia"', add
label define mbpl_lbl 70020 `"New Zealand"', add
label define mbpl_lbl 71000 `"Pacific Islands"', add
label define mbpl_lbl 71021 `"Fiji"', add
label define mbpl_lbl 71022 `"Tonga"', add
label define mbpl_lbl 71023 `"Samoa"', add
label define mbpl_lbl 71024 `"Marshall Islands"', add
label define mbpl_lbl 72000 `"Micronesia"', add
label define mbpl_lbl 96000 `"Other, n.e.c. and unknown"', add
label define mbpl_lbl 99999 `"NIU"', add
label values mbpl mbpl_lbl

label define fbpl_lbl 09900 `"U.S., n.s."'
label define fbpl_lbl 10000 `"American Samoa"', add
label define fbpl_lbl 10500 `"Guam"', add
label define fbpl_lbl 10750 `"Northern Mariana Islands"', add
label define fbpl_lbl 11000 `"Puerto Rico"', add
label define fbpl_lbl 11500 `"U.S. Virgin Islands"', add
label define fbpl_lbl 12090 `"U.S. outlying areas, n.s."', add
label define fbpl_lbl 15000 `"Canada"', add
label define fbpl_lbl 16010 `"Bermuda"', add
label define fbpl_lbl 19900 `"North America, n.s."', add
label define fbpl_lbl 20000 `"Mexico"', add
label define fbpl_lbl 21010 `"Belize/British Honduras"', add
label define fbpl_lbl 21020 `"Costa Rica"', add
label define fbpl_lbl 21030 `"El Salvador"', add
label define fbpl_lbl 21040 `"Guatemala"', add
label define fbpl_lbl 21050 `"Honduras"', add
label define fbpl_lbl 21060 `"Nicaragua"', add
label define fbpl_lbl 21070 `"Panama"', add
label define fbpl_lbl 21090 `"Central America, n.s."', add
label define fbpl_lbl 25000 `"Cuba"', add
label define fbpl_lbl 26000 `"West Indies"', add
label define fbpl_lbl 26010 `"Dominican Republic"', add
label define fbpl_lbl 26020 `"Haiti"', add
label define fbpl_lbl 26030 `"Jamaica"', add
label define fbpl_lbl 26043 `"Bahamas"', add
label define fbpl_lbl 26044 `"Barbados"', add
label define fbpl_lbl 26054 `"Dominica"', add
label define fbpl_lbl 26055 `"Grenada"', add
label define fbpl_lbl 26060 `"Trinidad and Tobago"', add
label define fbpl_lbl 26065 `"Antigua and Barbuda"', add
label define fbpl_lbl 26070 `"St. Kitts--Nevis"', add
label define fbpl_lbl 26075 `"St. Lucia"', add
label define fbpl_lbl 26080 `"St. Vincent and the Grenadi"', add
label define fbpl_lbl 26091 `"Caribbean, n.s."', add
label define fbpl_lbl 30000 `"South America"', add
label define fbpl_lbl 30005 `"Argentina"', add
label define fbpl_lbl 30010 `"Bolivia"', add
label define fbpl_lbl 30015 `"Brazil"', add
label define fbpl_lbl 30020 `"Chile"', add
label define fbpl_lbl 30025 `"Colombia"', add
label define fbpl_lbl 30030 `"Ecuador"', add
label define fbpl_lbl 30040 `"Guyana/British Guiana"', add
label define fbpl_lbl 30050 `"Peru"', add
label define fbpl_lbl 30060 `"Uruguay"', add
label define fbpl_lbl 30065 `"Venezuala"', add
label define fbpl_lbl 30070 `"Paraguay"', add
label define fbpl_lbl 31000 `"Americas, n.s."', add
label define fbpl_lbl 40000 `"Denmark"', add
label define fbpl_lbl 40100 `"Finland"', add
label define fbpl_lbl 40200 `"Iceland"', add
label define fbpl_lbl 40400 `"Norway"', add
label define fbpl_lbl 40500 `"Sweden"', add
label define fbpl_lbl 41000 `"England"', add
label define fbpl_lbl 41100 `"Scotland"', add
label define fbpl_lbl 41200 `"Wales"', add
label define fbpl_lbl 41300 `"United Kingdom, n.s."', add
label define fbpl_lbl 41400 `"Ireland"', add
label define fbpl_lbl 41410 `"Northern Ireland"', add
label define fbpl_lbl 42000 `"Belgium"', add
label define fbpl_lbl 42100 `"France"', add
label define fbpl_lbl 42500 `"Netherlands"', add
label define fbpl_lbl 42600 `"Switzerland"', add
label define fbpl_lbl 43300 `"Greece"', add
label define fbpl_lbl 43400 `"Italy"', add
label define fbpl_lbl 43600 `"Portugal"', add
label define fbpl_lbl 43610 `"Azores"', add
label define fbpl_lbl 43800 `"Spain"', add
label define fbpl_lbl 45000 `"Austria"', add
label define fbpl_lbl 45200 `"Czechoslavakia"', add
label define fbpl_lbl 45212 `"Slovakia"', add
label define fbpl_lbl 45213 `"Czech Republic"', add
label define fbpl_lbl 45300 `"Germany"', add
label define fbpl_lbl 45400 `"Hungary"', add
label define fbpl_lbl 45500 `"Poland"', add
label define fbpl_lbl 45600 `"Romania"', add
label define fbpl_lbl 45650 `"Bulgaria"', add
label define fbpl_lbl 45675 `"Albania"', add
label define fbpl_lbl 45700 `"Yugoslavia"', add
label define fbpl_lbl 45720 `"Bosnia and Herzegovina"', add
label define fbpl_lbl 45730 `"Croatia"', add
label define fbpl_lbl 45740 `"Macedonia"', add
label define fbpl_lbl 45750 `"Serbia"', add
label define fbpl_lbl 45760 `"Kosovo"', add
label define fbpl_lbl 45770 `"Montenegro"', add
label define fbpl_lbl 46100 `"Estonia"', add
label define fbpl_lbl 46200 `"Latvia"', add
label define fbpl_lbl 46300 `"Lithuania"', add
label define fbpl_lbl 46500 `"Other USSR/Russia"', add
label define fbpl_lbl 46530 `"Ukraine"', add
label define fbpl_lbl 46535 `"Belarus"', add
label define fbpl_lbl 46540 `"Moldova"', add
label define fbpl_lbl 46590 `"USSR, n.s."', add
label define fbpl_lbl 49900 `"Europe, n.s."', add
label define fbpl_lbl 50000 `"China"', add
label define fbpl_lbl 50010 `"Hong Kong"', add
label define fbpl_lbl 50040 `"Taiwan"', add
label define fbpl_lbl 50100 `"Japan"', add
label define fbpl_lbl 50200 `"Korea"', add
label define fbpl_lbl 50220 `"South Korea"', add
label define fbpl_lbl 50300 `"Mongolia"', add
label define fbpl_lbl 51100 `"Cambodia"', add
label define fbpl_lbl 51200 `"Indonesia"', add
label define fbpl_lbl 51300 `"Laos"', add
label define fbpl_lbl 51400 `"Malaysia"', add
label define fbpl_lbl 51500 `"Philippines"', add
label define fbpl_lbl 51600 `"Singapore"', add
label define fbpl_lbl 51700 `"Thailand"', add
label define fbpl_lbl 51800 `"Vietnam"', add
label define fbpl_lbl 52000 `"Afghanistan"', add
label define fbpl_lbl 52100 `"India"', add
label define fbpl_lbl 52110 `"Bangladesh"', add
label define fbpl_lbl 52120 `"Bhutan"', add
label define fbpl_lbl 52130 `"Burma (Myanmar)"', add
label define fbpl_lbl 52140 `"Pakistan"', add
label define fbpl_lbl 52150 `"Sri Lanka"', add
label define fbpl_lbl 52200 `"Nepal"', add
label define fbpl_lbl 55100 `"Armenia"', add
label define fbpl_lbl 55200 `"Azerbaijan"', add
label define fbpl_lbl 55300 `"Georgia"', add
label define fbpl_lbl 55400 `"Uzbekistan"', add
label define fbpl_lbl 55500 `"Kazakhstan"', add
label define fbpl_lbl 53000 `"Iran"', add
label define fbpl_lbl 53200 `"Iraq"', add
label define fbpl_lbl 53400 `"Israel"', add
label define fbpl_lbl 53420 `"Palestine"', add
label define fbpl_lbl 53500 `"Jordan"', add
label define fbpl_lbl 53700 `"Lebanon"', add
label define fbpl_lbl 54000 `"Saudi Arabia"', add
label define fbpl_lbl 54100 `"Syria"', add
label define fbpl_lbl 54200 `"Turkey"', add
label define fbpl_lbl 54300 `"Cyprus"', add
label define fbpl_lbl 54350 `"Kuwait"', add
label define fbpl_lbl 54400 `"Yemen"', add
label define fbpl_lbl 54500 `"United Arab Emirates"', add
label define fbpl_lbl 54700 `"Middle East, n.s."', add
label define fbpl_lbl 59900 `"Asia, n.e.c, /n.s."', add
label define fbpl_lbl 60000 `"Africa"', add
label define fbpl_lbl 60010 `"Northern Africa"', add
label define fbpl_lbl 60012 `"Egypt/United Arab Rep."', add
label define fbpl_lbl 60014 `"Morocco"', add
label define fbpl_lbl 60016 `"Algeria"', add
label define fbpl_lbl 60018 `"Sudan"', add
label define fbpl_lbl 60019 `"Libya"', add
label define fbpl_lbl 60023 `"Ghana"', add
label define fbpl_lbl 60031 `"Nigeria"', add
label define fbpl_lbl 60032 `"Cameroon"', add
label define fbpl_lbl 60033 `"Cape Verde"', add
label define fbpl_lbl 60034 `"Liberia"', add
label define fbpl_lbl 60035 `"Sengal"', add
label define fbpl_lbl 60036 `"Sierra Leone"', add
label define fbpl_lbl 60037 `"Guinea"', add
label define fbpl_lbl 60038 `"Ivory Coast"', add
label define fbpl_lbl 60039 `"Togo"', add
label define fbpl_lbl 60040 `"Eritrea"', add
label define fbpl_lbl 60044 `"Ethiopia"', add
label define fbpl_lbl 60045 `"Kenya"', add
label define fbpl_lbl 60050 `"Somalia"', add
label define fbpl_lbl 60060 `"Tanzania"', add
label define fbpl_lbl 60065 `"Uganda"', add
label define fbpl_lbl 60070 `"Zimbabwe"', add
label define fbpl_lbl 60094 `"South Africa (Union of)"', add
label define fbpl_lbl 60095 `"Zaire"', add
label define fbpl_lbl 60096 `"Congo"', add
label define fbpl_lbl 60097 `"Zambia"', add
label define fbpl_lbl 60099 `"Africa, n.s./n.e.c."', add
label define fbpl_lbl 70010 `"Australia"', add
label define fbpl_lbl 70020 `"New Zealand"', add
label define fbpl_lbl 71000 `"Pacific Islands"', add
label define fbpl_lbl 71021 `"Fiji"', add
label define fbpl_lbl 71022 `"Tonga"', add
label define fbpl_lbl 71023 `"Samoa"', add
label define fbpl_lbl 71024 `"Marshall Islands"', add
label define fbpl_lbl 72000 `"Micronesia"', add
label define fbpl_lbl 96000 `"Other, n.e.c. and unknown"', add
label define fbpl_lbl 99999 `"NIU"', add
label values fbpl fbpl_lbl

label define nativity_lbl 0 `"Unknown"'
label define nativity_lbl 1 `"Both parents native-born"', add
label define nativity_lbl 2 `"Father foreign, mother native"', add
label define nativity_lbl 3 `"Mother foreign, father native"', add
label define nativity_lbl 4 `"Both parents foreign"', add
label define nativity_lbl 5 `"Foreign born"', add
label values nativity nativity_lbl

label define hispan_lbl 000 `"Not Hispanic"'
label define hispan_lbl 100 `"Mexican"', add
label define hispan_lbl 102 `"Mexican American"', add
label define hispan_lbl 103 `"Mexicano/Mexicana"', add
label define hispan_lbl 104 `"Chicano/Chicana"', add
label define hispan_lbl 108 `"Mexican (Mexicano)"', add
label define hispan_lbl 109 `"Mexicano/Chicano"', add
label define hispan_lbl 200 `"Puerto Rican"', add
label define hispan_lbl 300 `"Cuban"', add
label define hispan_lbl 400 `"Dominican"', add
label define hispan_lbl 500 `"Salvadoran"', add
label define hispan_lbl 600 `"Other Hispanic"', add
label define hispan_lbl 610 `"Central/South American"', add
label define hispan_lbl 611 `"Central American, (excluding Salvadoran)"', add
label define hispan_lbl 612 `"South American"', add
label define hispan_lbl 901 `"Do not know"', add
label define hispan_lbl 902 `"N/A (and no response 1985-87)"', add
label values hispan hispan_lbl

label define empstat_lbl 00 `"NIU"'
label define empstat_lbl 01 `"Armed Forces"', add
label define empstat_lbl 10 `"At work"', add
label define empstat_lbl 12 `"Has job, not at work last week"', add
label define empstat_lbl 20 `"Unemployed"', add
label define empstat_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_lbl 22 `"Unemployed, new worker"', add
label define empstat_lbl 30 `"Not in labor force"', add
label define empstat_lbl 31 `"NILF, housework"', add
label define empstat_lbl 32 `"NILF, unable to work"', add
label define empstat_lbl 33 `"NILF, school"', add
label define empstat_lbl 34 `"NILF, other"', add
label define empstat_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_lbl 36 `"NILF, retired"', add
label values empstat empstat_lbl

label define labforce_lbl 0 `"NIU"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label values labforce labforce_lbl

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
label define occ2010_lbl 9999 `"NIU"', add
label values occ2010 occ2010_lbl

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
label define occ1990_lbl 290 `"Sales workers--allocated (1990 internal census)"', add
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
label define occ1990_lbl 390 `"Professional, technical, and kindred workers--allocated (1990 internal census)"', add
label define occ1990_lbl 391 `"Clerical and kindred workers--allocated (1990 internal census)"', add
label define occ1990_lbl 405 `"Housekeepers, maids, butlers, stewards, and lodging quarters cleaners"', add
label define occ1990_lbl 407 `"Private household cleaners and servants"', add
label define occ1990_lbl 408 `"Private household workers--allocated (1990 internal census)"', add
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
label define occ1990_lbl 480 `"Farm laborers and farm foreman--allocated (1990 internal census)"', add
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
label define occ1990_lbl 815 `"Transport equipment operatives--allocated (1990 internal census)"', add
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
label define occ1990_lbl 890 `"Laborers, except farm--allocated (1990 internal census)"', add
label define occ1990_lbl 905 `"Military"', add
label define occ1990_lbl 999 `"NIU"', add
label values occ1990 occ1990_lbl

label define ind1990_lbl 000 `"NIU"'
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
label define ind1990_lbl 229 `"Manufacturing, non-durable - allocated"', add
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
label define ind1990_lbl 441 `"Wired communications"', add
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
label define ind1990_lbl 998 `"Unknown"', add
label values ind1990 ind1990_lbl

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
label define occ1950_lbl 012 `"Agricultural sciences"', add
label define occ1950_lbl 013 `"Biological sciences"', add
label define occ1950_lbl 014 `"Chemistry"', add
label define occ1950_lbl 015 `"Economics"', add
label define occ1950_lbl 016 `"Engineering"', add
label define occ1950_lbl 017 `"Geology and geophysics"', add
label define occ1950_lbl 018 `"Mathematics"', add
label define occ1950_lbl 019 `"Medical sciences"', add
label define occ1950_lbl 023 `"Physics"', add
label define occ1950_lbl 024 `"Psychology"', add
label define occ1950_lbl 025 `"Statistics"', add
label define occ1950_lbl 026 `"Natural science (n.e.c.)"', add
label define occ1950_lbl 027 `"Social sciences (n.e.c.)"', add
label define occ1950_lbl 028 `"Nonscientific subjects"', add
label define occ1950_lbl 029 `"Subject not specified"', add
label define occ1950_lbl 031 `"Dancers and dancing teachers"', add
label define occ1950_lbl 032 `"Dentists"', add
label define occ1950_lbl 033 `"Designers"', add
label define occ1950_lbl 034 `"Dieticians and nutritionists"', add
label define occ1950_lbl 035 `"Draftsmen"', add
label define occ1950_lbl 036 `"Editors and reporters"', add
label define occ1950_lbl 041 `"Engineers, aeronautical"', add
label define occ1950_lbl 042 `"Engineers, chemical"', add
label define occ1950_lbl 043 `"Engineers, civil"', add
label define occ1950_lbl 044 `"Engineers, electrical"', add
label define occ1950_lbl 045 `"Engineers, industrial"', add
label define occ1950_lbl 046 `"Engineers, mechanical"', add
label define occ1950_lbl 047 `"Engineers, metallurgical, metallurgists"', add
label define occ1950_lbl 048 `"Engineers, mining"', add
label define occ1950_lbl 049 `"Engineers (n.e.c.)"', add
label define occ1950_lbl 051 `"Entertainers (n.e.c.)"', add
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
label define occ1950_lbl 069 `"Miscellaneous natural scientists"', add
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
label define occ1950_lbl 084 `"Miscellaneous social scientists"', add
label define occ1950_lbl 091 `"Sports instructors and officials"', add
label define occ1950_lbl 092 `"Surveyors"', add
label define occ1950_lbl 093 `"Teachers (n.e.c.)"', add
label define occ1950_lbl 094 `"Technicians, medical and dental"', add
label define occ1950_lbl 095 `"Technicians, testing"', add
label define occ1950_lbl 096 `"Technicians (n.e.c.)"', add
label define occ1950_lbl 097 `"Therapists and healers (n.e.c.)"', add
label define occ1950_lbl 098 `"Veterinarians"', add
label define occ1950_lbl 099 `"Professional, technical and kindred workers (n.e.c.)"', add
label define occ1950_lbl 100 `"Farmers (owners and tenants)"', add
label define occ1950_lbl 123 `"Farm managers"', add
label define occ1950_lbl 200 `"Buyers and department heads, store"', add
label define occ1950_lbl 201 `"Buyers and shippers, farm products"', add
label define occ1950_lbl 203 `"Conductors, railroad"', add
label define occ1950_lbl 204 `"Credit men"', add
label define occ1950_lbl 205 `"Floormen and floor managers, store"', add
label define occ1950_lbl 210 `"Inspectors, public administration"', add
label define occ1950_lbl 230 `"Managers and superintendents, building"', add
label define occ1950_lbl 240 `"Officers, pilots, pursers and engineers, ship"', add
label define occ1950_lbl 250 `"Officials and administrators (n.e.c.), public administration"', add
label define occ1950_lbl 260 `"Officials, lodge, society, union, etc."', add
label define occ1950_lbl 270 `"Postmasters"', add
label define occ1950_lbl 280 `"Purchasing agents and buyers (n.e.c.)"', add
label define occ1950_lbl 290 `"Managers, officials, and proprietors (n.e.c.)"', add
label define occ1950_lbl 300 `"Agents (n.e.c.)"', add
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
label define occ1950_lbl 490 `"Salesmen and sales clerks (n.e.c.)"', add
label define occ1950_lbl 500 `"Bakers"', add
label define occ1950_lbl 501 `"Blacksmiths"', add
label define occ1950_lbl 502 `"Bookbinders"', add
label define occ1950_lbl 503 `"Boilermakers"', add
label define occ1950_lbl 504 `"Brickmasons, stonemasons, and tile setters"', add
label define occ1950_lbl 505 `"Cabinetmakers"', add
label define occ1950_lbl 510 `"Carpenters"', add
label define occ1950_lbl 511 `"Cement and concrete finishers"', add
label define occ1950_lbl 512 `"Compositors and typesetters"', add
label define occ1950_lbl 513 `"Cranemen, derrickmen, and hoistmen"', add
label define occ1950_lbl 514 `"Decorators and window dressers"', add
label define occ1950_lbl 515 `"Electricians"', add
label define occ1950_lbl 520 `"Electrotypers and stereotypers"', add
label define occ1950_lbl 521 `"Engravers, except photoengravers"', add
label define occ1950_lbl 522 `"Excavating, grading, and road machinery operators"', add
label define occ1950_lbl 523 `"Foremen (n.e.c.)"', add
label define occ1950_lbl 524 `"Forgemen and hammermen"', add
label define occ1950_lbl 525 `"Furriers"', add
label define occ1950_lbl 530 `"Glaziers"', add
label define occ1950_lbl 531 `"Heat treaters, annealers, temperers"', add
label define occ1950_lbl 532 `"Inspectors, scalers, and graders, log and lumber"', add
label define occ1950_lbl 533 `"Inspectors (n.e.c.)"', add
label define occ1950_lbl 534 `"Jewelers, watchmakers, goldsmiths, and silversmiths"', add
label define occ1950_lbl 535 `"Job setters, metal"', add
label define occ1950_lbl 540 `"Linemen and servicemen, telegraph, telephone, and power"', add
label define occ1950_lbl 541 `"Locomotive engineers"', add
label define occ1950_lbl 542 `"Locomotive firemen"', add
label define occ1950_lbl 543 `"Loom fixers"', add
label define occ1950_lbl 544 `"Machinists"', add
label define occ1950_lbl 545 `"Mechanics and repairmen, airplane"', add
label define occ1950_lbl 550 `"Mechanics and repairmen, automobile"', add
label define occ1950_lbl 551 `"Mechanics and repairmen, office machine"', add
label define occ1950_lbl 552 `"Mechanics and repairmen, radio and television"', add
label define occ1950_lbl 553 `"Mechanics and repairmen, railroad and car shop"', add
label define occ1950_lbl 554 `"Mechanics and repairmen (n.e.c.)"', add
label define occ1950_lbl 555 `"Millers, grain, flour, feed, etc."', add
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
label define occ1950_lbl 594 `"Craftsmen and kindred workers (n.e.c.)"', add
label define occ1950_lbl 595 `"Members of the armed services"', add
label define occ1950_lbl 600 `"Apprentice auto mechanics"', add
label define occ1950_lbl 601 `"Apprentice bricklayers and masons"', add
label define occ1950_lbl 602 `"Apprentice carpenters"', add
label define occ1950_lbl 603 `"Apprentice electricians"', add
label define occ1950_lbl 604 `"Apprentice machinists and toolmakers"', add
label define occ1950_lbl 605 `"Apprentice mechanics, except auto"', add
label define occ1950_lbl 610 `"Apprentice plumbers and pipe fitters"', add
label define occ1950_lbl 611 `"Apprentices, building trades (n.e.c.)"', add
label define occ1950_lbl 612 `"Apprentices, metalworking trades (n.e.c.)"', add
label define occ1950_lbl 613 `"Apprentices, printing trades"', add
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
label define occ1950_lbl 640 `"Fruit, nut, veg graders and packers, except factory"', add
label define occ1950_lbl 641 `"Furnacemen, smeltermen and pourers"', add
label define occ1950_lbl 642 `"Heaters, metal"', add
label define occ1950_lbl 643 `"Laundry and dry cleaning operatives"', add
label define occ1950_lbl 644 `"Meat cutters, except slaughter and packing house"', add
label define occ1950_lbl 645 `"Milliners"', add
label define occ1950_lbl 650 `"Mine operatives and laborers"', add
label define occ1950_lbl 660 `"Motormen, mine, factory, logging camp, etc."', add
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
label define occ1950_lbl 682 `"Taxicab drivers and chauffers"', add
label define occ1950_lbl 683 `"Truck and tractor drivers"', add
label define occ1950_lbl 684 `"Weavers, textile"', add
label define occ1950_lbl 685 `"Welders and flame cutters"', add
label define occ1950_lbl 690 `"Operative and kindred workers (n.e.c.)"', add
label define occ1950_lbl 700 `"Housekeepers, private household"', add
label define occ1950_lbl 710 `"Laundressses, private household"', add
label define occ1950_lbl 720 `"Private household workers (n.e.c.)"', add
label define occ1950_lbl 730 `"Attendants, hospital and other institution"', add
label define occ1950_lbl 731 `"Attendants, professional and personal service (n.e.c.)"', add
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
label define occ1950_lbl 790 `"Service workers, except private household (n.e.c.)"', add
label define occ1950_lbl 810 `"Farm foremen"', add
label define occ1950_lbl 820 `"Farm laborers, wage workers"', add
label define occ1950_lbl 830 `"Farm laborers, unpaid family workers"', add
label define occ1950_lbl 840 `"Farm service laborers, self-employed"', add
label define occ1950_lbl 910 `"Fishermen and oystermen"', add
label define occ1950_lbl 920 `"Garage laborers and car washers and greasers"', add
label define occ1950_lbl 930 `"Gardeners, except farm, and groundskeepers"', add
label define occ1950_lbl 940 `"Longshoremen and stevedores"', add
label define occ1950_lbl 950 `"Lumbermen, raftsmen, and woodchoppers"', add
label define occ1950_lbl 960 `"Teamsters"', add
label define occ1950_lbl 970 `"Laborers (n.e.c.)"', add
label define occ1950_lbl 997 `"Unknown"', add
label define occ1950_lbl 999 `"NIU"', add
label values occ1950 occ1950_lbl

label define ind1950_lbl 000 `"NIU"'
label define ind1950_lbl 105 `"Agriculture"', add
label define ind1950_lbl 116 `"Forestry"', add
label define ind1950_lbl 126 `"Fisheries"', add
label define ind1950_lbl 206 `"Metal mining"', add
label define ind1950_lbl 216 `"Coal mining"', add
label define ind1950_lbl 226 `"Crude petroleum and natural gas extraction"', add
label define ind1950_lbl 236 `"Nonmetallic mining and quarrying, except fuel"', add
label define ind1950_lbl 246 `"Construction"', add
label define ind1950_lbl 306 `"Logging"', add
label define ind1950_lbl 307 `"Sawmills, planing mills, and millwork"', add
label define ind1950_lbl 308 `"Misc wood products"', add
label define ind1950_lbl 309 `"Furniture and fixtures"', add
label define ind1950_lbl 316 `"Glass and glass products"', add
label define ind1950_lbl 317 `"Cement, concrete, gypsum and plaster products"', add
label define ind1950_lbl 318 `"Structural clay products"', add
label define ind1950_lbl 319 `"Pottery and related products"', add
label define ind1950_lbl 326 `"Miscellaneous nonmetallic mineral and stone products"', add
label define ind1950_lbl 336 `"Blast furnaces, steel works, and rolling mills"', add
label define ind1950_lbl 337 `"Other primary iron and steel industries"', add
label define ind1950_lbl 338 `"Primary nonferrous industries"', add
label define ind1950_lbl 346 `"Fabricated steel products"', add
label define ind1950_lbl 347 `"Fabricated nonferrous metal products"', add
label define ind1950_lbl 348 `"Not specified metal industries"', add
label define ind1950_lbl 356 `"Agricultural machinery and tractors"', add
label define ind1950_lbl 357 `"Office and store machines and devices"', add
label define ind1950_lbl 358 `"Miscellaneous machinery"', add
label define ind1950_lbl 367 `"Electrical machinery, equipment, and supplies"', add
label define ind1950_lbl 376 `"Motor vehicles and motor vehicle equipment"', add
label define ind1950_lbl 377 `"Aircraft and parts"', add
label define ind1950_lbl 378 `"Ship and boat building and repairing"', add
label define ind1950_lbl 379 `"Railroad and miscellaneous transportation equipment"', add
label define ind1950_lbl 386 `"Professional equipment and supplies"', add
label define ind1950_lbl 387 `"Photographic equipment and supplies"', add
label define ind1950_lbl 388 `"Watches, clocks, and clockwork-operated devices"', add
label define ind1950_lbl 399 `"Miscellaneous manufacturing industries"', add
label define ind1950_lbl 406 `"Meat products"', add
label define ind1950_lbl 407 `"Dairy products"', add
label define ind1950_lbl 408 `"Canning and preserving fruits, vegetables, and seafoods"', add
label define ind1950_lbl 409 `"Grain-mill products"', add
label define ind1950_lbl 416 `"Bakery products"', add
label define ind1950_lbl 417 `"Confectionery and related products"', add
label define ind1950_lbl 418 `"Beverage industries"', add
label define ind1950_lbl 419 `"Miscellaneous food preparations and kindred products"', add
label define ind1950_lbl 426 `"Not specified food industries"', add
label define ind1950_lbl 429 `"Tobacco manufactures"', add
label define ind1950_lbl 436 `"Knitting mills"', add
label define ind1950_lbl 437 `"Dyeing and finishing textiles, except knit goods"', add
label define ind1950_lbl 438 `"Carpets, rugs, and other floor coverings"', add
label define ind1950_lbl 439 `"Yarn, thread, and fabric mills"', add
label define ind1950_lbl 446 `"Miscellaneous textile mill products"', add
label define ind1950_lbl 448 `"Apparel and accessories"', add
label define ind1950_lbl 449 `"Miscellaneous fabricated textile products"', add
label define ind1950_lbl 456 `"Pulp, paper, and paperboard mills"', add
label define ind1950_lbl 457 `"Paperboard containers and boxes"', add
label define ind1950_lbl 458 `"Miscellaneous paper and pulp products"', add
label define ind1950_lbl 459 `"Printing, publishing, and allied industries"', add
label define ind1950_lbl 466 `"Synthetic fibers"', add
label define ind1950_lbl 467 `"Drugs and medicines"', add
label define ind1950_lbl 468 `"Paints, varnishes, and related products"', add
label define ind1950_lbl 469 `"Miscellaneous chemicals and allied products"', add
label define ind1950_lbl 476 `"Petroleum refining"', add
label define ind1950_lbl 477 `"Miscellaneous petroleum and coal products"', add
label define ind1950_lbl 478 `"Rubber products"', add
label define ind1950_lbl 487 `"Leather: tanned, curried, and finished"', add
label define ind1950_lbl 488 `"Footwear, except rubber"', add
label define ind1950_lbl 489 `"Leather products, except footwear"', add
label define ind1950_lbl 499 `"Not specified manufacturing industries"', add
label define ind1950_lbl 506 `"Railroads and railway express service"', add
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
label define ind1950_lbl 619 `"Farm products--raw materials"', add
label define ind1950_lbl 626 `"Miscellaneous wholesale trade"', add
label define ind1950_lbl 627 `"Not specified wholesale trade"', add
label define ind1950_lbl 636 `"Food stores, except dairy products"', add
label define ind1950_lbl 637 `"Dairy products stores and milk retailing"', add
label define ind1950_lbl 646 `"General merchandise stores"', add
label define ind1950_lbl 647 `"Five and ten cent stores"', add
label define ind1950_lbl 656 `"Apparel and accessories stores, except shoe"', add
label define ind1950_lbl 657 `"Shoe stores"', add
label define ind1950_lbl 658 `"Furniture and house furnishing stores"', add
label define ind1950_lbl 659 `"Household appliance and radio stores"', add
label define ind1950_lbl 667 `"Motor vehicles and accessories retailing"', add
label define ind1950_lbl 668 `"Gasoline service stations"', add
label define ind1950_lbl 669 `"Drug stores"', add
label define ind1950_lbl 679 `"Eating and drinking places"', add
label define ind1950_lbl 686 `"Hardware and farm implement stores"', add
label define ind1950_lbl 687 `"Lumber and building material retailing"', add
label define ind1950_lbl 688 `"Liquor stores"', add
label define ind1950_lbl 689 `"Retail florists"', add
label define ind1950_lbl 696 `"Jewelry stores"', add
label define ind1950_lbl 697 `"Fuel and ice retailing"', add
label define ind1950_lbl 698 `"Miscellaneous retail stores"', add
label define ind1950_lbl 699 `"Not specified retail trade"', add
label define ind1950_lbl 716 `"Banking and credit agencies"', add
label define ind1950_lbl 726 `"Security and commodity brokerage and investment companies"', add
label define ind1950_lbl 736 `"Insurance"', add
label define ind1950_lbl 746 `"Real estate"', add
label define ind1950_lbl 806 `"Advertising"', add
label define ind1950_lbl 807 `"Accounting, auditing, and bookkeeping services"', add
label define ind1950_lbl 808 `"Miscellaneous business services"', add
label define ind1950_lbl 816 `"Auto repair services and garages"', add
label define ind1950_lbl 817 `"Miscellaneous repair services"', add
label define ind1950_lbl 826 `"Private households"', add
label define ind1950_lbl 836 `"Hotels and lodging places"', add
label define ind1950_lbl 846 `"Laundering, cleaning, and dyeing services"', add
label define ind1950_lbl 847 `"Dressmaking shops"', add
label define ind1950_lbl 848 `"Shoe repair shops"', add
label define ind1950_lbl 849 `"Miscellaneous personal services"', add
label define ind1950_lbl 856 `"Radio broadcasting and television"', add
label define ind1950_lbl 857 `"Theaters and motion pictures"', add
label define ind1950_lbl 858 `"Bowling alleys, and billiard and pool parlors"', add
label define ind1950_lbl 859 `"Miscellaneous entertainment and recreation services"', add
label define ind1950_lbl 868 `"Medical and other health services, except hospitals"', add
label define ind1950_lbl 869 `"Hospitals"', add
label define ind1950_lbl 879 `"Legal services"', add
label define ind1950_lbl 888 `"Educational services"', add
label define ind1950_lbl 896 `"Welfare and religious services"', add
label define ind1950_lbl 897 `"Nonprofit membership organizations"', add
label define ind1950_lbl 898 `"Engineering and architectural services"', add
label define ind1950_lbl 899 `"Miscellaneous professional and related services"', add
label define ind1950_lbl 906 `"Postal service"', add
label define ind1950_lbl 916 `"Federal public administration"', add
label define ind1950_lbl 926 `"State public administration"', add
label define ind1950_lbl 936 `"Local public administration"', add
label define ind1950_lbl 997 `"Nonclassifiable"', add
label define ind1950_lbl 998 `"Industry not reported"', add
label values ind1950 ind1950_lbl

label define classwkr_lbl 00 `"NIU"'
label define classwkr_lbl 10 `"Self-employed"', add
label define classwkr_lbl 13 `"Self-employed, not incorporated"', add
label define classwkr_lbl 14 `"Self-employed, incorporated"', add
label define classwkr_lbl 20 `"Works for wages or salary"', add
label define classwkr_lbl 21 `"Wage/salary, private"', add
label define classwkr_lbl 22 `"Private, for profit"', add
label define classwkr_lbl 23 `"Private, nonprofit"', add
label define classwkr_lbl 24 `"Wage/salary, government"', add
label define classwkr_lbl 25 `"Federal government employee"', add
label define classwkr_lbl 26 `"Armed forces"', add
label define classwkr_lbl 27 `"State government employee"', add
label define classwkr_lbl 28 `"Local government employee"', add
label define classwkr_lbl 29 `"Unpaid family worker"', add
label define classwkr_lbl 99 `"Missing/Unknown"', add
label values classwkr classwkr_lbl

label define uhrsworkt_lbl 997 `"Hours vary"'
label define uhrsworkt_lbl 999 `"NIU"', add
label values uhrsworkt uhrsworkt_lbl

label define uhrswork1_lbl 000 `"0 hours"'
label define uhrswork1_lbl 997 `"Hours vary"', add
label define uhrswork1_lbl 999 `"NIU/Missing"', add
label values uhrswork1 uhrswork1_lbl

label define absent_lbl 0 `"NIU"'
label define absent_lbl 1 `"No"', add
label define absent_lbl 2 `"Yes, laid off"', add
label define absent_lbl 3 `"Yes, other reason (vacation, illness, labor dispute)"', add
label values absent absent_lbl

label define durunem2_lbl 00 `"0"'
label define durunem2_lbl 01 `"1"', add
label define durunem2_lbl 02 `"2"', add
label define durunem2_lbl 03 `"3"', add
label define durunem2_lbl 04 `"4"', add
label define durunem2_lbl 05 `"5"', add
label define durunem2_lbl 06 `"6"', add
label define durunem2_lbl 07 `"7-10"', add
label define durunem2_lbl 08 `"11-14"', add
label define durunem2_lbl 09 `"15-18"', add
label define durunem2_lbl 10 `"19-22"', add
label define durunem2_lbl 11 `"23-26"', add
label define durunem2_lbl 12 `"27-34"', add
label define durunem2_lbl 13 `"35-42"', add
label define durunem2_lbl 14 `"43-50"', add
label define durunem2_lbl 15 `"51-52"', add
label define durunem2_lbl 16 `"Over 52 weeks"', add
label define durunem2_lbl 99 `"NIU"', add
label values durunem2 durunem2_lbl

label define whyunemp_lbl 0 `"NIU"'
label define whyunemp_lbl 1 `"Job loser - on layoff"', add
label define whyunemp_lbl 2 `"Other job loser"', add
label define whyunemp_lbl 3 `"Temporary job ended"', add
label define whyunemp_lbl 4 `"Job leaver"', add
label define whyunemp_lbl 5 `"Re-entrant"', add
label define whyunemp_lbl 6 `"New entrant"', add
label values whyunemp whyunemp_lbl

label define whyabsnt_lbl 00 `"NIU"'
label define whyabsnt_lbl 01 `"On temporary layoff (under 30 days)"', add
label define whyabsnt_lbl 02 `"On indefinite layoff (30+ days)"', add
label define whyabsnt_lbl 03 `"Slack work/business conditions"', add
label define whyabsnt_lbl 04 `"Waiting for a new job to begin"', add
label define whyabsnt_lbl 05 `"Vacation/personal days"', add
label define whyabsnt_lbl 06 `"Own illness/injury/medical problems"', add
label define whyabsnt_lbl 07 `"Child care problems"', add
label define whyabsnt_lbl 08 `"Other family/personal obligation"', add
label define whyabsnt_lbl 09 `"Maternity/paternity leave"', add
label define whyabsnt_lbl 10 `"Labor dispute"', add
label define whyabsnt_lbl 11 `"Weather affected job"', add
label define whyabsnt_lbl 12 `"School/training"', add
label define whyabsnt_lbl 13 `"Civic/military duty"', add
label define whyabsnt_lbl 14 `"Does not work in the business"', add
label define whyabsnt_lbl 15 `"Other"', add
label values whyabsnt whyabsnt_lbl

label define whyptlwk_lbl 000 `"NIU"'
label define whyptlwk_lbl 001 `"No response"', add
label define whyptlwk_lbl 010 `"Slack work, business conditions"', add
label define whyptlwk_lbl 011 `"Material shortage"', add
label define whyptlwk_lbl 012 `"Plant or machine repairs"', add
label define whyptlwk_lbl 020 `"Seasonal work"', add
label define whyptlwk_lbl 030 `"Weather affected job"', add
label define whyptlwk_lbl 040 `"Labor dispute"', add
label define whyptlwk_lbl 050 `"job started/ended during week"', add
label define whyptlwk_lbl 051 `"New job started"', add
label define whyptlwk_lbl 052 `"Job terminated"', add
label define whyptlwk_lbl 060 `"Could only find part-time"', add
label define whyptlwk_lbl 070 `"Not want full time work"', add
label define whyptlwk_lbl 071 `"Retired/SS limit on earnings"', add
label define whyptlwk_lbl 080 `"Full time work week under 35 hours"', add
label define whyptlwk_lbl 081 `"Full time peak season only"', add
label define whyptlwk_lbl 090 `"Holiday"', add
label define whyptlwk_lbl 100 `"Own illness"', add
label define whyptlwk_lbl 101 `"Health/medical limitation"', add
label define whyptlwk_lbl 110 `"On vacation"', add
label define whyptlwk_lbl 111 `"Vacation/personal day"', add
label define whyptlwk_lbl 120 `"Too busy with house, school, etc"', add
label define whyptlwk_lbl 121 `"Child care problems"', add
label define whyptlwk_lbl 122 `"Other family/personal obligations"', add
label define whyptlwk_lbl 123 `"School/training"', add
label define whyptlwk_lbl 124 `"Civic/military duty"', add
label define whyptlwk_lbl 130 `"Other"', add
label values whyptlwk whyptlwk_lbl

label define wnftlook_lbl 00 `"NIU"'
label define wnftlook_lbl 10 `"Less than 5 years ago"', add
label define wnftlook_lbl 11 `"In the last twelve months"', add
label define wnftlook_lbl 12 `"One to five years ago"', add
label define wnftlook_lbl 20 `"More than I2 months ago, unspecified"', add
label define wnftlook_lbl 30 `"More than 5 years ago"', add
label define wnftlook_lbl 40 `"Never worked"', add
label define wnftlook_lbl 41 `"Never worked full-time 2+ weeks"', add
label define wnftlook_lbl 42 `"Never worked at all"', add
label values wnftlook wnftlook_lbl

label define wkstat_lbl 10 `"Full-time schedules"'
label define wkstat_lbl 11 `"Full-time hours (35+), usually full-time"', add
label define wkstat_lbl 12 `"Part-time for non-economic reasons, usually full-time"', add
label define wkstat_lbl 13 `"Not at work, usually full-time"', add
label define wkstat_lbl 14 `"Full-time hours, usually part-time for economic reasons"', add
label define wkstat_lbl 15 `"Full-time hours, usually part-time for non-economic reasons"', add
label define wkstat_lbl 20 `"Part-time for economic reasons"', add
label define wkstat_lbl 21 `"Part-time for economic reasons, usually full-time"', add
label define wkstat_lbl 22 `"Part-time hours, usually part-time for economic reasons"', add
label define wkstat_lbl 40 `"Part-time for non-economic reasons, usually part-time"', add
label define wkstat_lbl 41 `"Part-time hours, usually part-time for non-economic reasons"', add
label define wkstat_lbl 42 `"Not at work, usually part-time"', add
label define wkstat_lbl 50 `"Unemployed, seeking full-time work"', add
label define wkstat_lbl 60 `"Unemployed, seeking part-time work"', add
label define wkstat_lbl 99 `"NIU, blank, or not in labor force"', add
label values wkstat wkstat_lbl

label define educ_lbl 000 `"NIU or no schooling"'
label define educ_lbl 001 `"NIU or blank"', add
label define educ_lbl 002 `"None or preschool"', add
label define educ_lbl 010 `"Grades 1, 2, 3, or 4"', add
label define educ_lbl 011 `"Grade 1"', add
label define educ_lbl 012 `"Grade 2"', add
label define educ_lbl 013 `"Grade 3"', add
label define educ_lbl 014 `"Grade 4"', add
label define educ_lbl 020 `"Grades 5 or 6"', add
label define educ_lbl 021 `"Grade 5"', add
label define educ_lbl 022 `"Grade 6"', add
label define educ_lbl 030 `"Grades 7 or 8"', add
label define educ_lbl 031 `"Grade 7"', add
label define educ_lbl 032 `"Grade 8"', add
label define educ_lbl 040 `"Grade 9"', add
label define educ_lbl 050 `"Grade 10"', add
label define educ_lbl 060 `"Grade 11"', add
label define educ_lbl 070 `"Grade 12"', add
label define educ_lbl 071 `"12th grade, no diploma"', add
label define educ_lbl 072 `"12th grade, diploma unclear"', add
label define educ_lbl 073 `"High school diploma or equivalent"', add
label define educ_lbl 080 `"1 year of college"', add
label define educ_lbl 081 `"Some college but no degree"', add
label define educ_lbl 090 `"2 years of college"', add
label define educ_lbl 091 `"Associate's degree, occupational/vocational program"', add
label define educ_lbl 092 `"Associate's degree, academic program"', add
label define educ_lbl 100 `"3 years of college"', add
label define educ_lbl 110 `"4 years of college"', add
label define educ_lbl 111 `"Bachelor's degree"', add
label define educ_lbl 120 `"5+ years of college"', add
label define educ_lbl 121 `"5 years of college"', add
label define educ_lbl 122 `"6+ years of college"', add
label define educ_lbl 123 `"Master's degree"', add
label define educ_lbl 124 `"Professional school degree"', add
label define educ_lbl 125 `"Doctorate degree"', add
label define educ_lbl 999 `"Missing/Unknown"', add
label values educ educ_lbl

label define educ99_lbl 00 `"NIU"'
label define educ99_lbl 01 `"No school completed"', add
label define educ99_lbl 04 `"1st-4th grade"', add
label define educ99_lbl 05 `"5th-8th grade"', add
label define educ99_lbl 06 `"9th grade"', add
label define educ99_lbl 07 `"10th grade"', add
label define educ99_lbl 08 `"11th grade"', add
label define educ99_lbl 09 `"12th grade, no diploma"', add
label define educ99_lbl 10 `"High school graduate, or GED"', add
label define educ99_lbl 11 `"Some college, no degree"', add
label define educ99_lbl 12 `"Associate degree, type of program not specified"', add
label define educ99_lbl 13 `"Associate degree, occupational program"', add
label define educ99_lbl 14 `"Associate degree, academic program"', add
label define educ99_lbl 15 `"Bachelors degree"', add
label define educ99_lbl 16 `"Masters degree"', add
label define educ99_lbl 17 `"Professional degree"', add
label define educ99_lbl 18 `"Doctorate degree"', add
label values educ99 educ99_lbl

label define schlcoll_lbl 0 `"NIU"'
label define schlcoll_lbl 1 `"High school full time"', add
label define schlcoll_lbl 2 `"High school part time"', add
label define schlcoll_lbl 3 `"College or university full time"', add
label define schlcoll_lbl 4 `"College or university part time"', add
label define schlcoll_lbl 5 `"Does not attend school, college or university"', add
label values schlcoll schlcoll_lbl

label define diffhear_lbl 0 `"NIU"'
label define diffhear_lbl 1 `"No hearing difficulty"', add
label define diffhear_lbl 2 `"Has hearing difficulty"', add
label values diffhear diffhear_lbl

label define diffeye_lbl 0 `"NIU"'
label define diffeye_lbl 1 `"No vision difficulty"', add
label define diffeye_lbl 2 `"Has vision difficulty"', add
label values diffeye diffeye_lbl

label define diffrem_lbl 0 `"NIU"'
label define diffrem_lbl 1 `"No difficulty remembering"', add
label define diffrem_lbl 2 `"Has difficulty remembering"', add
label values diffrem diffrem_lbl

label define diffphys_lbl 0 `"NIU"'
label define diffphys_lbl 1 `"No physical difficulty"', add
label define diffphys_lbl 2 `"Has physical difficulty"', add
label values diffphys diffphys_lbl

label define diffmob_lbl 0 `"NIU"'
label define diffmob_lbl 1 `"No mobility limitation"', add
label define diffmob_lbl 2 `"Has mobility limitation"', add
label values diffmob diffmob_lbl

label define diffcare_lbl 0 `"NIU"'
label define diffcare_lbl 1 `"No personal care difficulty"', add
label define diffcare_lbl 2 `"Has personal care difficulty"', add
label values diffcare diffcare_lbl

label define diffany_lbl 0 `"NIU"'
label define diffany_lbl 1 `"No difficulty"', add
label define diffany_lbl 2 `"Has difficulty"', add
label values diffany diffany_lbl

label define occ50ly_lbl 000 `"Accountants and auditors"'
label define occ50ly_lbl 001 `"Actors and actresses"', add
label define occ50ly_lbl 002 `"Airplane pilots and navigators"', add
label define occ50ly_lbl 003 `"Architects"', add
label define occ50ly_lbl 004 `"Artists and art teachers"', add
label define occ50ly_lbl 005 `"Athletes"', add
label define occ50ly_lbl 006 `"Authors"', add
label define occ50ly_lbl 007 `"Chemists"', add
label define occ50ly_lbl 008 `"Chiropractors"', add
label define occ50ly_lbl 009 `"Clergymen"', add
label define occ50ly_lbl 010 `"College presidents and deans"', add
label define occ50ly_lbl 012 `"Agricultural sciences"', add
label define occ50ly_lbl 013 `"Biological sciences"', add
label define occ50ly_lbl 014 `"Chemistry"', add
label define occ50ly_lbl 015 `"Economics"', add
label define occ50ly_lbl 016 `"Engineering"', add
label define occ50ly_lbl 017 `"Geology and geophysics"', add
label define occ50ly_lbl 018 `"Mathematics"', add
label define occ50ly_lbl 019 `"Medical sciences"', add
label define occ50ly_lbl 023 `"Physics"', add
label define occ50ly_lbl 024 `"Psychology"', add
label define occ50ly_lbl 025 `"Statistics"', add
label define occ50ly_lbl 026 `"Natural science (n.e.c.)"', add
label define occ50ly_lbl 027 `"Social sciences (n.e.c.)"', add
label define occ50ly_lbl 028 `"Nonscientific subjects"', add
label define occ50ly_lbl 029 `"Subject not specified"', add
label define occ50ly_lbl 031 `"Dancers and dancing teachers"', add
label define occ50ly_lbl 032 `"Dentists"', add
label define occ50ly_lbl 033 `"Designers"', add
label define occ50ly_lbl 034 `"Dieticians and nutritionists"', add
label define occ50ly_lbl 035 `"Draftsmen"', add
label define occ50ly_lbl 036 `"Editors and reporters"', add
label define occ50ly_lbl 041 `"Engineers, aeronautical"', add
label define occ50ly_lbl 042 `"Engineers, chemical"', add
label define occ50ly_lbl 043 `"Engineers, civil"', add
label define occ50ly_lbl 044 `"Engineers, electrical"', add
label define occ50ly_lbl 045 `"Engineers, industrial"', add
label define occ50ly_lbl 046 `"Engineers, mechanical"', add
label define occ50ly_lbl 047 `"Engineers, metallurgical, metallurgists"', add
label define occ50ly_lbl 048 `"Engineers, mining"', add
label define occ50ly_lbl 049 `"Engineers (n.e.c.)"', add
label define occ50ly_lbl 051 `"Entertainers (n.e.c.)"', add
label define occ50ly_lbl 052 `"Farm and home management advisors"', add
label define occ50ly_lbl 053 `"Foresters and conservationists"', add
label define occ50ly_lbl 054 `"Funeral directors and embalmers"', add
label define occ50ly_lbl 055 `"Lawyers and judges"', add
label define occ50ly_lbl 056 `"Librarians"', add
label define occ50ly_lbl 057 `"Musicians and music teachers"', add
label define occ50ly_lbl 058 `"Nurses, professional"', add
label define occ50ly_lbl 059 `"Nurses, student professional"', add
label define occ50ly_lbl 061 `"Agricultural scientists"', add
label define occ50ly_lbl 062 `"Biological scientists"', add
label define occ50ly_lbl 063 `"Geologists and geophysicists"', add
label define occ50ly_lbl 067 `"Mathematicians"', add
label define occ50ly_lbl 068 `"Physicists"', add
label define occ50ly_lbl 069 `"Miscellaneous natural scientists"', add
label define occ50ly_lbl 070 `"Optometrists"', add
label define occ50ly_lbl 071 `"Osteopaths"', add
label define occ50ly_lbl 072 `"Personnel and labor relations workers"', add
label define occ50ly_lbl 073 `"Pharmacists"', add
label define occ50ly_lbl 074 `"Photographers"', add
label define occ50ly_lbl 075 `"Physicians and surgeons"', add
label define occ50ly_lbl 076 `"Radio operators"', add
label define occ50ly_lbl 077 `"Recreation and group workers"', add
label define occ50ly_lbl 078 `"Religious workers"', add
label define occ50ly_lbl 079 `"Social and welfare workers, except group"', add
label define occ50ly_lbl 081 `"Economists"', add
label define occ50ly_lbl 082 `"Psychologists"', add
label define occ50ly_lbl 083 `"Statisticians and actuaries"', add
label define occ50ly_lbl 084 `"Miscellaneous social scientists"', add
label define occ50ly_lbl 091 `"Sports instructors and officials"', add
label define occ50ly_lbl 092 `"Surveyors"', add
label define occ50ly_lbl 093 `"Teachers (n.e.c.)"', add
label define occ50ly_lbl 094 `"Technicians, medical and dental"', add
label define occ50ly_lbl 095 `"Technicians, testing"', add
label define occ50ly_lbl 096 `"Technicians (n.e.c.)"', add
label define occ50ly_lbl 097 `"Therapists and healers (n.e.c.)"', add
label define occ50ly_lbl 098 `"Veterinarians"', add
label define occ50ly_lbl 099 `"Professional, technical and kindred workers (n.e.c.)"', add
label define occ50ly_lbl 100 `"Farmers (owners and tenants)"', add
label define occ50ly_lbl 123 `"Farm managers"', add
label define occ50ly_lbl 200 `"Buyers and department heads, store"', add
label define occ50ly_lbl 201 `"Buyers and shippers, farm products"', add
label define occ50ly_lbl 203 `"Conductors, railroad"', add
label define occ50ly_lbl 204 `"Credit men"', add
label define occ50ly_lbl 205 `"Floormen and floor managers, store"', add
label define occ50ly_lbl 210 `"Inspectors, public administration"', add
label define occ50ly_lbl 230 `"Managers and superintendents, building"', add
label define occ50ly_lbl 240 `"Officers, pilots, pursers and engineers, ship"', add
label define occ50ly_lbl 250 `"Officials and administrators (n.e.c.), public administration"', add
label define occ50ly_lbl 260 `"Officials, lodge, society, union, etc."', add
label define occ50ly_lbl 270 `"Postmasters"', add
label define occ50ly_lbl 280 `"Purchasing agents and buyers (n.e.c.)"', add
label define occ50ly_lbl 290 `"Managers, officials, and proprietors (n.e.c.)"', add
label define occ50ly_lbl 300 `"Agents (n.e.c.)"', add
label define occ50ly_lbl 301 `"Attendants and assistants, library"', add
label define occ50ly_lbl 302 `"Attendants, physicians and dentists office"', add
label define occ50ly_lbl 304 `"Baggagemen, transportation"', add
label define occ50ly_lbl 305 `"Bank tellers"', add
label define occ50ly_lbl 310 `"Bookkeepers"', add
label define occ50ly_lbl 320 `"Cashiers"', add
label define occ50ly_lbl 321 `"Collectors, bill and account"', add
label define occ50ly_lbl 322 `"Dispatchers and starters, vehicle"', add
label define occ50ly_lbl 325 `"Express messengers and railway mail clerks"', add
label define occ50ly_lbl 335 `"Mail carriers"', add
label define occ50ly_lbl 340 `"Messengers and office boys"', add
label define occ50ly_lbl 341 `"Office machine operators"', add
label define occ50ly_lbl 342 `"Shipping and receiving clerks"', add
label define occ50ly_lbl 350 `"Stenographers, typists, and secretaries"', add
label define occ50ly_lbl 360 `"Telegraph messengers"', add
label define occ50ly_lbl 365 `"Telegraph operators"', add
label define occ50ly_lbl 370 `"Telephone operators"', add
label define occ50ly_lbl 380 `"Ticket, station, and express agents"', add
label define occ50ly_lbl 390 `"Clerical and kindred workers (n.e.c.)"', add
label define occ50ly_lbl 400 `"Advertising agents and salesmen"', add
label define occ50ly_lbl 410 `"Auctioneers"', add
label define occ50ly_lbl 420 `"Demonstrators"', add
label define occ50ly_lbl 430 `"Hucksters and peddlers"', add
label define occ50ly_lbl 450 `"Insurance agents and brokers"', add
label define occ50ly_lbl 460 `"Newsboys"', add
label define occ50ly_lbl 470 `"Real estate agents and brokers"', add
label define occ50ly_lbl 480 `"Stock and bond salesmen"', add
label define occ50ly_lbl 490 `"Salesmen and sales clerks (n.e.c.)"', add
label define occ50ly_lbl 500 `"Bakers"', add
label define occ50ly_lbl 501 `"Blacksmiths"', add
label define occ50ly_lbl 502 `"Bookbinders"', add
label define occ50ly_lbl 503 `"Boilermakers"', add
label define occ50ly_lbl 504 `"Brickmasons, stonemasons, and tile setters"', add
label define occ50ly_lbl 505 `"Cabinetmakers"', add
label define occ50ly_lbl 510 `"Carpenters"', add
label define occ50ly_lbl 511 `"Cement and concrete finishers"', add
label define occ50ly_lbl 512 `"Compositors and typesetters"', add
label define occ50ly_lbl 513 `"Cranemen, derrickmen, and hoistmen"', add
label define occ50ly_lbl 514 `"Decorators and window dressers"', add
label define occ50ly_lbl 515 `"Electricians"', add
label define occ50ly_lbl 520 `"Electrotypers and stereotypers"', add
label define occ50ly_lbl 521 `"Engravers, except photoengravers"', add
label define occ50ly_lbl 522 `"Excavating, grading, and road machinery operators"', add
label define occ50ly_lbl 523 `"Foremen (n.e.c.)"', add
label define occ50ly_lbl 524 `"Forgemen and hammermen"', add
label define occ50ly_lbl 525 `"Furriers"', add
label define occ50ly_lbl 530 `"Glaziers"', add
label define occ50ly_lbl 531 `"Heat treaters, annealers, temperers"', add
label define occ50ly_lbl 532 `"Inspectors, scalers, and graders, log and lumber"', add
label define occ50ly_lbl 533 `"Inspectors (n.e.c.)"', add
label define occ50ly_lbl 534 `"Jewelers, watchmakers, goldsmiths, and silversmiths"', add
label define occ50ly_lbl 535 `"Job setters, metal"', add
label define occ50ly_lbl 540 `"Linemen and servicemen, telegraph, telephone, and power"', add
label define occ50ly_lbl 541 `"Locomotive engineers"', add
label define occ50ly_lbl 542 `"Locomotive firemen"', add
label define occ50ly_lbl 543 `"Loom fixers"', add
label define occ50ly_lbl 544 `"Machinists"', add
label define occ50ly_lbl 545 `"Mechanics and repairmen, airplane"', add
label define occ50ly_lbl 550 `"Mechanics and repairmen, automobile"', add
label define occ50ly_lbl 551 `"Mechanics and repairmen, office machine"', add
label define occ50ly_lbl 552 `"Mechanics and repairmen, radio and television"', add
label define occ50ly_lbl 553 `"Mechanics and repairmen, railroad and car shop"', add
label define occ50ly_lbl 554 `"Mechanics and repairmen (n.e.c.)"', add
label define occ50ly_lbl 555 `"Millers, grain, flour, feed, etc."', add
label define occ50ly_lbl 560 `"Millwrights"', add
label define occ50ly_lbl 561 `"Molders, metal"', add
label define occ50ly_lbl 562 `"Motion picture projectionists"', add
label define occ50ly_lbl 563 `"Opticians and lens grinders and polishers"', add
label define occ50ly_lbl 564 `"Painters, construction and maintenance"', add
label define occ50ly_lbl 565 `"Paperhangers"', add
label define occ50ly_lbl 570 `"Pattern and model makers, except paper"', add
label define occ50ly_lbl 571 `"Photoengravers and lithographers"', add
label define occ50ly_lbl 572 `"Piano and organ tuners and repairmen"', add
label define occ50ly_lbl 573 `"Plasterers"', add
label define occ50ly_lbl 574 `"Plumbers and pipe fitters"', add
label define occ50ly_lbl 575 `"Pressmen and plate printers, printing"', add
label define occ50ly_lbl 580 `"Rollers and roll hands, metal"', add
label define occ50ly_lbl 581 `"Roofers and slaters"', add
label define occ50ly_lbl 582 `"Shoemakers and repairers, except factory"', add
label define occ50ly_lbl 583 `"Stationary engineers"', add
label define occ50ly_lbl 584 `"Stone cutters and stone carvers"', add
label define occ50ly_lbl 585 `"Structural metal workers"', add
label define occ50ly_lbl 590 `"Tailors and tailoresses"', add
label define occ50ly_lbl 591 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ50ly_lbl 592 `"Tool makers, and die makers and setters"', add
label define occ50ly_lbl 593 `"Upholsterers"', add
label define occ50ly_lbl 594 `"Craftsmen and kindred workers (n.e.c.)"', add
label define occ50ly_lbl 595 `"Members of the armed services"', add
label define occ50ly_lbl 600 `"Apprentice auto mechanics"', add
label define occ50ly_lbl 601 `"Apprentice bricklayers and masons"', add
label define occ50ly_lbl 602 `"Apprentice carpenters"', add
label define occ50ly_lbl 603 `"Apprentice electricians"', add
label define occ50ly_lbl 604 `"Apprentice machinists and toolmakers"', add
label define occ50ly_lbl 605 `"Apprentice mechanics, except auto"', add
label define occ50ly_lbl 610 `"Apprentice plumbers and pipe fitters"', add
label define occ50ly_lbl 611 `"Apprentices, building trades (n.e.c.)"', add
label define occ50ly_lbl 612 `"Apprentices, metalworking trades (n.e.c.)"', add
label define occ50ly_lbl 613 `"Apprentices, printing trades"', add
label define occ50ly_lbl 614 `"Apprentices, other specified trades"', add
label define occ50ly_lbl 615 `"Apprentices, trade not specified"', add
label define occ50ly_lbl 620 `"Asbestos and insulation workers"', add
label define occ50ly_lbl 621 `"Attendants, auto service and parking"', add
label define occ50ly_lbl 622 `"Blasters and powdermen"', add
label define occ50ly_lbl 623 `"Boatmen, canalmen, and lock keepers"', add
label define occ50ly_lbl 624 `"Brakemen, railroad"', add
label define occ50ly_lbl 625 `"Bus drivers"', add
label define occ50ly_lbl 630 `"Chainmen, rodmen, and axmen, surveying"', add
label define occ50ly_lbl 631 `"Conductors, bus and street railway"', add
label define occ50ly_lbl 632 `"Deliverymen and routemen"', add
label define occ50ly_lbl 633 `"Dressmakers and seamstresses, except factory"', add
label define occ50ly_lbl 634 `"Dyers"', add
label define occ50ly_lbl 635 `"Filers, grinders, and polishers, metal"', add
label define occ50ly_lbl 640 `"Fruit, nut, veg graders and packers, except factory"', add
label define occ50ly_lbl 641 `"Furnacemen, smeltermen and pourers"', add
label define occ50ly_lbl 642 `"Heaters, metal"', add
label define occ50ly_lbl 643 `"Laundry and dry cleaning operatives"', add
label define occ50ly_lbl 644 `"Meat cutters, except slaughter and packing house"', add
label define occ50ly_lbl 645 `"Milliners"', add
label define occ50ly_lbl 650 `"Mine operatives and laborers"', add
label define occ50ly_lbl 660 `"Motormen, mine, factory, logging camp, etc."', add
label define occ50ly_lbl 661 `"Motormen, street, subway, and elevated railway"', add
label define occ50ly_lbl 662 `"Oilers and greaser, except auto"', add
label define occ50ly_lbl 670 `"Painters, except construction or maintenance"', add
label define occ50ly_lbl 671 `"Photographic process workers"', add
label define occ50ly_lbl 672 `"Power station operators"', add
label define occ50ly_lbl 673 `"Sailors and deck hands"', add
label define occ50ly_lbl 674 `"Sawyers"', add
label define occ50ly_lbl 675 `"Spinners, textile"', add
label define occ50ly_lbl 680 `"Stationary firemen"', add
label define occ50ly_lbl 681 `"Switchmen, railroad"', add
label define occ50ly_lbl 682 `"Taxicab drivers and chauffers"', add
label define occ50ly_lbl 683 `"Truck and tractor drivers"', add
label define occ50ly_lbl 684 `"Weavers, textile"', add
label define occ50ly_lbl 685 `"Welders and flame cutters"', add
label define occ50ly_lbl 690 `"Operative and kindred workers (n.e.c.)"', add
label define occ50ly_lbl 700 `"Housekeepers, private household"', add
label define occ50ly_lbl 710 `"Laundressses, private household"', add
label define occ50ly_lbl 720 `"Private household workers (n.e.c.)"', add
label define occ50ly_lbl 730 `"Attendants, hospital and other institution"', add
label define occ50ly_lbl 731 `"Attendants, professional and personal service (n.e.c.)"', add
label define occ50ly_lbl 732 `"Attendants, recreation and amusement"', add
label define occ50ly_lbl 740 `"Barbers, beauticians, and manicurists"', add
label define occ50ly_lbl 750 `"Bartenders"', add
label define occ50ly_lbl 751 `"Bootblacks"', add
label define occ50ly_lbl 752 `"Boarding and lodging house keepers"', add
label define occ50ly_lbl 753 `"Charwomen and cleaners"', add
label define occ50ly_lbl 754 `"Cooks, except private household"', add
label define occ50ly_lbl 760 `"Counter and fountain workers"', add
label define occ50ly_lbl 761 `"Elevator operators"', add
label define occ50ly_lbl 762 `"Firemen, fire protection"', add
label define occ50ly_lbl 763 `"Guards, watchmen, and doorkeepers"', add
label define occ50ly_lbl 764 `"Housekeepers and stewards, except private household"', add
label define occ50ly_lbl 770 `"Janitors and sextons"', add
label define occ50ly_lbl 771 `"Marshals and constables"', add
label define occ50ly_lbl 772 `"Midwives"', add
label define occ50ly_lbl 773 `"Policemen and detectives"', add
label define occ50ly_lbl 780 `"Porters"', add
label define occ50ly_lbl 781 `"Practical nurses"', add
label define occ50ly_lbl 782 `"Sheriffs and bailiffs"', add
label define occ50ly_lbl 783 `"Ushers, recreation and amusement"', add
label define occ50ly_lbl 784 `"Waiters and waitresses"', add
label define occ50ly_lbl 785 `"Watchmen (crossing) and bridge tenders"', add
label define occ50ly_lbl 790 `"Service workers, except private household (n.e.c.)"', add
label define occ50ly_lbl 810 `"Farm foremen"', add
label define occ50ly_lbl 820 `"Farm laborers, wage workers"', add
label define occ50ly_lbl 830 `"Farm laborers, unpaid family workers"', add
label define occ50ly_lbl 840 `"Farm service laborers, self-employed"', add
label define occ50ly_lbl 910 `"Fishermen and oystermen"', add
label define occ50ly_lbl 920 `"Garage laborers and car washers and greasers"', add
label define occ50ly_lbl 930 `"Gardeners, except farm, and groundskeepers"', add
label define occ50ly_lbl 940 `"Longshoremen and stevedores"', add
label define occ50ly_lbl 950 `"Lumbermen, raftsmen, and woodchoppers"', add
label define occ50ly_lbl 960 `"Teamsters"', add
label define occ50ly_lbl 970 `"Laborers (n.e.c.)"', add
label define occ50ly_lbl 997 `"Unknown"', add
label define occ50ly_lbl 999 `"NIU"', add
label values occ50ly occ50ly_lbl

label define ind50ly_lbl 000 `"NIU"'
label define ind50ly_lbl 105 `"Agriculture"', add
label define ind50ly_lbl 116 `"Forestry"', add
label define ind50ly_lbl 126 `"Fisheries"', add
label define ind50ly_lbl 206 `"Metal mining"', add
label define ind50ly_lbl 216 `"Coal mining"', add
label define ind50ly_lbl 226 `"Crude petroleum and natural gas extraction"', add
label define ind50ly_lbl 236 `"Nonmetallic mining and quarrying, except fuel"', add
label define ind50ly_lbl 239 `"Mining not specified"', add
label define ind50ly_lbl 246 `"Construction"', add
label define ind50ly_lbl 306 `"Logging"', add
label define ind50ly_lbl 307 `"Sawmills, planing mills, and millwork"', add
label define ind50ly_lbl 308 `"Misc wood products"', add
label define ind50ly_lbl 309 `"Furniture and fixtures"', add
label define ind50ly_lbl 316 `"Glass and glass products"', add
label define ind50ly_lbl 317 `"Cement, concrete, gypsum and plaster products"', add
label define ind50ly_lbl 318 `"Structural clay products"', add
label define ind50ly_lbl 319 `"Pottery and related products"', add
label define ind50ly_lbl 326 `"Miscellaneous nonmetallic mineral and stone products"', add
label define ind50ly_lbl 336 `"Blast furnaces, steel works, and rolling mills"', add
label define ind50ly_lbl 337 `"Other primary iron and steel industries"', add
label define ind50ly_lbl 338 `"Primary nonferrous industries"', add
label define ind50ly_lbl 346 `"Fabricated steel products"', add
label define ind50ly_lbl 347 `"Fabricated nonferrous metal products"', add
label define ind50ly_lbl 348 `"Not specified metal industries"', add
label define ind50ly_lbl 356 `"Agricultural machinery and tractors"', add
label define ind50ly_lbl 357 `"Office and store machines and devices"', add
label define ind50ly_lbl 358 `"Miscellaneous machinery"', add
label define ind50ly_lbl 367 `"Electrical machinery, equipment, and supplies"', add
label define ind50ly_lbl 376 `"Motor vehicles and motor vehicle equipment"', add
label define ind50ly_lbl 377 `"Aircraft and parts"', add
label define ind50ly_lbl 378 `"Ship and boat building and repairing"', add
label define ind50ly_lbl 379 `"Railroad and miscellaneous transportation equipment"', add
label define ind50ly_lbl 386 `"Professional equipment and supplies"', add
label define ind50ly_lbl 387 `"Photographic equipment and supplies"', add
label define ind50ly_lbl 388 `"Watches, clocks, and clockwork-operated devices"', add
label define ind50ly_lbl 399 `"Miscellaneous manufacturing industries"', add
label define ind50ly_lbl 406 `"Meat products"', add
label define ind50ly_lbl 407 `"Dairy products"', add
label define ind50ly_lbl 408 `"Canning and preserving fruits, vegetables, and seafoods"', add
label define ind50ly_lbl 409 `"Grain-mill products"', add
label define ind50ly_lbl 416 `"Bakery products"', add
label define ind50ly_lbl 417 `"Confectionery and related products"', add
label define ind50ly_lbl 418 `"Beverage industries"', add
label define ind50ly_lbl 419 `"Miscellaneous food preparations and kindred products"', add
label define ind50ly_lbl 426 `"Not specified food industries"', add
label define ind50ly_lbl 429 `"Tobacco manufactures"', add
label define ind50ly_lbl 436 `"Knitting mills"', add
label define ind50ly_lbl 437 `"Dyeing and finishing textiles, except knit goods"', add
label define ind50ly_lbl 438 `"Carpets, rugs, and other floor coverings"', add
label define ind50ly_lbl 439 `"Yarn, thread, and fabric mills"', add
label define ind50ly_lbl 446 `"Miscellaneous textile mill products"', add
label define ind50ly_lbl 448 `"Apparel and accessories"', add
label define ind50ly_lbl 449 `"Miscellaneous fabricated textile products"', add
label define ind50ly_lbl 456 `"Pulp, paper, and paperboard mills"', add
label define ind50ly_lbl 457 `"Paperboard containers and boxes"', add
label define ind50ly_lbl 458 `"Miscellaneous paper and pulp products"', add
label define ind50ly_lbl 459 `"Printing, publishing, and allied industries"', add
label define ind50ly_lbl 466 `"Synthetic fibers"', add
label define ind50ly_lbl 467 `"Drugs and medicines"', add
label define ind50ly_lbl 468 `"Paints, varnishes, and related products"', add
label define ind50ly_lbl 469 `"Miscellaneous chemicals and allied products"', add
label define ind50ly_lbl 476 `"Petroleum refining"', add
label define ind50ly_lbl 477 `"Miscellaneous petroleum and coal products"', add
label define ind50ly_lbl 478 `"Rubber products"', add
label define ind50ly_lbl 487 `"Leather: tanned, curried, and finished"', add
label define ind50ly_lbl 488 `"Footwear, except rubber"', add
label define ind50ly_lbl 489 `"Leather products, except footwear"', add
label define ind50ly_lbl 499 `"Not specified manufacturing industries"', add
label define ind50ly_lbl 506 `"Railroads and railway express service"', add
label define ind50ly_lbl 516 `"Street railways and bus lines"', add
label define ind50ly_lbl 526 `"Trucking service"', add
label define ind50ly_lbl 527 `"Warehousing and storage"', add
label define ind50ly_lbl 536 `"Taxicab service"', add
label define ind50ly_lbl 546 `"Water transportation"', add
label define ind50ly_lbl 556 `"Air transportation"', add
label define ind50ly_lbl 567 `"Petroleum and gasoline pipe lines"', add
label define ind50ly_lbl 568 `"Services incidental to transportation"', add
label define ind50ly_lbl 578 `"Telephone"', add
label define ind50ly_lbl 579 `"Telegraph"', add
label define ind50ly_lbl 586 `"Electric light and power"', add
label define ind50ly_lbl 587 `"Gas and steam supply systems"', add
label define ind50ly_lbl 588 `"Electric-gas utilities"', add
label define ind50ly_lbl 596 `"Water supply"', add
label define ind50ly_lbl 597 `"Sanitary services"', add
label define ind50ly_lbl 598 `"Other and not specified utilities"', add
label define ind50ly_lbl 606 `"Motor vehicles and equipment"', add
label define ind50ly_lbl 607 `"Drugs, chemicals, and allied products"', add
label define ind50ly_lbl 608 `"Dry goods apparel"', add
label define ind50ly_lbl 609 `"Food and related products"', add
label define ind50ly_lbl 616 `"Electrical goods, hardware, and plumbing equipment"', add
label define ind50ly_lbl 617 `"Machinery, equipment, and supplies"', add
label define ind50ly_lbl 618 `"Petroleum products"', add
label define ind50ly_lbl 619 `"Farm products--raw materials"', add
label define ind50ly_lbl 626 `"Miscellaneous wholesale trade"', add
label define ind50ly_lbl 627 `"Not specified wholesale trade"', add
label define ind50ly_lbl 636 `"Food stores, except dairy products"', add
label define ind50ly_lbl 637 `"Dairy products stores and milk retailing"', add
label define ind50ly_lbl 646 `"General merchandise stores"', add
label define ind50ly_lbl 647 `"Five and ten cent stores"', add
label define ind50ly_lbl 656 `"Apparel and accessories stores, except shoe"', add
label define ind50ly_lbl 657 `"Shoe stores"', add
label define ind50ly_lbl 658 `"Furniture and house furnishing stores"', add
label define ind50ly_lbl 659 `"Household appliance and radio stores"', add
label define ind50ly_lbl 667 `"Motor vehicles and accessories retailing"', add
label define ind50ly_lbl 668 `"Gasoline service stations"', add
label define ind50ly_lbl 669 `"Drug stores"', add
label define ind50ly_lbl 679 `"Eating and drinking places"', add
label define ind50ly_lbl 686 `"Hardware and farm implement stores"', add
label define ind50ly_lbl 687 `"Lumber and building material retailing"', add
label define ind50ly_lbl 688 `"Liquor stores"', add
label define ind50ly_lbl 689 `"Retail florists"', add
label define ind50ly_lbl 696 `"Jewelry stores"', add
label define ind50ly_lbl 697 `"Fuel and ice retailing"', add
label define ind50ly_lbl 698 `"Miscellaneous retail stores"', add
label define ind50ly_lbl 699 `"Not specified retail trade"', add
label define ind50ly_lbl 716 `"Banking and credit agencies"', add
label define ind50ly_lbl 726 `"Security and commodity brokerage and investment companies"', add
label define ind50ly_lbl 736 `"Insurance"', add
label define ind50ly_lbl 746 `"Real estate"', add
label define ind50ly_lbl 806 `"Advertising"', add
label define ind50ly_lbl 807 `"Accounting, auditing, and bookkeeping services"', add
label define ind50ly_lbl 808 `"Miscellaneous business services"', add
label define ind50ly_lbl 816 `"Auto repair services and garages"', add
label define ind50ly_lbl 817 `"Miscellaneous repair services"', add
label define ind50ly_lbl 826 `"Private households"', add
label define ind50ly_lbl 836 `"Hotels and lodging places"', add
label define ind50ly_lbl 846 `"Laundering, cleaning, and dyeing services"', add
label define ind50ly_lbl 847 `"Dressmaking shops"', add
label define ind50ly_lbl 848 `"Shoe repair shops"', add
label define ind50ly_lbl 849 `"Miscellaneous personal services"', add
label define ind50ly_lbl 856 `"Radio broadcasting and television"', add
label define ind50ly_lbl 857 `"Theaters and motion pictures"', add
label define ind50ly_lbl 858 `"Bowling alleys, and billiard and pool parlors"', add
label define ind50ly_lbl 859 `"Miscellaneous entertainment and recreation services"', add
label define ind50ly_lbl 868 `"Medical and other health services, except hospitals"', add
label define ind50ly_lbl 869 `"Hospitals"', add
label define ind50ly_lbl 879 `"Legal services"', add
label define ind50ly_lbl 888 `"Educational services"', add
label define ind50ly_lbl 896 `"Welfare and religious services"', add
label define ind50ly_lbl 897 `"Nonprofit membership organizations"', add
label define ind50ly_lbl 898 `"Engineering and architectural services"', add
label define ind50ly_lbl 899 `"Miscellaneous professional and related services"', add
label define ind50ly_lbl 906 `"Postal service"', add
label define ind50ly_lbl 916 `"Federal public administration"', add
label define ind50ly_lbl 926 `"State public administration"', add
label define ind50ly_lbl 936 `"Local public administration"', add
label define ind50ly_lbl 997 `"Nonclassifiable"', add
label define ind50ly_lbl 998 `"Industry not reported"', add
label values ind50ly ind50ly_lbl

label define occ90ly_lbl 003 `"Legislators"'
label define occ90ly_lbl 004 `"Chief executives and public administrators"', add
label define occ90ly_lbl 007 `"Financial managers"', add
label define occ90ly_lbl 008 `"Human resources and labor relations managers"', add
label define occ90ly_lbl 013 `"Managers and specialists in marketing, advertising, and public relations"', add
label define occ90ly_lbl 014 `"Managers in education and related fields"', add
label define occ90ly_lbl 015 `"Managers of medicine and health occupations"', add
label define occ90ly_lbl 016 `"Postmasters and mail superintendents"', add
label define occ90ly_lbl 017 `"Managers of food-serving and lodging establishments"', add
label define occ90ly_lbl 018 `"Managers of properties and real estate"', add
label define occ90ly_lbl 019 `"Funeral directors"', add
label define occ90ly_lbl 021 `"Managers of service organizations, n.e.c."', add
label define occ90ly_lbl 022 `"Managers and administrators, n.e.c."', add
label define occ90ly_lbl 023 `"Accountants and auditors"', add
label define occ90ly_lbl 024 `"Insurance underwriters"', add
label define occ90ly_lbl 025 `"Other financial specialists"', add
label define occ90ly_lbl 026 `"Management analysts"', add
label define occ90ly_lbl 027 `"Personnel, HR, training, and labor relations specialists"', add
label define occ90ly_lbl 028 `"Purchasing agents and buyers, of farm products"', add
label define occ90ly_lbl 029 `"Buyers, wholesale and retail trade"', add
label define occ90ly_lbl 033 `"Purchasing managers, agents and buyers, n.e.c."', add
label define occ90ly_lbl 034 `"Business and promotion agents"', add
label define occ90ly_lbl 035 `"Construction inspectors"', add
label define occ90ly_lbl 036 `"Inspectors and compliance officers, outside construction"', add
label define occ90ly_lbl 037 `"Management support occupations"', add
label define occ90ly_lbl 043 `"Architects"', add
label define occ90ly_lbl 044 `"Aerospace engineer"', add
label define occ90ly_lbl 045 `"Metallurgical and materials engineers, variously phrased"', add
label define occ90ly_lbl 047 `"Petroleum, mining, and geological engineers"', add
label define occ90ly_lbl 048 `"Chemical engineers"', add
label define occ90ly_lbl 053 `"Civil engineers"', add
label define occ90ly_lbl 055 `"Electrical engineer"', add
label define occ90ly_lbl 056 `"Industrial engineers"', add
label define occ90ly_lbl 057 `"Mechanical engineers"', add
label define occ90ly_lbl 059 `"Not-elsewhere-classified engineers"', add
label define occ90ly_lbl 064 `"Computer systems analysts and computer scientists"', add
label define occ90ly_lbl 065 `"Operations and systems researchers and analysts"', add
label define occ90ly_lbl 066 `"Actuaries"', add
label define occ90ly_lbl 067 `"Statisticians"', add
label define occ90ly_lbl 068 `"Mathematicians and mathematical scientists"', add
label define occ90ly_lbl 069 `"Physicists and astronomers"', add
label define occ90ly_lbl 073 `"Chemists"', add
label define occ90ly_lbl 074 `"Atmospheric and space scientists"', add
label define occ90ly_lbl 075 `"Geologists"', add
label define occ90ly_lbl 076 `"Physical scientists, n.e.c."', add
label define occ90ly_lbl 077 `"Agricultural and food scientists"', add
label define occ90ly_lbl 078 `"Biological scientists"', add
label define occ90ly_lbl 079 `"Foresters and conservation scientists"', add
label define occ90ly_lbl 083 `"Medical scientists"', add
label define occ90ly_lbl 084 `"Physicians"', add
label define occ90ly_lbl 085 `"Dentists"', add
label define occ90ly_lbl 086 `"Veterinarians"', add
label define occ90ly_lbl 087 `"Optometrists"', add
label define occ90ly_lbl 088 `"Podiatrists"', add
label define occ90ly_lbl 089 `"Other health and therapy"', add
label define occ90ly_lbl 095 `"Registered nurses"', add
label define occ90ly_lbl 096 `"Pharmacists"', add
label define occ90ly_lbl 097 `"Dietitians and nutritionists"', add
label define occ90ly_lbl 098 `"Respiratory therapists"', add
label define occ90ly_lbl 099 `"Occupational therapists"', add
label define occ90ly_lbl 103 `"Physical therapists"', add
label define occ90ly_lbl 104 `"Speech therapists"', add
label define occ90ly_lbl 105 `"Therapists, n.e.c."', add
label define occ90ly_lbl 106 `"Physicians' assistants"', add
label define occ90ly_lbl 113 `"Earth, environmental, and marine science instructors"', add
label define occ90ly_lbl 114 `"Biological science instructors"', add
label define occ90ly_lbl 115 `"Chemistry instructors"', add
label define occ90ly_lbl 116 `"Physics instructors"', add
label define occ90ly_lbl 118 `"Psychology instructors"', add
label define occ90ly_lbl 119 `"Economics instructors"', add
label define occ90ly_lbl 123 `"History instructors"', add
label define occ90ly_lbl 125 `"Sociology instructors"', add
label define occ90ly_lbl 127 `"Engineering instructors"', add
label define occ90ly_lbl 128 `"Math instructors"', add
label define occ90ly_lbl 139 `"Education instructors"', add
label define occ90ly_lbl 145 `"Law instructors"', add
label define occ90ly_lbl 147 `"Theology instructors"', add
label define occ90ly_lbl 149 `"Home economics instructors"', add
label define occ90ly_lbl 150 `"Humanities profs/instructors, college, nec"', add
label define occ90ly_lbl 154 `"Subject instructors (HS/college)"', add
label define occ90ly_lbl 155 `"Kindergarten and earlier school teachers"', add
label define occ90ly_lbl 156 `"Primary school teachers"', add
label define occ90ly_lbl 157 `"Secondary school teachers"', add
label define occ90ly_lbl 158 `"Special education teachers"', add
label define occ90ly_lbl 159 `"Teachers , n.e.c."', add
label define occ90ly_lbl 163 `"Vocational and educational counselors"', add
label define occ90ly_lbl 164 `"Librarians"', add
label define occ90ly_lbl 165 `"Archivists and curators"', add
label define occ90ly_lbl 166 `"Economists, market researchers, and survey researchers"', add
label define occ90ly_lbl 167 `"Psychologists"', add
label define occ90ly_lbl 168 `"Sociologists"', add
label define occ90ly_lbl 169 `"Social scientists, n.e.c."', add
label define occ90ly_lbl 173 `"Urban and regional planners"', add
label define occ90ly_lbl 174 `"Social workers"', add
label define occ90ly_lbl 175 `"Recreation workers"', add
label define occ90ly_lbl 176 `"Clergy and religious workers"', add
label define occ90ly_lbl 178 `"Lawyers"', add
label define occ90ly_lbl 179 `"Judges"', add
label define occ90ly_lbl 183 `"Writers and authors"', add
label define occ90ly_lbl 184 `"Technical writers"', add
label define occ90ly_lbl 185 `"Designers"', add
label define occ90ly_lbl 186 `"Musician or composer"', add
label define occ90ly_lbl 187 `"Actors, directors, producers"', add
label define occ90ly_lbl 188 `"Art makers: painters, sculptors, craft-artists, and print-makers"', add
label define occ90ly_lbl 189 `"Photographers"', add
label define occ90ly_lbl 193 `"Dancers"', add
label define occ90ly_lbl 194 `"Art/entertainment performers and related"', add
label define occ90ly_lbl 195 `"Editors and reporters"', add
label define occ90ly_lbl 198 `"Announcers"', add
label define occ90ly_lbl 199 `"Athletes, sports instructors, and officials"', add
label define occ90ly_lbl 200 `"Professionals, n.e.c."', add
label define occ90ly_lbl 203 `"Clinical laboratory technologies and technicians"', add
label define occ90ly_lbl 204 `"Dental hygenists"', add
label define occ90ly_lbl 205 `"Health record tech specialists"', add
label define occ90ly_lbl 206 `"Radiologic tech specialists"', add
label define occ90ly_lbl 207 `"Licensed practical nurses"', add
label define occ90ly_lbl 208 `"Health technologists and technicians, n.e.c."', add
label define occ90ly_lbl 213 `"Electrical and electronic (engineering) technicians"', add
label define occ90ly_lbl 214 `"Engineering technicians, n.e.c."', add
label define occ90ly_lbl 215 `"Mechanical engineering technicians"', add
label define occ90ly_lbl 217 `"Drafters"', add
label define occ90ly_lbl 218 `"Surveyors, cartographers, mapping scientists and technicians"', add
label define occ90ly_lbl 223 `"Biological technicians"', add
label define occ90ly_lbl 224 `"Chemical technicians"', add
label define occ90ly_lbl 225 `"Other science technicians"', add
label define occ90ly_lbl 226 `"Airplane pilots and navigators"', add
label define occ90ly_lbl 227 `"Air traffic controllers"', add
label define occ90ly_lbl 228 `"Broadcast equipment operators"', add
label define occ90ly_lbl 229 `"Computer software developers"', add
label define occ90ly_lbl 233 `"Programmers of numerically controlled machine tools"', add
label define occ90ly_lbl 234 `"Legal assistants, paralegals, legal support, etc"', add
label define occ90ly_lbl 235 `"Technicians, n.e.c."', add
label define occ90ly_lbl 243 `"Supervisors and proprietors of sales jobs"', add
label define occ90ly_lbl 253 `"Insurance sales occupations"', add
label define occ90ly_lbl 254 `"Real estate sales occupations"', add
label define occ90ly_lbl 255 `"Financial services sales occupations"', add
label define occ90ly_lbl 256 `"Advertising and related sales jobs"', add
label define occ90ly_lbl 258 `"Sales engineers"', add
label define occ90ly_lbl 274 `"Salespersons, n.e.c."', add
label define occ90ly_lbl 275 `"Retail sales clerks"', add
label define occ90ly_lbl 276 `"Cashiers"', add
label define occ90ly_lbl 277 `"Door-to-door sales, street sales, and news vendors"', add
label define occ90ly_lbl 283 `"Sales demonstrators / promoters / models"', add
label define occ90ly_lbl 290 `"Sales workers--allocated (1990 internal census)"', add
label define occ90ly_lbl 303 `"Office supervisors"', add
label define occ90ly_lbl 308 `"Computer and peripheral equipment operators"', add
label define occ90ly_lbl 313 `"Secretaries"', add
label define occ90ly_lbl 314 `"Stenographers"', add
label define occ90ly_lbl 315 `"Typists"', add
label define occ90ly_lbl 316 `"Interviewers, enumerators, and surveyors"', add
label define occ90ly_lbl 317 `"Hotel clerks"', add
label define occ90ly_lbl 318 `"Transportation ticket and reservation agents"', add
label define occ90ly_lbl 319 `"Receptionists"', add
label define occ90ly_lbl 323 `"Information clerks, nec"', add
label define occ90ly_lbl 326 `"Correspondence and order clerks"', add
label define occ90ly_lbl 328 `"Human resources clerks, except payroll and timekeeping"', add
label define occ90ly_lbl 329 `"Library assistants"', add
label define occ90ly_lbl 335 `"File clerks"', add
label define occ90ly_lbl 336 `"Records clerks"', add
label define occ90ly_lbl 337 `"Bookkeepers and accounting and auditing clerks"', add
label define occ90ly_lbl 338 `"Payroll and timekeeping clerks"', add
label define occ90ly_lbl 343 `"Cost and rate clerks (financial records processing)"', add
label define occ90ly_lbl 344 `"Billing clerks and related financial records processing"', add
label define occ90ly_lbl 345 `"Duplication machine operators / office machine operators"', add
label define occ90ly_lbl 346 `"Mail and paper handlers"', add
label define occ90ly_lbl 347 `"Office machine operators, n.e.c."', add
label define occ90ly_lbl 348 `"Telephone operators"', add
label define occ90ly_lbl 349 `"Other telecom operators"', add
label define occ90ly_lbl 354 `"Postal clerks, excluding mail carriers"', add
label define occ90ly_lbl 355 `"Mail carriers for postal service"', add
label define occ90ly_lbl 356 `"Mail clerks, outside of post office"', add
label define occ90ly_lbl 357 `"Messengers"', add
label define occ90ly_lbl 359 `"Dispatchers"', add
label define occ90ly_lbl 361 `"Inspectors, n.e.c."', add
label define occ90ly_lbl 364 `"Shipping and receiving clerks"', add
label define occ90ly_lbl 365 `"Stock and inventory clerks"', add
label define occ90ly_lbl 366 `"Meter readers"', add
label define occ90ly_lbl 368 `"Weighers, measurers, and checkers"', add
label define occ90ly_lbl 373 `"Material recording, scheduling, production, planning, and expediting clerks"', add
label define occ90ly_lbl 375 `"Insurance adjusters, examiners, and investigators"', add
label define occ90ly_lbl 376 `"Customer service reps, investigators and adjusters, except insurance"', add
label define occ90ly_lbl 377 `"Eligibility clerks for government programs; social welfare"', add
label define occ90ly_lbl 378 `"Bill and account collectors"', add
label define occ90ly_lbl 379 `"General office clerks"', add
label define occ90ly_lbl 383 `"Bank tellers"', add
label define occ90ly_lbl 384 `"Proofreaders"', add
label define occ90ly_lbl 385 `"Data entry keyers"', add
label define occ90ly_lbl 386 `"Statistical clerks"', add
label define occ90ly_lbl 387 `"Teacher's aides"', add
label define occ90ly_lbl 389 `"Administrative support jobs, n.e.c."', add
label define occ90ly_lbl 390 `"Professional, technical, and kindred workers--allocated (1990 internal census)"', add
label define occ90ly_lbl 391 `"Clerical and kindred workers--allocated (1990 internal census)"', add
label define occ90ly_lbl 405 `"Housekeepers, maids, butlers, stewards, and lodging quarters cleaners"', add
label define occ90ly_lbl 407 `"Private household cleaners and servants"', add
label define occ90ly_lbl 408 `"Private household workers--allocated (1990 internal census)"', add
label define occ90ly_lbl 415 `"Supervisors of guards"', add
label define occ90ly_lbl 417 `"Fire fighting, prevention, and inspection"', add
label define occ90ly_lbl 418 `"Police, detectives, and private investigators"', add
label define occ90ly_lbl 423 `"Other law enforcement: sheriffs, bailiffs, correctional institution officers"', add
label define occ90ly_lbl 425 `"Crossing guards and bridge tenders"', add
label define occ90ly_lbl 426 `"Guards, watchmen, doorkeepers"', add
label define occ90ly_lbl 427 `"Protective services, n.e.c."', add
label define occ90ly_lbl 434 `"Bartenders"', add
label define occ90ly_lbl 435 `"Waiter/waitress"', add
label define occ90ly_lbl 436 `"Cooks, variously defined"', add
label define occ90ly_lbl 438 `"Food counter and fountain workers"', add
label define occ90ly_lbl 439 `"Kitchen workers"', add
label define occ90ly_lbl 443 `"Waiter's assistant"', add
label define occ90ly_lbl 444 `"Misc food prep workers"', add
label define occ90ly_lbl 445 `"Dental assistants"', add
label define occ90ly_lbl 446 `"Health aides, except nursing"', add
label define occ90ly_lbl 447 `"Nursing aides, orderlies, and attendants"', add
label define occ90ly_lbl 448 `"Supervisors of cleaning and building service"', add
label define occ90ly_lbl 453 `"Janitors"', add
label define occ90ly_lbl 454 `"Elevator operators"', add
label define occ90ly_lbl 455 `"Pest control occupations"', add
label define occ90ly_lbl 456 `"Supervisors of personal service jobs, n.e.c."', add
label define occ90ly_lbl 457 `"Barbers"', add
label define occ90ly_lbl 458 `"Hairdressers and cosmetologists"', add
label define occ90ly_lbl 459 `"Recreation facility attendants"', add
label define occ90ly_lbl 461 `"Guides"', add
label define occ90ly_lbl 462 `"Ushers"', add
label define occ90ly_lbl 463 `"Public transportation attendants and inspectors"', add
label define occ90ly_lbl 464 `"Baggage porters"', add
label define occ90ly_lbl 465 `"Welfare service aides"', add
label define occ90ly_lbl 468 `"Child care workers"', add
label define occ90ly_lbl 469 `"Personal service occupations, nec"', add
label define occ90ly_lbl 473 `"Farmers (owners and tenants)"', add
label define occ90ly_lbl 474 `"Horticultural specialty farmers"', add
label define occ90ly_lbl 475 `"Farm managers, except for horticultural farms"', add
label define occ90ly_lbl 476 `"Managers of horticultural specialty farms"', add
label define occ90ly_lbl 479 `"Farm workers"', add
label define occ90ly_lbl 480 `"Farm laborers and farm foreman--allocated (1990 internal census)"', add
label define occ90ly_lbl 483 `"Marine life cultivation workers"', add
label define occ90ly_lbl 484 `"Nursery farming workers"', add
label define occ90ly_lbl 485 `"Supervisors of agricultural occupations"', add
label define occ90ly_lbl 486 `"Gardeners and groundskeepers"', add
label define occ90ly_lbl 487 `"Animal caretakers except on farms"', add
label define occ90ly_lbl 488 `"Graders and sorters of agricultural products"', add
label define occ90ly_lbl 489 `"Inspectors of agricultural products"', add
label define occ90ly_lbl 496 `"Timber, logging, and forestry workers"', add
label define occ90ly_lbl 498 `"Fishers, hunters, and kindred"', add
label define occ90ly_lbl 503 `"Supervisors of mechanics and repairers"', add
label define occ90ly_lbl 505 `"Automobile mechanics"', add
label define occ90ly_lbl 507 `"Bus, truck, and stationary engine mechanics"', add
label define occ90ly_lbl 508 `"Aircraft mechanics"', add
label define occ90ly_lbl 509 `"Small engine repairers"', add
label define occ90ly_lbl 514 `"Auto body repairers"', add
label define occ90ly_lbl 516 `"Heavy equipment and farm equipment mechanics"', add
label define occ90ly_lbl 518 `"Industrial machinery repairers"', add
label define occ90ly_lbl 519 `"Machinery maintenance occupations"', add
label define occ90ly_lbl 523 `"Repairers of industrial electrical equipment"', add
label define occ90ly_lbl 525 `"Repairers of data processing equipment"', add
label define occ90ly_lbl 526 `"Repairers of household appliances and power tools"', add
label define occ90ly_lbl 527 `"Telecom and line installers and repairers"', add
label define occ90ly_lbl 533 `"Repairers of electrical equipment, n.e.c."', add
label define occ90ly_lbl 534 `"Heating, air conditioning, and refigeration mechanics"', add
label define occ90ly_lbl 535 `"Precision makers, repairers, and smiths"', add
label define occ90ly_lbl 536 `"Locksmiths and safe repairers"', add
label define occ90ly_lbl 538 `"Office machine repairers and mechanics"', add
label define occ90ly_lbl 539 `"Repairers of mechanical controls and valves"', add
label define occ90ly_lbl 543 `"Elevator installers and repairers"', add
label define occ90ly_lbl 544 `"Millwrights"', add
label define occ90ly_lbl 549 `"Mechanics and repairers, n.e.c."', add
label define occ90ly_lbl 558 `"Supervisors of construction work"', add
label define occ90ly_lbl 563 `"Masons, tilers, and carpet installers"', add
label define occ90ly_lbl 567 `"Carpenters"', add
label define occ90ly_lbl 573 `"Drywall installers"', add
label define occ90ly_lbl 575 `"Electricians"', add
label define occ90ly_lbl 577 `"Electric power installers and repairers"', add
label define occ90ly_lbl 579 `"Painters, construction and maintenance"', add
label define occ90ly_lbl 583 `"Paperhangers"', add
label define occ90ly_lbl 584 `"Plasterers"', add
label define occ90ly_lbl 585 `"Plumbers, pipe fitters, and steamfitters"', add
label define occ90ly_lbl 588 `"Concrete and cement workers"', add
label define occ90ly_lbl 589 `"Glaziers"', add
label define occ90ly_lbl 593 `"Insulation workers"', add
label define occ90ly_lbl 594 `"Paving, surfacing, and tamping equipment operators"', add
label define occ90ly_lbl 595 `"Roofers and slaters"', add
label define occ90ly_lbl 596 `"Sheet metal duct installers"', add
label define occ90ly_lbl 597 `"Structural metal workers"', add
label define occ90ly_lbl 598 `"Drillers of earth"', add
label define occ90ly_lbl 599 `"Construction trades, n.e.c."', add
label define occ90ly_lbl 614 `"Drillers of oil wells"', add
label define occ90ly_lbl 615 `"Explosives workers"', add
label define occ90ly_lbl 616 `"Miners"', add
label define occ90ly_lbl 617 `"Other mining occupations"', add
label define occ90ly_lbl 628 `"Production supervisors or foremen"', add
label define occ90ly_lbl 634 `"Tool and die makers and die setters"', add
label define occ90ly_lbl 637 `"Machinists"', add
label define occ90ly_lbl 643 `"Boilermakers"', add
label define occ90ly_lbl 644 `"Precision grinders and filers"', add
label define occ90ly_lbl 645 `"Patternmakers and model makers"', add
label define occ90ly_lbl 646 `"Lay-out workers"', add
label define occ90ly_lbl 649 `"Engravers"', add
label define occ90ly_lbl 653 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ90ly_lbl 657 `"Cabinetmakers and bench carpenters"', add
label define occ90ly_lbl 658 `"Furniture and wood finishers"', add
label define occ90ly_lbl 659 `"Other precision woodworkers"', add
label define occ90ly_lbl 666 `"Dressmakers and seamstresses"', add
label define occ90ly_lbl 667 `"Tailors"', add
label define occ90ly_lbl 668 `"Upholsterers"', add
label define occ90ly_lbl 669 `"Shoe repairers"', add
label define occ90ly_lbl 674 `"Other precision apparel and fabric workers"', add
label define occ90ly_lbl 675 `"Hand molders and shapers, except jewelers"', add
label define occ90ly_lbl 677 `"Optical goods workers"', add
label define occ90ly_lbl 678 `"Dental laboratory and medical appliance technicians"', add
label define occ90ly_lbl 679 `"Bookbinders"', add
label define occ90ly_lbl 684 `"Other precision and craft workers"', add
label define occ90ly_lbl 686 `"Butchers and meat cutters"', add
label define occ90ly_lbl 687 `"Bakers"', add
label define occ90ly_lbl 688 `"Batch food makers"', add
label define occ90ly_lbl 693 `"Adjusters and calibrators"', add
label define occ90ly_lbl 694 `"Water and sewage treatment plant operators"', add
label define occ90ly_lbl 695 `"Power plant operators"', add
label define occ90ly_lbl 696 `"Plant and system operators, stationary engineers"', add
label define occ90ly_lbl 699 `"Other plant and system operators"', add
label define occ90ly_lbl 703 `"Lathe, milling, and turning machine operatives"', add
label define occ90ly_lbl 706 `"Punching and stamping press operatives"', add
label define occ90ly_lbl 707 `"Rollers, roll hands, and finishers of metal"', add
label define occ90ly_lbl 708 `"Drilling and boring machine operators"', add
label define occ90ly_lbl 709 `"Grinding, abrading, buffing, and polishing workers"', add
label define occ90ly_lbl 713 `"Forge and hammer operators"', add
label define occ90ly_lbl 717 `"Fabricating machine operators, n.e.c."', add
label define occ90ly_lbl 719 `"Molders, and casting machine operators"', add
label define occ90ly_lbl 723 `"Metal platers"', add
label define occ90ly_lbl 724 `"Heat treating equipment operators"', add
label define occ90ly_lbl 726 `"Wood lathe, routing, and planing machine operators"', add
label define occ90ly_lbl 727 `"Sawing machine operators and sawyers"', add
label define occ90ly_lbl 728 `"Shaping and joining machine operator (woodworking)"', add
label define occ90ly_lbl 729 `"Nail and tacking machine operators  (woodworking)"', add
label define occ90ly_lbl 733 `"Other woodworking machine operators"', add
label define occ90ly_lbl 734 `"Printing machine operators, n.e.c."', add
label define occ90ly_lbl 735 `"Photoengravers and lithographers"', add
label define occ90ly_lbl 736 `"Typesetters and compositors"', add
label define occ90ly_lbl 738 `"Winding and twisting textile/apparel operatives"', add
label define occ90ly_lbl 739 `"Knitters, loopers, and toppers textile operatives"', add
label define occ90ly_lbl 743 `"Textile cutting machine operators"', add
label define occ90ly_lbl 744 `"Textile sewing machine operators"', add
label define occ90ly_lbl 745 `"Shoemaking machine operators"', add
label define occ90ly_lbl 747 `"Pressing machine operators (clothing)"', add
label define occ90ly_lbl 748 `"Laundry workers"', add
label define occ90ly_lbl 749 `"Misc textile machine operators"', add
label define occ90ly_lbl 753 `"Cementing and gluing maching operators"', add
label define occ90ly_lbl 754 `"Packers, fillers, and wrappers"', add
label define occ90ly_lbl 755 `"Extruding and forming machine operators"', add
label define occ90ly_lbl 756 `"Mixing and blending machine operatives"', add
label define occ90ly_lbl 757 `"Separating, filtering, and clarifying machine operators"', add
label define occ90ly_lbl 759 `"Painting machine operators"', add
label define occ90ly_lbl 763 `"Roasting and baking machine operators (food)"', add
label define occ90ly_lbl 764 `"Washing, cleaning, and pickling machine operators"', add
label define occ90ly_lbl 765 `"Paper folding machine operators"', add
label define occ90ly_lbl 766 `"Furnace, kiln, and oven operators, apart from food"', add
label define occ90ly_lbl 768 `"Crushing and grinding machine operators"', add
label define occ90ly_lbl 769 `"Slicing and cutting machine operators"', add
label define occ90ly_lbl 773 `"Motion picture projectionists"', add
label define occ90ly_lbl 774 `"Photographic process workers"', add
label define occ90ly_lbl 779 `"Machine operators, n.e.c."', add
label define occ90ly_lbl 783 `"Welders and metal cutters"', add
label define occ90ly_lbl 784 `"Solderers"', add
label define occ90ly_lbl 785 `"Assemblers of electrical equipment"', add
label define occ90ly_lbl 789 `"Hand painting, coating, and decorating occupations"', add
label define occ90ly_lbl 796 `"Production checkers and inspectors"', add
label define occ90ly_lbl 799 `"Graders and sorters in manufacturing"', add
label define occ90ly_lbl 803 `"Supervisors of motor vehicle transportation"', add
label define occ90ly_lbl 804 `"Truck, delivery, and tractor drivers"', add
label define occ90ly_lbl 808 `"Bus drivers"', add
label define occ90ly_lbl 809 `"Taxi cab drivers and chauffeurs"', add
label define occ90ly_lbl 813 `"Parking lot attendants"', add
label define occ90ly_lbl 815 `"Transport equipment operatives--allocated (1990 internal census)"', add
label define occ90ly_lbl 823 `"Railroad conductors and yardmasters"', add
label define occ90ly_lbl 824 `"Locomotive operators (engineers and firemen)"', add
label define occ90ly_lbl 825 `"Railroad brake, coupler, and switch operators"', add
label define occ90ly_lbl 829 `"Ship crews and marine engineers"', add
label define occ90ly_lbl 834 `"Water transport infrastructure tenders and crossing guards"', add
label define occ90ly_lbl 844 `"Operating engineers of construction equipment"', add
label define occ90ly_lbl 848 `"Crane, derrick, winch, and hoist operators"', add
label define occ90ly_lbl 853 `"Excavating and loading machine operators"', add
label define occ90ly_lbl 859 `"Misc material moving occupations"', add
label define occ90ly_lbl 865 `"Helpers, constructions"', add
label define occ90ly_lbl 866 `"Helpers, surveyors"', add
label define occ90ly_lbl 869 `"Construction laborers"', add
label define occ90ly_lbl 874 `"Production helpers"', add
label define occ90ly_lbl 875 `"Garbage and recyclable material collectors"', add
label define occ90ly_lbl 876 `"Materials movers: stevedores and longshore workers"', add
label define occ90ly_lbl 877 `"Stock handlers"', add
label define occ90ly_lbl 878 `"Machine feeders and offbearers"', add
label define occ90ly_lbl 883 `"Freight, stock, and materials handlers"', add
label define occ90ly_lbl 885 `"Garage and service station related occupations"', add
label define occ90ly_lbl 887 `"Vehicle washers and equipment cleaners"', add
label define occ90ly_lbl 888 `"Packers and packagers by hand"', add
label define occ90ly_lbl 889 `"Laborers outside construction"', add
label define occ90ly_lbl 890 `"Laborers, except farm--allocated (1990 internal census)"', add
label define occ90ly_lbl 905 `"Military"', add
label define occ90ly_lbl 991 `"Unemployed"', add
label define occ90ly_lbl 999 `"NIU"', add
label values occ90ly occ90ly_lbl

label define ind90ly_lbl 000 `"NIU"'
label define ind90ly_lbl 010 `"Agricultural production, crops"', add
label define ind90ly_lbl 011 `"Agricultural production, livestock"', add
label define ind90ly_lbl 012 `"Veterinary services"', add
label define ind90ly_lbl 020 `"Landscape and horticultural services"', add
label define ind90ly_lbl 030 `"Agricultural services, n.e.c."', add
label define ind90ly_lbl 031 `"Forestry"', add
label define ind90ly_lbl 032 `"Fishing, hunting, and trapping"', add
label define ind90ly_lbl 040 `"Metal mining"', add
label define ind90ly_lbl 041 `"Coal mining"', add
label define ind90ly_lbl 042 `"Oil and gas extraction"', add
label define ind90ly_lbl 050 `"Nonmetallic mining and quarrying, except fuels"', add
label define ind90ly_lbl 060 `"All construction"', add
label define ind90ly_lbl 100 `"Meat products"', add
label define ind90ly_lbl 101 `"Dairy products"', add
label define ind90ly_lbl 102 `"Canned, frozen, and preserved fruits and vegetables"', add
label define ind90ly_lbl 110 `"Grain mill products"', add
label define ind90ly_lbl 111 `"Bakery products"', add
label define ind90ly_lbl 112 `"Sugar and confectionery products"', add
label define ind90ly_lbl 120 `"Beverage industries"', add
label define ind90ly_lbl 121 `"Misc. food preparations and kindred products"', add
label define ind90ly_lbl 122 `"Food industries, n.s."', add
label define ind90ly_lbl 130 `"Tobacco manufactures"', add
label define ind90ly_lbl 132 `"Knitting mills"', add
label define ind90ly_lbl 140 `"Dyeing and finishing textiles, except wool and knit goods"', add
label define ind90ly_lbl 141 `"Carpets and rugs"', add
label define ind90ly_lbl 142 `"Yarn, thread, and fabric mills"', add
label define ind90ly_lbl 150 `"Miscellaneous textile mill products"', add
label define ind90ly_lbl 151 `"Apparel and accessories, except knit"', add
label define ind90ly_lbl 152 `"Miscellaneous fabricated textile products"', add
label define ind90ly_lbl 160 `"Pulp, paper, and paperboard mills"', add
label define ind90ly_lbl 161 `"Miscellaneous paper and pulp products"', add
label define ind90ly_lbl 162 `"Paperboard containers and boxes"', add
label define ind90ly_lbl 171 `"Newspaper publishing and printing"', add
label define ind90ly_lbl 172 `"Printing, publishing, and allied industries, except newspapers"', add
label define ind90ly_lbl 180 `"Plastics, synthetics, and resins"', add
label define ind90ly_lbl 181 `"Drugs"', add
label define ind90ly_lbl 182 `"Soaps and cosmetics"', add
label define ind90ly_lbl 190 `"Paints, varnishes, and related products"', add
label define ind90ly_lbl 191 `"Agricultural chemicals"', add
label define ind90ly_lbl 192 `"Industrial and miscellaneous chemicals"', add
label define ind90ly_lbl 200 `"Petroleum refining"', add
label define ind90ly_lbl 201 `"Miscellaneous petroleum and coal products"', add
label define ind90ly_lbl 210 `"Tires and inner tubes"', add
label define ind90ly_lbl 211 `"Other rubber products, and plastics footwear and belting"', add
label define ind90ly_lbl 212 `"Miscellaneous plastics products"', add
label define ind90ly_lbl 220 `"Leather tanning and finishing"', add
label define ind90ly_lbl 221 `"Footwear, except rubber and plastic"', add
label define ind90ly_lbl 222 `"Leather products, except footwear"', add
label define ind90ly_lbl 229 `"Manufacturing, non-durable - allocated"', add
label define ind90ly_lbl 230 `"Logging"', add
label define ind90ly_lbl 231 `"Sawmills, planing mills, and millwork"', add
label define ind90ly_lbl 232 `"Wood buildings and mobile homes"', add
label define ind90ly_lbl 241 `"Miscellaneous wood products"', add
label define ind90ly_lbl 242 `"Furniture and fixtures"', add
label define ind90ly_lbl 250 `"Glass and glass products"', add
label define ind90ly_lbl 251 `"Cement, concrete, gypsum, and plaster products"', add
label define ind90ly_lbl 252 `"Structural clay products"', add
label define ind90ly_lbl 261 `"Pottery and related products"', add
label define ind90ly_lbl 262 `"Misc. nonmetallic mineral and stone products"', add
label define ind90ly_lbl 270 `"Blast furnaces, steelworks, rolling and finishing mills"', add
label define ind90ly_lbl 271 `"Iron and steel foundries"', add
label define ind90ly_lbl 272 `"Primary aluminum industries"', add
label define ind90ly_lbl 280 `"Other primary metal industries"', add
label define ind90ly_lbl 281 `"Cutlery, handtools, and general hardware"', add
label define ind90ly_lbl 282 `"Fabricated structural metal products"', add
label define ind90ly_lbl 290 `"Screw machine products"', add
label define ind90ly_lbl 291 `"Metal forgings and stampings"', add
label define ind90ly_lbl 292 `"Ordnance"', add
label define ind90ly_lbl 300 `"Miscellaneous fabricated metal products"', add
label define ind90ly_lbl 301 `"Metal industries, n.s."', add
label define ind90ly_lbl 310 `"Engines and turbines"', add
label define ind90ly_lbl 311 `"Farm machinery and equipment"', add
label define ind90ly_lbl 312 `"Construction and material handling machines"', add
label define ind90ly_lbl 320 `"Metalworking machinery"', add
label define ind90ly_lbl 321 `"Office and accounting machines"', add
label define ind90ly_lbl 322 `"Computers and related equipment"', add
label define ind90ly_lbl 331 `"Machinery, except electrical, n.e.c."', add
label define ind90ly_lbl 332 `"Machinery, n.s."', add
label define ind90ly_lbl 340 `"Household appliances"', add
label define ind90ly_lbl 341 `"Radio, TV, and communication equipment"', add
label define ind90ly_lbl 342 `"Electrical machinery, equipment, and supplies, n.e.c."', add
label define ind90ly_lbl 350 `"Electrical machinery, equipment, and supplies, n.s."', add
label define ind90ly_lbl 351 `"Motor vehicles and motor vehicle equipment"', add
label define ind90ly_lbl 352 `"Aircraft and parts"', add
label define ind90ly_lbl 360 `"Ship and boat building and repairing"', add
label define ind90ly_lbl 361 `"Railroad locomotives and equipment"', add
label define ind90ly_lbl 362 `"Guided missiles, space vehicles, and parts"', add
label define ind90ly_lbl 370 `"Cycles and miscellaneous transportation equipment"', add
label define ind90ly_lbl 371 `"Scientific and controlling instruments"', add
label define ind90ly_lbl 372 `"Medical, dental, and optical instruments and supplies"', add
label define ind90ly_lbl 380 `"Photographic equipment and supplies"', add
label define ind90ly_lbl 381 `"Watches, clocks, and clockwork operated devices"', add
label define ind90ly_lbl 390 `"Toys, amusement, and sporting goods"', add
label define ind90ly_lbl 391 `"Miscellaneous manufacturing industries"', add
label define ind90ly_lbl 392 `"Manufacturing industries, n.s."', add
label define ind90ly_lbl 400 `"Railroads"', add
label define ind90ly_lbl 401 `"Bus service and urban transit"', add
label define ind90ly_lbl 402 `"Taxicab service"', add
label define ind90ly_lbl 410 `"Trucking service"', add
label define ind90ly_lbl 411 `"Warehousing and storage"', add
label define ind90ly_lbl 412 `"U.S. Postal Service"', add
label define ind90ly_lbl 420 `"Water transportation"', add
label define ind90ly_lbl 421 `"Air transportation"', add
label define ind90ly_lbl 422 `"Pipe lines, except natural gas"', add
label define ind90ly_lbl 432 `"Services incidental to transportation"', add
label define ind90ly_lbl 440 `"Radio and television broadcasting and cable"', add
label define ind90ly_lbl 441 `"Wired communications"', add
label define ind90ly_lbl 442 `"Telegraph and miscellaneous communications services"', add
label define ind90ly_lbl 450 `"Electric light and power"', add
label define ind90ly_lbl 451 `"Gas and steam supply systems"', add
label define ind90ly_lbl 452 `"Electric and gas, and other combinations"', add
label define ind90ly_lbl 470 `"Water supply and irrigation"', add
label define ind90ly_lbl 471 `"Sanitary services"', add
label define ind90ly_lbl 472 `"Utilities, n.s."', add
label define ind90ly_lbl 500 `"Motor vehicles and equipment"', add
label define ind90ly_lbl 501 `"Furniture and home furnishings"', add
label define ind90ly_lbl 502 `"Lumber and construction materials"', add
label define ind90ly_lbl 510 `"Professional and commercial equipment and supplies"', add
label define ind90ly_lbl 511 `"Metals and minerals, except petroleum"', add
label define ind90ly_lbl 512 `"Electrical goods"', add
label define ind90ly_lbl 521 `"Hardware, plumbing and heating supplies"', add
label define ind90ly_lbl 530 `"Machinery, equipment, and supplies"', add
label define ind90ly_lbl 531 `"Scrap and waste materials"', add
label define ind90ly_lbl 532 `"Miscellaneous wholesale, durable goods"', add
label define ind90ly_lbl 540 `"Paper and paper products"', add
label define ind90ly_lbl 541 `"Drugs, chemicals, and allied products"', add
label define ind90ly_lbl 542 `"Apparel, fabrics, and notions"', add
label define ind90ly_lbl 550 `"Groceries and related products"', add
label define ind90ly_lbl 551 `"Farm-product raw materials"', add
label define ind90ly_lbl 552 `"Petroleum products"', add
label define ind90ly_lbl 560 `"Alcoholic beverages"', add
label define ind90ly_lbl 561 `"Farm supplies"', add
label define ind90ly_lbl 562 `"Miscellaneous wholesale, nondurable goods"', add
label define ind90ly_lbl 571 `"Wholesale trade, n.s."', add
label define ind90ly_lbl 580 `"Lumber and building material retailing"', add
label define ind90ly_lbl 581 `"Hardware stores"', add
label define ind90ly_lbl 582 `"Retail nurseries and garden stores"', add
label define ind90ly_lbl 590 `"Mobile home dealers"', add
label define ind90ly_lbl 591 `"Department stores"', add
label define ind90ly_lbl 592 `"Variety stores"', add
label define ind90ly_lbl 600 `"Miscellaneous general merchandise stores"', add
label define ind90ly_lbl 601 `"Grocery stores"', add
label define ind90ly_lbl 602 `"Dairy products stores"', add
label define ind90ly_lbl 610 `"Retail bakeries"', add
label define ind90ly_lbl 611 `"Food stores, n.e.c."', add
label define ind90ly_lbl 612 `"Motor vehicle dealers"', add
label define ind90ly_lbl 620 `"Auto and home supply stores"', add
label define ind90ly_lbl 621 `"Gasoline service stations"', add
label define ind90ly_lbl 622 `"Miscellaneous vehicle dealers"', add
label define ind90ly_lbl 623 `"Apparel and accessory stores, except shoe"', add
label define ind90ly_lbl 630 `"Shoe stores"', add
label define ind90ly_lbl 631 `"Furniture and home furnishings stores"', add
label define ind90ly_lbl 632 `"Household appliance stores"', add
label define ind90ly_lbl 633 `"Radio, TV, and computer stores"', add
label define ind90ly_lbl 640 `"Music stores"', add
label define ind90ly_lbl 641 `"Eating and drinking places"', add
label define ind90ly_lbl 642 `"Drug stores"', add
label define ind90ly_lbl 650 `"Liquor stores"', add
label define ind90ly_lbl 651 `"Sporting goods, bicycles, and hobby stores"', add
label define ind90ly_lbl 652 `"Book and stationery stores"', add
label define ind90ly_lbl 660 `"Jewelry stores"', add
label define ind90ly_lbl 661 `"Gift, novelty, and souvenir shops"', add
label define ind90ly_lbl 662 `"Sewing, needlework, and piece goods stores"', add
label define ind90ly_lbl 663 `"Catalog and mail order houses"', add
label define ind90ly_lbl 670 `"Vending machine operators"', add
label define ind90ly_lbl 671 `"Direct selling establishments"', add
label define ind90ly_lbl 672 `"Fuel dealers"', add
label define ind90ly_lbl 681 `"Retail florists"', add
label define ind90ly_lbl 682 `"Miscellaneous retail stores"', add
label define ind90ly_lbl 691 `"Retail trade, n.s."', add
label define ind90ly_lbl 700 `"Banking"', add
label define ind90ly_lbl 701 `"Savings institutions, including credit unions"', add
label define ind90ly_lbl 702 `"Credit agencies, n.e.c."', add
label define ind90ly_lbl 710 `"Security, commodity brokerage, and investment companies"', add
label define ind90ly_lbl 711 `"Insurance"', add
label define ind90ly_lbl 712 `"Real estate, including real estate-insurance offices"', add
label define ind90ly_lbl 721 `"Advertising"', add
label define ind90ly_lbl 722 `"Services to dwellings and other buildings"', add
label define ind90ly_lbl 731 `"Personnel supply services"', add
label define ind90ly_lbl 732 `"Computer and data processing services"', add
label define ind90ly_lbl 740 `"Detective and protective services"', add
label define ind90ly_lbl 741 `"Business services, n.e.c."', add
label define ind90ly_lbl 742 `"Automotive rental and leasing, without drivers"', add
label define ind90ly_lbl 750 `"Automobile parking and carwashes"', add
label define ind90ly_lbl 751 `"Automotive repair and related services"', add
label define ind90ly_lbl 752 `"Electrical repair shops"', add
label define ind90ly_lbl 760 `"Miscellaneous repair services"', add
label define ind90ly_lbl 761 `"Private households"', add
label define ind90ly_lbl 762 `"Hotels and motels"', add
label define ind90ly_lbl 770 `"Lodging places, except hotels and motels"', add
label define ind90ly_lbl 771 `"Laundry, cleaning, and garment services"', add
label define ind90ly_lbl 772 `"Beauty shops"', add
label define ind90ly_lbl 780 `"Barber shops"', add
label define ind90ly_lbl 781 `"Funeral service and crematories"', add
label define ind90ly_lbl 782 `"Shoe repair shops"', add
label define ind90ly_lbl 790 `"Dressmaking shops"', add
label define ind90ly_lbl 791 `"Miscellaneous personal services"', add
label define ind90ly_lbl 800 `"Theaters and motion pictures"', add
label define ind90ly_lbl 801 `"Video tape rental"', add
label define ind90ly_lbl 802 `"Bowling centers"', add
label define ind90ly_lbl 810 `"Miscellaneous entertainment and recreation services"', add
label define ind90ly_lbl 812 `"Offices and clinics of physicians"', add
label define ind90ly_lbl 820 `"Offices and clinics of dentists"', add
label define ind90ly_lbl 821 `"Offices and clinics of chiropractors"', add
label define ind90ly_lbl 822 `"Offices and clinics of optometrists"', add
label define ind90ly_lbl 830 `"Offices and clinics of health practitioners, n.e.c."', add
label define ind90ly_lbl 831 `"Hospitals"', add
label define ind90ly_lbl 832 `"Nursing and personal care facilities"', add
label define ind90ly_lbl 840 `"Health services, n.e.c."', add
label define ind90ly_lbl 841 `"Legal services"', add
label define ind90ly_lbl 842 `"Elementary and secondary schools"', add
label define ind90ly_lbl 850 `"Colleges and universities"', add
label define ind90ly_lbl 851 `"Vocational schools"', add
label define ind90ly_lbl 852 `"Libraries"', add
label define ind90ly_lbl 860 `"Educational services, n.e.c."', add
label define ind90ly_lbl 861 `"Job training and vocational rehabilitation services"', add
label define ind90ly_lbl 862 `"Child day care services"', add
label define ind90ly_lbl 863 `"Family child care homes"', add
label define ind90ly_lbl 870 `"Residential care facilities, without nursing"', add
label define ind90ly_lbl 871 `"Social services, n.e.c."', add
label define ind90ly_lbl 872 `"Museums, art galleries, and zoos"', add
label define ind90ly_lbl 873 `"Labor unions"', add
label define ind90ly_lbl 880 `"Religious organizations"', add
label define ind90ly_lbl 881 `"Membership organizations, n.e.c."', add
label define ind90ly_lbl 882 `"Engineering, architectural, and surveying services"', add
label define ind90ly_lbl 890 `"Accounting, auditing, and bookkeeping services"', add
label define ind90ly_lbl 891 `"Research, development, and testing services"', add
label define ind90ly_lbl 892 `"Management and public relations services"', add
label define ind90ly_lbl 893 `"Miscellaneous professional and related services"', add
label define ind90ly_lbl 900 `"Executive and legislative offices"', add
label define ind90ly_lbl 901 `"General government, n.e.c."', add
label define ind90ly_lbl 910 `"Justice, public order, and safety"', add
label define ind90ly_lbl 921 `"Public finance, taxation, and monetary policy"', add
label define ind90ly_lbl 922 `"Administration of human resources programs"', add
label define ind90ly_lbl 930 `"Administration of environmental quality and housing programs"', add
label define ind90ly_lbl 931 `"Administration of economic programs"', add
label define ind90ly_lbl 932 `"National security and international affairs"', add
label define ind90ly_lbl 940 `"Army"', add
label define ind90ly_lbl 941 `"Air Force"', add
label define ind90ly_lbl 942 `"Navy"', add
label define ind90ly_lbl 950 `"Marines"', add
label define ind90ly_lbl 951 `"Coast Guard"', add
label define ind90ly_lbl 952 `"Armed Forces, branch not specified"', add
label define ind90ly_lbl 960 `"Military Reserves or National Guard"', add
label define ind90ly_lbl 998 `"Unknown"', add
label values ind90ly ind90ly_lbl

label define occ10ly_lbl 0010 `"Chief executives and legislators"'
label define occ10ly_lbl 0020 `"General and Operations Managers"', add
label define occ10ly_lbl 0040 `"Advertising and Promotions Managers"', add
label define occ10ly_lbl 0050 `"Marketing and Sales Managers"', add
label define occ10ly_lbl 0060 `"Public Relations and Fundraising Managers"', add
label define occ10ly_lbl 0100 `"Administrative Services Managers"', add
label define occ10ly_lbl 0110 `"Computer and Information Systems Managers"', add
label define occ10ly_lbl 0120 `"Financial Managers"', add
label define occ10ly_lbl 0135 `"Compensation and benefits managers"', add
label define occ10ly_lbl 0136 `"Human Resources Managers"', add
label define occ10ly_lbl 0137 `"Training and development managers"', add
label define occ10ly_lbl 0140 `"Industrial Production Managers"', add
label define occ10ly_lbl 0150 `"Purchasing Managers"', add
label define occ10ly_lbl 0160 `"Transportation, Storage, and Distribution Managers"', add
label define occ10ly_lbl 0205 `"Farmers, Ranchers, and Other Agricultural Managers"', add
label define occ10ly_lbl 0220 `"Construction Managers"', add
label define occ10ly_lbl 0230 `"Education Administrators"', add
label define occ10ly_lbl 0300 `"Architectural and Engineering Managers"', add
label define occ10ly_lbl 0310 `"Food Service Managers"', add
label define occ10ly_lbl 0330 `"Gaming Managers"', add
label define occ10ly_lbl 0340 `"Lodging Managers"', add
label define occ10ly_lbl 0350 `"Medical and Health Services Managers"', add
label define occ10ly_lbl 0360 `"Natural Sciences Managers"', add
label define occ10ly_lbl 0410 `"Property, Real Estate, and Community Association Managers"', add
label define occ10ly_lbl 0420 `"Social and Community Service Managers"', add
label define occ10ly_lbl 0425 `"Emergency management directors"', add
label define occ10ly_lbl 0430 `"Miscellaneous managers, including funeral service managers and postmasters and mail superintendents"', add
label define occ10ly_lbl 0500 `"Agents and Business Managers of Artists, Performers, and Athletes"', add
label define occ10ly_lbl 0510 `"Buyers and Purchasing Agents, Farm Products"', add
label define occ10ly_lbl 0520 `"Wholesale and Retail Buyers, Except Farm Products"', add
label define occ10ly_lbl 0530 `"Purchasing Agents, Except Wholesale, Retail, and Farm Products"', add
label define occ10ly_lbl 0540 `"Claims Adjusters, Appraisers, Examiners, and Investigators"', add
label define occ10ly_lbl 0565 `"Compliance Officers"', add
label define occ10ly_lbl 0600 `"Cost Estimators"', add
label define occ10ly_lbl 0630 `"Human Resources Workers"', add
label define occ10ly_lbl 0640 `"Compensation, benefits, and job analysis specialists"', add
label define occ10ly_lbl 0650 `"Training and development specialists"', add
label define occ10ly_lbl 0700 `"Logisticians"', add
label define occ10ly_lbl 0710 `"Management Analysts"', add
label define occ10ly_lbl 0725 `"Meeting, Convention, and Event Planners"', add
label define occ10ly_lbl 0726 `"Fundraisers"', add
label define occ10ly_lbl 0735 `"Market Research Analysts and Marketing Specialists"', add
label define occ10ly_lbl 0740 `"Business Operations Specialists, All Other"', add
label define occ10ly_lbl 0800 `"Accountants and Auditors"', add
label define occ10ly_lbl 0810 `"Appraisers and Assessors of Real Estate"', add
label define occ10ly_lbl 0820 `"Budget Analysts"', add
label define occ10ly_lbl 0830 `"Credit Analysts"', add
label define occ10ly_lbl 0840 `"Financial Analysts"', add
label define occ10ly_lbl 0850 `"Personal Financial Advisors"', add
label define occ10ly_lbl 0860 `"Insurance Underwriters"', add
label define occ10ly_lbl 0900 `"Financial Examiners"', add
label define occ10ly_lbl 0910 `"Credit Counselors and Loan Officers"', add
label define occ10ly_lbl 0930 `"Tax Examiners and Collectors, and Revenue Agents"', add
label define occ10ly_lbl 0940 `"Tax Preparers"', add
label define occ10ly_lbl 0950 `"Financial Specialists, All Other"', add
label define occ10ly_lbl 1005 `"Computer and information research scientists"', add
label define occ10ly_lbl 1006 `"Computer Systems Analysts"', add
label define occ10ly_lbl 1007 `"Information security analysts"', add
label define occ10ly_lbl 1010 `"Computer Programmers"', add
label define occ10ly_lbl 1020 `"Software Developers, Applications and Systems Software"', add
label define occ10ly_lbl 1030 `"Web Developers"', add
label define occ10ly_lbl 1050 `"Computer Support Specialists"', add
label define occ10ly_lbl 1060 `"Database Administrators"', add
label define occ10ly_lbl 1105 `"Network and Computer Systems Administrators"', add
label define occ10ly_lbl 1106 `"Computer network architects"', add
label define occ10ly_lbl 1107 `"Computer occupations, all other"', add
label define occ10ly_lbl 1200 `"Actuaries"', add
label define occ10ly_lbl 1220 `"Operations Research Analysts"', add
label define occ10ly_lbl 1240 `"Miscellaneous mathematical science occupations, including mathematicians and statisticians"', add
label define occ10ly_lbl 1300 `"Architects, Except Naval"', add
label define occ10ly_lbl 1310 `"Surveyors, Cartographers, and Photogrammetrists"', add
label define occ10ly_lbl 1320 `"Aerospace Engineers"', add
label define occ10ly_lbl 1340 `"Biomedical and agricultural engineers"', add
label define occ10ly_lbl 1350 `"Chemical Engineers"', add
label define occ10ly_lbl 1360 `"Civil Engineers"', add
label define occ10ly_lbl 1400 `"Computer Hardware Engineers"', add
label define occ10ly_lbl 1410 `"Electrical and Electronics Engineers"', add
label define occ10ly_lbl 1420 `"Environmental Engineers"', add
label define occ10ly_lbl 1430 `"Industrial Engineers, including Health and Safety"', add
label define occ10ly_lbl 1440 `"Marine Engineers and Naval Architects"', add
label define occ10ly_lbl 1450 `"Materials Engineers"', add
label define occ10ly_lbl 1460 `"Mechanical Engineers"', add
label define occ10ly_lbl 1520 `"Petroleum, mining and geological engineers, including mining safety engineers"', add
label define occ10ly_lbl 1530 `"Miscellaneous engineers, including nuclear engineers"', add
label define occ10ly_lbl 1540 `"Drafters"', add
label define occ10ly_lbl 1550 `"Engineering Technicians, Except Drafters"', add
label define occ10ly_lbl 1560 `"Surveying and Mapping Technicians"', add
label define occ10ly_lbl 1600 `"Agricultural and Food Scientists"', add
label define occ10ly_lbl 1610 `"Biological Scientists"', add
label define occ10ly_lbl 1640 `"Conservation Scientists and Foresters"', add
label define occ10ly_lbl 1650 `"Medical scientists, and life scientists, all other"', add
label define occ10ly_lbl 1700 `"Astronomers and Physicists"', add
label define occ10ly_lbl 1710 `"Atmospheric and Space Scientists"', add
label define occ10ly_lbl 1720 `"Chemists and Materials Scientists"', add
label define occ10ly_lbl 1740 `"Environmental Scientists and Geoscientists"', add
label define occ10ly_lbl 1760 `"Physical Scientists, All Other"', add
label define occ10ly_lbl 1800 `"Economists"', add
label define occ10ly_lbl 1820 `"Psychologists"', add
label define occ10ly_lbl 1840 `"Urban and Regional Planners"', add
label define occ10ly_lbl 1860 `"Miscellaneous social scientists, including survey researchers and sociologists"', add
label define occ10ly_lbl 1900 `"Agricultural and Food Science Technicians"', add
label define occ10ly_lbl 1910 `"Biological Technicians"', add
label define occ10ly_lbl 1920 `"Chemical Technicians"', add
label define occ10ly_lbl 1930 `"Geological and petroleum technicians, and nuclear technicians"', add
label define occ10ly_lbl 1965 `"Miscellaneous life, physical, and social science technicians, including social science research assistants"', add
label define occ10ly_lbl 2000 `"Counselors"', add
label define occ10ly_lbl 2010 `"Social Workers"', add
label define occ10ly_lbl 2015 `"Probation officers and correctional treatment specialists"', add
label define occ10ly_lbl 2016 `"Social and human service assistants"', add
label define occ10ly_lbl 2025 `"Miscellaneous community and social service specialists, including health educators and community health workers"', add
label define occ10ly_lbl 2040 `"Clergy"', add
label define occ10ly_lbl 2050 `"Directors, Religious Activities and Education"', add
label define occ10ly_lbl 2060 `"Religious Workers, All Other"', add
label define occ10ly_lbl 2100 `"Lawyers, and judges, magistrates, and other judicial workers"', add
label define occ10ly_lbl 2105 `"Judicial law clerks"', add
label define occ10ly_lbl 2145 `"Paralegals and Legal Assistants"', add
label define occ10ly_lbl 2160 `"Miscellaneous Legal Support Workers"', add
label define occ10ly_lbl 2200 `"Postsecondary Teachers"', add
label define occ10ly_lbl 2300 `"Preschool and Kindergarten Teachers"', add
label define occ10ly_lbl 2310 `"Elementary and Middle School Teachers"', add
label define occ10ly_lbl 2320 `"Secondary School Teachers"', add
label define occ10ly_lbl 2330 `"Special Education Teachers"', add
label define occ10ly_lbl 2340 `"Other Teachers and Instructors"', add
label define occ10ly_lbl 2400 `"Archivists, Curators, and Museum Technicians"', add
label define occ10ly_lbl 2430 `"Librarians"', add
label define occ10ly_lbl 2440 `"Library Technicians"', add
label define occ10ly_lbl 2540 `"Teacher Assistants"', add
label define occ10ly_lbl 2550 `"Other Education, Training, and Library Workers"', add
label define occ10ly_lbl 2600 `"Artists and Related Workers"', add
label define occ10ly_lbl 2630 `"Designers"', add
label define occ10ly_lbl 2700 `"Actors"', add
label define occ10ly_lbl 2710 `"Producers and Directors"', add
label define occ10ly_lbl 2720 `"Athletes, Coaches, Umpires, and Related Workers"', add
label define occ10ly_lbl 2740 `"Dancers and Choreographers"', add
label define occ10ly_lbl 2750 `"Musicians, Singers, and Related Workers"', add
label define occ10ly_lbl 2760 `"Entertainers and Performers, Sports and Related Workers, All Other"', add
label define occ10ly_lbl 2800 `"Announcers"', add
label define occ10ly_lbl 2810 `"News Analysts, Reporters and Correspondents"', add
label define occ10ly_lbl 2825 `"Public Relations Specialists"', add
label define occ10ly_lbl 2830 `"Editors"', add
label define occ10ly_lbl 2840 `"Technical Writers"', add
label define occ10ly_lbl 2850 `"Writers and Authors"', add
label define occ10ly_lbl 2860 `"Miscellaneous Media and Communication Workers"', add
label define occ10ly_lbl 2900 `"Broadcast and sound engineering technicians and radio operators, and media and communication equipment workers, all other"', add
label define occ10ly_lbl 2910 `"Photographers"', add
label define occ10ly_lbl 2920 `"Television, Video, and Motion Picture Camera Operators and Editors"', add
label define occ10ly_lbl 3000 `"Chiropractors"', add
label define occ10ly_lbl 3010 `"Dentists"', add
label define occ10ly_lbl 3030 `"Dietitians and Nutritionists"', add
label define occ10ly_lbl 3040 `"Optometrists"', add
label define occ10ly_lbl 3050 `"Pharmacists"', add
label define occ10ly_lbl 3060 `"Physicians and Surgeons"', add
label define occ10ly_lbl 3110 `"Physician Assistants"', add
label define occ10ly_lbl 3120 `"Podiatrists"', add
label define occ10ly_lbl 3140 `"Audiologists"', add
label define occ10ly_lbl 3150 `"Occupational Therapists"', add
label define occ10ly_lbl 3160 `"Physical Therapists"', add
label define occ10ly_lbl 3200 `"Radiation Therapists"', add
label define occ10ly_lbl 3210 `"Recreational Therapists"', add
label define occ10ly_lbl 3220 `"Respiratory Therapists"', add
label define occ10ly_lbl 3230 `"Speech-Language Pathologists"', add
label define occ10ly_lbl 3245 `"Other therapists, including exercise physiologists"', add
label define occ10ly_lbl 3250 `"Veterinarians"', add
label define occ10ly_lbl 3255 `"Registered Nurses"', add
label define occ10ly_lbl 3256 `"Nurse anesthetists"', add
label define occ10ly_lbl 3258 `"Nurse practitioners and nurse midwives"', add
label define occ10ly_lbl 3260 `"Health Diagnosing and Treating Practitioners, All Other"', add
label define occ10ly_lbl 3300 `"Clinical Laboratory Technologists and Technicians"', add
label define occ10ly_lbl 3310 `"Dental Hygienists"', add
label define occ10ly_lbl 3320 `"Diagnostic Related Technologists and Technicians"', add
label define occ10ly_lbl 3400 `"Emergency Medical Technicians and Paramedics"', add
label define occ10ly_lbl 3420 `"Health Practitioner Support Technologists and  Technicians"', add
label define occ10ly_lbl 3500 `"Licensed Practical and Licensed Vocational Nurses"', add
label define occ10ly_lbl 3510 `"Medical Records and Health Information Technicians"', add
label define occ10ly_lbl 3520 `"Opticians, Dispensing"', add
label define occ10ly_lbl 3535 `"Miscellaneous Health Technologists and Technicians"', add
label define occ10ly_lbl 3540 `"Other Healthcare Practitioners and Technical Occupations"', add
label define occ10ly_lbl 3600 `"Nursing, Psychiatric, and Home Health Aides"', add
label define occ10ly_lbl 3610 `"Occupational Therapy Assistants and Aides"', add
label define occ10ly_lbl 3620 `"Physical Therapist Assistants and Aides"', add
label define occ10ly_lbl 3630 `"Massage Therapists"', add
label define occ10ly_lbl 3640 `"Dental Assistants"', add
label define occ10ly_lbl 3645 `"Medical Assistants"', add
label define occ10ly_lbl 3646 `"Medical transcriptionists"', add
label define occ10ly_lbl 3647 `"Pharmacy aides"', add
label define occ10ly_lbl 3648 `"Veterinary assistants and laboratory animal caretakers"', add
label define occ10ly_lbl 3649 `"Phlebotomists"', add
label define occ10ly_lbl 3655 `"Healthcare support workers, all other, including medical equipment preparers"', add
label define occ10ly_lbl 3700 `"First-Line Supervisors of Correctional Officers"', add
label define occ10ly_lbl 3710 `"First-Line Supervisors of Police and Detectives"', add
label define occ10ly_lbl 3720 `"First-Line Supervisors of Fire Fighting and Prevention Workers"', add
label define occ10ly_lbl 3730 `"First-Line Supervisors of Protective Service Workers, All Other"', add
label define occ10ly_lbl 3740 `"Firefighters"', add
label define occ10ly_lbl 3750 `"Fire Inspectors"', add
label define occ10ly_lbl 3800 `"Bailiffs, Correctional Officers, and Jailers"', add
label define occ10ly_lbl 3820 `"Detectives and Criminal Investigators"', add
label define occ10ly_lbl 3840 `"Miscellaneous law enforcement workers"', add
label define occ10ly_lbl 3850 `"Police officers"', add
label define occ10ly_lbl 3900 `"Animal Control Workers"', add
label define occ10ly_lbl 3910 `"Private Detectives and Investigators"', add
label define occ10ly_lbl 3930 `"Security Guards and Gaming Surveillance Officers"', add
label define occ10ly_lbl 3940 `"Crossing Guards"', add
label define occ10ly_lbl 3945 `"Transportation security screeners"', add
label define occ10ly_lbl 3955 `"Lifeguards and Other Recreational, and All Other Protective Service Workers"', add
label define occ10ly_lbl 4000 `"Chefs and Head Cooks"', add
label define occ10ly_lbl 4010 `"First-Line Supervisors of Food Preparation and Serving Workers"', add
label define occ10ly_lbl 4020 `"Cooks"', add
label define occ10ly_lbl 4030 `"Food Preparation Workers"', add
label define occ10ly_lbl 4040 `"Bartenders"', add
label define occ10ly_lbl 4050 `"Combined Food Preparation and Serving Workers, Including Fast Food"', add
label define occ10ly_lbl 4060 `"Counter Attendants, Cafeteria, Food Concession, and Coffee Shop"', add
label define occ10ly_lbl 4110 `"Waiters and Waitresses"', add
label define occ10ly_lbl 4120 `"Food Servers, Nonrestaurant"', add
label define occ10ly_lbl 4130 `"Miscellaneous food preparation and serving related workers, including dining room and cafeteria attendants and bartender helpers"', add
label define occ10ly_lbl 4140 `"Dishwashers"', add
label define occ10ly_lbl 4150 `"Hosts and Hostesses, Restaurant, Lounge, and Coffee Shop"', add
label define occ10ly_lbl 4200 `"First-Line Supervisors of Housekeeping and Janitorial Workers"', add
label define occ10ly_lbl 4210 `"First-Line Supervisors of Landscaping, Lawn Service, and Groundskeeping Workers"', add
label define occ10ly_lbl 4220 `"Janitors and Building Cleaners"', add
label define occ10ly_lbl 4230 `"Maids and housekeeping cleaners"', add
label define occ10ly_lbl 4240 `"Pest Control Workers"', add
label define occ10ly_lbl 4250 `"Grounds Maintenance Workers"', add
label define occ10ly_lbl 4300 `"First-Line Supervisors of Gaming Workers"', add
label define occ10ly_lbl 4320 `"First-Line Supervisors of Personal Service Workers"', add
label define occ10ly_lbl 4340 `"Animal Trainers"', add
label define occ10ly_lbl 4350 `"Nonfarm Animal Caretakers"', add
label define occ10ly_lbl 4400 `"Gaming Services Workers"', add
label define occ10ly_lbl 4410 `"Motion Picture Projectionists"', add
label define occ10ly_lbl 4420 `"Ushers, Lobby Attendants, and Ticket Takers"', add
label define occ10ly_lbl 4430 `"Miscellaneous Entertainment Attendants and Related Workers"', add
label define occ10ly_lbl 4460 `"Embalmers and Funeral Attendants"', add
label define occ10ly_lbl 4465 `"Morticians, undertakers, and funeral directors"', add
label define occ10ly_lbl 4500 `"Barbers"', add
label define occ10ly_lbl 4510 `"Hairdressers, Hairstylists, and Cosmetologists"', add
label define occ10ly_lbl 4520 `"Miscellaneous Personal Appearance Workers"', add
label define occ10ly_lbl 4530 `"Baggage Porters, Bellhops, and Concierges"', add
label define occ10ly_lbl 4540 `"Tour and Travel Guides"', add
label define occ10ly_lbl 4600 `"Childcare Workers"', add
label define occ10ly_lbl 4610 `"Personal Care Aides"', add
label define occ10ly_lbl 4620 `"Recreation and Fitness Workers"', add
label define occ10ly_lbl 4640 `"Residential Advisors"', add
label define occ10ly_lbl 4650 `"Personal Care and Service Workers, All Other"', add
label define occ10ly_lbl 4700 `"First-Line Supervisors of Retail Sales Workers"', add
label define occ10ly_lbl 4710 `"First-Line Supervisors of Non-Retail Sales Workers"', add
label define occ10ly_lbl 4720 `"Cashiers"', add
label define occ10ly_lbl 4740 `"Counter and Rental Clerks"', add
label define occ10ly_lbl 4750 `"Parts Salespersons"', add
label define occ10ly_lbl 4760 `"Retail Salespersons"', add
label define occ10ly_lbl 4800 `"Advertising Sales Agents"', add
label define occ10ly_lbl 4810 `"Insurance Sales Agents"', add
label define occ10ly_lbl 4820 `"Securities, Commodities, and Financial Services Sales Agents"', add
label define occ10ly_lbl 4830 `"Travel Agents"', add
label define occ10ly_lbl 4840 `"Sales Representatives, Services, All Other"', add
label define occ10ly_lbl 4850 `"Sales Representatives, Wholesale and Manufacturing"', add
label define occ10ly_lbl 4900 `"Models, Demonstrators, and Product Promoters"', add
label define occ10ly_lbl 4920 `"Real Estate Brokers and Sales Agents"', add
label define occ10ly_lbl 4930 `"Sales Engineers"', add
label define occ10ly_lbl 4940 `"Telemarketers"', add
label define occ10ly_lbl 4950 `"Door-to-Door Sales Workers, News and Street Vendors, and Related Workers"', add
label define occ10ly_lbl 4965 `"Sales and Related Workers, All Other"', add
label define occ10ly_lbl 5000 `"First-Line Supervisors of Office and Administrative Support Workers"', add
label define occ10ly_lbl 5010 `"Switchboard Operators, Including Answering Service"', add
label define occ10ly_lbl 5020 `"Telephone Operators"', add
label define occ10ly_lbl 5030 `"Communications Equipment Operators, All Other"', add
label define occ10ly_lbl 5100 `"Bill and Account Collectors"', add
label define occ10ly_lbl 5110 `"Billing and Posting Clerks"', add
label define occ10ly_lbl 5120 `"Bookkeeping, Accounting, and Auditing Clerks"', add
label define occ10ly_lbl 5130 `"Gaming Cage Workers"', add
label define occ10ly_lbl 5140 `"Payroll and Timekeeping Clerks"', add
label define occ10ly_lbl 5150 `"Procurement Clerks"', add
label define occ10ly_lbl 5160 `"Tellers"', add
label define occ10ly_lbl 5165 `"Financial clerks, all other"', add
label define occ10ly_lbl 5200 `"Brokerage Clerks"', add
label define occ10ly_lbl 5220 `"Court, Municipal, and License Clerks"', add
label define occ10ly_lbl 5230 `"Credit Authorizers, Checkers, and Clerks"', add
label define occ10ly_lbl 5240 `"Customer Service Representatives"', add
label define occ10ly_lbl 5250 `"Eligibility Interviewers, Government Programs"', add
label define occ10ly_lbl 5260 `"File Clerks"', add
label define occ10ly_lbl 5300 `"Hotel, Motel, and Resort Desk Clerks"', add
label define occ10ly_lbl 5310 `"Interviewers, Except Eligibility and Loan"', add
label define occ10ly_lbl 5320 `"Library Assistants, Clerical"', add
label define occ10ly_lbl 5330 `"Loan Interviewers and Clerks"', add
label define occ10ly_lbl 5340 `"New Accounts Clerks"', add
label define occ10ly_lbl 5350 `"Correspondence clerks and order clerks"', add
label define occ10ly_lbl 5360 `"Human resources assistants, except payroll and timekeeping"', add
label define occ10ly_lbl 5400 `"Receptionists and Information Clerks"', add
label define occ10ly_lbl 5410 `"Reservation and Transportation Ticket Agents and Travel Clerks"', add
label define occ10ly_lbl 5420 `"Information and Record Clerks, All Other"', add
label define occ10ly_lbl 5500 `"Cargo and Freight Agents"', add
label define occ10ly_lbl 5510 `"Couriers and Messengers"', add
label define occ10ly_lbl 5520 `"Dispatchers"', add
label define occ10ly_lbl 5530 `"Meter Readers, Utilities"', add
label define occ10ly_lbl 5540 `"Postal Service Clerks"', add
label define occ10ly_lbl 5550 `"Postal Service Mail Carriers"', add
label define occ10ly_lbl 5560 `"Postal Service Mail Sorters, Processors, and Processing Machine Operators"', add
label define occ10ly_lbl 5600 `"Production, Planning, and Expediting Clerks"', add
label define occ10ly_lbl 5610 `"Shipping, Receiving, and Traffic Clerks"', add
label define occ10ly_lbl 5620 `"Stock Clerks and Order Fillers"', add
label define occ10ly_lbl 5630 `"Weighers, Measurers, Checkers, and Samplers, Recordkeeping"', add
label define occ10ly_lbl 5700 `"Secretaries and Administrative Assistants"', add
label define occ10ly_lbl 5800 `"Computer Operators"', add
label define occ10ly_lbl 5810 `"Data Entry Keyers"', add
label define occ10ly_lbl 5820 `"Word Processors and Typists"', add
label define occ10ly_lbl 5840 `"Insurance Claims and Policy Processing Clerks"', add
label define occ10ly_lbl 5850 `"Mail Clerks and Mail Machine Operators, Except Postal Service"', add
label define occ10ly_lbl 5860 `"Office Clerks, General"', add
label define occ10ly_lbl 5900 `"Office Machine Operators, Except Computer"', add
label define occ10ly_lbl 5910 `"Proofreaders and Copy Markers"', add
label define occ10ly_lbl 5920 `"Statistical Assistants"', add
label define occ10ly_lbl 5940 `"Miscellaneous office and administrative support workers, including desktop publishers"', add
label define occ10ly_lbl 6005 `"First-line supervisors of farming, fishing, and forestry workers"', add
label define occ10ly_lbl 6010 `"Agricultural Inspectors"', add
label define occ10ly_lbl 6040 `"Graders and Sorters, Agricultural Products"', add
label define occ10ly_lbl 6050 `"Miscellaneous agricultural workers, including animal breeders"', add
label define occ10ly_lbl 6100 `"Fishing and hunting workers"', add
label define occ10ly_lbl 6120 `"Forest and Conservation Workers"', add
label define occ10ly_lbl 6130 `"Logging Workers"', add
label define occ10ly_lbl 6200 `"First-Line Supervisors of Construction Trades and Extraction Workers"', add
label define occ10ly_lbl 6210 `"Boilermakers"', add
label define occ10ly_lbl 6220 `"Brickmasons, blockmasons, stonemasons, and reinforcing iron and rebar workers"', add
label define occ10ly_lbl 6230 `"Carpenters"', add
label define occ10ly_lbl 6240 `"Carpet, Floor, and Tile Installers and Finishers"', add
label define occ10ly_lbl 6250 `"Cement Masons, Concrete Finishers, and Terrazzo Workers"', add
label define occ10ly_lbl 6260 `"Construction Laborers"', add
label define occ10ly_lbl 6300 `"Paving, Surfacing, and Tamping Equipment Operators"', add
label define occ10ly_lbl 6320 `"Construction equipment operators except paving, surfacing, and tamping equipment operators"', add
label define occ10ly_lbl 6330 `"Drywall Installers, Ceiling Tile Installers, and Tapers"', add
label define occ10ly_lbl 6355 `"Electricians"', add
label define occ10ly_lbl 6360 `"Glaziers"', add
label define occ10ly_lbl 6400 `"Insulation Workers"', add
label define occ10ly_lbl 6420 `"Painters and paperhangers"', add
label define occ10ly_lbl 6440 `"Pipelayers, Plumbers, Pipefitters, and Steamfitters"', add
label define occ10ly_lbl 6460 `"Plasterers and Stucco Masons"', add
label define occ10ly_lbl 6515 `"Roofers"', add
label define occ10ly_lbl 6520 `"Sheet Metal Workers"', add
label define occ10ly_lbl 6530 `"Structural Iron and Steel Workers"', add
label define occ10ly_lbl 6600 `"Helpers, Construction Trades"', add
label define occ10ly_lbl 6660 `"Construction and Building Inspectors"', add
label define occ10ly_lbl 6700 `"Elevator Installers and Repairers"', add
label define occ10ly_lbl 6710 `"Fence Erectors"', add
label define occ10ly_lbl 6720 `"Hazardous Materials Removal Workers"', add
label define occ10ly_lbl 6730 `"Highway Maintenance Workers"', add
label define occ10ly_lbl 6740 `"Rail-Track Laying and Maintenance Equipment Operators"', add
label define occ10ly_lbl 6765 `"Miscellaneous construction workers, including solar photovoltaic installers, septic tank servicers and sewer pipe cleaners"', add
label define occ10ly_lbl 6800 `"Derrick, rotary drill, and service unit operators, and roustabouts, oil, gas, and mining"', add
label define occ10ly_lbl 6820 `"Earth Drillers, Except Oil and Gas"', add
label define occ10ly_lbl 6830 `"Explosives Workers, Ordnance Handling Experts, and Blasters"', add
label define occ10ly_lbl 6840 `"Mining Machine Operators"', add
label define occ10ly_lbl 6940 `"Miscellaneous extraction workers, including roof bolters and helpers"', add
label define occ10ly_lbl 7000 `"First-Line Supervisors of Mechanics, Installers, and Repairers"', add
label define occ10ly_lbl 7010 `"Computer, Automated Teller, and Office Machine Repairers"', add
label define occ10ly_lbl 7020 `"Radio and Telecommunications Equipment Installers and Repairers"', add
label define occ10ly_lbl 7030 `"Avionics Technicians"', add
label define occ10ly_lbl 7040 `"Electric Motor, Power Tool, and Related Repairers"', add
label define occ10ly_lbl 7100 `"Electrical and electronics repairers, transportation equipment, and industrial and utility"', add
label define occ10ly_lbl 7110 `"Electronic Equipment Installers and Repairers, Motor Vehicles"', add
label define occ10ly_lbl 7120 `"Electronic Home Entertainment Equipment Installers and Repairers"', add
label define occ10ly_lbl 7130 `"Security and Fire Alarm Systems Installers"', add
label define occ10ly_lbl 7140 `"Aircraft Mechanics and Service Technicians"', add
label define occ10ly_lbl 7150 `"Automotive Body and Related Repairers"', add
label define occ10ly_lbl 7160 `"Automotive Glass Installers and Repairers"', add
label define occ10ly_lbl 7200 `"Automotive Service Technicians and Mechanics"', add
label define occ10ly_lbl 7210 `"Bus and Truck Mechanics and Diesel Engine Specialists"', add
label define occ10ly_lbl 7220 `"Heavy Vehicle and Mobile Equipment Service Technicians and Mechanics"', add
label define occ10ly_lbl 7240 `"Small Engine Mechanics"', add
label define occ10ly_lbl 7260 `"Miscellaneous Vehicle and Mobile Equipment Mechanics, Installers, and Repairers"', add
label define occ10ly_lbl 7300 `"Control and Valve Installers and Repairers"', add
label define occ10ly_lbl 7315 `"Heating, Air Conditioning, and Refrigeration Mechanics and Installers"', add
label define occ10ly_lbl 7320 `"Home Appliance Repairers"', add
label define occ10ly_lbl 7330 `"Industrial and Refractory Machinery Mechanics"', add
label define occ10ly_lbl 7340 `"Maintenance and Repair Workers, General"', add
label define occ10ly_lbl 7350 `"Maintenance Workers, Machinery"', add
label define occ10ly_lbl 7360 `"Millwrights"', add
label define occ10ly_lbl 7410 `"Electrical Power-Line Installers and Repairers"', add
label define occ10ly_lbl 7420 `"Telecommunications Line Installers and Repairers"', add
label define occ10ly_lbl 7430 `"Precision Instrument and Equipment Repairers"', add
label define occ10ly_lbl 7510 `"Coin, Vending, and Amusement Machine Servicers and Repairers"', add
label define occ10ly_lbl 7540 `"Locksmiths and Safe Repairers"', add
label define occ10ly_lbl 7560 `"Riggers"', add
label define occ10ly_lbl 7610 `"Helpers--Installation, Maintenance, and Repair Workers"', add
label define occ10ly_lbl 7630 `"Miscellaneous installation, maintenance, and repair workers, including wind turbine service technicians"', add
label define occ10ly_lbl 7700 `"First-Line Supervisors of Production and Operating Workers"', add
label define occ10ly_lbl 7710 `"Aircraft Structure, Surfaces, Rigging, and Systems Assemblers"', add
label define occ10ly_lbl 7720 `"Electrical, Electronics, and Electromechanical Assemblers"', add
label define occ10ly_lbl 7730 `"Engine and Other Machine Assemblers"', add
label define occ10ly_lbl 7740 `"Structural Metal Fabricators and Fitters"', add
label define occ10ly_lbl 7750 `"Miscellaneous Assemblers and Fabricators"', add
label define occ10ly_lbl 7800 `"Bakers"', add
label define occ10ly_lbl 7810 `"Butchers and Other Meat, Poultry, and Fish Processing Workers"', add
label define occ10ly_lbl 7830 `"Food and Tobacco Roasting, Baking, and Drying Machine Operators and Tenders"', add
label define occ10ly_lbl 7840 `"Food Batchmakers"', add
label define occ10ly_lbl 7850 `"Food Cooking Machine Operators and Tenders"', add
label define occ10ly_lbl 7855 `"Food processing workers, all other"', add
label define occ10ly_lbl 7900 `"Computer Control Programmers and Operators"', add
label define occ10ly_lbl 7920 `"Extruding and Drawing Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ10ly_lbl 7930 `"Forging Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ10ly_lbl 7940 `"Rolling Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ10ly_lbl 7950 `"Machine tool cutting setters, operators, and tenders, metal and plastic"', add
label define occ10ly_lbl 8030 `"Machinists"', add
label define occ10ly_lbl 8040 `"Metal Furnace Operators, Tenders, Pourers, and Casters"', add
label define occ10ly_lbl 8100 `"Model makers, patternmakers, and molding machine setters, metal and plastic"', add
label define occ10ly_lbl 8130 `"Tool and Die Makers"', add
label define occ10ly_lbl 8140 `"Welding, Soldering, and Brazing Workers"', add
label define occ10ly_lbl 8220 `"Miscellaneous metal workers and plastic workers, including multiple machine tool setters"', add
label define occ10ly_lbl 8250 `"Prepress Technicians and Workers"', add
label define occ10ly_lbl 8255 `"Printing Press Operators"', add
label define occ10ly_lbl 8256 `"Print Binding and Finishing Workers"', add
label define occ10ly_lbl 8300 `"Laundry and Dry-Cleaning Workers"', add
label define occ10ly_lbl 8310 `"Pressers, Textile, Garment, and Related Materials"', add
label define occ10ly_lbl 8320 `"Sewing Machine Operators"', add
label define occ10ly_lbl 8330 `"Shoe and leather workers"', add
label define occ10ly_lbl 8350 `"Tailors, Dressmakers, and Sewers"', add
label define occ10ly_lbl 8400 `"Textile bleaching and dyeing, and cutting machine setters, operators, and tenders"', add
label define occ10ly_lbl 8410 `"Textile Knitting and Weaving Machine Setters, Operators, and Tenders"', add
label define occ10ly_lbl 8420 `"Textile Winding, Twisting, and Drawing Out Machine Setters, Operators, and Tenders"', add
label define occ10ly_lbl 8450 `"Upholsterers"', add
label define occ10ly_lbl 8460 `"Miscellaneous textile, apparel, and furnishings workers except upholsterers"', add
label define occ10ly_lbl 8500 `"Cabinetmakers and Bench Carpenters"', add
label define occ10ly_lbl 8510 `"Furniture Finishers"', add
label define occ10ly_lbl 8530 `"Sawing Machine Setters, Operators, and Tenders, Wood"', add
label define occ10ly_lbl 8540 `"Woodworking Machine Setters, Operators, and Tenders, Except Sawing"', add
label define occ10ly_lbl 8550 `"Miscellaneous woodworkers, including model makers and patternmakers"', add
label define occ10ly_lbl 8600 `"Power Plant Operators, Distributors, and Dispatchers"', add
label define occ10ly_lbl 8610 `"Stationary Engineers and Boiler Operators"', add
label define occ10ly_lbl 8620 `"Water and Wastewater Treatment Plant and System Operators"', add
label define occ10ly_lbl 8630 `"Miscellaneous Plant and System Operators"', add
label define occ10ly_lbl 8640 `"Chemical Processing Machine Setters, Operators, and Tenders"', add
label define occ10ly_lbl 8650 `"Crushing, Grinding, Polishing, Mixing, and Blending Workers"', add
label define occ10ly_lbl 8710 `"Cutting Workers"', add
label define occ10ly_lbl 8720 `"Extruding, Forming, Pressing, and Compacting Machine Setters, Operators, and Tenders"', add
label define occ10ly_lbl 8730 `"Furnace, Kiln, Oven, Drier, and Kettle Operators and Tenders"', add
label define occ10ly_lbl 8740 `"Inspectors, Testers, Sorters, Samplers, and Weighers"', add
label define occ10ly_lbl 8750 `"Jewelers and Precious Stone and Metal Workers"', add
label define occ10ly_lbl 8760 `"Medical, Dental, and Ophthalmic Laboratory Technicians"', add
label define occ10ly_lbl 8800 `"Packaging and Filling Machine Operators and Tenders"', add
label define occ10ly_lbl 8810 `"Painting Workers"', add
label define occ10ly_lbl 8830 `"Photographic Process Workers and Processing Machine Operators"', add
label define occ10ly_lbl 8850 `"Adhesive Bonding Machine Operators and Tenders"', add
label define occ10ly_lbl 8910 `"Etchers and Engravers"', add
label define occ10ly_lbl 8920 `"Molders, Shapers, and Casters, Except Metal and Plastic"', add
label define occ10ly_lbl 8930 `"Paper Goods Machine Setters, Operators, and Tenders"', add
label define occ10ly_lbl 8940 `"Tire Builders"', add
label define occ10ly_lbl 8950 `"Helpers--Production Workers"', add
label define occ10ly_lbl 8965 `"Miscellaneous production workers, including semiconductor processors"', add
label define occ10ly_lbl 9000 `"Supervisors of Transportation and Material Moving Workers"', add
label define occ10ly_lbl 9030 `"Aircraft Pilots and Flight Engineers"', add
label define occ10ly_lbl 9040 `"Air Traffic Controllers and Airfield Operations Specialists"', add
label define occ10ly_lbl 9050 `"Flight Attendants"', add
label define occ10ly_lbl 9110 `"Ambulance Drivers and Attendants, Except Emergency Medical Technicians"', add
label define occ10ly_lbl 9120 `"Bus Drivers"', add
label define occ10ly_lbl 9130 `"Driver/Sales Workers and Truck Drivers"', add
label define occ10ly_lbl 9140 `"Taxi Drivers and Chauffeurs"', add
label define occ10ly_lbl 9150 `"Motor Vehicle Operators, All Other"', add
label define occ10ly_lbl 9200 `"Locomotive Engineers and Operators"', add
label define occ10ly_lbl 9240 `"Railroad Conductors and Yardmasters"', add
label define occ10ly_lbl 9260 `"Subway, streetcar, and other rail transportation workers"', add
label define occ10ly_lbl 9300 `"Sailors and marine oilers, and ship engineers"', add
label define occ10ly_lbl 9310 `"Ship and Boat Captains and Operators"', add
label define occ10ly_lbl 9350 `"Parking Lot Attendants"', add
label define occ10ly_lbl 9360 `"Automotive and Watercraft Service Attendants"', add
label define occ10ly_lbl 9410 `"Transportation Inspectors"', add
label define occ10ly_lbl 9415 `"Transportation attendants, except flight attendants"', add
label define occ10ly_lbl 9420 `"Miscellaneous transportation workers, including bridge and lock tenders and traffic technicians"', add
label define occ10ly_lbl 9510 `"Crane and Tower Operators"', add
label define occ10ly_lbl 9520 `"Dredge, Excavating, and Loading Machine Operators"', add
label define occ10ly_lbl 9560 `"Conveyor operators and tenders, and hoist and winch operators"', add
label define occ10ly_lbl 9600 `"Industrial Truck and Tractor Operators"', add
label define occ10ly_lbl 9610 `"Cleaners of Vehicles and Equipment"', add
label define occ10ly_lbl 9620 `"Laborers and Freight, Stock, and Material Movers, Hand"', add
label define occ10ly_lbl 9630 `"Machine Feeders and Offbearers"', add
label define occ10ly_lbl 9640 `"Packers and Packagers, Hand"', add
label define occ10ly_lbl 9650 `"Pumping Station Operators"', add
label define occ10ly_lbl 9720 `"Refuse and Recyclable Material Collectors"', add
label define occ10ly_lbl 9750 `"Miscellaneous material moving workers, including mine shuttle car operators, and tank car, truck, and ship loaders"', add
label define occ10ly_lbl 9800 `"Military Officer Special and Tactical Operations Leaders"', add
label define occ10ly_lbl 9810 `"First-Line Enlisted Military Supervisors"', add
label define occ10ly_lbl 9820 `"Military Enlisted Tactical Operations and Air/Weapons Specialists and Crew Members"', add
label define occ10ly_lbl 9830 `"Military, Rank Not Specified"', add
label define occ10ly_lbl 9999 `"NIU"', add
label values occ10ly occ10ly_lbl

label define classwly_lbl 00 `"NIU"'
label define classwly_lbl 10 `"Self-employed"', add
label define classwly_lbl 13 `"Self-employed, not incorporated"', add
label define classwly_lbl 14 `"Self-employed, incorporated"', add
label define classwly_lbl 20 `"Works for wages or salary"', add
label define classwly_lbl 22 `"Wage/salary, private"', add
label define classwly_lbl 24 `"Wage/salary, government"', add
label define classwly_lbl 25 `"Federal government employee"', add
label define classwly_lbl 27 `"State government employee"', add
label define classwly_lbl 28 `"Local government employee"', add
label define classwly_lbl 29 `"Unpaid family worker"', add
label define classwly_lbl 99 `"Missing/Unknown"', add
label values classwly classwly_lbl

label define workly_lbl 00 `"NIU"'
label define workly_lbl 01 `"No"', add
label define workly_lbl 02 `"Yes"', add
label values workly workly_lbl

label define wkswork2_lbl 0 `"NIU"'
label define wkswork2_lbl 1 `"1-13 weeks"', add
label define wkswork2_lbl 2 `"14-26 weeks"', add
label define wkswork2_lbl 3 `"27-39 weeks"', add
label define wkswork2_lbl 4 `"40-47 weeks"', add
label define wkswork2_lbl 5 `"48-49 weeks"', add
label define wkswork2_lbl 6 `"50-52 weeks"', add
label define wkswork2_lbl 9 `"Missing data"', add
label values wkswork2 wkswork2_lbl

label define wksunem2_lbl 0 `"None"'
label define wksunem2_lbl 1 `"1-4 weeks"', add
label define wksunem2_lbl 2 `"5-10 weeks"', add
label define wksunem2_lbl 3 `"11-14 weeks"', add
label define wksunem2_lbl 4 `"15-26 weeks"', add
label define wksunem2_lbl 5 `"27-39 weeks"', add
label define wksunem2_lbl 6 `"40+ weeks"', add
label define wksunem2_lbl 7 `"Over 26 weeks (1962-1967)"', add
label define wksunem2_lbl 8 `"Missing/Unknown"', add
label define wksunem2_lbl 9 `"NIU"', add
label values wksunem2 wksunem2_lbl

label define fullpart_lbl 0 `"NIU"'
label define fullpart_lbl 1 `"Full-time"', add
label define fullpart_lbl 2 `"Part-time"', add
label define fullpart_lbl 9 `"Unknown"', add
label values fullpart fullpart_lbl

label define wkxpns_lbl 9999 `"9999"'
label values wkxpns wkxpns_lbl

label define nwlookwk_lbl 00 `"Did not look for work/wasn't on layoff"'
label define nwlookwk_lbl 01 `"1 week"', add
label define nwlookwk_lbl 02 `"2 weeks"', add
label define nwlookwk_lbl 03 `"3 weeks"', add
label define nwlookwk_lbl 04 `"4 weeks"', add
label define nwlookwk_lbl 05 `"5 weeks"', add
label define nwlookwk_lbl 06 `"6 weeks"', add
label define nwlookwk_lbl 07 `"7 weeks"', add
label define nwlookwk_lbl 08 `"8 weeks"', add
label define nwlookwk_lbl 09 `"9 weeks"', add
label define nwlookwk_lbl 10 `"10 weeks"', add
label define nwlookwk_lbl 11 `"11 weeks"', add
label define nwlookwk_lbl 12 `"12 weeks"', add
label define nwlookwk_lbl 13 `"13 weeks"', add
label define nwlookwk_lbl 14 `"14 weeks"', add
label define nwlookwk_lbl 15 `"15 weeks"', add
label define nwlookwk_lbl 16 `"16 weeks"', add
label define nwlookwk_lbl 17 `"17 weeks"', add
label define nwlookwk_lbl 18 `"18 weeks"', add
label define nwlookwk_lbl 19 `"19 weeks"', add
label define nwlookwk_lbl 20 `"20 weeks"', add
label define nwlookwk_lbl 21 `"21 weeks"', add
label define nwlookwk_lbl 22 `"22 weeks"', add
label define nwlookwk_lbl 23 `"23 weeks"', add
label define nwlookwk_lbl 24 `"24 weeks"', add
label define nwlookwk_lbl 25 `"25 weeks"', add
label define nwlookwk_lbl 26 `"26 weeks"', add
label define nwlookwk_lbl 27 `"27 weeks"', add
label define nwlookwk_lbl 28 `"28 weeks"', add
label define nwlookwk_lbl 29 `"29 weeks"', add
label define nwlookwk_lbl 30 `"30 weeks"', add
label define nwlookwk_lbl 31 `"31 weeks"', add
label define nwlookwk_lbl 32 `"32 weeks"', add
label define nwlookwk_lbl 33 `"33 weeks"', add
label define nwlookwk_lbl 34 `"34 weeks"', add
label define nwlookwk_lbl 35 `"35 weeks"', add
label define nwlookwk_lbl 36 `"36 weeks"', add
label define nwlookwk_lbl 37 `"37 weeks"', add
label define nwlookwk_lbl 38 `"38 weeks"', add
label define nwlookwk_lbl 39 `"39 weeks"', add
label define nwlookwk_lbl 40 `"40 weeks"', add
label define nwlookwk_lbl 41 `"41 weeks"', add
label define nwlookwk_lbl 42 `"42 weeks"', add
label define nwlookwk_lbl 43 `"43 weeks"', add
label define nwlookwk_lbl 44 `"44 weeks"', add
label define nwlookwk_lbl 45 `"45 weeks"', add
label define nwlookwk_lbl 46 `"46 weeks"', add
label define nwlookwk_lbl 47 `"47 weeks"', add
label define nwlookwk_lbl 48 `"48 weeks"', add
label define nwlookwk_lbl 49 `"49 weeks"', add
label define nwlookwk_lbl 50 `"50 weeks"', add
label define nwlookwk_lbl 51 `"51 weeks"', add
label define nwlookwk_lbl 52 `"52 weeks"', add
label define nwlookwk_lbl 99 `"NIU"', add
label values nwlookwk nwlookwk_lbl

label define pension_lbl 0 `"NIU"'
label define pension_lbl 1 `"No pension plan at work"', add
label define pension_lbl 2 `"Pension plan at work, but not included"', add
label define pension_lbl 3 `"Included in pension plan at work"', add
label values pension pension_lbl

label define firmsize_lbl 0 `"NIU"'
label define firmsize_lbl 1 `"Under 10"', add
label define firmsize_lbl 2 `"10 to 24"', add
label define firmsize_lbl 3 `"Under 25"', add
label define firmsize_lbl 4 `"10 to 49"', add
label define firmsize_lbl 5 `"25 to 99"', add
label define firmsize_lbl 6 `"50 to 99"', add
label define firmsize_lbl 7 `"100 to 499"', add
label define firmsize_lbl 8 `"500 to 999"', add
label define firmsize_lbl 9 `"1000+"', add
label values firmsize firmsize_lbl

label define wantjob_lbl 0 `"NIU"'
label define wantjob_lbl 1 `"No"', add
label define wantjob_lbl 2 `"Yes"', add
label define wantjob_lbl 3 `"Maybe, it depends"', add
label define wantjob_lbl 4 `"Do not know"', add
label define wantjob_lbl 9 `"Unknown"', add
label values wantjob wantjob_lbl

label define whyptly_lbl 0 `"NIU"'
label define whyptly_lbl 1 `"Could not find full time job"', add
label define whyptly_lbl 2 `"Wanted part time"', add
label define whyptly_lbl 3 `"Slack work"', add
label define whyptly_lbl 4 `"Other"', add
label values whyptly whyptly_lbl

label define usftptlw_lbl 0 `"NIU"'
label define usftptlw_lbl 1 `"No"', add
label define usftptlw_lbl 2 `"Yes"', add
label values usftptlw usftptlw_lbl

label define payifabs_lbl 0 `"NIU"'
label define payifabs_lbl 1 `"Not Paid"', add
label define payifabs_lbl 2 `"Paid"', add
label define payifabs_lbl 3 `"Self-employed"', add
label values payifabs payifabs_lbl

label define wnlwnilf_lbl 00 `"NIU"'
label define wnlwnilf_lbl 10 `"Within past 12 months"', add
label define wnlwnilf_lbl 20 `"More than 12 months ago"', add
label define wnlwnilf_lbl 21 `"1 up to 2 years ago"', add
label define wnlwnilf_lbl 22 `"2 up to 3 years ago"', add
label define wnlwnilf_lbl 23 `"3 up to 4 years ago"', add
label define wnlwnilf_lbl 24 `"4 up to 5 years ago"', add
label define wnlwnilf_lbl 25 `"5 or more years ago"', add
label define wnlwnilf_lbl 30 `"Never worked"', add
label values wnlwnilf wnlwnilf_lbl

label define strechlk_lbl 0 `"NIU"'
label define strechlk_lbl 1 `"1 stretch"', add
label define strechlk_lbl 2 `"More than 1 stretch"', add
label define strechlk_lbl 3 `"2 stretches"', add
label define strechlk_lbl 4 `"3+ stretches"', add
label define strechlk_lbl 9 `"Not specified"', add
label values strechlk strechlk_lbl

label define whynwly_lbl 0 `"NIU"'
label define whynwly_lbl 1 `"Could not find work"', add
label define whynwly_lbl 2 `"Ill or disabled"', add
label define whynwly_lbl 3 `"Taking care of home/family"', add
label define whynwly_lbl 4 `"Going to school"', add
label define whynwly_lbl 5 `"Retired"', add
label define whynwly_lbl 6 `"In Armed Forces"', add
label define whynwly_lbl 7 `"Other"', add
label define whynwly_lbl 9 `"Unknown/missing"', add
label values whynwly whynwly_lbl

label define actnlfly_lbl 00 `"NIU"'
label define actnlfly_lbl 10 `"Ill or disabled"', add
label define actnlfly_lbl 20 `"Taking care of home/family"', add
label define actnlfly_lbl 30 `"Going to school"', add
label define actnlfly_lbl 40 `"Retired"', add
label define actnlfly_lbl 50 `"Other"', add
label define actnlfly_lbl 51 `"Looking for work"', add
label define actnlfly_lbl 52 `"No work available"', add
label define actnlfly_lbl 53 `"Doing unpaid work"', add
label define actnlfly_lbl 54 `"In Armed Forces"', add
label values actnlfly actnlfly_lbl

label define ptweeks_lbl 00 `"NIU"'
label define ptweeks_lbl 01 `"1 week"', add
label define ptweeks_lbl 02 `"2 weeks"', add
label define ptweeks_lbl 03 `"3 weeks"', add
label define ptweeks_lbl 04 `"4 weeks"', add
label define ptweeks_lbl 05 `"5 weeks"', add
label define ptweeks_lbl 06 `"6 weeks"', add
label define ptweeks_lbl 07 `"7 weeks"', add
label define ptweeks_lbl 08 `"8 weeks"', add
label define ptweeks_lbl 09 `"9 weeks"', add
label define ptweeks_lbl 10 `"10 weeks"', add
label define ptweeks_lbl 11 `"11 weeks"', add
label define ptweeks_lbl 12 `"12 weeks"', add
label define ptweeks_lbl 13 `"13 weeks"', add
label define ptweeks_lbl 14 `"14 weeks"', add
label define ptweeks_lbl 15 `"15 weeks"', add
label define ptweeks_lbl 16 `"16 weeks"', add
label define ptweeks_lbl 17 `"17 weeks"', add
label define ptweeks_lbl 18 `"18 weeks"', add
label define ptweeks_lbl 19 `"19 weeks"', add
label define ptweeks_lbl 20 `"20 weeks"', add
label define ptweeks_lbl 21 `"21 weeks"', add
label define ptweeks_lbl 22 `"22 weeks"', add
label define ptweeks_lbl 23 `"23 weeks"', add
label define ptweeks_lbl 24 `"24 weeks"', add
label define ptweeks_lbl 25 `"25 weeks"', add
label define ptweeks_lbl 26 `"26 weeks"', add
label define ptweeks_lbl 27 `"27 weeks"', add
label define ptweeks_lbl 28 `"28 weeks"', add
label define ptweeks_lbl 29 `"29 weeks"', add
label define ptweeks_lbl 30 `"30 weeks"', add
label define ptweeks_lbl 31 `"31 weeks"', add
label define ptweeks_lbl 32 `"32 weeks"', add
label define ptweeks_lbl 33 `"33 weeks"', add
label define ptweeks_lbl 34 `"34 weeks"', add
label define ptweeks_lbl 35 `"35 weeks"', add
label define ptweeks_lbl 36 `"36 weeks"', add
label define ptweeks_lbl 37 `"37 weeks"', add
label define ptweeks_lbl 38 `"38 weeks"', add
label define ptweeks_lbl 39 `"39 weeks"', add
label define ptweeks_lbl 40 `"40 weeks"', add
label define ptweeks_lbl 41 `"41 weeks"', add
label define ptweeks_lbl 42 `"42 weeks"', add
label define ptweeks_lbl 43 `"43 weeks"', add
label define ptweeks_lbl 44 `"44 weeks"', add
label define ptweeks_lbl 45 `"45 weeks"', add
label define ptweeks_lbl 46 `"46 weeks"', add
label define ptweeks_lbl 47 `"47 weeks"', add
label define ptweeks_lbl 48 `"48 weeks"', add
label define ptweeks_lbl 49 `"49 weeks"', add
label define ptweeks_lbl 50 `"50 weeks"', add
label define ptweeks_lbl 51 `"51 weeks"', add
label define ptweeks_lbl 52 `"52 weeks"', add
label values ptweeks ptweeks_lbl

label define inctot_lbl 999999999 `"NIU"'
label define inctot_lbl 999999998 `"Missing"', add
label values inctot inctot_lbl

label define incwage_lbl 99999999 `"NIU"'
label define incwage_lbl 99999998 `"Missing"', add
label values incwage incwage_lbl

label define incbus_lbl 99999999 `"NIU"'
label define incbus_lbl 99999998 `"Missing (1962-1964 only)"', add
label values incbus incbus_lbl

label define incfarm_lbl 99999999 `"NIU"'
label define incfarm_lbl 99999998 `"Missing"', add
label values incfarm incfarm_lbl

label define incwelfr_lbl 999999 `"NIU"'
label values incwelfr incwelfr_lbl

label define incretir_lbl 99999999 `"NIU"'
label values incretir incretir_lbl

label define incint_lbl 9999999 `"NIU"'
label values incint incint_lbl

label define incunemp_lbl 999999 `"NIU"'
label values incunemp incunemp_lbl

label define incsurv_lbl 9999999 `"NIU"'
label values incsurv incsurv_lbl

label define incdisab_lbl 9999999 `"NIU"'
label values incdisab incdisab_lbl

label define incdivid_lbl 9999999 `"NIU"'
label values incdivid incdivid_lbl

label define incrent_lbl 9999999 `"NIU"'
label values incrent incrent_lbl

label define inceduc_lbl 9999999 `"NIU"'
label values inceduc inceduc_lbl

label define incchild_lbl 999999 `"NIU"'
label values incchild incchild_lbl

label define oincbus_lbl 99999999 `"NIU"'
label values oincbus oincbus_lbl

label define oincfarm_lbl 99999999 `"NIU"'
label values oincfarm oincfarm_lbl

label define oincwage_lbl 99999999 `"NIU"'
label values oincwage oincwage_lbl

label define srcreti1_lbl 0 `"NIU"'
label define srcreti1_lbl 1 `"Company or Union  pension"', add
label define srcreti1_lbl 2 `"Federal Government retirement Pension"', add
label define srcreti1_lbl 3 `"US Military retirement pension"', add
label define srcreti1_lbl 4 `"State or local Govt retirement pension"', add
label define srcreti1_lbl 5 `"US Railroad retirement pension"', add
label define srcreti1_lbl 6 `"Regular payments from annuities or paid-up insurance policies"', add
label define srcreti1_lbl 7 `"Regular payments from IRA, KEOGH, or 401K accounts"', add
label define srcreti1_lbl 8 `"Other or don't know"', add
label values srcreti1 srcreti1_lbl

label define srcreti2_lbl 0 `"NIU"'
label define srcreti2_lbl 1 `"Company or Union  pension"', add
label define srcreti2_lbl 2 `"Federal Government retirement Pension"', add
label define srcreti2_lbl 3 `"US Military retirement pension"', add
label define srcreti2_lbl 4 `"State or local Govt retirement pension"', add
label define srcreti2_lbl 5 `"US Railroad retirement pension"', add
label define srcreti2_lbl 6 `"Regular payments from annuities or paid-up insurance policies"', add
label define srcreti2_lbl 7 `"Regular payments from IRA, KEOGH, or 401K accounts"', add
label define srcreti2_lbl 8 `"Other or do not know"', add
label values srcreti2 srcreti2_lbl

label define srcsurv1_lbl 00 `"NIU"'
label define srcsurv1_lbl 01 `"Company or union survivor pension"', add
label define srcsurv1_lbl 02 `"Federal government pension"', add
label define srcsurv1_lbl 03 `"US military retirement survivor pension"', add
label define srcsurv1_lbl 04 `"State or local govt survivor pension"', add
label define srcsurv1_lbl 05 `"US railroad retirement survivor pension"', add
label define srcsurv1_lbl 06 `"Workers compensation pension"', add
label define srcsurv1_lbl 07 `"Black lung survivor pension"', add
label define srcsurv1_lbl 08 `"Regular payments from estates or trusts"', add
label define srcsurv1_lbl 09 `"Regular payments from annuities or paid-up life insurance"', add
label define srcsurv1_lbl 10 `"Other or do not know"', add
label values srcsurv1 srcsurv1_lbl

label define srcsurv2_lbl 00 `"NIU"'
label define srcsurv2_lbl 01 `"Company or union survivor pension"', add
label define srcsurv2_lbl 02 `"Federal government pension"', add
label define srcsurv2_lbl 03 `"US military retirement survivor pension"', add
label define srcsurv2_lbl 04 `"State or local govt survivor pension"', add
label define srcsurv2_lbl 05 `"US railroad retirement survivor pension"', add
label define srcsurv2_lbl 06 `"Workers compensation pension"', add
label define srcsurv2_lbl 07 `"Black lung survivor pension"', add
label define srcsurv2_lbl 08 `"Regular payments from estates or trusts"', add
label define srcsurv2_lbl 09 `"Regular payments from annuities or paid-up life insurance"', add
label define srcsurv2_lbl 10 `"Other or do not know"', add
label values srcsurv2 srcsurv2_lbl

label define incsurv1_lbl 99999999 `"NIU"'
label values incsurv1 incsurv1_lbl

label define incsurv2_lbl 99999999 `"NIU"'
label values incsurv2 incsurv2_lbl

label define srcdisa1_lbl 00 `"NIU"'
label define srcdisa1_lbl 01 `"Workers compensation"', add
label define srcdisa1_lbl 02 `"Company or union disability"', add
label define srcdisa1_lbl 03 `"Federal govt disability"', add
label define srcdisa1_lbl 04 `"US military retirement disability"', add
label define srcdisa1_lbl 05 `"State or local govt employee disability"', add
label define srcdisa1_lbl 06 `"US railroad retirement disability"', add
label define srcdisa1_lbl 07 `"Accident or disability insurance"', add
label define srcdisa1_lbl 08 `"Black lung miners disability"', add
label define srcdisa1_lbl 09 `"State temporary sickness"', add
label define srcdisa1_lbl 10 `"Other or don't know"', add
label values srcdisa1 srcdisa1_lbl

label define srcdisa2_lbl 00 `"NIU"'
label define srcdisa2_lbl 01 `"Workers compensation"', add
label define srcdisa2_lbl 02 `"Company or union disability"', add
label define srcdisa2_lbl 03 `"Federal govt disability"', add
label define srcdisa2_lbl 04 `"US military retirement disability"', add
label define srcdisa2_lbl 05 `"State or local govt employee disability"', add
label define srcdisa2_lbl 06 `"US railroad retirement disability"', add
label define srcdisa2_lbl 07 `"Accident or disability insurance"', add
label define srcdisa2_lbl 08 `"Black lung miners disability"', add
label define srcdisa2_lbl 09 `"State temporary sickness"', add
label define srcdisa2_lbl 10 `"Other or don't know"', add
label values srcdisa2 srcdisa2_lbl

label define incdisa1_lbl 9999999 `"NIU"'
label values incdisa1 incdisa1_lbl

label define incdisa2_lbl 9999999 `"NIU"'
label values incdisa2 incdisa2_lbl

label define srcret1_lbl 01 `"401k account"'
label define srcret1_lbl 02 `"403b account"', add
label define srcret1_lbl 03 `"Roth IRA"', add
label define srcret1_lbl 04 `"Regular IRA"', add
label define srcret1_lbl 05 `"KEOGH plan"', add
label define srcret1_lbl 06 `"Simplified Employee Pension (SEP) plan"', add
label define srcret1_lbl 07 `"Other type of retirement account"', add
label define srcret1_lbl 99 `"NIU"', add
label values srcret1 srcret1_lbl

label define srcret2_lbl 01 `"401k account"'
label define srcret2_lbl 02 `"403b account"', add
label define srcret2_lbl 03 `"Roth IRA"', add
label define srcret2_lbl 04 `"Regular IRA"', add
label define srcret2_lbl 05 `"KEOGH plan"', add
label define srcret2_lbl 06 `"Simplified Employee Pension (SEP) plan"', add
label define srcret2_lbl 07 `"Other type of retirement account"', add
label define srcret2_lbl 99 `"NIU"', add
label values srcret2 srcret2_lbl

label define incret1_lbl 9999999 `"NIU"'
label values incret1 incret1_lbl

label define incret2_lbl 9999999 `"NIU"'
label values incret2 incret2_lbl

label define srcpen1_lbl 01 `"Company pension"'
label define srcpen1_lbl 02 `"Union pension"', add
label define srcpen1_lbl 03 `"Federal government pension"', add
label define srcpen1_lbl 04 `"State government pension"', add
label define srcpen1_lbl 05 `"Local government pension"', add
label define srcpen1_lbl 06 `"US military pension"', add
label define srcpen1_lbl 07 `"US Railroad Retirement"', add
label define srcpen1_lbl 08 `"Other pension"', add
label define srcpen1_lbl 99 `"NIU"', add
label values srcpen1 srcpen1_lbl

label define srcpen2_lbl 01 `"Company pension"'
label define srcpen2_lbl 02 `"Union pension"', add
label define srcpen2_lbl 03 `"Federal government pension"', add
label define srcpen2_lbl 04 `"State government pension"', add
label define srcpen2_lbl 05 `"Local government pension"', add
label define srcpen2_lbl 06 `"US military pension"', add
label define srcpen2_lbl 07 `"US Railroad Retirement"', add
label define srcpen2_lbl 08 `"Other pension"', add
label define srcpen2_lbl 99 `"NIU"', add
label values srcpen2 srcpen2_lbl

label define incpen1_lbl 9999999 `"NIU"'
label values incpen1 incpen1_lbl

label define incpen2_lbl 9999999 `"NIU"'
label values incpen2 incpen2_lbl

label define retcont_lbl 999999 `"NIU"'
label values retcont retcont_lbl

label define srcrint1_lbl 01 `"401k account"'
label define srcrint1_lbl 02 `"403b account"', add
label define srcrint1_lbl 03 `"Roth IRA"', add
label define srcrint1_lbl 04 `"Regular IRA"', add
label define srcrint1_lbl 05 `"KEOGH"', add
label define srcrint1_lbl 06 `"Simplified Employee Pension (SEP) plan"', add
label define srcrint1_lbl 07 `"Other type of retirement account"', add
label define srcrint1_lbl 99 `"NIU"', add
label values srcrint1 srcrint1_lbl

label define srcrint2_lbl 01 `"401k account"'
label define srcrint2_lbl 02 `"403b account"', add
label define srcrint2_lbl 03 `"Roth IRA"', add
label define srcrint2_lbl 04 `"Regular IRA"', add
label define srcrint2_lbl 05 `"KEOGH"', add
label define srcrint2_lbl 06 `"Simplified Employee Pension (SEP) plan"', add
label define srcrint2_lbl 07 `"Other type of retirement account"', add
label define srcrint2_lbl 99 `"NIU"', add
label values srcrint2 srcrint2_lbl

label define incrint1_lbl 9999999 `"NIU"'
label values incrint1 incrint1_lbl

label define incrint2_lbl 9999999 `"NIU"'
label values incrint2 incrint2_lbl

label define inccapg_lbl 9999999 `"NIU"'
label values inccapg inccapg_lbl

label define srcearn_lbl 0 `"NIU"'
label define srcearn_lbl 1 `"Wage and salary"', add
label define srcearn_lbl 2 `"Self employment"', add
label define srcearn_lbl 3 `"Farm self employment"', add
label define srcearn_lbl 4 `"Without pay"', add
label values srcearn srcearn_lbl

label define srceduc_lbl 0 `"NIU"'
label define srceduc_lbl 1 `"Government assistance"', add
label define srceduc_lbl 2 `"Scholarships, grants etc from school"', add
label define srceduc_lbl 3 `"Other assistance"', add
label define srceduc_lbl 4 `"Govt assistance and scholarships, grants etc from school"', add
label define srceduc_lbl 5 `"Govt assistance and other assistance"', add
label define srceduc_lbl 6 `"Scholarships, grants etc from school and other assistance"', add
label define srceduc_lbl 7 `"Govt assistance, scholarships, grants etc from school, and other assistance"', add
label values srceduc srceduc_lbl

label define srcunemp_lbl 0 `"No supplemental or strike benefits"'
label define srcunemp_lbl 1 `"Supplemental unemployment benefits"', add
label define srcunemp_lbl 2 `"Union unemployment or strike benefits"', add
label define srcunemp_lbl 3 `"Both"', add
label define srcunemp_lbl 9 `"NIU"', add
label values srcunemp srcunemp_lbl

label define srcwelfr_lbl 0 `"NIU"'
label define srcwelfr_lbl 1 `"AFDC/TANF"', add
label define srcwelfr_lbl 2 `"Other"', add
label define srcwelfr_lbl 3 `"Both AFDC/TANF and other"', add
label values srcwelfr srcwelfr_lbl

label define srcwkcom_lbl 0 `"NIU"'
label define srcwkcom_lbl 1 `"State Workers Compensation"', add
label define srcwkcom_lbl 2 `"Employer or employers insurance"', add
label define srcwkcom_lbl 3 `"Own insurance"', add
label define srcwkcom_lbl 4 `"Other"', add
label values srcwkcom srcwkcom_lbl

label define ssikid_lbl 0 `"NIU"'
label define ssikid_lbl 1 `"No"', add
label define ssikid_lbl 2 `"Yes"', add
label values ssikid ssikid_lbl

label define sskid_lbl 0 `"NIU"'
label define sskid_lbl 1 `"No"', add
label define sskid_lbl 2 `"Yes"', add
label values sskid sskid_lbl

label define vetqa_lbl 0 `"NIU"'
label define vetqa_lbl 1 `"No"', add
label define vetqa_lbl 2 `"Yes"', add
label values vetqa vetqa_lbl

label define whyss1_lbl 0 `"NIU"'
label define whyss1_lbl 1 `"Retired"', add
label define whyss1_lbl 2 `"Disabled (adult or child)"', add
label define whyss1_lbl 3 `"Widowed"', add
label define whyss1_lbl 4 `"Spouse"', add
label define whyss1_lbl 5 `"Surviving child"', add
label define whyss1_lbl 6 `"Dependent child"', add
label define whyss1_lbl 7 `"On behalf of surviving, dependent, or disabled child(ren)"', add
label define whyss1_lbl 8 `"Other (adult or child)"', add
label values whyss1 whyss1_lbl

label define whyss2_lbl 0 `"NIU"'
label define whyss2_lbl 1 `"Retired"', add
label define whyss2_lbl 2 `"Disabled (adult or child)"', add
label define whyss2_lbl 3 `"Widowed"', add
label define whyss2_lbl 4 `"Spouse"', add
label define whyss2_lbl 5 `"Surviving child"', add
label define whyss2_lbl 6 `"Dependent child"', add
label define whyss2_lbl 7 `"On behalf of surviving, dependent, or disabled child(ren)"', add
label define whyss2_lbl 8 `"Other (adult or child)"', add
label values whyss2 whyss2_lbl

label define whyssi1_lbl 0 `"NIU"'
label define whyssi1_lbl 1 `"Disabled (adult or child)"', add
label define whyssi1_lbl 2 `"Blind (adult or child)"', add
label define whyssi1_lbl 3 `"On behalf of a disabled child"', add
label define whyssi1_lbl 4 `"On behalf of a blind child"', add
label define whyssi1_lbl 5 `"Other (adult or child)"', add
label values whyssi1 whyssi1_lbl

label define whyssi2_lbl 0 `"NIU"'
label define whyssi2_lbl 1 `"Disabled (adult or child)"', add
label define whyssi2_lbl 2 `"Blind (adult or child)"', add
label define whyssi2_lbl 3 `"On behalf of a disabled child"', add
label define whyssi2_lbl 4 `"On behalf of a blind child"', add
label define whyssi2_lbl 5 `"Other (adult or child)"', add
label values whyssi2 whyssi2_lbl

label define gotvdisa_lbl 0 `"NIU"'
label define gotvdisa_lbl 1 `"No"', add
label define gotvdisa_lbl 2 `"Yes"', add
label values gotvdisa gotvdisa_lbl

label define gotveduc_lbl 0 `"NIU"'
label define gotveduc_lbl 1 `"No"', add
label define gotveduc_lbl 2 `"Yes"', add
label values gotveduc gotveduc_lbl

label define gotvothe_lbl 0 `"NIU"'
label define gotvothe_lbl 1 `"No"', add
label define gotvothe_lbl 2 `"Yes"', add
label values gotvothe gotvothe_lbl

label define gotvpens_lbl 0 `"NIU"'
label define gotvpens_lbl 1 `"No"', add
label define gotvpens_lbl 2 `"Yes"', add
label values gotvpens gotvpens_lbl

label define gotvsurv_lbl 0 `"NIU"'
label define gotvsurv_lbl 1 `"No"', add
label define gotvsurv_lbl 2 `"Yes"', add
label values gotvsurv gotvsurv_lbl

label define filestat_lbl 0 `"No data"'
label define filestat_lbl 1 `"Joint, both less than 65"', add
label define filestat_lbl 2 `"Joint, one less than 65, one 65+"', add
label define filestat_lbl 3 `"Joint, both 65+"', add
label define filestat_lbl 4 `"Head of household"', add
label define filestat_lbl 5 `"Single"', add
label define filestat_lbl 6 `"Nonfiler"', add
label values filestat filestat_lbl

label define offpov_lbl 01 `"Below Poverty Line"'
label define offpov_lbl 02 `"Above Poverty Line"', add
label define offpov_lbl 99 `"NIU"', add
label values offpov offpov_lbl

label define offpovuniv_lbl 00 `"Out of Poverty Universe"'
label define offpovuniv_lbl 01 `"In Poverty Universe"', add
label values offpovuniv offpovuniv_lbl

label define offreason_lbl 01 `"No Family Income Issue - Coding Error/Out of Poverty Universe"'
label define offreason_lbl 02 `"Family Income Missing - Out of Poverty Universe"', add
label define offreason_lbl 03 `"Family Income Recode Issue"', add
label define offreason_lbl 99 `"NIU"', add
label values offreason offreason_lbl

label define poverty_lbl 00 `"NIU"'
label define poverty_lbl 10 `"Below poverty"', add
label define poverty_lbl 20 `"Above poverty"', add
label define poverty_lbl 21 `"100-124 percent of the low-income level"', add
label define poverty_lbl 22 `"125-149 percent of the low-income level"', add
label define poverty_lbl 23 `"150 percent and above the low-income level"', add
label values poverty poverty_lbl

label define spmnewfam_lbl 0 `"Same as official poverty unit"'
label define spmnewfam_lbl 1 `"Cohabiting couple present"', add
label define spmnewfam_lbl 2 `"Unrelated individual under 15 present"', add
label define spmnewfam_lbl 3 `"Foster child age 15-21 present"', add
label define spmnewfam_lbl 4 `"Newly included parent"', add
label define spmnewfam_lbl 5 `"Multiple changes"', add
label values spmnewfam spmnewfam_lbl

label define spmpov_lbl 0 `"Above poverty (SPM)"'
label define spmpov_lbl 1 `"Below poverty (SPM)"', add
label values spmpov spmpov_lbl

label define spmmort_lbl 1 `"Owners with a mortgage"'
label define spmmort_lbl 2 `"Owners without a mortgage"', add
label define spmmort_lbl 3 `"Renters"', add
label values spmmort spmmort_lbl

label define migsta1_lbl 00 `"NIU"'
label define migsta1_lbl 01 `"Alabama"', add
label define migsta1_lbl 02 `"Alaska"', add
label define migsta1_lbl 04 `"Arizona"', add
label define migsta1_lbl 05 `"Arkansas"', add
label define migsta1_lbl 06 `"California"', add
label define migsta1_lbl 08 `"Colorado"', add
label define migsta1_lbl 09 `"Connecticut"', add
label define migsta1_lbl 10 `"Delaware"', add
label define migsta1_lbl 11 `"District of Columbia"', add
label define migsta1_lbl 12 `"Florida"', add
label define migsta1_lbl 13 `"Georgia"', add
label define migsta1_lbl 15 `"Hawaii"', add
label define migsta1_lbl 16 `"Idaho"', add
label define migsta1_lbl 17 `"Illinois"', add
label define migsta1_lbl 18 `"Indiana"', add
label define migsta1_lbl 19 `"Iowa"', add
label define migsta1_lbl 20 `"Kansas"', add
label define migsta1_lbl 21 `"Kentucky"', add
label define migsta1_lbl 22 `"Louisiana"', add
label define migsta1_lbl 23 `"Maine"', add
label define migsta1_lbl 24 `"Maryland"', add
label define migsta1_lbl 25 `"Massachusetts"', add
label define migsta1_lbl 26 `"Michigan"', add
label define migsta1_lbl 27 `"Minnesota"', add
label define migsta1_lbl 28 `"Mississippi"', add
label define migsta1_lbl 29 `"Missouri"', add
label define migsta1_lbl 30 `"Montana"', add
label define migsta1_lbl 31 `"Nebraska"', add
label define migsta1_lbl 32 `"Nevada"', add
label define migsta1_lbl 33 `"New Hampshire"', add
label define migsta1_lbl 34 `"New Jersey"', add
label define migsta1_lbl 35 `"New Mexico"', add
label define migsta1_lbl 36 `"New York"', add
label define migsta1_lbl 37 `"North Carolina"', add
label define migsta1_lbl 38 `"North Dakota"', add
label define migsta1_lbl 39 `"Ohio"', add
label define migsta1_lbl 40 `"Oklahoma"', add
label define migsta1_lbl 41 `"Oregon"', add
label define migsta1_lbl 42 `"Pennsylvania"', add
label define migsta1_lbl 44 `"Rhode Island"', add
label define migsta1_lbl 45 `"South Carolina"', add
label define migsta1_lbl 46 `"South Dakota"', add
label define migsta1_lbl 47 `"Tennessee"', add
label define migsta1_lbl 48 `"Texas"', add
label define migsta1_lbl 49 `"Utah"', add
label define migsta1_lbl 50 `"Vermont"', add
label define migsta1_lbl 51 `"Virginia"', add
label define migsta1_lbl 53 `"Washington"', add
label define migsta1_lbl 54 `"West Virginia"', add
label define migsta1_lbl 55 `"Wisconsin"', add
label define migsta1_lbl 56 `"Wyoming"', add
label define migsta1_lbl 91 `"Abroad"', add
label define migsta1_lbl 99 `"Same house"', add
label values migsta1 migsta1_lbl

label define migsta5_lbl 00 `"NIU"'
label define migsta5_lbl 01 `"Alabama"', add
label define migsta5_lbl 02 `"Alaska"', add
label define migsta5_lbl 04 `"Arizona"', add
label define migsta5_lbl 05 `"Arkansas"', add
label define migsta5_lbl 06 `"California"', add
label define migsta5_lbl 08 `"Colorado"', add
label define migsta5_lbl 09 `"Connecticut"', add
label define migsta5_lbl 10 `"Delaware"', add
label define migsta5_lbl 11 `"District of Columbia"', add
label define migsta5_lbl 12 `"Florida"', add
label define migsta5_lbl 13 `"Georgia"', add
label define migsta5_lbl 15 `"Hawaii"', add
label define migsta5_lbl 16 `"Idaho"', add
label define migsta5_lbl 17 `"Illinois"', add
label define migsta5_lbl 18 `"Indiana"', add
label define migsta5_lbl 19 `"Iowa"', add
label define migsta5_lbl 20 `"Kansas"', add
label define migsta5_lbl 21 `"Kentucky"', add
label define migsta5_lbl 22 `"Louisiana"', add
label define migsta5_lbl 23 `"Maine"', add
label define migsta5_lbl 24 `"Maryland"', add
label define migsta5_lbl 25 `"Massachusetts"', add
label define migsta5_lbl 26 `"Michigan"', add
label define migsta5_lbl 27 `"Minnesota"', add
label define migsta5_lbl 28 `"Mississippi"', add
label define migsta5_lbl 29 `"Missouri"', add
label define migsta5_lbl 30 `"Montana"', add
label define migsta5_lbl 31 `"Nebraska"', add
label define migsta5_lbl 32 `"Nevada"', add
label define migsta5_lbl 33 `"New Hampshire"', add
label define migsta5_lbl 34 `"New Jersey"', add
label define migsta5_lbl 35 `"New Mexico"', add
label define migsta5_lbl 36 `"New York"', add
label define migsta5_lbl 37 `"North Carolina"', add
label define migsta5_lbl 38 `"North Dakota"', add
label define migsta5_lbl 39 `"Ohio"', add
label define migsta5_lbl 40 `"Oklahoma"', add
label define migsta5_lbl 41 `"Oregon"', add
label define migsta5_lbl 42 `"Pennsylvania"', add
label define migsta5_lbl 44 `"Rhode Island"', add
label define migsta5_lbl 45 `"South Carolina"', add
label define migsta5_lbl 46 `"South Dakota"', add
label define migsta5_lbl 47 `"Tennessee"', add
label define migsta5_lbl 48 `"Texas"', add
label define migsta5_lbl 49 `"Utah"', add
label define migsta5_lbl 50 `"Vermont"', add
label define migsta5_lbl 51 `"Virginia"', add
label define migsta5_lbl 53 `"Washington"', add
label define migsta5_lbl 54 `"West Virginia"', add
label define migsta5_lbl 55 `"Wisconsin"', add
label define migsta5_lbl 56 `"Wyoming"', add
label define migsta5_lbl 91 `"Abroad"', add
label values migsta5 migsta5_lbl

label define whymove_lbl 00 `"NIU"'
label define whymove_lbl 01 `"Change in marital status"', add
label define whymove_lbl 02 `"To establish own household"', add
label define whymove_lbl 03 `"Other family reason"', add
label define whymove_lbl 04 `"New job or job transfer"', add
label define whymove_lbl 05 `"To look for work or lost job"', add
label define whymove_lbl 06 `"For easier commute"', add
label define whymove_lbl 07 `"Retired"', add
label define whymove_lbl 08 `"Other job-related reason"', add
label define whymove_lbl 09 `"Wanted to own home, not rent"', add
label define whymove_lbl 10 `"Wanted new or better housing"', add
label define whymove_lbl 11 `"Wanted better neighborhood"', add
label define whymove_lbl 12 `"For cheaper housing"', add
label define whymove_lbl 13 `"Other housing reason"', add
label define whymove_lbl 14 `"Attend/leave college"', add
label define whymove_lbl 15 `"Change of climate"', add
label define whymove_lbl 16 `"Health reasons"', add
label define whymove_lbl 17 `"Other reasons"', add
label define whymove_lbl 18 `"Natural disaster"', add
label define whymove_lbl 19 `"Foreclosure or eviction"', add
label define whymove_lbl 20 `"Relationship with unmarried partner"', add
label values whymove whymove_lbl

label define migrate1_lbl 0 `"NIU"'
label define migrate1_lbl 1 `"Same house"', add
label define migrate1_lbl 2 `"Different house, place not reported"', add
label define migrate1_lbl 3 `"Moved within county"', add
label define migrate1_lbl 4 `"Moved within state, different county"', add
label define migrate1_lbl 5 `"Moved between states"', add
label define migrate1_lbl 6 `"Abroad"', add
label define migrate1_lbl 9 `"Unknown"', add
label values migrate1 migrate1_lbl

label define migrate5_lbl 00 `"NIU"'
label define migrate5_lbl 10 `"Same house"', add
label define migrate5_lbl 20 `"Place not reported (within U.S.)"', add
label define migrate5_lbl 30 `"Moved within county"', add
label define migrate5_lbl 40 `"Moved within state, between counties"', add
label define migrate5_lbl 41 `"Different county, same state, same SMSA"', add
label define migrate5_lbl 42 `"Different county, same state, different SMSA"', add
label define migrate5_lbl 50 `"Moved between states"', add
label define migrate5_lbl 51 `"Moved between contiguous states"', add
label define migrate5_lbl 52 `"Moved between non-contiguous states"', add
label define migrate5_lbl 60 `"Abroad five years ago"', add
label values migrate5 migrate5_lbl

label define mig5diffarea_lbl 0 `"NIU"'
label define mig5diffarea_lbl 1 `"Nonmover"', add
label define mig5diffarea_lbl 2 `"Same county"', add
label define mig5diffarea_lbl 3 `"Different county, same state"', add
label define mig5diffarea_lbl 4 `"Different state, same division"', add
label define mig5diffarea_lbl 5 `"Different division, same region"', add
label define mig5diffarea_lbl 6 `"Different region"', add
label define mig5diffarea_lbl 7 `"Abroad"', add
label values mig5diffarea mig5diffarea_lbl

label define mig5diffreg_lbl 0 `"NIU"'
label define mig5diffreg_lbl 1 `"Nonmover"', add
label define mig5diffreg_lbl 2 `"Same county"', add
label define mig5diffreg_lbl 3 `"Different county, same state"', add
label define mig5diffreg_lbl 4 `"Moved to different state in Northeast"', add
label define mig5diffreg_lbl 5 `"Moved to different state in Midwest"', add
label define mig5diffreg_lbl 6 `"Moved to different state in South"', add
label define mig5diffreg_lbl 7 `"Moved to different state in West"', add
label define mig5diffreg_lbl 8 `"Abroad"', add
label values mig5diffreg mig5diffreg_lbl

label define mig5diffcbst_lbl 0 `"NIU"'
label define mig5diffcbst_lbl 1 `"Nonmover"', add
label define mig5diffcbst_lbl 2 `"Metro to metro"', add
label define mig5diffcbst_lbl 3 `"Metro to non-metro"', add
label define mig5diffcbst_lbl 4 `"Non-metro to metro"', add
label define mig5diffcbst_lbl 5 `"Non-metro to non-metro"', add
label define mig5diffcbst_lbl 6 `"Abroad to metro"', add
label define mig5diffcbst_lbl 7 `"Abroad to non-metro"', add
label define mig5diffcbst_lbl 8 `"Not identified"', add
label values mig5diffcbst mig5diffcbst_lbl

label define mig5cbst_lbl 0 `"NIU"'
label define mig5cbst_lbl 1 `"In a metropolitan CBSA"', add
label define mig5cbst_lbl 2 `"Not in a metropolitan CBSA"', add
label define mig5cbst_lbl 3 `"Abroad"', add
label define mig5cbst_lbl 4 `"Not identified"', add
label values mig5cbst mig5cbst_lbl

label define mig5div_lbl 00 `"NIU"'
label define mig5div_lbl 01 `"New England"', add
label define mig5div_lbl 02 `"Middle Atlantic"', add
label define mig5div_lbl 03 `"East North Central"', add
label define mig5div_lbl 04 `"West North Central"', add
label define mig5div_lbl 05 `"South Atlantic"', add
label define mig5div_lbl 06 `"East South Central"', add
label define mig5div_lbl 07 `"West South Central"', add
label define mig5div_lbl 08 `"Mountain"', add
label define mig5div_lbl 09 `"Pacific"', add
label define mig5div_lbl 10 `"Abroad"', add
label values mig5div mig5div_lbl

label define mig5cityst_lbl 0 `"NIU"'
label define mig5cityst_lbl 1 `"Principal city of a metropolitan CBSA"', add
label define mig5cityst_lbl 2 `"Balance of a metropolitan CBSA"', add
label define mig5cityst_lbl 3 `"Not in a metropolitan CBSA"', add
label define mig5cityst_lbl 4 `"Abroad"', add
label define mig5cityst_lbl 5 `"Not identified"', add
label values mig5cityst mig5cityst_lbl

label define mig5region_lbl 0 `"NIU"'
label define mig5region_lbl 1 `"Northeast"', add
label define mig5region_lbl 2 `"Midwest"', add
label define mig5region_lbl 3 `"South"', add
label define mig5region_lbl 4 `"West"', add
label define mig5region_lbl 5 `"Abroad"', add
label values mig5region mig5region_lbl

label define qmig5same_lbl 0 `"NIU or not changed"'
label define qmig5same_lbl 1 `"Assigned from householder"', add
label define qmig5same_lbl 2 `"Assigned from spouse"', add
label define qmig5same_lbl 3 `"Assigned from parent 1"', add
label define qmig5same_lbl 4 `"Assigned from parent 2"', add
label define qmig5same_lbl 5 `"Allocated from matrix mob"', add
label values qmig5same qmig5same_lbl

label define disabwrk_lbl 0 `"NIU"'
label define disabwrk_lbl 1 `"No disability that affects work"', add
label define disabwrk_lbl 2 `"Disability limits or prevents work"', add
label values disabwrk disabwrk_lbl

label define health_lbl 1 `"Excellent"'
label define health_lbl 2 `"Very good"', add
label define health_lbl 3 `"Good"', add
label define health_lbl 4 `"Fair"', add
label define health_lbl 5 `"Poor"', add
label values health health_lbl

label define quitsick_lbl 0 `"NIU"'
label define quitsick_lbl 1 `"No, did not quit job or retire"', add
label define quitsick_lbl 2 `"Yes, quit job or retired"', add
label values quitsick quitsick_lbl

label define hourwage_lbl 99999 `"NIU"'
label values hourwage hourwage_lbl

label define paidhour_lbl 0 `"NIU"'
label define paidhour_lbl 1 `"No"', add
label define paidhour_lbl 2 `"Yes"', add
label define paidhour_lbl 6 `"Refused"', add
label define paidhour_lbl 7 `"Don't Know"', add
label values paidhour paidhour_lbl

label define union_lbl 0 `"NIU"'
label define union_lbl 1 `"No union coverage"', add
label define union_lbl 2 `"Member of labor union"', add
label define union_lbl 3 `"Covered by union but not a member"', add
label values union union_lbl

label define earnweek_lbl 00999999 `"NIU"'
label values earnweek earnweek_lbl

label define eligorg_lbl 0 `"Not eligible"'
label define eligorg_lbl 1 `"Eligible"', add
label values eligorg eligorg_lbl

label define telwrkpay_lbl 0 `"NIU"'
label define telwrkpay_lbl 1 `"Yes"', add
label define telwrkpay_lbl 2 `"No"', add
label values telwrkpay telwrkpay_lbl

save "$data/CPS-ASECPrelim_Nov16.dta", replace
