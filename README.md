# DLCP

DLCP is a deep learning - based procedure to stratify cancer patients, identify the possible clinical prognosis biomarkers and their small molecular ligands.

DLCP includes four steps:

1. performs icluster by integrating integrated genomic, transcriptomic and epigenetic data and cancer survival (DNN.py)

2. stratifies cancer patients cancer patients into two subtypes with distinct cancer survival and molecular characteristics (identkeyfeatures.R)

3. identifies clinical prognosis biomarkers that closely related with cancer survival and tumor progression (identCP.R)

4. screens small molecular ligands for cancer treatment (CIPHEN)
