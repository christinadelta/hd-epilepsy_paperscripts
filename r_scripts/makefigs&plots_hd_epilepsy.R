# MAKE FIGURES FOR THE HD-EPILEPSY PAPER

# 1. MAKE PIE CHART OF THE STUDIES SPLIT INTO 2 TIME PEIODES: 2010-2015, 2016-2020

# load the library.
library(plotrix)
library(ggplot2)

# Create data for the graph.
x =  c(1, 10)
lbl = c("","")
# lbl = c("2010-2015","2016-2020")

# Give the chart file a name.
png(file = "3d_pie_of_the studiesIncluded2.jpg")

# Plot the chart.
pie3D(x,labels = lbl,explode = 0.1, main = "Pie Chart of studies by years ")

# Save the file.
dev.off()

# --------------------------------------
# 2. MAKE PIE CHART OF THE POPULATION IN THE STUDY: CLINICAL AND HEALTHY SUBJECTS

# Create data for the graph.
x =  c(3, 1, 7)
lbl = c("","","")

# Give the chart file a name.
png(file = "3d_pie_of_the_population.jpg")

# Plot the chart.
pie3D(x,labels = lbl,explode = 0.1, main = "Pie Chart of population in the studies")

# Save the file.
dev.off()

# --------------------------------------
# 3. Create bar-plot with the stimulation sites and number of studies

# for this plot we'll use the ggplot2 package which we loaded on the top

# create a dataframe with the data
df = data.frame(stim_site=c("PFC", "Motor Cortex", "SMA", "Visual Cortex", 
                       "SMC", "Pecuneus", "Parietal Cortex"),
                 N_studies=c(6, 2, 1, 2, 1, 1, 1))

# take a look at the data
head(df)

# make the plot
p = ggplot(df, aes(x=stim_site, y=N_studies, fill=stim_site)) +
  geom_bar(stat="identity") + theme_minimal()

# visualize 
p

# make the bar plot horizontal
p + coord_flip()

# ---------------------------------------------
# 4. Make bubble plot of TEPs, source model and number of studies





