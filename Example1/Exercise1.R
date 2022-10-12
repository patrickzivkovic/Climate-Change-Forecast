# Environment and Meteorology
# Exercise 1
# Patrick Zivkovic

# In this exercise we want to compare historical data of the maximum temperature of summer
# with future data (2081-2100), which is predicted by the RCP 8.5. model. We want to calculate the
# delta (difference between these two temperatures) for the whole European region and display
# them graphically all with the help of the climate4R package.

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

clim_hist <- climatology(tx_hist)
clim_future <- climatology(tx_future)

spatialPlot(clim_hist, rev.colors = TRUE, scales=list(draw=TRUE))
spatialPlot(clim_future, rev.colors = TRUE, scales=list(draw=TRUE))

delta <- gridArithmetics(clim_future,clim_hist,operator = "-")
clim_delta <- climatology(delta)
spatialPlot(clim_delta, rev.colors = TRUE, scales=list(draw=TRUE))



