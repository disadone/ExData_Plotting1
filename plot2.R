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

#draw2
png(file = "plot2.png",width=480,height=480,bg="transparent")
attach(td)
plot(dt,Global_active_power,cex=cexSet,xaxt="n",type="l",xlab="",ylab="Global Active Power (kilowatts)")
axis.POSIXct(1,at=seq(daterange[1],daterange[2],by="day",format="%b"))
detach(td)
dev.off()