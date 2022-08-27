# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #

library(ggplot2)
library(grid)
library(gridExtra)
library(png)
library(jpeg)
library(stringr)


# Load Plots
source(paste0(getwd(),"/plots/load.test.plots.R"), chdir = TRUE)

## Create pdf file by test results
CreatePDF.TestR <- function(results, automation_tag)
{
  automation_tag_formatted <- str_remove_all(automation_tag, "[^A-Za-z0-9]+")
  
  pdf(file= paste0("results\\pdf\\",current_date,"-",automation_tag_formatted,".pdf"), 
      width = 11, 
      height = 9.5)
  
  # create a 2X2 grid
  par( mfrow= c(2,2) )
  
  # Plot Results - don't touch here
  pet <- tc_plot_elapsed_times(results)
  peth <- tc_plot_elapsed_times_histogram(results)
  prt <- tc_plot_requests_by_thread(results)
  prs <- tc_plot_requests_per_second(results)
  
  
  ar <- test_mark %>%
    rasterGrob(x = 0.98, 
               y=.05, 
               hjust = 1, 
               width= 0.05, 
               interpolate=TRUE) %>% annotation_custom()
  
  grid_graphs <- ggarrange(pet,
                           peth, 
                           prt, 
                           prs,
                           ncol = 2, nrow = 2)
  
  grid.raster(cover, vjust = 0.04, width=.99)
  
  
  grid.text("TestR Load/Performance Test Framework", y=.26, gp = gpar(fontface = "bold", fontsize = 18))
  grid.text("Load Test Report", y=.22, gp = gpar(fontface = "bold", fontsize = 15))
  grid.text(paste0(automation_tag), y=.16, gp = gpar(fontface = "bold", fontsize = 15))
  
  grid.text(paste0(current_time), y=.08, gp = gpar(fontsize = 18))
  
  out <- grid_graphs %>% 
    annotate_figure(bottom = text_grob(paste("\n \n This file auto generated and executed by: TestR Framework. Test Classes used. This page involves only load and performance tests, \n for more info about TestR please visit project repo: https://github.com/Berkantyuks/TestR-Framework\n"),
                                       color = "black",
                                       face = "italic", 
                                       size = 10),
                    
                    left = paste(current_time, "TestR"),
                    
                    right = paste(current_time, "TestR"),
                    
                    top = text_grob(paste0("\n Automated NF Test Results for ",automation_tag,"\n"), 
                                    color = "black", 
                                    face = "bold", 
                                    size = 14)) + ar
  
  print(out)
  dev.off()
}