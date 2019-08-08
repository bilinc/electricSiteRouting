clc
clear
close all
syms A B C D E F G H I J K L M N1 N2 N3 N4 N5 N6 N7 N8 N9 N10 N11
Road_Names=[A,B,C,D,E,F,G,H,I,J,K,L,M,N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11];
R_costs=[3.7065,1.8374,3.6906,1.0008,1.0441,2.0224,2.4089,1.6,2,1.0198,3.0008,6.3996,1.0007,5.1142,3.6056,3.0431,3.6065,0.5002,0.5001,0.5000,1.0777,2.8657,2.5016,1.9217];
%Source to facility

Roads_SF{1,:}={A,B,C,D};
Roads_SF{2,:}={A,N1,D};
Roads_SF{3,:}={A,B,N10,N2,D};
Roads_SF{4,:}={A,B,N10,N9,G,F,D};
Roads_SF{5,:}={A,B,N10,N9,G,N11};
Roads_SF{6,:}={L,K,H,G,F,D};
Roads_SF{7,:}={L,K,H,G,N11};
Roads_SF{8,:}={L,N3,N2,D};
Roads_SF{9,:}={L,N3,N9,G,N11};
Roads_SF{10,:}={L,N3,N9,G,F,D};
Roads_SF{11,:}={L,N3,N10,C,D};
%Source to charging
Roads_SCH{1,:}={L,K,I,N5};
Roads_SCH{2,:}={L,K,N4,N5};
Roads_SCH{3,:}={L,N3,N9,H,I,N5};
Roads_SCH{4,:}={A,B,N10,N9,H,I,N5};
Roads_SCH{5,:}={A,B,N10,N3,K,I,N5};
Roads_SCH{6,:}={A,B,N10,N9,H,I,N5};
Roads_SCH{7,:}={A,B,N10,N3,N4,N5};
Roads_SCH{5,:}={A,B,C,F,G,H,I,N5};
%Source to Parking
Roads_SP{1,:}={L,K,M};
Roads_SP{2,:}={L,N4,I,M};
Roads_SP{3,:}={L,N3,N9,H,M};
Roads_SP{4,:}={A,B,N10,N9,H,M};
Roads_SP{5,:}={A,B,C,F,G,H,M};
Roads_SP{6,:}={A,B,N10,N9,H,M};


cost=Cost_function(Roads_SF,Road_Names,R_costs);
Prio_list=Prio(cost,Roads_SF);
%%
disp(Prio_list{1,:})
