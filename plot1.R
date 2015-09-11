# read data
Sys.setlocale("LC_TIME","English");
fUrl<-"exdata-data-household_power_consumption/household_power_consumption.txt"
td<-read.table(fUrl,nrows=10,sep=";",header=TRUE,na.strings = "?")
coltd<-colnames(td)
classes<-sapply(td,class)
td<-read.table(fUrl,sep=";",skip=66637,nrows=2881,na.strings = "?",colClasses=classes)
colnames(td)<-coltd
datetime<-paste(as.character(td$Date),as.character(td$Time))
datetime<-strptime(datetime,"%d/%m/%Y %H:%M:%S")
td$Date<-as.Date(td$Date,"%d/%m/%Y")
td<-td[,3:ncol(td)]
td<-data.frame(dt=datetime,td)

daterange=c(
  as.POSIXlt(min(td$dt)),as.POSIXlt(max(td$dt)))
rm(datetime)
library(datasets)
cexSet=0.95

#draw1

png(file = "plot1.png",width=480,height=480,bg="transparent")
with(td,hist(Global_active_power,cex=cexSet,main="Global Active Power",xlab="Global Active Power (kilowatts)",col = "red"))
dev.off()