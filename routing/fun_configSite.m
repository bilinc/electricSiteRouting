%% Function with the quarry site parameters and configuration
function [A, C, Roads] = fun_configSite(n)

A = zeros(n);
C = zeros(n);
C(1,2)=3.71; C(1,10)=6.40;
C(2,3)=1.84; C(2,4)=5.12; 
C(3,4)=3.96; C(3,7)=2.51; 
C(4,5)=1.01; C(4,6)=2.03; C(4,7)=3.61;
C(5,6)=1.93;
C(6,9)=2.41;
C(7,9)=2.87; C(7,10)=3.05;
C(8,9)=1.08; C(8,11)=1.9;
C(9,12)=1.6;
C(10,12)=3.01; C(10,14)=3.61;
C(11,12)=1.05; C(11,13)=1.91;
C(12,14)=2;
C(13,14)= 0.9; %0.51;
% Stacked Cost Matrix
for i = 1:length(C)
    for j = 1:length(C)
        C(j,i) = C(i,j);
    end
end
C = C*100;

for i = 1:14
    for j = 1:14
       if C(i,j) > 0
           A(i,j) = 1;
       else
           A(i,j) = 0;
       end
    end
end

% Creating the Roads
Roads = cell(n);
Roads{1,2} = 'A'; Roads{1,10} = 'L';
Roads{2,3} = 'B'; Roads{2,4} = 'N1';
Roads{3,4} = 'C'; Roads{3,7} = 'N10';
Roads{4,5} = 'D'; Roads{4,6} = 'F'; Roads{4,7} = 'N2';
Roads{5,6} = 'N11';
Roads{6,9} = 'G';
Roads{7,9} = 'N9'; Roads{7,10} = 'N3';
Roads{8,9} = 'N8'; Roads{8,11} = 'N7';
Roads{9,12} = 'H';
Roads{10,12} = 'K'; Roads{10,14} = 'N4'; 
Roads{11,12} = 'M'; Roads{11,13} = 'N6';
Roads{12,14} = 'I';
Roads{13,14} = 'N5';

for i = 1:length(Roads)
    for j = 1:length(Roads)
       Roads{j,i} = Roads{i,j}; 
    end
end
