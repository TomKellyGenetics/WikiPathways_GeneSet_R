setwd("./Human_WP")
system("ls *.gpml.txt > files.txt")
files<-readLines('files.txt')
files
pathways.mat<-list()
for(i in 1:length(files)){
  pathways.mat[[i]]<-readLines(files[i])
  print(i)
}
names(pathways.mat)<-unlist(lapply(lapply(files, function(x) strsplit(x, split="WP")[[1]][2]), function(x) paste0("WP", strsplit(x, split="_")[[1]][1])))
WikiPathways.list<-pathways.mat[lapply(pathways.mat, length)!=0]
path3<-unlist(lapply(lapply(lapply(files, function(x) strsplit(x, split="_WP")[[1]][1]), function(x) strsplit(x, split="_-")[[1]][1]), function(x) strsplit(x, split="Hs_")[[1]][2]))
names(path3)<-unlist(lapply(lapply(files, function(x) strsplit(x, split="WP")[[1]][2]), function(x) paste0("WP", strsplit(x, split="_")[[1]][1])))
path3<-path3[lapply(pathways.mat, length)!=0]
path3<-gsub("_", " ", path3)
save(WikiPathways.list, path3, file="../WikiPathways.pway.db.RData")

if(require("org.Hs.eg.db")){
  SYMBOL.list<-as.list(org.Hs.egSYMBOL)
} else{
  source("http://bioconductor.org/biocLite.R")
  biocLite("org.Hs.eg.db", suppressUpdates=T)
  library("org.Hs.eg.db")
  SYMBOL.list<-as.list(org.Hs.egSYMBOL)
}
WikiPathways.list2<-list()
for(i in 1:length(WikiPathways.list)){
  WikiPathways.list2[[i]]<-unlist(SYMBOL.list[match(WikiPathways.list[[i]], names(SYMBOL.list))])
  print(unlist(SYMBOL.list[match(WikiPathways.list[[i]], names(SYMBOL.list))]))
  print(i)
}
names(WikiPathways.list2)<-names(path3)
save(WikiPathways.list2, path3, file="../WikiPathways.named.db.RData")

EntrezID<-na.omit(sort(as.numeric(unique(unlist(WikiPathways.list)))))
WikiPathways.listx<-as.list(rep(NA, length(EntrezID)))
for(i in 1:length(EntrezID)){
  system(paste("grep -lw", EntrezID[i], "*gpml.txt > pathway.txt"))
  WikiPathways.listx[[i]]<-unlist(lapply(lapply(readLines("pathway.txt"), function(x) strsplit(x, split="WP")[[1]][2]), function(x) paste0("WP", strsplit(x, split="_")[[1]][1])))
  print(i)
}
WikiPathways.listx<-WikiPathways.listx[match(names(SYMBOL.list), EntrezID)]
names(WikiPathways.listx)<-SYMBOL.list
WikiPathways.listx[WikiPathways.listx=="NULL"]<-NA
WikiPathways.list<-WikiPathways.listx
save(WikiPathways.list, path3, file="../WikiPathways.db.RData")



