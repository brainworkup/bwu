
#######################################################################
# This function reads in a CSV file specified in the inFile parameter
# then executes the examiner composite and scale scoring routine for
# each row and writes the results out to the CSV file name specified
# in the outFile parameter.  The lang_var parameter is the name of the
# column in inFile that contains the language of test administration.
# The var_names parameter specifies the names of the columns (case
# sensitive) in the inFile that contain the following examiner V3.2
# variables in order:
#
#  	dot_total,nb1_score,nb2_score,flanker_score,error_score,antisacc,
#	vf1_corr,vf2_crr,cf1_corr,cf2_corr,shift_score
#
#
#

score_file <- function(inFile, outFile, var_names=c("dot_total","nb1_score","nb2_score","flanker_score","error_score","antisacc","vf1_corr","vf2_corr",
"cf1_corr","cf2_corr","shift_score"), lang_var="language") {

# input raw score file
data_raw <- read.table(inFile, header=TRUE, sep=",")

col_names_in = colnames(data_raw)

for (col in var_names) {
	if(!col %in% names(data_raw)) {
		print(paste("Missing required column '",col,"' in input file '",inFile,"'.",sep=""))
		return("Error reading input file.")
	}
}
if(!lang_var %in% names(data_raw)) {
		print(paste("Missing required column '",lang_var,"' in input file '",inFile,"'.",sep=""))
		return("Error reading input file.")
}

rows = nrow(data_raw)
for (k in 1:rows) {
	lang <- data_raw[k,lang_var]
	raw_sc <- data_raw[k,var_names]
	print(paste("Scoring row",k,"of",rows))
	irt_out <- score_examiner(lang,raw_sc)
	out_val <- c(data_raw[k,col_names_in],irt_out)
	if(k==1){
		data_out <- out_val
	}
	else {
		data_out <- rbind(data_out,out_val)
	}
}

colnames(data_out) <- c(col_names_in,"executive_composite","executive_se","fluency_factor","fluency_se","cog_control_factor","cog_control_se","working_memory_factor","working_memory_se")
write.table(data_out, outFile, sep=",",row.names=FALSE)
}

#######################################################################
# This function is the same as score_file, but uses the old variable names
# from the examiner data collected during development of the battery.

score_file_old_vars <- function(inFile,outFile){

score_file(inFile,outFile,var_names=c("DotCntTot","nb1dprime","nb2dprime","flankerinc2","newerrors","antisacc","VF1Corr","VF2Corr",
"CF1Corr","CF2Corr","shiftscore"),lang_var="lang")
}



#######################################################################
# This function is the same as score_file, but uses the variable names
# from the "Examiner Primary Variables" data file included with the
# examiner battery.

score_primary_vars_file <- function(inFile,outFile){

score_file(inFile,outFile,var_names=c("DotCounting","Nb1dprime","Nb2dprime","FlankerScore","DysexErrs","Antisaccade","VF1Corr","VF2Corr",
"CF1Corr","CF2Corr","SetShiftScore"),lang_var="lang")
}



##############################################################################################################
# This function inputs an array with the 11 variables used in Examiner IRT scoring.
# It recodes the raw continuous variables into ordinal variables, and inputs
# the ordinal variables into r ltm to generate IRT scores.
# lang is language of test administration: 1 = English, 2 = Spanish
# The raw continuous variable must be input in raw_sc in the following order: DotCntTot,nb1dprime,nb2dprime,flankerinc2,newerrors,antisacc,VF1Corr,VF2Corr,CF1Corr,CF2Corr,shiftscore
# irt_sc is the output, and contains the IRT scores and standard errors for global executive (exec_theta, exec_se),
# fluency (flncy_theta, flncy_se), control (contr_theta, contr_se), and working memory (wm_theta, wm_se)
#
#		Note (jhesse, 12/30/2011): 	this script uses older variable names internally.  Below are the internal
#		variable names mapped to the current (V3.2) examiner output file files names and the
#		suggested Examiner Battery CRF field names.
#
#		DotCntTot = dot_total
#	   	nb1dprime = nb1_score
#	   	nb2dprime = nb2_score
#	   	flankerinc2 = flanker_score
# 		newerrors = error_score
#	   	antisacc = antisacc
#		VF1Corr = vf1_corr
#		VF2Corr = vf2_corr
#		CF1Corr = cf1_corr
#		CF2Corr = cf2_corr
#		shiftscore = shift_score
#
#		Using the V3.2 variable names, the input to the score_exec function is an array (raw_sc) with data in the
#		following order:
#
#		dot_total,nb1_score,nb2_score,flanker_score,error_score,antisacc,vf1_corr,vf2_crr,cf1_corr,cf2_corr,shift_score
#


