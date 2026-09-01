
data<-read.csv("blastn_integrons_Resfinder_V2.txt", header=F, sep="\t")
data$V15<-data$V4*100/data$V14

data2<-data[which(data$V15>=80),]
sort(table(data2$V1), decreasing=TRUE)[1:10]

write.table(data2, "blastn_integrons_Resfinder_V2_filtered.txt", sep="\t", quote=FALSE)

