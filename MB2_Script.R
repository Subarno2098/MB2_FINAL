# MB2 Project
# Name: Subarno Shankar 
# Course: MSc. EAGLE (Applied Earth Observation and Geoanalysis of the Living Environment)
# University: Julius Maximilians Universität Würzburg


# Project Description: The project represents the change in Snow Cover in the mountains of Þórsmörk, Iceland from 1984 to 2021.
# The NDSI of every annual mean image from Landsat 5, Landsat  7, Landsat 8 were calculated for the prediction 
# of Snow Cover. 

# Used Data: USGS Landsat 5 TM Collection 1 Tier 1 TOA Reflectance (Landsat 5), USGS Landsat 7 Collection 1 Tier 1 TOA Reflectance (Landsat 7),
# USGS Landsat 8 Collection 1 Tier 1 TOA Reflectance (Landsat 8).

# Source of the Acquired Data: https://developers.google.com/earth-engine/datasets
# Source of Data: Landsat 5: https://developers.google.com/earth-engine/datasets/catalog/LANDSAT_LT05_C01_T1_TOA
# Landsat 7: https://developers.google.com/earth-engine/datasets/catalog/LANDSAT_LE07_C01_T1_TOA
# Landsat 8: https://developers.google.com/earth-engine/datasets/catalog/LANDSAT_LC08_C01_T1_TOA


# Bands Used: Landsat 5: (Band 2 (Green), Band 5(SWIR1))
#Landsat 7: (Band 2 (Green), Band 5(SWIR1))
# Landsat 8: (Band 3(Green), Band 6(SWIR1))

# Existing Problems in Data: Landsat 8: The annual mean image of the year 2017, 2020 have errors. 

# Literature: 


#########################################################################################################

# Getting and Setting the Working Directory 
getwd()
setwd(dir = "D:/EAGLE/MB2/final_project/results")

# Loading required libraries 
library(raster)
library(rgdal)
library(ggplot2)
library(RStoolbox)
library(cluster)
library(animation)
library(rasterVis)


# About the data



# LANDSAT 5 Data 
# Name	Description	           Resolution	  Wavelength
# B2	  Green	                 30 meters	  0.52 - 0.60 µm
# B5	  Shortwave infrared 1	 30 meters	  1.55 - 1.75 µm


# Assigning Variable (l5_data) and setting the path to extract Landsat 5 data from 1984 to 1998
l5_data <- ("D:/EAGLE/MB2/final_project/raster_data/annual_mean_raster/final_data/Landsat_5")
l5_data_list <- list.files(l5_data, pattern = "tif$", full.names = TRUE)


# band 1  = B2 Band (Green) 
# band 2 = B5 Band (Shortwave Infrared 1)
l5_b2_stack <- stack(l5_data_list, bands = 1)
l5_b5_stack <- stack(l5_data_list, bands = 2)


# Changing the default band names of the rasters in the raster stack (l5_b2_stack) to "XYYYY_a_b2"
names(l5_b2_stack) <- gsub(pattern = "s100", replacement = "b2", x = names(l5_b2_stack))


# Changing the default band names of the rasters in the raster stack (l5_b5_stack) to "XYYYY_a_b5"
names(l5_b5_stack) <- gsub(pattern = "s100", replacement = "b5", x = names(l5_b5_stack))


# creating a function to calculate NDSI (Normalized Difference Snow Index)
ndsi_calc <- function(green,swir1) {
  (green-swir1)/(green+swir1)
}


# Using raster::overlay() to calculate NDSI (Normalized Difference Snow Index)
##Setting ndsi_calc() as a function for the parameter 'fun'
l5_ndsi_brick <- overlay(x = l5_b2_stack, y = l5_b5_stack, fun = ndsi_calc)


# Renaming the layer names of the created NDSI raster stack (l5_ndsi_stack)
names(l5_ndsi_brick) <- gsub(pattern = "layer.", replacement = "Landsat_5_", x = names(l5_ndsi_brick))


