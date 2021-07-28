#! /usr/bin/Rscript

library("ReactomeGSA")

reactome_request = ReactomeAnalysisRequest(method = "PADOG")

reactome_request = set_parameters(request = reactome_request, max_missing_values = 0.5)
reactome_request

dataset1 = readRDS("GSE20881_ES.RDS")
## to find out about contrast terms
#str(dataset1[[1]]@phenoData@data, max.level = 2)
reactome_request = add_dataset(request = reactome_request,
                              expression_values = dataset1[[1]],
                              name = "RNA-seq1",
                              type = "rnaseq_counts",
                              comparison_factor = "source_name_ch1",
                              comparison_group_1 = "sigmoid colon biopsy from crohns disease subject",
                              comparison_group_2 = "sigmoid colon biopsy from healthy subject",
                              additional_factors = NULL,
                              discrete_norm_function = "TMM")

dataset2 = readRDS("GSE59071_ES.RDS")
reactome_request = add_dataset(request = reactome_request,
                               expression_values = dataset2[[1]],
                               name = "RNA-seq2",
                               type = "rnaseq_counts",
                               comparison_factor = "disease activity:ch1",
                               comparison_group_1 = "active",
                               comparison_group_2 = "normal",
                               additional_factors = NULL,
                               discrete_norm_function = "TMM")

result_1 = perform_reactome_analysis(request = reactome_request, compress = TRUE)

names(result_1)
result_types(result_1)

