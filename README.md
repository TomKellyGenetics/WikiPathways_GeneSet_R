# WikiPathways_GeneSet_R
Shell/R scripts to import gene sets into R (compatible with  `safe::getCmatrix`)

`import_gene_set.R` will load bioconductor packages for KEGG, Gene Ontology (GO), Reactome
and call other scripts for WikiPathways: `download_WikiPathways.sh` (will run download_WikiPathways.R)

Files used for WikiPathways will be stored in subdirectory Human_WP, output RData files ready to load in current directory: either run scripts to update datasets from web or use existing RData files (last updated 23 June 2015)

Entrez gene IDs used to define gene sets (pathways): requires `org.Hs.eg.db` package to map to Gene Symbols

WikiPathway download can be modified by altering the `wget <url>` in `download_WikiPathways.sh`
- change _Genus%20species_ as needed
- remove _tags_ (as shown by commented out `wget` line)

Requires:
- any recent version of R
- access to bioconductore packages
- BASH (or and Unix shell)
