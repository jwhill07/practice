# checkDates checks the consistencies of birthdates and scandates per patient
# prints inconsistencies

source("fix_dataset.R")

# if "data." precedes colnames in dataset1, fix
colnames(dataset1) <- gsub("data.", "", colnames(dataset1))

# param (string) colname1, colname2: the columns of dataset1 that should be compared
# param (boolean) contains: if true, check if colname2 contains colname1. otherwise, checks for equality. 
# prints inconsistent dates with the corresponding Subject ID and relevant colnames
checkDate <- function(colname1, colname2, contains) {
  returnValue <- T
  col1 <- dataset1[colname1]
  col1[col1==""] <- NA
  col2 <- dataset1[colname2]
  col2[col2==""] <- NA
  ifelse(contains==F, checkBooleans <- col1 == col2, checkBooleans <- grepl(colname1, colname2))
  indices <- which(checkBooleans==FALSE) # && (!is.na(dataset1[colname1]) || !is.na(dataset1[colname2])))
  if (length(indices) > 0) {
    returnValue <- F;
    print(sprintf("%s: %s != %s", dataset1[indices, "idnum"], dataset1[indices, colname1], dataset1[indices, colname2]))
    cat(sprintf("CHECK %s vs. %s\n", colname1, colname2))
  } 
  return(returnValue)
}

# wraps overall function for test satisfaction (TODO: optimize)
retCheckDate <- function(colname1, colname2, contains, allG) {
  return(ifelse(checkDate(colname1, colname2, contains), allG, F))
}

# calls checkDate() for birth dates
checkDOB <- function() {
  allGood <- T
  allGood <- retCheckDate("off_mri_dob", "on_mri_dob", F, allGood)
  allGood <- retCheckDate("off_mri_dob", "health_demo_dob", F, allGood)
  allGood <- retCheckDate("on_mri_dob", "health_demo_dob", F, allGood)
  allGood <- retCheckDate("abc_birthyear", "fog_birthyear", F, allGood)
  allGood <- retCheckDate("off_mri_dob", "abc_birthyear", T, allGood)
  if (allGood) {
    print("All birthdates are consistent")
  }
}

# calls checkDate() for scan dates
checkScanDates <- function() {
  allGood <- T
  allGood <- retCheckDate("off_mri_date", "on_mri_date", F, allGood)
  allGood <- retCheckDate("off_mri_date", "abc_visitdate", F, allGood)
  allGood <- retCheckDate("off_mri_date", "fog_visitdate", F, allGood)
  if (allGood) {
    print("All scanDates are consistent")
  }
}

checkDOB()
checkScanDates()