# Animating the NDSI stack (l5_ndsi_stack) using terra::animate()
animate(x = l5_ndsi_brick, pause = 0.50, n = 1, col = rainbow(100))



# LANDSAT 7 Data 
# Name	Description	           Resolution	  Wavelength
# B2	  Green	                 30 meters	  0.52 - 0.60 µm
# B5	  Shortwave infrared 1	 30 meters	  1.55 - 1.75 µm


# Assigning Variable (l7_data) and setting the path to extract Landsat 7 data from 1999 to 2012
l7_data <- ("D:/EAGLE/MB2/final_project/raster_data/annual_mean_raster/final_data/Landsat_7")
l7_data_list <- list.files(l7_data, pattern = "tif$", full.names = TRUE)


# band 1  = B2 Band (Green) 
# band 2 = B5 Band (Shortwave Infrared 1)
l7_b2_stack <- stack(l7_data_list, bands = 1)
l7_b5_stack <- stack(l7_data_list, bands = 2)


# Changing the default band names of the rasters in the raster stack (l7_b2_stack) to "XYYYY_a_b2"
names(l7_b2_stack) <- gsub(pattern = "s100", replacement = "b2", x = names(l7_b2_stack))


# Changing the default band names of the rasters in the raster stack (l7_b5_stack) to "XYYYY_a_b5"
names(l7_b5_stack) <- gsub(pattern = "s100", replacement = "b5", x = names(l7_b5_stack))


# Using raster::overlay() to calculate NDSI (Normalized Difference Snow Index)
##Setting ndsi_calc() as a function for the parameter 'fun'
l7_ndsi_brick <- overlay(x = l7_b2_stack, y = l7_b5_stack, fun = ndsi_calc)


# Renaming the layer names of the created NDSI raster stack (l7_ndsi_stack)
names(l7_ndsi_brick) <- gsub(pattern = "layer.", replacement = "Landsat_7_", x = names(l7_ndsi_brick))


# Animating the NDSI stack (l7_ndsi_stack) using terra::animate()
animate(x = l7_ndsi_brick, pause = 0.50, n = 1, col = rainbow(100))


# LANDSAT 8 Data 
# Name	Description	           Resolution	  Wavelength

# B3	  Green	                 30 meters	  0.53 - 0.59 µm
# B6	  Shortwave infrared 1	 30 meters	  1.57 - 1.65 µm

# Assigning Variable (l8_data) and setting the path to extract Landsat  data from 2013 to 2021
l8_data <- ("D:/EAGLE/MB2/final_project/raster_data/annual_mean_raster/final_data/Landsat_8")
l8_data_list <- list.files(l8_data, pattern = "tif$", full.names = TRUE)


# band 1  = B2 Band (Green) 
# band 2 = B5 Band (Shortwave Infrared 1)
l8_b3_stack <- stack(l8_data_list, bands = 1)
l8_b6_stack <- stack(l8_data_list, bands = 2)


# Changing the default band names of the rasters in the raster stack (l8_b3_stack) to "XYYYY_a_b3"
names(l8_b3_stack) <- gsub(pattern = "s100", replacement = "b3", x = names(l8_b3_stack))


# Changing the default band names of the rasters in the raster stack (l8_b6_stack) to "XYYYY_a_b6"
names(l8_b6_stack) <- gsub(pattern = "s100", replacement = "b6", x = names(l8_b6_stack))


# Using raster::overlay() to calculate NDSI (Normalized Difference Snow Index)
##Setting ndsi_calc() as a function for the parameter 'fun'
l8_ndsi_brick <- overlay(l8_b3_stack, l8_b6_stack, fun = ndsi_calc)


# Renaming the layer names of the created NDSI raster stack (l7_ndsi_stack)
names(l8_ndsi_brick) <- gsub(pattern = "layer.", replacement = "Landsat_8_", x = names(l8_ndsi_brick))


