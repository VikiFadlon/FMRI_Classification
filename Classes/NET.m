% Part 2 - NET class 
% Inherited from ROI class
% Slice data per specific Network.
% Use ROI class to read and calc results
%
classdef (HandleCompatible) NET < ROI
   properties (SetAccess = private)
   end
   methods 
       function self = NET(Name,data,PCA_array)
           nets = {[1:9 51:58],... % Visual_Network
            [10:15 59:66],... % Somatomotor_Network
            [16:23 67:73],... % Dorsal_Network
            [24:30 74:78],... % Ventral_Network
            [31:33 79:80],... % Limbic_Network
            [34:37 81:89],... % Frontoparoetal_Network
            [38:50 90:100]... % Default_Mode_Network
            };
           currnt_data = data(:,nets{Name.Index});
           self@ROI(Name,currnt_data,PCA_array);
       end
   end
end

