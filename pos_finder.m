clc 
clear
close 

Path_A=[1 2 3 4 5 6 6.5 7.5 7.8 7.9 8 8 8
     1 1 1.1 1.2 1.3 1.4 1.5 3 4 5 6 7 8
     1 1 2 3 4 4 4 3 2 2 1 1 1];

Data_A=Road_def('Path_A',Path_A); %Data contains name of road, length of road, X_pol(s), Y_pol(s)


drive(Data_A{3},Data_A{4},Data_A{5},Data_A{2},1)