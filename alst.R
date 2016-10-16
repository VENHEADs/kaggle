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
