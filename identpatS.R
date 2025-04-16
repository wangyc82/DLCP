#this procedure is to get the subtypes of patients with diffrent survival and molecular feature, and identify prognosis biomarkers

#suppose you got the signatures based on DNN

#taken gene expression as anexample, the signatures in expression were in testdata
# time and status is survival information

pat_exp<-testdata[,1:100]

# library(pheatmap)
hl<-hclust(dist(pat_exp),method = "ward.D2")
clusMember=cutree(hl,k=2)

#draw pheatmap to see the diffrences of expression in two subtypes

pheatmap(t(pat_exp[c(which(clusMember==1),which(clusMember==2)),]),cluster_rows = TRUE,cluster_cols = FALSE,cellwidth = 6,cellheight = 0.5)

#for survival test
library(survival)
ggsurvplot(survfit(Surv(time, status) ~ expression, data =data.frame(status=event_vec,time=OS.time,expression=ifelse(pat_exp[,candi_gene]<median(pat_exp[,candi_gene]),"low","high")[-82])),pval = TRUE, conf.int = TRUE, risk.table = FALSE, risk.table.col = "strata", linetype = "strata",surv.median.line = "hv", ggtheme = theme_bw(), palette = c("#ADE0B4", "#5DBFE9"),title = paste("TCGA-LIHC-OS for candidate gene",candi_gene))

#for expression test
library(ggpubr)
ggboxplot(data.frame(expression=c(pat_exp[which(clusMember==1),candi_gene],pat_exp[which(clusMember==2),candi_gene]),type=rep(c("clusI","clusII"),table(clusMember))),x="type",y="expression",add = "jitter",palette = c("#ADE0B4", "#5DBFE9"),color = "type")+stat_compare_means(comparisons = list(c("clusI","clusII")),method = "wilcox.test",label = "p.signif",size=5)+labs(title ="",x="",y=paste(candi_gene[1],"expression"))+theme(text = element_text(size=15),legend.position = "none")

#identify the candidate prognosis biomarkers

# to get sigmutgenes
genesMut<-colSums(pat_mut[,clusMember==2]) #pat_mut is patient mutations, get umber of mutations in high risk patients
sigmutgene<-colnames(pat_mut)[which(genesMut>=0.5*length(which(clusMember==2)))]

# to get DEGs
library(limma)
design <- model.matrix(~ 0 + factor(clusMember))
rownames(design)<-rownames(nldata)
fit<-lmFit(pat_exp,design)
fit2 <- contrasts.fit(fit, contrast.matrix)
fit3 <- eBayes(fit2)
Results <- topTable(fit3,number=nrow(fit3))
DEGs<-Results$ID[which(abs(Results$logFC)>0.8 & Results$adj.P.Val<0.05)]

# to get DMGs
rownames(design)<-rownames(nldata)
fit<-lmFit(pat_methy,design)# pat_methy is DNA methylation data
fit2 <- contrasts.fit(fit, contrast.matrix)
fit3 <- eBayes(fit2)
Results <- topTable(fit3,number=nrow(fit3))
DMGs<-Results$ID[which(abs(Results$logFC)>0.8 & Results$adj.P.Val<0.05)]





