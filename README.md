# FMRI_Classification
This project is a part of a final project at FMRI machine learning course in HIT- by dr' Erez Simoni and Eyal Hizmi.
# Project details
This project describes an experiment about classification of FMRI signals.
In this experimentgroup A with 35 students watched 20 minutes of Sherlock series of BBC. 

group B other 35 students answer quastions about 49 events in the movie.
using the answers of group B we got the classifications for the behavier for thos events.
for more details the [Article.](https://www.biorxiv.org/content/10.1101/2020.05.18.101758v1)
![alt text](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Images/Strip.PNG)

# what inside 
The code is separate to files:

Files for Part 1:
* [main_part1.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/main_part1.m) - Main file for part 1 in assignment.
* [Functions/Run_program_part1.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Functions/Run_program_part1.m) - Run program algorithm for part 1.
* [Test_Results_part1.mat](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Test_Results_part1.mat) - Results file for part 1.

Files for Part 2:
* [main_part2.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/main_part2.m) - main file for part 2 in assignment.
* [Functions/Run_program_part2.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Functions/Run_program_part2.m) - Run program algorithm for part 2.
* [Test_Results_part2.mat](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Test_Results_part2.mat) - Results file for part 2.

Global files (for part 1 and part 2):
* [Functions/textprogressbar.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Functions/textprogressbar.m) - External function for prograss bar from [link.](https://www.mathworks.com/matlabcentral/fileexchange/28067-text-progress-bar)
* [Classes/Mat_events.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Classes/Mat_events.m) - Mat_events class, read and parse dataset label file.
* [Classes/ROI.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Classes/ROI.m) - ROI class, read ROI data. calculate PCA and analyse results using ML.
* [Classes/NET.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Classes/NET.m) - Net class, read NET data. slice data for given index and calculate results.
* [Classes/Result.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Classes/Result.m) - Result class, containe results for each classifier and display bar plot.
* [Classes/Results.m](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Classes/Results.m) - Results class, insert results to Result class and conterol Result methods.

# Results 
The results display as bar plot and table of PCA accuracy results for each regoin at given ML algorithm using Display_results method in [Results class](https://github.com/VikiFadlon/FMRI_Classification/blob/master/Classes/Results.m)



