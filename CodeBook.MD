---
title: "R Notebook"
output: html_notebook
---


The following script prepares, cleans and fixes the data fulfilling 5 main stages

0. Load the required package for the analysis

```{r}
library(dplyr)
```
1. Download the Information

```{r}
fileLib <- "Coursera_Final.zip"
if (!file.exists(fileLib)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, fileLib, method="curl")}


if (!file.exists("UCI HAR Dataset")) { 
      unzip(fileLib) 
}
```
2. Assign each data to variables



