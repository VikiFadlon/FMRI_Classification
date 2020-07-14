
clc
clear all;
close all;
addpath('Classes','Datasets','Functions')
Total = 7;
PCA = [10,5];

if isfile('Test_Results_part2.mat') %% check if Result file exsits
    Run_Program = false;
else
    Run_Program = true;
end

if Run_Program
    Test_Results = Run_program_part2(Total,PCA);
    fprintf("Saving results to Test_Results_part2.mat file\n")
    save('Test_Results_part2.mat','Test_Results');
else
    fprintf("Loading results from Test_Results_part2.mat file\n")
    load('Test_Results_part2.mat');
end
current_Results = Results(Test_Results,Total,PCA);
current_Results.Display_results


