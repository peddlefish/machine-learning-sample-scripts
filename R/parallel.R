# ----------------------------------------------------------------------
#################################################################
######## Compare parallel with traditional loop #################
#################################################################
library(foreach)
library(doParallel)
#number of iterations
iters<-1e3
#setup parallel backend to use 2 processors
cl<-makeCluster(2)
registerDoParallel(cl)
#Parallel
strt<-Sys.time()
ls<-foreach(icount(iters)) %dopar% {
  to.ls<-rnorm(1e4)
  to.ls<-summary(to.ls)
  to.ls
}
print(Sys.time()-strt)
stopCluster(cl)
#Time difference of 5.730673 mins
#start time
strt<-Sys.time()
#Traditional loop
for(val in 1:iters){
  to.ls<-rnorm(1e4)
  to.ls<-summary(to.ls)
  to.ls
}
print(Sys.time()-strt)
#Time difference of 3.723783 mins

# ----------------------------------------------------------------------
#################################################################
######## Example 2 ##############################################
#################################################################
cl <- makeCluster(detectCores() - 1)
registerDoParallel(cl, cores = detectCores() - 1)
data = foreach(i = 1:length(filenames), .packages = c("ncdf","chron","stats"),
.combine = rbind) %dopar% {
try({
# your operations; line 1...
# your operations; line 2...
# your output
})
}
stopCluster(cl)