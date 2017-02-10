# if "yes" for fog_q1, then there should be no NA values for all other fog_q*
# prints inconsistencies

source("fix_dataset.R")

# if "data." precedes colnames in dataset1, fix
colnames(dataset1) <- gsub("data.", "", colnames(dataset1))

yesOnFog <- ids["fog_q1"]==1
indices = which(ids["fog_q1"]==1)
fogQuestions <- ids[indices, which(colnames(ids)=="fog_q2"): which(colnames(ids)=="fog_q9")]
rowNA <- fogQuestions[rowSums(is.na(fogQuestions)) > 0,]
indices <- strtoi(rownames(rowNA))
if (length(indices) > 0) {
  cat(sprintf("Subject %s has unanswered fog questions when 'yes' to fog_q1 was marked\n", ids[indices, "ids"]))
} else {
  cat("Subjects that marked 'yes' to fog_q1 answered all other questions")
}
