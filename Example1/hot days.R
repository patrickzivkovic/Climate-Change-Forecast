library(loadeR)
library(transformeR)
library(visualizeR)
library(downscaleR)
library(climate4R.climdex)

lon <- c(-10, 20)
lat <- c(35, 46)

eobs<-"http://opendap.knmi.nl/knmi/thredds/dodsC/e-obs_0.25regular/tx_0.25deg_reg_v17.0.nc"
di <- dataInventory(eobs)

SU <- loadGridData(eobs, var = "tx",
                   season = 6:8, 
                   years = 1991:2000,
                   lonLim = lon, 
                   latLim = lat,
                   aggr.m = "sum", 
                   condition = "GT", 
                   threshold = 25)

# Days in Summer on which the temp was more than 25

getShape(SU)
getGridUnits((SU))
getTimeResolution(SU)

SU.annual <- aggregateGrid(SU, aggr.y = list(FUN = "sum"))

# counting all the days across the months

library(RColorBrewer)
colstx <- rev(brewer.pal(n = 9, "Spectral"))
colsindex <- rev(brewer.pal(n = 9, "RdYlBu"))
colsdelta <- brewer.pal(n = 9, "Reds")
colsbias <- brewer.pal(n = 9, "PiYG")
colssd <- brewer.pal(n = 9, "Blues")

spatialPlot(climatology(SU.annual), backdrop.theme = "countries",
            at = seq(0,90,10), col.regions = colorRampPalette(colsindex))
# seq is from 0 to 90 hot days in summer
