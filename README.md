# Visualization-of-Speeding-Related-Accidents-and-Injuries-2008-2015-Using-R

Overview:
This project demonstrates how to visualize accidents due to exceeding lawful speed limits in India from 2008 to 2015, using geospatial data and R. 
The visualization utilizes accident data from the Survey of India and Digital Elevation Model (DEM) data to provide insights into accident distribution over time,
highlighting regions with higher accident rates and visualizing trends through animated maps.

Prerequisites:
Ensure that you have R installed along with the following libraries:
  pacman
  sf
  terra
  ggplot2
  gganimate
  viridis
  dplyr
  tidyverse

You can install them using the following commands:
  install.packages(c("sf", "terra", "ggplot2", "gganimate", "viridis", "dplyr", "tidyverse"))

Steps:
  1. Install and Load Libraries
      Start by loading the necessary libraries in R.
  2. Set Working Directory for Data
      Create a working directory to store the shapefiles and DEM data for India.
  3. Load and Prepare Data
      Load the accident data shapefile and DEM data.
  4. Ensure CRS Consistency
      Check and match the Coordinate Reference System (CRS) of the shapefile and DEM.
  5. Reshape and Process Accident Data
      Prepare accident data for visualization by reshaping it.
  6. Merge Accident Data with Geospatial Data
      Merge the reshaped accident data back with the geometrical data for proper mapping.
  7. Create Animated Visualization
      Use ggplot2 and gganimate to create an animated visualization of accidents over time.
  8. Save the Animation
      Save the generated animation as a GIF or video.

Conclusion:
This project effectively uses R to visualize accidents related to speeding in India over a period of eight years (2008-2015). 
The animated map demonstrates how accidents have fluctuated year by year, and the spatial distribution of such accidents in relation to the elevation context. 
This visualization can serve as a valuable resource for policymakers and safety organizations, enabling better decision-making for reducing accidents and promoting road safety.

Optional:
  You can access the accident data and DEM data for other regions by visiting the following resources:
    Accident Data: 'https://www.data.gov.in/'
    OpenTopography DEM Data:'https://opentopography.org/'
  

