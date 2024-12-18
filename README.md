# "Data" project

This is the final project for the subject "Data Acquisition Analysis and Scientific Methods for Life Sciences" shorted as "Data" from the first course of the Master Plant Health at the Universitat Politècnica de València.

In this project the students chose a scientific article and redo all possible statistic analyses and graphics from it, trying different approaches to see if they can improve them. They will use the data included in the article and follow the Material and methods chapter as a guide.

## Group members

Group A: 

Keve Toth; Jakov Cancar; Camille Delabaere

## Chosen article

[Cooperation between arbuscular mycorrhizal fungi and plant growth-promoting bacteria and their effects on plant growth and soil quality](https://peerj.com/articles/13080/)

## Proposal

To analyse if arbuscular mycorrhizal fungi *AMF* & plant growth-promoting rhizobacteria *PGRB* have any synergy effects on nutrients uptakes or plant growth.

We hypothesized that: (1) AMF and PGPR could mutually symbiose and enhance the plant growth of Elymus nutans Griseb, and (2) the co-existence of AMF and PGPR could improve plant traits and soil quality better than their individual applications.

Correlation analyses, ANOVA analyse, and some multivariate analyses.

We plan to start with each variable analyses separately then ANOVA analyses we'll combine these small results analyses with the knowledge acquire from the article chosen to define the larger scale multivariate analyses. These might be a relationship between soil nutrients/quality and plant size measurements (multiple roots measurements and above ground biomass).

You have a nice article to follow but data are a bit scarce. The dataframe have a lot of variables but not too many observations. Anyway it should be enough to do multivariate analyses to compare soil and plant compositions.

## Files description

## Protocol

The final result is showcased in the Preliminary_Test.Rmd file it should run separately on its own. If no all the graphs can be seen following the protocol

1. To set up the workspace run R file 00_GetData.
2. To get boxplots showcasing the Analyisis of Variance (ANOVA) analyisis of all variables run 02_ANOVAs
3. To get all the significant ANOVAs in one document run 18_ANOVAmix
4. To get Bonferroni corrected ANOVA p values in a table run 09_ANOVAptable
5. To get boxplots showcasing where there was a significant variation between treatment with only Arbuscular mycorrhizal fungi, and both AM fungi and Rhizobial Bacteria run 03_ANOVAfungi
6. We will not use this in our final results but to get a Principal component analyisis shown on Scree plots, as well as a scatter plot for all variables run 06_PCAimproved
7. In the further analyisis we conducted we have separated variables measuring soil and plant parameters for more accuracy, to set up for this run 07_Subsetting soil-plant parameters
8. To get Scree plots, Arrow plots showcasing how each variable influenced PC1 and PC2, and a Principle Component Analysis (PCA) scatter plot for both soil and plant parameters run 08_PCAsubsetted
9. To get a scatter plot that compares principle component 1 (PC1) of plant parameters and PC1 of soil parameters run 11_PCAcombo
10. To set up for performing Linear Discriminant Analysis (LDA) for the subset of plant parameters and soil parameters run 15_LDAfunction
11. To get scatterplot showcasing LDA and arrow plot for all the variables measured run 19_BigLDA
12. To get a scatterplot showcasing LDA for both and also an arrow plot that shows the strength of each variables contribution to LD1 and LD2 run 12_LDAplots
13. To get a correlogram showcasing the correlation between plant characteristics and soil characteristics run 10_Correlogram
14. To get correlograms showing Specific Root Lengths (SRL) correlation with plant characteristics, and separately SRL correlation with soil parameters run 14_SRLcorrelogram
15. We wanted to showcase some important traits that we thougth might be correlated, and we know that these variables have significant variation based on the ANOVA analyisis to 
	get the plots for these correlations run 16_InterestingCorrelations
16. We also found one correlation that might better be explained by a nonlinear correlation this is the correaltion between Urease in soil (UE) and Plant phosphorus
	to get a graph for this correlation run 17_UEvsPlantprelation
	
