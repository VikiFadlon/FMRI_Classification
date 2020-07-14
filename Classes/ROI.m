classdef (HandleCompatible) ROI < Mat_events
   properties (SetAccess = private)
       Name
       X
       Y
       Z
       Total
       Index
       type
       Data
       PCA_Values 
       Labels
       Data_per_feel
   end
   methods 
       function self = ROI(details,data,PCA_array)
           self@Mat_events();
           if isa(details ,'table')
               self.Name = string(details.ROI);
               self.Index = details.Index;
               self.X = details.x;
               self.Y = details.y;
               self.Z = details.z;
               self.Total = 100;
               self.type = "ROI";
           else
               self.Name = details.Name;
               self.Index = details.Index;
               self.Total = 7;
               self.type = "NET";
           end
           
           self.Data = data;
           self.PCA_Values = PCA_array;
           self.Labels = self.set_labels;
           self.Data_per_feel = self.Analyze_data;
       end
       function self = set.Data(self,data)
       [r,c] = size(data);
           if (r == 946) && (c >1)
               self.Data = data;
           else
               error("Worng, data is not ROI")
           end
       end
       function result = set_labels(self)
           labels = cell(1,7);
           for feel = 3:9
               labels{feel-2} = nonzeros(self.Events(:,feel));
           end
           result = labels;
       end
       function result = Analyze_data(self)
           self.PrintLog("Load");
           self.Data(:,isnan(self.Data(1,:))) = [];
           len = length(self.Times);
           PCA_len = length(self.PCA_Values);
           PCA_res = cell(PCA_len,1);
           chunks = zeros(len,15 * size(self.Data,2));
           area_per_feel = cell(PCA_len + 1,7);
           for k =1:length(self.Times)
                x = self.Data(self.Times(k,1):self.Times(k,2),:);
                chunks(k,:) = x(:)';
           end
           for feel = 3:9
               self.PrintLog(sprintf("Calculate PCA for %s",self.Feels(feel-2)));
               x = chunks(self.Events(:,feel) > 0,:);
               area_per_feel{1,feel-2} = x;
               PCA = self.PCA_Values;
               for k = 1:PCA_len
                  [~,score] = pca(zscore(x),'NumComponents' ,PCA(k), 'Algorithm' ,'eig');
                  PCA_res(k) = {score};
               end
               area_per_feel(2:end,feel-2) = PCA_res;
           end
           result = area_per_feel;
       end
       function [Knn_results,Knn_PCA_results,...
               Ldr_results,Ldr_PCA_results,...
               Svm_results,Svm_PCA_results,...
               Bayes_results,Bayes_PCA_results] = Extract_results(self,feel) 
           self.PrintLog(sprintf("Analyze ML results for %s",self.Feels(feel)));
           Knn_PCA_results = zeros(1,length(self.PCA_Values));
           Ldr_PCA_results = zeros(1,length(self.PCA_Values));
           Svm_PCA_results = zeros(1,length(self.PCA_Values));
           Bayes_PCA_results = zeros(1,length(self.PCA_Values));
           [len,~] = size(self.Data_per_feel);
           y = self.Labels{feel};
           k = 1;           
           x = self.Data_per_feel{k,feel};
           Knn_results = self.Calc_Knn(k,x,y);
           Ldr_results = self.Calc_Ldr(k,x,y);
           Svm_results = self.Calc_Svm(k,x,y);
           Bayes_results = self.Calc_Bayes(k,x,y);
           for k = 2:len
               x = self.Data_per_feel{k,feel};
               Knn_PCA_results(k-1) = self.Calc_Knn(k,x,y);
               Ldr_PCA_results(k-1) = self.Calc_Ldr(k,x,y);
               Svm_PCA_results(k-1) = self.Calc_Svm(k,x,y);
               Bayes_PCA_results(k-1) = self.Calc_Bayes(k,x,y);
           end 
           if feel == 7
               self.PrintLog("Done");
           end
       end
       function result = Calc_Knn(~,k,x,y)
            cp = classperf(y);
            for i = 1:10
                [train,test] = crossvalind('LeaveMOut',y,1);
                mdl = fitcknn(x(train,:),y(train),'NumNeighbors',3);
                predictions = predict(mdl,x(test,:));
                classperf(cp,predictions,test);
            end
            if k == 1
                result = [cp.ErrorRate,cp.Sensitivity,cp.Specificity];
            else
                result = (cp.ErrorRate)*100;
            end
       end
       function result = Calc_Ldr(~,k,x,y)
            cp = classperf(y);
            for i = 1:10
                [train,test] = crossvalind('LeaveMOut',y,1);
                mdl = fitcdiscr(x(train,:),y(train),'DiscrimType','linear');
                predictions = predict(mdl,x(test,:));
                classperf(cp,predictions,test);
            end
            if k == 1
                result = [cp.ErrorRate,cp.Sensitivity,cp.Specificity];
            else
                result = (cp.ErrorRate)*100;
            end
       end
       function result = Calc_Svm(~,k,x,y)
            cp = classperf(y);
            for i = 1:10
                [train,test] = crossvalind('LeaveMOut',y,1);
                mdl = fitcsvm(x(train,:),y(train));
                predictions = predict(mdl,x(test,:));
                classperf(cp,predictions,test);
            end
            if k == 1
                result = [cp.ErrorRate,cp.Sensitivity,cp.Specificity];
            else
                result = (cp.ErrorRate)*100;
            end
       end
       function result = Calc_Bayes(~,k,x,y)
            cp = classperf(y);
            for i = 1:10
                [train,test] = crossvalind('LeaveMOut',y,1);
                mdl = fitcnb(x(train,:),y(train));
                predictions = predict(mdl,x(test,:));
                classperf(cp,predictions,test);
            end
            if k == 1
                result = [cp.ErrorRate,cp.Sensitivity,cp.Specificity];
            else
                result = (cp.ErrorRate)*100;
            end
       end
       function PrintLog(self,text)
           if text == "Load"
               clc
               fprintf(sprintf('Analyze %s Datasets\n',self.type))
               textprogressbar('Progress:')
               fprintf('\n')
               textprogressbar((self.Index/self.Total)*100)
               fprintf('\n')
               if self.type == "ROI"
                   fprintf('%s x,y,z = [%d,%d,%d] : %s %s \n',self.Name,self.X,self.Y,self.Z,text,self.type);
               else
                   fprintf('%s : %s %s\n',self.Name,text,self.type);
               end
           elseif text == "Done"
               textprogressbar('Done')
               clc
           else 
               fprintf('%s %s : %s\n',self.type,self.Name,text);
           end
       end
   end
end

