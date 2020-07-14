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
        function Display_result(self,index,feel_title)
            param = ["acucuarcy","recall","precision"];
            columname = {'PCA 20', 'PCA 15', 'PCA 10', 'PCA 5','Best 5'};
            columname = columname(5-self.PCA_len:end);
            figure('units','normalized','outerposition',[0 0 1 1])
            PCA_temp = squeeze(self.PCA(:,index,:,:));

            subplot(4,2,1)
            name = "KNN - K = 3"; 
            knn_temp = squeeze(self.KNN(:,index,:));
            best5 = zeros(self.Total,1);
            [~,max_index] = maxk(knn_temp(:,1),5);
            best5(max_index) = 1;
            bar(knn_temp)
            legend(param,"location","bestoutside")
            title(name);
            text(850,400,sprintf('\bf PCA accuracy for %s:',name))
            uitable('Data', [squeeze(PCA_temp(:,1,:)) best5], 'ColumnName', columname, 'Position', [850 550 400 120]);

            subplot(4,2,3)
            svm_temp = squeeze(self.SVM(:,index,:));
            best5 = zeros(self.Total,1);
            [~,max_index] = maxk(svm_temp(:,1),5);
            best5(max_index) = 1;
            bar(svm_temp)
            legend(param,"location","bestoutside")
            title("SVM");
            uitable('Data', [squeeze(PCA_temp(:,2,:)) best5], 'ColumnName', columname, 'Position', [850 390 400 120]);

            subplot(4,2,5)
            ldr_temp = squeeze(self.LDR(:,index,:));
            best5 = zeros(self.Total,1);
            [~,max_index] = maxk(ldr_temp(:,1),5);
            best5(max_index) = 1;
            bar(ldr_temp)
            legend(param,"location","bestoutside")
            title("LDR");
            uitable('Data', [squeeze(PCA_temp(:,3,:)) best5], 'ColumnName', columname, 'Position', [850 220 400 120]);

            subplot(4,2,7)
            bayes_temp = squeeze(self.BAYES(:,index,:));
            best5 = zeros(self.Total,1);
            [~,max_index] = maxk(bayes_temp(:,1),5);
            best5(max_index) = 1;
            bar(bayes_temp)
            legend(param,"location","bestoutside")
            title("Naive Bayes");
            uitable('Data', [squeeze(PCA_temp(:,4,:)) best5], 'ColumnName', columname, 'Position', [850 70 400 120]);
            sgtitle(feel_title)  
        end
    end
end