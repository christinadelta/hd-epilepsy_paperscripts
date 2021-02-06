# MAKE FIGURES FOR THE HD-EPILEPSY PAPER

# 1. MAKE PIE CHART OF THE STUDIES SPLIT INTO 2 TIME PEIODES: 2010-2015, 2016-2020

# load the library.
library(plotrix)

# Create data for the graph.
x =  c(1, 10)
lbl = c("","")
# lbl = c("2010-2015","2016-2020")

# Give the chart file a name.
png(file = "3d_pie_of_the studiesIncluded2.jpg")

# Plot the chart.
pie3D(x,labels = lbl,explode = 0.1, main = "Pie Chart of Countries ")

# Save the file.
dev.off()


