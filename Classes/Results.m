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
               result = ['Visual_Network','Somatomotor_Network',...
                        'Dorsal_Network','Ventral_Network',...
                        'Limbic_Network','Frontoparoetal_Network',...
                        'Default_Mode_Network'];
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
              self.Resolved_results.Display_result(i,self.Feels(i))
           end
       end
   end
end

