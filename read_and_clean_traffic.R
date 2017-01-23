rm(list=ls())
#library(RJSONIO)
library(jsonlite)
library(tidyr)
library(dplyr)
library(iptools)
library(crafter)
setwd("/root/Documents/SnortR")
#traffic.json <- fromJSON("tsharkJson.json")
traffic.json <- fromJSON("trafiJsonForPacket.json") 
traffic <- traffic.json$`_source`

traffic <- cbind.data.frame(
                  # frame info
                  traffic$layers$frame$frame.time, traffic$layers$frame$frame.time_delta,
                  traffic$layers$frame$frame.number, traffic$layers$frame$frame.len,
                  traffic$layers$frame$frame.protocols,
                  # ether info
                  traffic$layers$eth$eth.dst, traffic$layers$eth$eth.src, traffic$layers$eth$eth.type, 
                  # ip info
                  traffic$layers$ip$ip.version, traffic$layers$ip$ip.len, traffic$layers$ip$ip.id,
                  traffic$layers$ip$ip.flags, traffic$layers$ip$ip.frag_offset, traffic$layers$ip$ip.ttl,
                  traffic$layers$ip$ip.proto, traffic$layers$ip$ip.src, traffic$layers$ip$ip.dst,
                  #Source  GeoIP
                  traffic$layers$ip[[21]][[2]], traffic$layers$ip[[21]][[3]],
                  traffic$layers$ip[[21]][[5]], traffic$layers$ip[[21]][[7]], 
                  #Destination GeoIP
                  traffic$layers$ip[[22]][[2]], traffic$layers$ip[[22]][[3]], 
                  traffic$layers$ip[[22]][[5]], traffic$layers$ip[[22]][[7]],
                  # tcp
                  traffic$layers$tcp$tcp.srcport, traffic$layers$tcp$tcp.dstport, traffic$layers$tcp$tcp.stream,
                  traffic$layers$tcp$tcp.len, traffic$layers$tcp$tcp.seq, traffic$layers$tcp$tcp.hdr_len,
                  traffic$layers$tcp$tcp.flags_tree[[1]],# tcp.flags.res
                  traffic$layers$tcp$tcp.flags_tree[[2]],# tcp.flags.ns
                  traffic$layers$tcp$tcp.flags_tree[[3]],# tcp.flags.cwr
                  traffic$layers$tcp$tcp.flags_tree[[4]],# tcp.flags.ecn
                  traffic$layers$tcp$tcp.flags_tree[[5]],# tcp.flags.urg
                  traffic$layers$tcp$tcp.flags_tree[[6]],# tcp.flags.ack
                  traffic$layers$tcp$tcp.flags_tree[[7]],# tcp.flags.push
                  traffic$layers$tcp$tcp.flags_tree[[8]],# tcp.flags.reset
                  traffic$layers$tcp$tcp.flags_tree[[9]],# tcp.flags.syn
                  traffic$layers$tcp$tcp.flags_tree[[10]],# tcp.flags.fin
                  traffic$layers$tcp$tcp.window_size   
                  
                                    )

    colnames(traffic) <- c(
                      # frame info cname
                      "frame.time", "frame.time.delta", "frame.number", "frame.len", "frame.protocols",
                      #ether info cname
                      "eth.dst", "eth.src", "eth.type",
                      # ip info cnames
                      "ip.version", "ip.len", "ip.id",
                      "ip.flags", "ip.frag.offset", "ip.ttl",
                      "ip.proto", "ip.src", "ip.dst",
                      "src.geoip.ansum", "src.country", 
                      "src.geoip.lat", "src.geoip.lon",
                      "dst.geoip.ansum", "dst.country", 
                      "dst.geoip.lat", "dst.geoip.lon",
                      #tcp info cname
                      "tcp.srcport", "tcp.dstport", "tcp.stream",
                      "tcp.len", "tcp.seq", "tcp.hdr_len",
                      "tcp.flags.res", "tcp.flags.ns", "tcp.flags.cwr", "tcp.flags.ecn",
                      "tcp.flags.urg", "tcp.flags.ack", "tcp.flags.push", "tcp.flags.reset",
                      "tcp.flags.syn", "tcp.flags.fin", "window_size"
                      
                      )
    
   


#--------------------------------------             
connDB <-dbConnect(MySQL(),
                   user = 'root',
                   #password = '34times34',
                   host = '127.0.0.1',
                   dbname = 'mts'
)
dbGetInfo(connDB)
dbListTables(connDB)
dbWriteTable(connDB, name = 'mts_table', value = user.info.message.table, overwrite=TRUE)

dbDisconnect(connDB)





hbot <- read_pcap(system.file("tsharkPcap.pcap", package="crafter"))




