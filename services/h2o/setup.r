#!/usr/bin/Rscript
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }
install.packages("h2o", repos=(c("http://s3.amazonaws.com/h2o-release/h2o/rel-knuth/11/R", getOption("repos"))))