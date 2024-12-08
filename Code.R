# Load required libraries
library(sf)
library(terra)
library(ggplot2)
library(ggspatial)
library(dplyr)
library(tidyr)
library(gganimate)
library(viridis)

# File paths
shapefile_path <- "D:/Rstudio_2/Heatmap/Data/Ap.shp"
dem_path <- "D:/Rstudio_2/Heatmap/Ap_DEM.tif"
output_dir <- "D:/Rstudio_2/Heatmap/Frames"
if (!dir.exists(output_dir)) dir.create(output_dir)

# Load shapefile and DEM
accident_data <- st_read(shapefile_path)
dem <- rast(dem_path)

# Step 1: Get CRS for shapefile and DEM
shapefile_crs <- st_crs(accident_data)$wkt  # Use WKT format for shapefile CRS
raster_crs <- crs(dem)  # Get CRS for DEM raster

# Print both CRS to check
print(shapefile_crs)
print(raster_crs)

# If shapefile CRS is different from DEM CRS, transform shapefile to DEM's CRS
if (shapefile_crs != raster_crs) {
  accident_data <- st_transform(accident_data, crs = raster_crs)
}

# Reshape the data for visualization (Accidents for 2008-2015)
accident_data_long <- accident_data %>%
  select(STATE, X2008:X2015) %>%
  pivot_longer(cols = X2008:X2015, 
               names_to = "Year", 
               values_to = "Accidents")

# Convert 'Year' to numeric
accident_data_long <- accident_data_long %>%
  mutate(Year = as.numeric(sub("X", "", Year)))

# Merge reshaped data back with geometry for proper mapping
accident_data_long <- left_join(accident_data, accident_data_long, by = "STATE")

# Animate the accident data over the years using state polygons
plot_animation <- ggplot() +
  # Plot the DEM as a background raster
  annotation_raster(as.raster(dem), xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  
  # Plot accident data as polygons (states colored by accidents for the year)
  geom_sf(data = accident_data_long, aes(fill = Accidents), color = "black", alpha = 0.7) +
  scale_fill_viridis_c(option = "inferno") +  # Color scale based on accidents
  labs(
    title = "Accidents Due To Exceeding Lawful Speed - Persons Injured", 
    subtitle = "Year: {closest_state}", 
    x = "Longitude", 
    y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title.position = "panel",  # Center the title in the panel
    plot.title.align = 0.5  # Align title to the center
  ) +
  # Animate across the 'Year' variable
  transition_states(Year, transition_length = 2, state_length = 1)  # Transition between years

# Save animation as a GIF or video
anim_save(paste(output_dir, "accidents_animation_2.gif", sep = "/"), plot_animation)