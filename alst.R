me<-mean(train$loss)
sd<-sd(train$loss)
xt<-train$loss>me-1*sd
train1<-train[xt,]
 
train<-train1
testm<-data.matrix(test[,2:131])
trainm<-data.matrix(train[,2:132])
 
trainm[,131]<-log(trainm[,131])
dtrain = xgb.DMatrix(trainm[,1:130], label=trainm[,131])
dtest = xgb.DMatrix(testm)



xgb_params = list(
    colsample_bytree = 0.7,
    subsample = 0.7,
    eta = 0.05,
    objective = 'reg:linear',
    max_depth = 8,
    num_parallel_tree = 10,
    min_child_weight = 3,
    base_score = 8)

gbdt = xgb.train(xgb_params, dtrain, nrounds=900,nfold=6)
pre = exp(predict(gbdt,dtest))
testx[,2]<-pre
write.csv(testx,"base8_nr900_p10.csv",row.names = FALSE)
