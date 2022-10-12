library(loadeR)
library(transformeR)
library(visualizeR)
library(downscaleR)
library(climate4R.climdex)

makeAggregatedDataset(source.dir = "Simulaciones/tasmax_historical/tasmax",
                      "hist.ncml")
makeAggregatedDataset(source.dir = "Simulaciones/tasmax_rcp85/tasmax",
                      "future.ncml")

tx_hist <- loadGridData(dataset = "hist.ncml",
                        var = "tasmax", 
                        season = 6:8)
tx_future <- loadGridData(dataset = "future.ncml",
                          var = "tasmax",
                          season = 6:8)

C4R.vocabulary()

file.create("dicCDX.dic")
writeLines(c("identifier,short_name,time_step,lower_time_bound,upper_time_bound,cell_meto
d,offset,scale,deaccum,derived,interface",
             "tasmax,tasmax,24h,0,24,max,-273.15,1,0,0,"), "dicCDX.dic")
SUf <- loadGridData(dataset = "future.ncml",
                    var = "tasmax",
                    season = 1:12,
                    lonLim = lon,
                    latLim = lat,
                    years = 2071:2100,
                    aggr.m = "sum", 
                    threshold = 25,
                    condition = "GT",
                    dictionary = "dicCDX.dic")
