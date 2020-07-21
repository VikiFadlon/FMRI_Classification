% Global (use in Part 1 and Part 2) - Result class
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

classdef Result < handle
    properties
        KNN
        LDR
        SVM
        BAYES
        PCA
        PCA_len
        Total
    end
    methods
        function self = Result(data_len,PCA_len)
            self.KNN = zeros(data_len,7,3);
            self.LDR = zeros(data_len,7,3);
            self.SVM = zeros(data_len,7,3);
            self.BAYES = zeros(data_len,7,3);
            self.PCA = zeros(data_len,7,4,PCA_len);
            self.Total = data_len;
            self.PCA_len = PCA_len;
        end
        function append_KNN(self,index,data)
            for i=1:7
                self.KNN(index,i,:) = data(i,:);
            end
        end
        function append_LDR(self,index,data)
            for i=1:7
                self.LDR(index,i,:) = data(i,:);
            end
        end
        function append_SVM(self,index,data)
            for i=1:7
                self.SVM(index,i,:) = data(i,:);
            end
        end
        function append_BAYES(self,index,data)
            for i=1:7
                self.BAYES(index,i,:) = data(i,:);
            end
        end
        function append_PCA(self,index,data)
            for i=1:7
                self.PCA(index,i,:,:) = data(i,:,:);
            end
        end      
        function Display_result(self,index,file_names,feel_title)
            param = ["acucuarcy","recall","precision"];
            if self.Total == 100
                best_name = 'Best 5';
            else
                best_name = 'Best 2';
            end
            columname = {'PCA 20', 'PCA 15', 'PCA 10', 'PCA 5',best_name};
            columname = columname(5-self.PCA_len:end);
            columname(2:end+1) = columname;
            columname(1) = {'Names'};
            best = 1.5 * self.PCA_len - 1;
            figure('units','normalized','outerposition',[0 0 1 1])
            PCA_temp = squeeze(self.PCA(:,index,:,:));

            subplot(4,2,1)
            knn_temp = squeeze(self.KNN(:,index,:));
            best5 = zeros(self.Total,1);
            [~,max_index] = maxk(knn_temp(:,1),best);
            best5(max_index) = 1;
            filee = file_names(max_index);
            fprintf('%s KNN Results:\n',feel_title)
            for i=1:length(filee)
                fprintf('%s.\n',filee(i))
            end
            fprintf('\n')
            file_names(max_index);
            bar(knn_temp)
            legend(param,"location","bestoutside")
            title("KNN - K = 3");
            if self.Total == 100
                T = table(char(file_names),squeeze(PCA_temp(:,1,1)),squeeze(PCA_temp(:,1,2)),squeeze(PCA_temp(:,1,3)),squeeze(PCA_temp(:,1,4)),best5);
            else
                T = table(char(file_names),squeeze(PCA_temp(:,1,1)),squeeze(PCA_temp(:,1,2)),best5);
            end
            uitable('Data', table2cell(T), 'ColumnName', columname, 'Position', [850 550 500 120]);

            subplot(4,2,3)
            svm_temp = squeeze(self.SVM(:,index,:));
            best5 = zeros(self.Total,1);
            [~,max_index] = maxk(svm_temp(:,1),best);
            best5(max_index) = 1;
            filee = file_names(max_index);
            fprintf('%s SVM Results:\n',feel_title)
            for i=1:length(filee)
                fprintf('%s.\n',filee(i))
            end
            fprintf('\n')
            bar(svm_temp)
            legend(param,"location","bestoutside")
            title("SVM");
            if self.Total == 100
                T = table(char(file_names),squeeze(PCA_temp(:,2,1)),squeeze(PCA_temp(:,2,2)),squeeze(PCA_temp(:,2,3)),squeeze(PCA_temp(:,2,4)),best5);
            else
                T = table(char(file_names),squeeze(PCA_temp(:,2,1)),squeeze(PCA_temp(:,2,2)),best5);
            end
            uitable('Data', table2cell(T), 'ColumnName', columname, 'Position', [850 390 500 120]);

            subplot(4,2,5)
            ldr_temp = squeeze(self.LDR(:,index,:));
            best5 = zeros(self.Total,1);
            [~,max_index] = maxk(ldr_temp(:,1),best);
            best5(max_index) = 1;
            filee = file_names(max_index);
            fprintf('%s LDR Results:\n',feel_title)
            for i=1:length(filee)
                fprintf('%s.\n',filee(i))
            end
            fprintf('\n')
            bar(ldr_temp)
            legend(param,"location","bestoutside")
            title("LDR");
            if self.Total == 100
                T = table(char(file_names),squeeze(PCA_temp(:,3,1)),squeeze(PCA_temp(:,3,2)),squeeze(PCA_temp(:,3,3)),squeeze(PCA_temp(:,3,4)),best5);
            else
                T = table(char(file_names),squeeze(PCA_temp(:,3,1)),squeeze(PCA_temp(:,3,2)),best5);
            end
            uitable('Data', table2cell(T), 'ColumnName', columname, 'Position', [850 220 500 120]);

            subplot(4,2,7)
            bayes_temp = squeeze(self.BAYES(:,index,:));
            best5 = zeros(self.Total,1);
            [~,max_index] = maxk(bayes_temp(:,1),best);
            best5(max_index) = 1;
            filee = file_names(max_index);
            fprintf('%s Naive Bayes Results:\n',feel_title)
            for i=1:length(filee)
                fprintf('%s.\n',filee(i))
            end
            fprintf('\n')
            bar(bayes_temp)
            legend(param,"location","bestoutside")
            title("Naive Bayes");
            if self.Total == 100
                T = table(char(file_names),squeeze(PCA_temp(:,4,1)),squeeze(PCA_temp(:,4,2)),squeeze(PCA_temp(:,4,3)),squeeze(PCA_temp(:,4,4)),best5);
            else
                T = table(char(file_names),squeeze(PCA_temp(:,4,1)),squeeze(PCA_temp(:,4,2)),best5);
            end
            uitable('Data', table2cell(T), 'ColumnName', columname, 'Position', [850 70 500 120]);
            sgtitle(feel_title)  
    end
    end
end