
#DrivingDurations <- read.csv(file="DrivingDurations.csv")

DrivingDurations <- read.csv(file="~/ShinyApps/map/DrivingDurations.csv")
npa <- read.csv(file="~/ShinyApps/map/npa_transpose.csv")

npa$X

npatemp <- npa

npatemp <- subset(npatemp,X=="drive_alone")
trans_npa <- as.data.frame(t(npatemp))
label_for_axis <- trans_npa[1,]
trans_npa_plot <- trans_npa[-1,]
trans_npa_plot_df <- data.frame("Metric"=trans_npa_plot,"Neighborhood"=names(trans_npa_plot))

#### Clustering

#npaclust <- npa
#npaclust <- subset(npaclust,X %in% c("id","median_age","residential_tree_canopy","commute_time"))

