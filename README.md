# DLCP

DLCP is a deep learning - based procedure to stratify cancer patients, identify the possible clinical prognosis biomarkers and their small molecular ligands.

DLCP includes three steps:

1. performs icluster by integrating integrated genomic, transcriptomic and epigenetic data and cancer survival (DNN-c.py)

2. stratifies cancer patients cancer patients and identifies clinical prognosis biomarkers that closely related with cancer survival and tumor progression (identpatS.R)

4. screens small molecular ligands for cancer treatment (CIPHEN https://github.com/wangyc82/CIPHEN)


The requirements of DNN includes numpy, torch, torch.nn and torch.optim. The input data for training DNN includes cancer omics represented by matrices with gene as row and patient as column. The output was the survival vectors that were generated by surival status and last follow-up time.

The R codes for signature analysis required package of pheatmap to perform hierarchical clustering and capture the diverse profiles of signatures in high and low risk patients, ggpubr to display the differences in signatures between high and low risk patients. The differentially expressed and methylated analysis were performed by limma package
