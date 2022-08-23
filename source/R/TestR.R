# Set Environment Variable
Sys.setenv("LOADTEST_JMETER_PATH"="C:\\apache-jmeter-5.5\\bin\\jmeter.bat")

#Check libraries installed
source(paste0(getwd(),"/source/lib/init.R"), chdir = TRUE)
source(paste0(getwd(),"/source/plots/load_test_plots.R"), chdir = TRUE)

# Load libraries
library(loadtest)
library(ggpubr)
library(ggplot2)
library(grid)
library(gridExtra)
library(png)
library(jpeg)
library(stringr)
library(magrittr)


test_url <- c("https://kariyer.baykartech.com")
test_url_formatted <- str_replace(test_url, "https://","")

logo <- readPNG("img/TestR-Logo.png")
test_mark <- readPNG("img/TestR-Logo.png")

cover <- readPNG("img/TestR-Cover-7619720.png")

thr = 7
loops = 40

automation_tag <- paste0(test_url_formatted," (THR: ",thr,", LPS: ",loops,")")

# Run loadtest
results <- loadtest(url = test_url,
                    method = "GET",
                    threads = thr,
                    loops = loops,
                    delay_per_request=100)

# Print Results
print(results)

head(results)


## Create pdf file by test results
CreatePDF.LoadTest <- function(results)
{
  automation_tag_formatted <- str_remove_all(automation_tag, "[^A-Za-z0-9]+")
  pdf(file= paste0("results\\pdf\\",current_date,"test_result_",automation_tag_formatted,".pdf"), width = 11, height = 9.5)
  
  # create a 2X2 grid
  par( mfrow= c(2,2) )
  
  # Plot Results - don't touch here
  pet <- tc_plot_elapsed_times(results)
  peth <- tc_plot_elapsed_times_histogram(results)
  prt <- tc_plot_requests_by_thread(results)
  prs <- tc_plot_requests_per_second(results)

  
  ar <- annotation_custom(rasterGrob(test_mark, 
                                     x = 0.98, 
                                     y=.05, 
                                     hjust = 1, 
                                     width= 0.05, 
                                     interpolate=TRUE))
  
  grid_graphs <- ggarrange(pet,
                           peth, 
                           prt, 
                           prs,
                           ncol = 2, nrow = 2)
  
  grid.raster(cover, vjust = 0.04, width=.99)
  

  grid.text("TestR Load/Performance Test Framework", y=.26, gp = gpar(fontface = "bold", fontsize = 18))
  grid.text("Load Test Report by Berkant", y=.22, gp = gpar(fontface = "bold", fontsize = 15))
  grid.text(paste0(automation_tag), y=.16, gp = gpar(fontface = "bold", fontsize = 15))
  
  grid.text(paste0(current_time), y=.08, gp = gpar(fontsize = 18))
  
  out <- annotate_figure(grid_graphs,
                         bottom = text_grob(paste("\n \n This file auto generated and executed by: Berkant Yüksektepe. Test Classes used. This page involves only load and performance tests, \n for more information please visit project repo: https://github.com/Berkantyuks/TestR-Framework\n"),
                                            color = "black",
                                            face = "italic", 
                                            size = 10),
                         left = paste(current_time, "TestR"),
                         right = paste(current_time, "TestR"),
                         top = text_grob(paste0("\n Automated NF Test Results for ",automation_tag,"\n"), color = "black", face = "bold", size = 14))  + ar
  
  print(out)
  dev.off()
}

CreatePDF.LoadTest(results)


# Generate HTML Report
loadtest_report(results,paste0(getwd(),"/results/html/"))