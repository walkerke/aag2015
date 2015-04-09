## Functions for use in the project

# Location quotient

lq <- function(group, total) {
  num <- group / total
  denom <- sum(group) / sum(total)
  quotient <- num / denom
  x <- ifelse(total == 0, 0, quotient)
  return(x)
}

# Better z-score calculations

zscore <- function(vec) { 
  z <- (vec - mean(vec)) / sd(vec)
  z
}

# Cluster on standardized local moran's I w/spdep p-values

to_cluster <- function(stdvar, lagvar, ivar, pval) {
  
  x <- ifelse(stdvar >= 0 & lagvar >=0 & ivar[,5] <= pval, "High-high", 
              ifelse(stdvar <= 0 & lagvar <= 0 & ivar[,5] <= pval, "Low-low", 
                     ifelse(stdvar <= 0 & lagvar >=0 & ivar[,5] <= pval, "Low-high",
                            ifelse(stdvar >= 0 & lagvar <=0 & ivar[,5] <= pval, "High-low", "Not significant"))))
  
  x
  
}

# Cluster on Monte Carlo-derived p-values for LISA

to_cluster_mc <- function(stdvar, lagvar, pvar, pval) {
  
  x <- ifelse(stdvar >= 0 & lagvar >=0 & pvar <= pval, "High-high", 
              ifelse(stdvar <= 0 & lagvar <= 0 & pvar <= pval, "Low-low", 
                     ifelse(stdvar <= 0 & lagvar >=0 & pvar <= pval, "Low-high",
                            ifelse(stdvar >= 0 & lagvar <=0 & pvar <= pval, "High-low", "Not significant"))))
  
  x
  
}