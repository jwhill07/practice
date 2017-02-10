# checkMobLocation ensures all patients entered onto Redcap were marked as "scanned at UWMC"
# notes inconsistencies

source("fix_dataset.R")

# if "data." precedes colnames in dataset1, fix
colnames(dataset1) <- gsub("data.", "", colnames(dataset1))

indices <- which(dataset1["mob_location"] != 4) 
if (length(indices) > 0) {
  sprintf("Subject %s did not have mob assessment at UWMC", dataset1[indices, "idnum"])
} else {
  cat("All Subjects had mob assessments at UWMC")
}
