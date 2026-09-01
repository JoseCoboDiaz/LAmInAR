
data<-read.csv("blastn_integrons_Resfinder_V2_filtered.txt", sep=("\t"), header=F)
data2<-data[order(data$V8),]
data3<-data2[order(data2$V2),]
write.table(data3[,-1],file="blastn_ordered.txt", sep="\t")
