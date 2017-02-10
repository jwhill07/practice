# abcTotals computes and prints out the total score for abc questions

source("fix_dataset.R")

# if "data." precedes colnames in dataset1, fix
colnames(dataset1) <- gsub("data.", "", colnames(dataset1))

computeABCTotal <- function() {
  dataset1$abcTotals <- rowSums(dataset1[grep("^abc_q", colnames(dataset1))])
  print(dataset1[c("idnum", "abcTotals")])
}

computeABCTotal()
