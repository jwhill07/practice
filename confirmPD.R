#confirm controls and/or PDs, print inconsistencies

#source("fix_dataset.R")

# if "data." precedes colnames in dataset1, fix
colnames(dataset1) <- gsub("data.", "", colnames(dataset1))

dataset1$isPatient <- dataset1["redcap_event_name"]=="off_arm_1"

# hoehn&yahr = 0 for controls 
checkControls <- function() {
  troubleIndices <- which(dataset1["isPatient"]==FALSE && dataset1["updrs_3_hoehn_yahr"] != 0)
  if (length(troubleIndices) > 0) {
    print(sprintf("Control Subject %s has nonzero hoehn & yahr score"))
  } else {
    print("All control subjects have hoehn and yahr score = 0")
  }
  troubleIndices <- which(dataset1["isPatient"]==FALSE && dataset1["health_demo_med_cond___16"]==1)
  if(length(troubleIndices) > 0) {
    sprintf("Control subject %s identified with Parkinson's on health demo", dataset1[troubleIndices, "idnum"])
  } else {
    print("all control subjects correctly identified no to Parkinson's on health demo")
  }
}

checkPDs <- function() {
  troubleIndices <- which(dataset1["isPatient"]==TRUE && dataset1["health_demo_med_cond___16"]==0)
  if(length(troubleIndices) > 0) {
    sprintf("PD subject %s didn't identify with Parkinson's on health demo", dataset1[troubleIndices, "idnum"])
  } else {
    print("all PD subjects correctly identified with Parkinson's on health demo")
  }
}

checkControls()
checkPDs()
