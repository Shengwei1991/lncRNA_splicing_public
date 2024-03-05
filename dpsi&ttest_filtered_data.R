library(dplyr)
library(ggplot2)
#setting the working directory
mydir<- paste("/Volumes/jonesylab/Projects/CurrentLabMembers/Shengwei_Xiong/MAJIQ_Project/show_constitutive/RBM/")
#mydir<- paste("/Volumes/jonesylab/Projects/CurrentLabMembers/Shengwei_Xiong/MAJIQ_Project/hnRNP/")
mymooduloizeddir<- paste("/Volumes/jonesylab/Projects/CurrentLabMembers/Shengwei_Xiong/MAJIQ_Project/show_constitutive/RBM/RBM47/HepG2/output/modulized/")

#save all the output files into the folder
setwd(mymooduloizeddir)

#how many lncRNAs are spliced in particular way in each files. Go inside of the directory, only find the csv files and list those files. 
lncRNA_csv <- list.files(mymooduloizeddir, pattern = "[.]csv")


#count only significant data
count_data_sig <- data.frame(File = character(), lncRNA_Count = numeric(), stringsAsFactors = FALSE)

# Loop through each CSV file
for (i in 1:length(lncRNA_csv)) {
  # Read CSV file
  lncRNAsplicedtype <- read.csv(paste0(mymooduloizeddir, lncRNA_csv[i]), header = TRUE, sep = ",")
  
  # Filter significant psi values
  # Filter significant psi values
  sig_psi <- subset(lncRNAsplicedtype, 
                    lncRNAsplicedtype$control_sh_RBM47_HepG2.sh_RBM47_HepG2_het_median_dpsi >= 0.1 & 
                      lncRNAsplicedtype$control_sh_RBM47_HepG2.sh_RBM47_HepG2_het_ttest <= 0.05)
  
  # Count unique gene_ids
  justgeneids_sig <- length(unique(sig_psi$gene_id))
  
  # Store file name and count in the data frame
  count_data_sig[i, ] <- c(lncRNA_csv[i], justgeneids_sig)
}

print(count_data_sig)

