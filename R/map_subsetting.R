mt <- map(n, ~ sample(pop, .x)) %m%

DT[val, on=col, j]

 foo <- function(colToFilter, filterValue) {
 #you need get in order to 'get' the column named cyl
 new_dt <- test_dt[get(colToFilter) == filterValue, list(disp, hp, gear)]
 return(new_dt)

data(mtcars)
test_dt <- data.table::as.data.table(mtcars)
test_dt
(new_dt <- test_dt[cyl == '4', c('disp', 'hp', 'gear')])

foo <- function(colToFilter, filterValue) {
 #you need get in order to 'get' the column named cyl
 new_dt <- test_dt[get(colToFilter) == filterValue, list(disp, hp, gear)]
 return(new_dt)
 }

 foo('cyl', '4')

 DT[val, on=col, j]

 foo <- function(colToFilter) {
 #you need get in order to 'get' the column named cyl
 new_dt <- test_dt[get(colToFilter), list(z, percentile)]
 return(new_dt)
 }