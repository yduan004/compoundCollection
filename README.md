# customCompoundDB: Cutsomize and Query Compound Annotation Database

## Introduction

This software package is the query interface for the corresponding
[compoundCollectionData](https://github.com/yduan004/compoundCollectionData) package.
It contains utilities to query the compound annotations from 
[DrugAge](https://genomics.senescence.info/drugs/), 
[DrugBank](https://www.drugbank.ca/),
[CMAP02](https://portals.broadinstitute.org/cmap/),
and [LINCS](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE92742) 
resources by providing ChEMBL ids of the query compounds.
It also supports adding custom compound annotations to the annotation SQLite
database from the `compoundCollectionData` package.

## Installation and Loading
`customCompoundDB` is a R/Bioconductor package and can be installed using 
`BiocManager::install()`.
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("customCompoundDB")
```

To obtain the most recent updates immediately, one can install it directly from 
GitHub as follows.
```r
devtools::install_github("yduan004/customCompoundDB", build_vignettes=TRUE)
```

After the package is installed, it can be loaded into an R session as follows.
```r
library(customCompoundDB)
```
For detailed description of the package, please refer to the vignette by running
```r
browseVignettes("customCompoundDB")
```

## Vignette
The vignette of this package is also available at [here](https://www.bioconductor.org/packages/release/bioc/vignettes/customCompoundDB/inst/doc/customCompoundDB.html)
