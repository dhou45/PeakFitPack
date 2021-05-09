chi.read()
iq.read()
sq.read()
fq.read()
gr.read()
#define Box-car
#r.begin<-as.numeric(readline("r.begin: ")); r.end<-as.numeric(readline("r.end: ")); r.step<-as.numeric(readline("r.step: ")); r.range<-as.numeric(readline("box.size: "))
gr.R.calc()

gr.R.calc(1,50,0.5,10)



#plotting
plot.data<-read.csv("fq.data.csv")

plotting.pdf(r.min=4, r.max=14, pattern.list=c(4,10))

plotting.pdf(r.min=4, r.max=14, pattern.list=c(4,10))