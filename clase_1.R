library (sp)
library (raster)
library (reshape2)
library(maptools)
library(rgdal)

raster1 <- raster("1.tif")
raster2 <- raster("2.tif")
raster3 <- raster("3.tif")
raster4 <- raster("4.tif")
raster5 <- raster("5.tif")

mosaico1 <- mosaic(raster1, raster2, raster3, raster4, raster5, fun=mean)

plot(mosaico1)

pendiente_mosaico <- terrain(mosaico1, opt = "slope", unit = "degrees")

plot(pendiente_mosaico)

writeRaster(pendiente_mosaico, filename="pendiente_mosaico.tif", format="GTiff", overwrite=TRUE)

Sh_cuenca_geog <- readShapeSpatial("Cuenca_Geog.shp")
plot(Sh_cuenca_geog)

corte_mosaico <- crop(pendiente_mosaico, Sh_cuenca_geog)

pendiente_final <- mask(corte_mosaico, mask = Sh_cuenca_geog)

plot(pendiente_final)

writeRaster(pendiente_final, filename="pendiente_final.tif", format="GTiff", overwrite=TRUE)

hist(pendiente_final)

summary(pendiente_final)
