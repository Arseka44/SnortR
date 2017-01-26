rm(list=ls())
library(shiny)
library(shinydashboard)
library(jsonlite)
library(tidyr)
library(dplyr)
library(iptools)
library(crafter)
library(DT)
#source("get_traffic.R")
# read traffic
project.dir <- "/root/Documents/SnortR/TrafficExamples"
stopifnot( dir.exists(file.path(project.dir))  )
setwd(file.path(project.dir))
traffic.all <- read.table(file="CTF_1.txt", quote="\"", header = T, sep=",")
# extract from traffic tcp stream`s
tcp_streams <- filter(traffic.all, !is.na(tcp.stream))
