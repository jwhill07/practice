# this script checks if "best hand" is consistent throughout subjects' documents
# prints inconsistencies

source("fix_dataset.R")

# if "data." precedes colnames in dataset1, fix
colnames(dataset1) <- gsub("data.", "", colnames(dataset1))

# param (string) colname1, colname2: the names of the columns of dataset1 that should be compared & should be equivalent for each Subject
# ignores values that are empty or NA -- missing values are checked for by another function
# prints inconsistencies
checkHands <- function(colname1, colname2) {
  col1 <- dataset1[,colname1]
  col1[col1==""] <- NA
  col2 <- dataset1[,colname2]
  col2[col2==""] <- NA
  indices <- which(col1 != col2 && (col1 == 1 || col1 ==2) && (col2 == 1 || col2 == 2))
  if (length(indices) > 0) {
    allCorrect <- F
    print(sprintf("Subject %s has inconsistent hand dominance: %s != %s", dataset1[indices, "idnum"], col1[indices], col2[indices]))
    cat(sprintf("CHECK %s vs. %s\n", colname1, colname2))
  }
}

checkAllHands <- function() {
  checkHands("off_mri_dominant_hand", "on_mri_dominant_hand")
  checkHands("on_mri_dominant_hand", "mob_sidebutton")
  if (allCorrect) {
    print("All hand dominances are consistent")
  }
}

checkAllHands()