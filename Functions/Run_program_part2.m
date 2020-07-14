
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
        current_ROI = NET(details,data,PCA);

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
        Test_Results(net,:) = {Knn_result,Ldr_result,Svm_result,Bayes_result,PCA_result};
    end
end