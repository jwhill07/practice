# abcTotals computes and prints out the total score for abc questions

source("fix_dataset.R")

# if "data." precedes colnames in dataset1, fix
colnames(dataset1) <- gsub("data.", "", colnames(dataset1))

computeABCTotal <- function() {
  ids$abcTotals <- rowSums(ids[grep("^abc_q", colnames(ids))])
  print(ids[c("ids", "abcTotals")])
}

computeABCTotal()