# Animating the NDSI brick (l8_ndsi_brick) using terra::animate()
animate(x = l8_ndsi_brick, pause = 0.50, n = 1, col = rainbow(100))


# Stacking NDSI rasters of Landsat 5 of the years 1984-1998, NDSI rasters of Landsat 7 of the years 1999-2012 and Landsat 8 2013-2016, 2018-2019, 2021
l5_l7_l8_ndsi_stack <- stack(l5_ndsi_brick, l7_ndsi_brick, l8_ndsi_brick)


# Animating the NDSI stack (l5_l7_ndsi_stack) using terra::animate()
l5_l7_l8_ndsi_animate <- animate(l5_l7_l8_ndsi_stack, pause = 0.5, n = 1, col = rainbow(100))


# Plotting Histogram of l5_l7_l8_ndsi_stack to monitor the change in pixel Values
hist(x = l5_l7_l8_ndsi_stack,main = "NDSI: Distribution of pixels", breaks = 50, col = "springgreen", xlab = "NDSI Index Values")






# # Classifying the raster stack (l5_l7_l8_ndsi_stack_df) using RStoolbox::unsuperClass()
# # Landsat 5
# set.seed(5)
# l5_1_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_1, nClasses = 5)
# l5_2_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_2, nClasses = 5)
# l5_3_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_3, nClasses = 5)
# l5_4_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_4, nClasses = 5)
# l5_5_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_5, nClasses = 5)
# l5_6_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_6, nClasses = 5)
# l5_7_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_7, nClasses = 5)
# l5_8_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_8, nClasses = 5)
# l5_9_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_9, nClasses = 5)
# l5_10_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_10, nClasses = 5)
# l5_11_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_11, nClasses = 5)
# l5_12_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_12, nClasses = 5)
# l5_13_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_13, nClasses = 5)
# l5_14_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_14, nClasses = 5)
# l5_15_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_15, nClasses = 5)
# 
# # Classifying the raster stack (l5_l7_l8_ndsi_stack_df) using RStoolbox::unsuperClass()
# Landsat 7
# l5_
# set.seed(5)
# l5_1_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_1, nClasses = 5)
# l5_2_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_2, nClasses = 5)
# l5_3_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_3, nClasses = 5)
# l5_4_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_4, nClasses = 5)
# l5_5_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_5, nClasses = 5)
# l5_6_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_6, nClasses = 5)
# l5_7_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_7, nClasses = 5)
# l5_8_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_8, nClasses = 5)
# l5_9_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_9, nClasses = 5)
# l5_10_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_10, nClasses = 5)
# l5_11_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_11, nClasses = 5)
# l5_12_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_12, nClasses = 5)
# l5_13_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_13, nClasses = 5)
# l5_14_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_14, nClasses = 5)
# l5_15_ndsi_uc <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_15, nClasses = 5)
# 
# l5_l7_l8_ndsi_uc <- apply(l5_l7_l8_ndsi_stack_df, MARGIN = 2, FUN = ndsi_uc)
# 
# 
# set.seed(3)
# kmeans_out <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_8_1, nClasses = 3)
# 
# set.seed(3)
# kmeans_out <- unsuperClass(l5_l7_l8_ndsi_stack$Landsat_5_1, nClasses = 3)
# 
# 
# 
# kmeans_out$model
# 
# plot(kmeans_out$map)
# 
# 
# p224r63_2011_uc
# 
# plot(p224r63_2011_uc$map)
# 
# 
# ggplot(l5_l7_l8_ndsi_stack_df) + aes(x = `Landsat_5_1`, colour = "green") + geom_histogram(bins = 10) 
# 
# cor_1 <- cor(x = l5_l7_l8_ndsi_stack_df$Landsat_5_1, l5_l7_l8_ndsi_stack_df$Landsat_8_1, use = "complete.obs")
# plot(cor_1)
