#load required packages 
library(tidyverse)
library(GEOquery)
library(ggpubr)
library(openxlsx)

# import row counts data 
counts_data<- read.csv("data/GSE183947_fpkm.csv")

# get metadata 

result<- getGEO(GEO= 'GSE183947', GSEMatrix = T)
class(result)
result


# meta data
metadata <- pData(phenoData(result[[1]]))
metadata |> 
  head()

# subset metadata


metadata_subset<- metadata |>
  select(c(1,10,11,17))



# data pre-processing

metadata_modified<- metadata_subset |>
  rename(tissue = characteristics_ch1, metastasis= characteristics_ch1.1) |>
  mutate(tissue = gsub('tissue: ', '', tissue)) |> 
  mutate (metastasis = gsub('metastasis: ', '', metastasis))
  
View(metadata_modified)
  
# reshaping data ( wide to long)

counts_data_long <- counts_data |> 
  rename(gene= X) |> 
  pivot_longer(-gene, 
               names_to = 'samples',
               values_to= 'fpkm')

View(counts_data_long)



# joining metadata_modified & counts_data_long

counts_final_data <- counts_data_long |>
  left_join(metadata_modified, by= c('samples' = 'description'))
  
 View(counts_final_data)

 
# export data 
 
write.csv(counts_final_data, 'data/GSE183947_counts.csv', row.names = FALSE)

