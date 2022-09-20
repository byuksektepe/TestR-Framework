# ============================================================================ #
#
# TestR Framework                                                             
# 
# Licensed Under The MIT License
# 
# Copyright (c) 2022 Berkant Yüksektepe
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#   
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# ============================================================================ #


# Load Plots
source(paste0(getwd(),"/plots/load.test.plots.R"), chdir = TRUE)

logo      <- readPNG(paste0(getwd(),"/img/TestR-Logo.png"))
test_mark <- readPNG(paste0(getwd(),"/img/TestR-Logo.png"))
cover     <- readPNG(paste0(getwd(),"/img/TestR-Cover-7619720.png"))


#' Create PDF File
#' Creates pdf file by test results
#'
#' @param results : Data-Frame
#' @param automation_tag : String
#' @param description : String
#'
#' @return
#' @export PDF
#'
#' @examples
CreatePDF.TestR <- function(results,
                            automation_tag,
                            description,
                            url,
                            index)
{
  automation_tag_formatted <- str_remove_all(automation_tag, "[^A-Za-z0-9]+")
  
  pdf(file= paste0("results/pdf/",current_date,"-",automation_tag_formatted,".pdf"), 
      width = 11, 
      height = 9.5)
  
  # create a 2X2 grid
  par( mfrow= c(2,2) )
  
  # Plots
  pet <- tc_plot_elapsed_times(results)
  peth <- tc_plot_elapsed_times_histogram(results)
  prt <- tc_plot_requests_by_thread(results)
  prs <- tc_plot_requests_per_second(results)
  prc <- tc_plot_response_code(results)
  
  
  ar <- test_mark %>%
    rasterGrob(x = 0.98, 
               y=.05, 
               hjust = 1, 
               width= 0.05, 
               interpolate=TRUE) %>% annotation_custom()
  
  grid.graphs.one <- ggarrange(pet,
                           peth, 
                           prt, 
                           prs,
                           ncol = 2, nrow = 2)
  
  grid.graphs.two <- ggarrange(prc,
                           ncol = 1, nrow = 1)
  
  grid.raster(cover, vjust = 0.04, width=.99)
  
  
  grid.text("TestR Load/Performance Test Framework", 
            y=.41, 
            gp = gpar(fontface = "bold",
                      fontsize = 18))
  
  grid.text("Load Test Report", 
            y=.37,
            gp = gpar(fontface = "bold",
                      fontsize = 15))
  
  grid.text(description,
            y=.32,
            gp = gpar(fontsize = 12))
  
  grid.text(paste0(automation_tag),
            y=.16,
            gp = gpar(fontface = "bold",
                      fontsize = 15))
  
  grid.text(paste0(url),
            y=.12,
            gp = gpar(fontface = "bold",
                      fontsize = 15))
  
  grid.text(paste("Test Time:",
                   current_time,
                   "- Test Index:",
                   index),
            y=.05,
            gp = gpar(fontsize = 16))
  
  out.plots <- grid.graphs.one %>% 
    annotate_figure(bottom = text_grob(paste("\n \n This file auto generated and executed by: TestR Framework. Test Classes used. This page involves only load and performance tests, \n for more info about TestR please visit project repo: https://github.com/Berkantyuks/TestR-Framework\n"),
                                       color = "black",
                                       face = "italic", 
                                       size = 10),
                    
                    left = paste(current_time, "TestR", index),
                    
                    right = paste(current_time, "TestR", index),
                    
                    top = text_grob(paste0("\n TestR: Automated Test Results for ",automation_tag,"\n"), 
                                    color = "black", 
                                    face = "bold", 
                                    size = 14)) + ar
  
  out.stat <-  grid.graphs.two %>%
    annotate_figure(bottom = text_grob(paste("\n \n This file auto generated and executed by: TestR Framework. Test Classes used. This page involves only load and performance tests, \n for more info about TestR please visit project repo: https://github.com/Berkantyuks/TestR-Framework\n"),
                                       color = "black",
                                       face = "italic", 
                                       size = 10),
                    
                    left = paste(current_time, "TestR", index),
                    
                    right = paste(current_time, "TestR", index),
                    
                    top = text_grob(paste0("\n TestR: Automated Test Results for ",automation_tag,"\n"), 
                                    color = "black", 
                                    face = "bold", 
                                    size = 14)) + ar
  
  print(out.plots)
  print(out.stat)
  dev.off()
}