# MAKE FIGURES FOR THE HD-EPILEPSY PAPER

# 1. MAKE PIE CHART OF THE STUDIES SPLIT INTO 2 TIME PEIODES: 2010-2015, 2016-2020

# load the library.
library(plotrix)
library(ggplot2)

# Create data for the graph.
x =  c(4, 11)
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
x =  c(3, 1, 1, 10)
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
                       "SMC", "Pecuneus", "Parietal Cortex", "Premotor Cortex", "Frontal Cortex" ),
                 N_studies=c(7, 2, 1, 2, 1,1, 4, 1, 2))

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

library(readxl)
# load the model data:
bubbledata = read_excel("Desktop/HD_epilepsy/bubble_info2.xls")
df = bubbledata

# set the theme function theme_bw() as the default theme:
theme_set(
  theme_bw() + 
    theme(legend.position = "top")
)

# Inspect the data
# head(df[, c("TEPs","TEPnum", "deflection", "timewindow", "studynum", "inversesolution")], 4)

# Convert deflection as a grouping variable
df$deflection2 = as.factor(df$deflection2)

ggplot(df, aes(x = inversesolution, y = timewindow)) + 
  geom_point(aes(color = deflection2, size = studynum), alpha = 0.5) +
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07", "#999999")) +
  scale_size(range = c(1, 10))  # Adjust the range of points size


# version 2 of the bubble plot
ggplot(df, aes(x = timewindow, y = inversesolution)) + 
  geom_point(aes(color = deflection2, size = deflection), alpha = 0.5) +
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07", "#999999")) +
  scale_size(range = c(1, 10))  # Adjust the range of points size

#----------------------------------------------

# 5. Make pie chart, for source reconstruction models and number of studies 

# Create data for the graph.
x =  c(2,8,4,1,1)
lbl = c("","","","")

# Give the chart file a name.
png(file = "3d_pie_of_the studiesByCortRec.jpg")

# Plot the chart.
pie3D(x,labels = lbl,explode = 0.1, main = "Pie Chart of studies by cortical reconstruction ")

# Save the file.
dev.off()

# ---------------------------------------------------

# 6. circular packing for proportion of studies, TEPs and cortical solution method 

# Libraries
library(ggraph)
library(igraph)
library(tidyverse)
library(viridis)

# Add the data.tree library
library(data.tree)

# Rebuild the data
edges = flare$edges
vertices = flare$vertices

# Transform it in a 'tree' format
tree = FromDataFrameNetwork(edges)

# Then I can easily get the level of each node, and add it to the initial data frame:
mylevels = data.frame( name=tree$Get('name'), level=tree$Get("level") )
vertices = vertices %>% 
  left_join(., mylevels, by=c("name"="name"))

# Now we can add label for level1 and 2 only for example:
vertices = vertices %>% 
  mutate(new_label=ifelse(level==2, shortName, NA))
mygraph = graph_from_data_frame( edges, vertices=vertices )

# Make the graph
ggraph(mygraph, layout = 'circlepack', weight="size") + 
  geom_node_circle(aes(fill = as.factor(depth), color = as.factor(depth) )) +
  scale_fill_manual(values=c("0" = "white", "1" = viridis(4)[1], "2" = viridis(4)[2], "3" = viridis(4)[3], "4"=viridis(4)[4])) +
  scale_color_manual( values=c("0" = "white", "1" = "black", "2" = "black", "3" = "black", "4"="black") ) +
  geom_node_label( aes(label=new_label), size=4) +
  theme_void() + 
  theme(legend.position="FALSE", plot.margin = unit(rep(0,4), "cm"))



