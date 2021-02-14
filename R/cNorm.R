# cNorm 7/6/20
# updated 2/6/21

install.packages("cNORM", dependencies = TRUE)
devtools::install_github("WLenhard/cNORM")

# Load cNORM

library(cNORM)

# Start help

help(cNORM)

# Start GUI

cNORM.GUI()

# Install psych package
install.packages("psych", dependencies = TRUE)

# Display descriptive results
library(psych)
library(readr)

# read raw data
mta <- read_csv("cNorm/mta.csv", locale = locale())

# read processed normative data
load("data/examiner_flanker.RData")
file.choose()

examiner <- as.data.frame(ut_weighted_score)

describeBy(ut_weighted_score, group="age")

describeBy(mta, group="group1")

# Determine percentiles by group
normData <- rankByGroup(mta, group = "group1", raw = "vocab", method=7)
normData
head(ppvt)

# Estimation of normal scores via a sliding windows of the width 0.5

normData2 <- rankBySlidingWindow(data = normData, age = "age", raw = "vocab", width = 1, group = "group1")


# The rankBySlidingWindow offers functionality to automatically build a grouping variable and determine the group means:#

  # Estimation of normal scores via a sliding windows of the width 1
  # A grouping variable is automatically determined with 14 distinct groups.
  # The mean age is assigned automatically for each group

mta1<-rankBySlidingWindow(data=normData2,age="age",raw="vocab",width=2,nGroup=15)




# Calculation of powers and interactions up to k = 4

normData3<-computePowers(normData, k=5, norm="normValue", age="age", covariate = "group1")



# Combines the functions 'rankByGroup' and 'computePowers'

normData <- prepareData(mta, raw="vocab", age="group1")

# The variable names can be provided, if necessary
# In the example, the CDC dataset on BMI growth is used

data.bmi <- prepareData(CDC, group="group", raw="bmi", age="age")

