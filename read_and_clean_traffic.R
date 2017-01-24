
rm(list=ls())
#library(RJSONIO)
library(jsonlite)
library(tidyr)
library(dplyr)
library(iptools)
library(crafter)


project.dir <- "/root/Documents/SnortR/TrafficExamples"
stopifnot( dir.exists(file.path(project.dir))  )
setwd(file.path(project.dir))
traffic.all <- read.table(file="CTF_1.txt", quote="\"", header = T, sep=",")
