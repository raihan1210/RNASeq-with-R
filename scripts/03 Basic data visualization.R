#load required packages 
library(tidyverse)

# import data

data<- read.csv('data/GSE183947_counts.csv')

# visualization of data (structure of ggplot)
ggplot(data= , aes(x=, y= )) + geom_type()

# 1. bar plot

data |> 
  filter(gene== 'BRCA1') |>
  ggplot(aes(x= samples, y= fpkm, fill= tissue)) +
  geom_col()
  

# 2. box plot

data |> 
  filter(gene== 'BRCA1') |>
  ggplot(aes(x= metastasis, y= fpkm, fill= tissue)) +
  geom_boxplot()
  

# 3. violin plot 

data |> 
  filter(gene== 'BRCA1') |>
  ggplot(aes(x= metastasis, y= fpkm, fill= tissue)) +
  geom_violin()

# 4. histogram 

data |> 
  filter(gene== 'BRCA1') |>
  ggplot(aes(x= fpkm, fill= tissue)) +
  geom_histogram()

  
# 5. split figures

data |> 
  filter(gene== 'BRCA1') |>
  ggplot(aes(x= fpkm, fill= tissue)) +
  geom_histogram() +
  facet_wrap(~tissue)


# 5. density plot

data |> 
  filter(gene== 'BRCA1') |>
  ggplot(aes(x= fpkm, fill= tissue)) +
  geom_density() +
  facet_wrap(~tissue)
  
# 6. scatter plot

data |>
  filter(gene== 'BRCA1' | gene== 'BRCA2') |>
  # creating column for BRCA1 & BRCA2
  spread(key = gene, value = fpkm) |>
  ggplot(aes(x= BRCA1 , y= BRCA2, color= tissue)) +
  geom_point()

# add statistics

data |>
  filter(gene== 'BRCA1' | gene== 'BRCA2') |>
  # creating column for BRCA1 & BRCA2
  spread(key = gene, value = fpkm) |>
  ggplot(aes(x= BRCA1 , y= BRCA2, color= tissue)) +
  geom_point() +
  geom_smooth(method = 'lm', se= FALSE)

# hitmap

gene_of_interest <- c('BRCA1', 'BRCA2', 'TP53', 'MYCN')
data |>
  filter(gene %in% gene_of_interest) |>
  ggplot (aes(x= samples, y= gene, fill= fpkm)) +
  geom_tile() +
  scale_fill_gradient(low= 'white', high= 'red')
  