score_examiner <- function(lang,raw_sc){
library(ltm)

# input lookup table for recoding continuous variables into ordinal variables
luv <- read.table("./lookup/examiner_ordinal_lookup_values.csv", header = TRUE, sep=",")

luv$nb2en_min <- luv$nb2dprime_min
luv$nb2en_max <- luv$nb2dprime_max

luv$asen_min <- luv$antisacc_min
luv$asen_max <- luv$antisacc_max

luv$dcen_min <- luv$DotCntTot_min
luv$dcen_max <- luv$DotCntTot_max
luv$erren_min <- luv$newerrors_min
luv$erren_max <- luv$newerrors_max
luv$vf2en_min <- luv$VF2Corr_min
luv$vf2en_max <- luv$VF2Corr_max
luv$nb1en_min <- luv$nb1dprime_min
luv$nb1en_max <- luv$nb1dprime_max
luv$flken_min <- luv$flankerinc2_min
luv$flken_max <- luv$flankerinc2_max
luv$shen_min <- luv$shiftscore_min
luv$shen_max <- luv$shiftscore_max


# input parameters file
load("./lookup/exec_fit_3.Rdata")
load("./lookup/flncy_fit.Rdata")
load("./lookup/contr_fit.Rdata")
load("./lookup/wm_fit.Rdata")

# labels for ordinal input variables
var_lab <- c("DotCntTot","nb1dprime","nb2dprime","flankerinc2","newerrors","antisacc","VF1Corr","VF2Corr",
"CF1Corr","CF2Corr","shiftscore","dcen","dcsp","nb1en","nb1sp","nb2en","nb2sp","flken","flksp","erren","errsp",
"asen","assp","vf2en","vf2sp","shen","shsp")

var_lab_r <- c("DotCntTotr","nb1dprimer","nb2dprimer","flankerinc2r","newerrorsr","antisaccr","VF1Corrr","VF2Corrr",
"CF1Corrr","CF2Corrr","shiftscorer","dcenr","dcspr","nb1enr","nb1spr","nb2enr","nb2spr","flkenr","flkspr","errenr","errspr",
"asenr","asspr","vf2enr","vf2spr","shenr","shspr")

if(lang==1){
	raw_sc_2 <- c(raw_sc[1],raw_sc[2],raw_sc[3],raw_sc[4],raw_sc[5],raw_sc[6],
	raw_sc[7],raw_sc[8],raw_sc[9],raw_sc[10],raw_sc[11],raw_sc[1],NA,raw_sc[2],NA,raw_sc[3],NA,raw_sc[4],NA,
	raw_sc[5],NA,raw_sc[6],NA,raw_sc[8],NA,raw_sc[11],NA)
} else {
	raw_sc_2 <- c(raw_sc[1],raw_sc[2],raw_sc[3],raw_sc[4],raw_sc[5],raw_sc[6],
	raw_sc[7],raw_sc[8],raw_sc[9],raw_sc[10],raw_sc[11],NA,raw_sc[1],NA,raw_sc[2],NA,raw_sc[3],NA,raw_sc[4],NA,
	raw_sc[5],NA,raw_sc[6],NA,raw_sc[8],NA,raw_sc[11])
}


# test raw score values
# raw_sc = c(7,2.562037,1.634457,8.162265,NA,36,25,10,21,1,NA)
# raw_sc = c(22,3.671374,1.518065,9.267859,NA,40,19,18,21,19,NA)

# recode continuous variables into ordinal variables
for (i in 1:27){
	a <- paste(var_lab[i], "_min", sep ="")
	b <- paste(var_lab[i], "_max", sep = "")
	if(!is.na(raw_sc_2[i])){
		if(raw_sc_2[i] <= min(luv[,c(a)], na.rm=TRUE)) {
				rcval <- min(luv$ord_val, na.rm=TRUE)
			} else {
				if(raw_sc_2[i] >= max(luv[,c(b)], na.rm=TRUE)){
					rcval <- max(luv$ord_val[which(!is.na(luv[,c(b)]))], na.rm=TRUE)
				} else {
					rcval <- luv[which(luv[,c(a)]<=as.numeric(raw_sc_2[i]) & luv[,c(b)]>as.numeric(raw_sc_2[i])),1]
				}
			}
	} else {
		rcval=NA
	}
	if(i==1){
		recode_sc <- rcval
	} else {
		recode_sc <- c(recode_sc,rcval)
	}
}

recode_sc <- rbind(recode_sc)
colnames(recode_sc)<-c(var_lab_r)
recode_sc <- data.frame(recode_sc,row.names=NULL)

# create global executive irt score

vars_ex <- c("VF1Corrr","CF1Corrr","CF2Corrr","shiftscorer","nb2enr","nb2spr","asenr",
"asspr","dcenr","dcspr","errenr","errspr","vf2enr","vf2spr","nb1enr","nb1spr","flkenr","flkspr")
exec <- recode_sc[,vars_ex]

fsc_ex<-factor.scores(exec_fit_3, exec, method="EB")
fsc_ex<-as.data.frame(fsc_ex[1])

colnames(fsc_ex)<-c(vars_ex,"Obs","Exp","exec_theta","exec_se")

# create fluency irt score

vars_fl <- c("VF1Corrr","VF2Corrr","CF1Corrr","CF2Corrr")
flncy <- recode_sc[,vars_fl]

fsc_fl<-factor.scores(flncy_fit, flncy, method="EB")
fsc_fl<-as.data.frame(fsc_fl[1])

colnames(fsc_fl)<-c(vars_fl,"Obs","Exp","flncy_theta","flncy_se")

# create control irt score

vars_cn <- c("flankerinc2r","shiftscorer","antisaccr","newerrorsr")
contr <- recode_sc[,vars_cn]

fsc_cn<-factor.scores(contr_fit, contr, method="EB")
fsc_cn<-as.data.frame(fsc_cn[1])

colnames(fsc_cn)<-c(vars_cn,"Obs","Exp","contr_theta","contr_se")

#change directionality of control_theta by multipleing by -1
fsc_cn[,7] <- fsc_cn[,7] * -1

# create working memory irt score

vars_wm <- c("DotCntTotr","nb1dprimer","nb2dprimer")
wm <- recode_sc[,vars_wm]

fsc_wm<-factor.scores(wm_fit, wm, method="EB")
fsc_wm<-as.data.frame(fsc_wm[1])

colnames(fsc_wm)<-c(vars_wm,"Obs","Exp","wm_theta","wm_se")


irt_sc <- cbind(fsc_ex$exec_theta,fsc_ex$exec_se,fsc_fl$flncy_theta,fsc_fl$flncy_se,
fsc_cn$contr_theta,fsc_cn$contr_se,fsc_wm$wm_theta,fsc_wm$wm_se)

return(irt_sc)
}
