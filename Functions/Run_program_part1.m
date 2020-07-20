% Part 1 - Run algorithm for part 1 in assignment. 
% Classification between events on 100 ROI regions.
% Check accuracy using PCA to 20,15,10,5 dimensions.
% Read dataset from
% voxelBold_sherlock_firstPart_Schafer2018_100regions7nets_3m_MeanOfAllSubjects.mat file.
% 
% for all ROI data at dataset:
%       use ROI class to read ROI data.
%       then use Extract_results function at ROI class to extract ROI
%       results.
%       save results in Test_Result variable (output of function).
% 

function [Test_Results] = Run_program_part1(Total,PCA)
    load('voxelBold_sherlock_firstPart_Schafer2018_100regions7nets_3m_MeanOfAllSubjects.mat','groupMeanBOLD')
    ROI_table =readtable('Schaefer2018_100Parcels_7Networks_order.txt');
    ROI_table.Properties.VariableNames = {'Index','ROI','x','y','z','-'};
    Test_Results = cell(Total,5);
    for region=1:length(groupMeanBOLD)
        details = ROI_table(region,:);
        data = groupMeanBOLD{region};

        current_ROI = ROI(details,data,PCA);

        Knn_result = zeros(current_ROI.Feels_num,3);
        Ldr_result = zeros(current_ROI.Feels_num,3);
        Svm_result = zeros(current_ROI.Feels_num,3);
        Bayes_result = zeros(current_ROI.Feels_num,3);

        PCA_result = zeros(current_ROI.Feels_num,4,length(PCA));

        for i = 1:current_ROI.Feels_num
            [Knn_result(i,:),PCA_result(i,1,:),...
            Ldr_result(i,:),PCA_result(i,2,:),...
            Svm_result(i,:),PCA_result(i,3,:),...
            Bayes_result(i,:),PCA_result(i,4,:)] = current_ROI.Extract_results(i);
        end
        Test_Results(region,:) = {Knn_result,Ldr_result,Svm_result,Bayes_result,PCA_result};
    end
end