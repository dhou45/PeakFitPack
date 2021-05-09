#Code by Dong Hou to calculate R* for many PDFs, for example changing with electric field
#First of all open this file in RStudio and click on Source
#You will be prompted to input the variables for the begining and end of your PDF data, the box step size and the box size

gr.read<-function()
{
  library("tcltk")
  f.dir<-tk_choose.dir()
  setwd(f.dir)
  gr.list<-list.files(f.dir,pattern='.*\\.gr')
  gr.list<-edit(gr.list)

  gr.raw<-sapply(gr.list,read.table, skip=29)
  gr.raw.simple<-gr.raw[2,]

  extract.col<-function(mydata) t(t(unlist(mydata)))
  
  gr.y<-sapply(gr.raw.simple,extract.col)
  gr.x<-t(t(unlist(gr.raw[1,1])))
  colnames(gr.x)<-c("gr.x")
  gr.data<-cbind(gr.x,gr.y)
  
  gr.diff<-gr.y[,1]-gr.y
  gr.diff<-cbind(gr.x,gr.diff)
  
  write.csv(gr.data, "gr.data.csv", row.names=FALSE)
  write.csv(gr.diff, "gr.diff.csv", row.names=FALSE)

}

gr.R.calc<-function(r.begin=1,r.end=50,r.step=0.1,r.range=5)
{
  library("tcltk")
  f.dir<-tk_choose.dir()
  setwd(f.dir)
  gr.data<-read.csv("gr.data.csv")
  gr.diff<-read.csv("gr.diff.csv")
  gr.R.x<-c()
  gr.R.y<-c()
  for (r.start in seq(r.begin,r.end-r.range,by=r.step))
  { 
    gr.R.y1<-colSums(abs(subset(gr.diff, gr.diff[,"gr.x"]>=r.start & gr.diff[,"gr.x"]<(r.start+r.range),select = -1)))

    gr.R.y2<-colSums(abs(subset(gr.data, gr.data[,"gr.x"]>=r.start & gr.data[,"gr.x"]<(r.start+r.range),select = 2)))
    gr.R.y<-cbind(gr.R.y,gr.R.y1/gr.R.y2)
    gr.R.x<-cbind(gr.R.x,mean(as.matrix(subset(gr.diff, gr.diff[,"gr.x"]>=r.start & gr.diff[,"gr.x"]<=(r.start+r.range),select = 1))))
  }
  gr.R<-cbind(t(gr.R.x),t(gr.R.y))

  write.csv(gr.R, "R.calc.csv", row.names = FALSE)
}


fq.read<-function()
{
  library("tcltk")
  f.dir<-tk_choose.dir()
  setwd(f.dir)
  gr.list<-list.files(f.dir,pattern='.*\\.fq')
  gr.list<-edit(gr.list)

  gr.raw<-sapply(gr.list,read.table, skip=28)
  gr.raw.simple<-gr.raw[2,]

  extract.col<-function(mydata) t(t(unlist(mydata)))

  gr.y<-sapply(gr.raw.simple,extract.col)
  gr.x<-t(t(unlist(gr.raw[1,1])))
  colnames(gr.x)<-c("fq.x")
  gr.data<-cbind(gr.x,gr.y)
  write.csv(gr.data, "fq.data.csv", row.names=FALSE)

  gr.diff<-gr.y[,1]-gr.y
  gr.diff<-cbind(gr.x,gr.diff)
  write.csv(gr.diff, "fq.diff.csv", row.names=FALSE)
}


chi.read<-function()
{
  library("tcltk")
  f.dir<-tk_choose.dir()
  setwd(f.dir)
  gr.list<-list.files(f.dir,pattern='.*\\.chi')
  gr.list<-edit(gr.list)

  gr.raw<-sapply(gr.list,read.table, skip=4)
  gr.raw.simple<-gr.raw[2,]

  extract.col<-function(mydata) t(t(unlist(mydata)))

  gr.y<-sapply(gr.raw.simple,extract.col)
  gr.x<-t(t(unlist(gr.raw[1,1])))
  colnames(gr.x)<-c("chi.x")
  gr.data<-cbind(gr.x,gr.y)
  write.csv(gr.data, "chi.data.csv", row.names=FALSE)

  gr.diff<-gr.y[,1]-gr.y
  gr.diff<-cbind(gr.x,gr.diff)
  write.csv(gr.diff, "chi.diff.csv", row.names=FALSE)
}


sq.read<-function()
{
  library("tcltk")
  f.dir<-tk_choose.dir()
  setwd(f.dir)
  gr.list<-list.files(f.dir,pattern='.*\\.sq')
  gr.list<-edit(gr.list)

  gr.raw<-sapply(gr.list,read.table, skip=28)
  gr.raw.simple<-gr.raw[2,]

  extract.col<-function(mydata) t(t(unlist(mydata)))

  gr.y<-sapply(gr.raw.simple,extract.col)
  gr.x<-t(t(unlist(gr.raw[1,1])))
  colnames(gr.x)<-c("sq.x")
  gr.data<-cbind(gr.x,gr.y)
  write.csv(gr.data, "sq.data.csv", row.names=FALSE)

  gr.diff<-gr.y[,1]-gr.y
  gr.diff<-cbind(gr.x,gr.diff)
  write.csv(gr.diff, "sq.diff.csv", row.names=FALSE)
}



iq.read<-function()
{
  library("tcltk")
  f.dir<-tk_choose.dir()
  setwd(f.dir)
  gr.list<-list.files(f.dir,pattern='.*\\.iq')
  gr.list<-edit(gr.list)

  gr.raw<-sapply(gr.list,read.table, skip=28)
  gr.raw.simple<-gr.raw[2,]

  extract.col<-function(mydata) t(t(unlist(mydata)))

  gr.y<-sapply(gr.raw.simple,extract.col)
  gr.x<-t(t(unlist(gr.raw[1,1])))
  colnames(gr.x)<-c("iq.x")
  gr.data<-cbind(gr.x,gr.y)
  write.csv(gr.data, "iq.data.csv", row.names=FALSE)

  gr.diff<-gr.y[,1]-gr.y
  gr.diff<-cbind(gr.x,gr.diff)
  write.csv(gr.diff, "iq.diff.csv", row.names=FALSE)
}


plotting.pdf<-function(x.min=min(plot.data[,1]), x.max=max(plot.data[,1]), pattern.list=2:length(plot.data[1,]))
{
  #image(plot.data[,1], 1:length(pattern.list), plot.data[,pattern.list],lty=1, xlab="r", ylab="R", xlim = c(x.min, x.max))
 matplot(plot.data[,1], plot.data[,pattern.list],type="l", lty=1, xlab="r", ylab="R", xlim = c(x.min, x.max), col = rainbow(length(pattern.list)))
}
