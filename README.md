#Readme
In the main file waveEx.mlx, set the path to the dataset folder and the species categories it contains
##1 dataset Path
for example:
		root = fullfile(pwd(),"/data"); 
##2 fasta Path struct
for example:

		/data/train/+human_lnc.fa
					+mouse_lnc.fa
					+cow_lnc.fa
					+ath_lnc.fa
					+osa_lnc.fa
					+zma_lnc.fa
		/data/train/+human_pc.fa
					+mouse_pc.fa
					+cow_pc.fa
					+ath_pc.fa
					+osa_pc.fa
					+zma_pc.fa
If the lnc and pc files are separate, you need to set c2>0,	(sets each data set to a unique number) This also makes it easy to distinguish which data set the sequence belongs to in the feature file.
The format is:
		trainSet = struct("Animal",["human","mouse","cow"],
							"Plant",["ath","osa","zma"],
							"Path",fullfile(root,"/train/"),
							"c2",2
						  );
% Sets
You can put multiple data sets in Eset when there are multiple data sets
	for example:
		Eset = [trainSet,testSet,cpc2Set,lncSet];
The final feature data file is stored in the same folder as the source data, where the filename suffix '_Mw' is the final average feature file, and the '_w' file is the feature of all orfs in an RNA, they are identified by RNA number.
