% Global (use in Part 1 and Part 2) - Results class
% Inherited from Mat_events class.
% Containe test results, split results by ML model.
% Accsess results in data per feel index.
% Include graphics function to display bar plot/
%
% Variables
% self.KNN <- containe results for KNN classifier.
% self.LDR <- containe results for LDR classifier.
% self.SVM <- containe results for SVM classifier.
% self.BAYES <- containe results for Naive Bayes classifier.
% self.PCA <- containe results for PCA accuracy for all classifiers.
% self.PCA_len <- containe numbers of PCA tests.
% self.Total <- number of regions (100 for part 1 and 7 for part 2).
%
% Methods
% self.append_KNN() <- append KNN results data to KNN variable.
% self.append_LDR() <- append LDR results data to LDR variable.
% self.append_SVM() <- append SVM results data to SVM variable.
% self.append_BAYES() <- append KNN results data to Naive Bayes variable.
% self.append_PCA() <- append PCA results data to PCA variable. 
% self.Display_result() <- display results for all test, display bar plot for 
%						   each feel in test and extract PCA result table.
classdef Results < Mat_events
   properties (SetAccess = private)
       Results_content
       PCA_Values
       Resolved_results
       Total
       Files_name
   end
   methods 
       function self = Results(results,data_len,PCA_array)
           self@Mat_events();
           self.PCA_Values = PCA_array;
           self.Results_content = results;
           self.Total = data_len;
           self.Files_name = self.Set_files_name;
           self.Resolved_results = self.Analyze_results;
       end
       function result = Set_files_name(self)
           if self.Total == 100
                ROI_table =readtable('Schaefer2018_100Parcels_7Networks_order.txt');
                ROI_table.Properties.VariableNames = {'Index','ROI','x','y','z','-'};
                result = strings(100,1);
                for i = 1:self.Total
                    result(i) =ROI_table.ROI{i};
                end
           else
               result = strings(7,1);
               result(1:7) = ["Visual_Network";"Somatomotor_Network";...
                        "Dorsal_Network";"Ventral_Network";...
                        "Limbic_Network";"Frontoparoetal_Network";...
                        "Default_Mode_Network"];
           end
       end
       function result = Analyze_results(self)
           result = Result(self.Total,length(self.PCA_Values));
           for i = 1:length(self.Results_content)
                data = self.Results_content(i,:);
                result.append_KNN(i,data{1})
                result.append_LDR(i,data{2})
                result.append_SVM(i,data{3})
                result.append_BAYES(i,data{4})
                result.append_PCA(i,data{5})
           end
       end
       function Display_results(self)
           for i = 1:self.Feels_num
              self.Resolved_results.Display_result(i,self.Files_name,self.Feels(i))
           end
       end
   end
end

