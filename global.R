library(ggplot2)
library(plyr)
#load data
babynames <- read.csv("data/baby-names.csv", stringsAsFactors = FALSE)

#helper fnction (splits the input name string into a vector of names)
splitNames <- function(inputNames){
  
  splitNames <- gsub("( )?,( )?", ",", inputNames)
  totalNames <- strsplit(splitNames, split = ",")[[1]]
  
  return(totalNames)
  
}

plotNames <- function(inputNames, inputSex, bottomYear, topYear, inputPlotType){
  
  bottomYear <- as.numeric(bottomYear)
  topYear <- as.numeric(topYear)
  
  totalNames <- splitNames(inputNames)
  
  plot.type <- switch(inputPlotType, 
                      "areaplot" = geom_area(aes(group = name, order = desc(name), fill = name), na.rm = TRUE),
                      "lineplot" = geom_line(aes(colour = name), size = 1.8),
                      "boxplot" = geom_boxplot(aes(group = round_any(year, 10, floor)))
  )
  
  nameSummary <- subset(babynames, name %in% totalNames & sex %in% inputSex)
  
  if(nrow(nameSummary) == 0) {
    
    "empty"
    
  } else {
   
    cbbPalette <- c("red2", "navy", "limegreen", "darkorchid", "cyan3", "deeppink", "seagreen", "royalblue")
    
    if(length(inputSex) == 1){
      
      ggplot(nameSummary, aes(year, percent)) + plot.type + scale_colour_manual(values = cbbPalette) + 
        scale_x_continuous(limits = c(bottomYear, topYear), breaks = seq(from = bottomYear, to = topYear, by = 10)) +
        labs(x = 'Year', y = 'Proportion', colour = 'Name') + theme_bw()
      
    } else if(length(inputSex) == 2){
      
      ggplot(nameSummary, aes(year, percent)) + plot.type + scale_colour_manual(values = cbbPalette) + 
        scale_x_continuous(limits = c(bottomYear, topYear), breaks = seq(from = bottomYear, to = topYear, by = 10)) +
        labs(x = 'Year', y = 'Proportion', colour = 'Name') + facet_wrap(~sex, ncol=1) + theme_bw()
      
    }
    
  }
  
}
