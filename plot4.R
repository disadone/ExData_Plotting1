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

#draw4
png(file = "plot4.png",width=480,height=480,bg="transparent")

attach(td)
par(mfrow=c(2,2))
plot(dt,Global_active_power,cex=cexSet,xaxt="n",type="l",xlab="",ylab="Global Active Power (kilowatts)")
axis.POSIXct(1,at=seq(daterange[1],daterange[2],by="day",format="%b"))

plot(dt,Voltage,cex=1,xaxt="n",type="l",xlab="datetime",ylab="Voltage")
axis.POSIXct(1,at=seq(daterange[1],daterange[2],by="day",format="%b"))

plot(dt,Sub_metering_1,cex=cexSet,xaxt="n",type="l",xlab="",ylab="Energy Sub metering")
lines(dt,Sub_metering_2,col="red")
lines(dt,Sub_metering_3,col="blue")
legend("topright",
       legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1,bty="n",cex=cexSet
)
axis.POSIXct(1,at=seq(daterange[1],daterange[2],by="day",format="%b"))

plot(dt,Global_reactive_power,cex=1,xaxt="n",type="l",xlab="datetime")
axis.POSIXct(1,at=seq(daterange[1],daterange[2],by="day",format="%b"))
detach(td)

dev.off()