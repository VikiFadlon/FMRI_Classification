% Part 2 - Run algorithm for part 2 in assignment. 
% Classification between events on 7 NET regions.
% Check accuracy using PCA to 10,5 dimensions.
% Read dataset from bold_subject_all.mat file.
% 
% first calculate mean for all subjects FMRI.
% for all NET regions:
%       use NET class to read the data.
%       then use Extract_results function at NET class to extract results.
%       save results in Test_Result variable (output of function).
% 

function [Test_Results] = Run_program_part2(Total,PCA)
    names = ["Visual_Network","Somatomotor_Network",...
             "Dorsal_Network","Ventral_Network",...
             "Limbic_Network","Frontoparoetal_Network",...
             "Default_Mode_Network"];
    Test_Results = cell(Total,5);
    load('bold_subject_all.mat','bold_subject_all');
    data = mean(bold_subject_all,3);
    for net=1:length(names)
        details = struct('Name',names(net),'Index',net);
        current_NET = NET(details,data,PCA);

        Knn_result = zeros(current_NET.Feels_num,3);
        Ldr_result = zeros(current_NET.Feels_num,3);
        Svm_result = zeros(current_NET.Feels_num,3);
        Bayes_result = zeros(current_NET.Feels_num,3);

        PCA_result = zeros(current_NET.Feels_num,4,length(PCA));

        for i = 1:current_NET.Feels_num
            [Knn_result(i,:),PCA_result(i,1,:),...
            Ldr_result(i,:),PCA_result(i,2,:),...
            Svm_result(i,:),PCA_result(i,3,:),...
            Bayes_result(i,:),PCA_result(i,4,:)] = current_NET.Extract_results(i);
        end
        Test_Results(net,:) = {Knn_result,Ldr_result,Svm_result,Bayes_result,PCA_result};
    end
end