# install required R packages 
install.packages(c('tidyverse', 'ggpubr', 'openxlsx'))

#install required bioconductor packages 
BiocManager::install(c('GEOquery', 'TCGAbiolinks','DESeq2', 'metaRNASeq', 'limma','edgeR', 'airway'))

install.packages(c("DESeq2", "metaRNASeq", "limma", "edgeR"), force = TRUE)

#load required packages 
library(tidyverse)
library(GEOquery)
library(ggpubr)
library(openxlsx)


# data manipulation
# import data

data<- read.csv('data/GSE183947_fpkm.csv')

# data exploration 
# dimension of data

dim(data)
ncol(data)
nrow(data)

# examine first few rows

head(data)
head(data, 10)

# examine last few rows

tail(data)
tail (data, 10)

# sampling 

sample(data)
sample_n(data, 100)
sample_frac(data, 0.25)

# is there any missing value

is.na(data)
sum(is.na(data))


#1. select (sub-setting column)
#1.1 select single column by col number

select(data,1)

#1.2 select multiple column by col number

select(data, c(1,3,5))

#1.3 select range of column using : operator

select(data, 1:3)

#1.4 select single column by col name

select(data, X)



#2. filter

#2.1 filter data using (==)

filter (data, column name == 'yes')

#2.2 filter using (>)
filter (data, fpkm > 10)


#2.3 filter using (<)
filter (data, fpkm < 10)

names (data)

# filter data using (&)
filter(data, metastasis == 'yes' & fpkm > 10)


# filter data using (|)

filter(data, metastasis == 'yes' | fpkm > 10)

#select and filter

new_data <- select(data, gene, metastasis, fpkm)
filter (new_data, metastasis=='yes')

# chaining method (pipe operator |> )

data |> 
  select (gene, metastasis, fpkm) |> 
  filter (metastasis =='yes')

# multiple filtering criteria (%in%)

data |> 
  filter(gene %in% c("BRCA1", 'BRCA2')) |> 
  head()
 

#3. mutate (creating column)

data |> 
  mutate (fpkm_log = log(fpkm)) |> 
  head()



#4. grouping and summarizing
  

# giving summary column name
data |> 
  filter( gene== 'BRCA1' | gene== 'BRACA1') |> 
  group_by(tissue, gene) |>
  sumarise( mean_fpkm = mean(fpkm)
            median_fpkm = median(fpkm))

#5. arrange

data |> 
  filter( gene== 'BRCA1' | gene== 'BRACA1') |> 
  group_by(tissue, gene) |>
  sumarise( mean_fpkm = mean(fpkm)
            median_fpkm = median(fpkm)) |> 
  arrange(desc(mean_fpkm))




  
