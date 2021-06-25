library(tercen)
library(dplyr)
library(mclust)
library(reshape2)
library(pgCheckInput)

# Set appropriate options
#options("tercen.serviceUri"="http://tercen:5400/api/v1/")
#options("tercen.workflowId"= "4133245f38c1411c543ef25ea3020c41")
#options("tercen.stepId"= "2b6d9fbf-25e4-4302-94eb-b9562a066aa5")
#options("tercen.username"= "admin")
#options("tercen.password"= "admin")

do.cluster <- function(df, nClust = "auto") {
  Y  <- dcast(df, .ri ~ .x, fun.aggregate = mean, value.var = ".y")
  ri <- Y[, 1]
  Y  <- Y[, -1]
  
  # check missing values and perform PCA
  bMissing    <- is.na(apply(Y, 1, mean))
  ri_complete <- ri[!bMissing]
  Y           <- Y[!bMissing,]
  Y           <- prcomp(Y)$x
  
  if (nClust == "auto"){
    clustering <- Mclust(Y)
  } else {
    nClust <- as.numeric(nClust)
    if (is.na(nClust)){
      stop("invalid value for number of clusters")
    }
    clustering <- Mclust(Y, G = nClust)
  }
  
  data.frame(.ri = ri_complete, .ci = df$.ci[1], clusterIdx = clustering$classification)                       
}

ctx = tercenCtx()

check(ExactNumberOfFactors, ctx, groupingType = "xAxis", nFactors = 1)

n_clusters <- ifelse(is.null(ctx$op.value("Number of clusters")), "auto", ctx$op.value("Number of clusters"))

ctx  %>% 
  select(.ci, .ri, .y, .x) %>% 
  group_by(.ci) %>%
  do(do.cluster(., n_clusters)) %>%
  ctx$addNamespace() %>%
  ctx$save()
