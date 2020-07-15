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