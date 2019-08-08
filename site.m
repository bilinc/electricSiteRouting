clc
clf
close all
clear
cc=[100,100,100]./255;  %Road color
areacolor=[230,230,230]./255; 
%Define locations
Source=[0 4.5 1.5 1.5]; %Position of bottom left corner and size
Facility=[8.5 8.5 1.5 1.5];
Charging=[8.5 0 1.5 1.5];
Parking=[9 2 1 2];

ControlTower=[9 4.5 1 1];
%Define quarry hill
hill_x=[2 2.5 2.5 2; 2.5 2.8 2.8 2.5; 3 3.2 3.2 3.2];
hill_y=[3 4 6 7.5;2.5 3.5 6.5 8;2.3 3.5 6.5 7.5];
%Create topografy
Z=[0.2 1   1.2  1.5 1.5 1.5 1.5 1.5 1.5 1.2 1.2
   0 1   1.2  1.5 1.5 1.5 1.5 1.5 1.5 1.2 1.2
   0 0.5 1    1.2 1.5 1.5 1.5 1.5 1.5 1.2 1.2
   0 0.2   0.5  1   1.5 1.5 1.5 1.5 1.2 1.2 1.2
   0 0   0    0.2 1.5 1.5 1.5 1.5 1.2 1.2 1.2
   0 0   0    0.2 1.5 1.5 1.5 1.5 1.2 1.2 1.2
   0 0  0    0.2 1.5 1.5 1.5 1.5 1.2 1.2 1.2
   0 0   0.2   0.5 1.5 1.5 1.5 1.5 1.2 1   1.2
   0 0.5 0.5  1   1.5 1.5 1.5 1.5 1.2 1.2 1.2
   0 0.5 1    1   1.5 1.5 1.5 1.5 1.2 1.2 1.2
   0.2 1   1.5  1.5 1.5 1.5 1.5 1.5 1.5 1.2 1.2].*0.2+1;
% figure(1)
% contourf(Z);

index =[1     1
     2     2
     3     3
     4     4
     5     5
     6     6
     7     7
     8     8
     9     9
    10    10
    11    11
    1     2
     2     3
     3     4
     4     5
     5     6
     6     7
     7     8
     8     9
     9    10
    10    11
    11     1 
     1     3
     2     4
     3     5
     4     6
     5     7
     6     8
     7     9
     8    10
     9    11
     10    1
     11    2
     1     4
     2     5
     3     6
     4     7
     5     8
     6     9
     7    10
     8    11
     9     1
     10    2
     11    3
     1     5 
     2     6
     3     7
     4     8
     5     9
     6    10
     7    11
     8     1
     9     2
     10    3
     11    4
     1     6
     2     7
     3     8
     4     9
     5    10
     6    11
     7     1
     8     2
     9     3
     10    4
     11    5
     1     7
     2     8
     3     9
     4    10
     5    11 
     6     1
     7     2
     8     3
     9     4
     10    5
     11    6
     1     8
     2     9
     3    10
     4    11 
     5     1
     6     2
     7     3
     8     4
     9     5
     10    6
     11    7
     1     9
     2    10
     3    11
     4     1
     5     2
     6     3
     7     4
     8     5
     9     6
     10    7
     11    8
     1    10
     2     11
     3     1
     4     2
     5     3
     6     4
     7     5
     8     6
     9     7
     10    8
     11    9]-1;
z=zeros(1,110);
index=[index,z'];
for I=1:110
   index(I,3)=Z(index(I,1)+1,index(I,2)+1) ;
end
%Fit topograpy
z_topo=fit([index(:,1),index(:,2)],index(:,3),'poly55');

%Check fit - Uncomment
 %figure(2)
%  plot(z_topo,index(:,1:2),index(:,3))
%   axis([0 12 0 12 0 2])
 % hold off
 
 %%
 step=0.1;
 x=[0:10];
y=x;
Z_data=zeros(length(x),length(y));
for Spot=1:length(x)
   for j=1:length(x)
       Z_data(Spot,j)=z_topo(x(Spot),y(j));
   end
end

%Check topography
%%
% figure(3)
%colors:
map=[210,180,140
    210,180,140
    210,180,140
    210,180,140
    210,180,140
    210,180,140
    210,180,140
    210,180,140
    210,180,140]./255;

J=0.5;
step=(1-J)/8;
for I=1:8
   map(I,:)=map(I,:).*J;
   J=J+step;
end
% Uncomment below for figure 3
 colormap(map) 
 [C,h]=contourf(Z_data);
 brighten(0.4)
 set(h,'LineColor',cc)

%%
%Defins crossings
Crossings=[2.5 4 7.5 7.8 8 8 8 5 5.5;9 8 9 7 4.6 3 1 3 6];
%Define wide road segments
Road_A=[1 1.05 1.1 1.3 1.6 1.8 2 2.2 Crossings(1,1);6 6.6 7 7.8 8.5 8.8 8.9 9 Crossings(2,1)];
Road_B=[Crossings(1,1) 2.7 2.9 3.1 3.3 3.5 3.7 3.9 Crossings(1,2) ;Crossings(2,1) 8.9 8.8 8.7 8.5 8.3 8.1 8.02 Crossings(2,2)];
Road_C=[Crossings(1,2) 4.3 4.7 5.5 6.5 7 7.3 Crossings(1,3);Crossings(2,2) 8 8.2 8.5 8.9 9 9 Crossings(2,3)];
Road_D=[Crossings(1,3) 7.7 8.5;Crossings(2,3) 9 9];
Road_E=[7.2 Crossings(1,3);10 Crossings(2,3)];
Road_F=[Crossings(1,3) Crossings(1,4);Crossings(2,3) Crossings(2,4)];
Road_G=[Crossings(1,4) 7.9 Crossings(1,5);Crossings(2,4) 5.5 Crossings(2,5)];
Road_H=[Crossings(1,5) Crossings(1,6);Crossings(2,5) Crossings(2,6)];
Road_I=[Crossings(1,6) Crossings(1,7);Crossings(2,6) Crossings(2,7)];
Road_J=[Crossings(1,7) 7.8 ;Crossings(2,7) 0];
Road_K=[Crossings(1,6) 7 6 Crossings(1,8);Crossings(2,6) 3 3 Crossings(2,8)];
Road_L=[Crossings(1,8) 4.5 3.5 3 2.5 2 1.8 1.6 1.4 1.2;Crossings(2,6) 2.8 1.6 1.5 1.6 2 2.5 3.2 4 4.5];
Road_M=[9 Crossings(1,6);3 Crossings(2,6)];
%Define narrow roads segments
Road_N1=[Crossings(1,1) 3 3.5 4 5 6 6.5 7.2 Crossings(1,3);Crossings(2,1) 9.2 9.27 9.3 9.3 9.3 9.28 9.2 Crossings(2,3)];
Road_N2=[Crossings(1,3) Crossings(1,9);Crossings(2,3) Crossings(2,9)];
Road_N3=[Crossings(1,9) 5.2 Crossings(1,8);Crossings(2,9) 4.5 Crossings(2,8)];
Road_N4=[Crossings(1,8) 6.5 Crossings(1,7);Crossings(2,8) 2 Crossings(2,7)];
Road_N5=[Crossings(1,7) 8.5;Crossings(2,7) 1];
Road_N6=[9.5 9.5; 1.5 2];
Road_N7=[9.5 9.5;4 4.5];
Road_N8=[9 Crossings(1,5); 5 Crossings(2,5)];
Road_N9=[Crossings(1,5) (8+5.5)/2 Crossings(1,9); Crossings(2,5) (4.6 + 6)/2 Crossings(2,9)];
Road_N10=[Crossings(1,9) 4.7 Crossings(1,2); Crossings(2,9) 7 Crossings(2,2)];
Road_N11=[Crossings(1,4) 9;Crossings(2,4) 8.5];
%Combined wide roads
Road_Wide1=[Road_A,Road_B,Road_C,Road_D];
Road_Wide2=[Road_E,Road_F,Road_G,Road_H,Road_I,Road_J];
Road_Wide3=[Road_M,Road_K,Road_L];

% Choose Road Details
Road_Name = 'B';
Road_Path = Road_N4;
Road_Poly = 'poly2';    % Choose polyfit polynomial degree
%%%%%%%%%%%%%%%%%%%
Road_XYZ=[Road_Path;z_topo(Road_Path(2,:),Road_Path(1,:))]; %Add z data, enter z_topo(y,x) NOT z_topo(x,y)!!!

Data_A=Road_def(Road_Name,Road_XYZ,Road_Poly);

RoadId=Data_A{1}
s_max=Data_A{2}
x=Data_A{3}
y=Data_A{4}
z=Data_A{5};
dz=Data_A{6}
xpol=zeros(1,7);
ypol=xpol;
zpol=xpol;




disp('----')
%disp([RoadId,',',num2str(s_max),',',num2str(x.p1),',',num2str(x.p2),',',num2str(x.p3),',',num2str(x.p4),',',num2str(x.p5),',',num2str(x.p6),',',num2str(x.p7),',',num2str(x.p8),',',num2str(y.p1),',',num2str(y.p2),',',num2str(y.p3),',',num2str(y.p4),',',num2str(y.p5),',',num2str(y.p6),',',num2str(y.p7),',',num2str(y.p8),',',num2str(z.p1),',',num2str(z.p2),',',num2str(z.p3),',',num2str(z.p4),',',num2str(z.p5),',',num2str(z.p6),',',num2str(z.p7),',',num2str(z.p8)])
%disp(num2str([y.p1,y.p2,y.p3,y.p4,y.p5,y.p6,y.p7,y.p8]))
%disp(num2str([z.p1,z.p2,z.p3,z.p4,z.p5,z.p6,z.p7,z.p8]))
%Check functions: x and y
% Uncomment
% figure(4) 
% subplot(2,1,1)
% plot(Road_Path(1,:),Road_Path(2,:),'b*')
% axis equal
% hold on
% plot(x(0:0.01:s_max),y(0:0.01:s_max),'r-');
% legend('Datapoint','Fitted curve')
% title(Road_Name)
% hold off
% %Check function Z
% subplot(2,1,2)
% plot([0:0.001:s_max],z_topo(y(0:0.001:s_max),x(0:0.001:s_max)),'b')
% axis([-0.1 s_max+0.1 0.9 1.5])
% hold on
% plot([0:0.001:s_max],z(0:0.001:s_max),'r');
% legend('Topography','Fitted curve')
% title(Road_Name)
% hold off

% Uncomment for creating a Continuous Map 
% plot(x(0:0.01:s_max)+1,y(0:0.01:s_max)+1,'Color',cc,'LineWidth',6)

%%
%Plotting
%Plot topography
%figure(6)
%'axis([1 11 1 11])
%hold on
%colormap(map)
%[C,h]=contourf(Z_data);
%brighten(0.4)
%set(h,'LineColor','k')%removes black lines
%cc = [0 0 0]/255

% Source
S=[Source(1:2)+1 Source(3:4)];  %here we go!
rectangle('Position',S,'FaceColor',areacolor,'EdgeColor',cc)
txt_source = 'Source';
text(Source(1)+Source(3)/6+1, Source(2)+Source(4)/2+1, txt_source,'FontSize',14)
%Facility
F=[Facility(1:2)+1 Facility(3:4)];  %here we go!
rectangle('Position',F,'FaceColor',areacolor,'EdgeColor',cc)
txt_facility = 'Facility';
text(Facility(1)+Facility(3)/6+1, Facility(2)+Facility(4)/2+1,txt_facility,'FontSize',14)
%Charging stations
C=[Charging(1:2)+1 Charging(3:4)];  %here we go!
rectangle('Position',C,'FaceColor',areacolor,'EdgeColor',cc)
txt_charging = 'Charging';
text(Charging(1)+Charging(3)/6+1, Charging(2)+Charging(4)/2+1,txt_charging,'FontSize',14)

% %%%%%%%%%%%%%%%%%% Parking %%%%%%%%%%%%%%%%%%
P=[Parking(1:2)+1 Parking(3:4)];
rectangle('Position',P,'FaceColor',areacolor,'EdgeColor',cc)


% %%%%%%%%%%%%%%%%%% Plotting Parking Spots %%%%%%%%%%%%%%%%%%
% Plus 1 is for distortion
spotsize = 0.2;
number_of_spots = floor(Parking(end)/spotsize);
half = number_of_spots-(number_of_spots/2+1);
top = number_of_spots/2+1;
xpos = zeros(1,16);
ypos = xpos;
Spot=1;
for i = 1:2 %11-0.3:-0.55:10
    for j = 1:1:floor(half)
        parking_spots = [10.2-0.5+(i*0.5) 3-spotsize+j*spotsize 0.2 0.2];
        PSpot = [parking_spots(1:2) parking_spots(3:4)];
        xpos(Spot) = parking_spots(1) + spotsize/2 - 1; % Scaling coordinates for centre
        ypos(Spot) = parking_spots(2) + spotsize/2 - 1;
        %rectangle('Position',PSpot,'FaceColor', [135 206 250]/255, 'EdgeColor', cc)
        Spot=Spot+1;
    end
    
    for j = top:1:number_of_spots-1
        parking_spots = [10.2-0.5 + (i*0.5) 3+j*spotsize 0.2 0.2];
        PSpot = [parking_spots(1:2) parking_spots(3:4)];
        xpos(Spot) = parking_spots(1) + spotsize/2; % Scaling coordinates for centre
        ypos(Spot) = parking_spots(2) + spotsize/2;
        %rectangle('Position',PSpot,'FaceColor', [135 206 250]/255, 'EdgeColor', cc)
        Spot=Spot+1;
    end
end
p_x = sprintf('%1.1f,',xpos);
p_y = sprintf('%1.1f,',ypos);
% %%%%%%%%%%%%%%%%%% Plot Charging Spots %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%                     %%%%%%%%%%%%%%%%%%
number_of_chspots = floor(Charging(end)/spotsize);
half = number_of_chspots - (number_of_chspots/2+1);
top = number_of_chspots/2 + 1;
xpos = zeros(1,8);
ypos = xpos;
spotsize = 0.15;
% Charging slots
for i = 1:8 %11-0.3:-0.55:10
        charging_spots = [9.5+(i*1)*spotsize 1+spotsize spotsize spotsize];
        Chspot = [charging_spots(1:2) charging_spots(3:4)];
        xpos(i) = charging_spots(1) + spotsize/2 - 1;    % Scaling coordinates for centre
        ypos(i) = charging_spots(2) + spotsize/2 - 1;
        %rectangle('Position',Chspot,'FaceColor', [255 255 0]/255, 'EdgeColor', cc)
        i=i+1;
end
ch_x = sprintf('%1.1f,',xpos);
ch_y = sprintf('%1.1f,',ypos);
% Parking spots for queueing on Charge area
for j = 1:8
        charging_p_spots = [9.55+j*spotsize 2+spotsize spotsize spotsize];
        ChPspot = [charging_p_spots(1:2) charging_p_spots(3:4)];
        xpos(j) = charging_p_spots(1) + spotsize/2 - 1;    % Scaling coordinates for centre
        ypos(j) = charging_p_spots(2) + spotsize/2 - 1;
        %rectangle('Position',ChPspot,'FaceColor', [135 206 250]/255, 'EdgeColor', cc)
        j=j+1;
end

chp_x = sprintf('%1.2f,',fliplr(xpos));
chp_y = sprintf('%1.2f,',ypos);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Plot Source Queue %%%%%%%%%%%%%%%%%%%%%%
% source_queue = [2.0 Source(:,2)+1 spotsize spotsize]
spotsize = 0.10;
sa_x = zeros(1,8);
sa_y = sa_x;
for i = 1:10
    if i >= 1 && i <= 7
        source_queue = [2.0-spotsize*i+spotsize Source(:,2)+1+0.64*spotsize*i-0.5*spotsize spotsize spotsize];
        Sspot = [source_queue(1:2) source_queue(3:4)];
        %rectangle('Position', Sspot, 'FaceColor', [135 206 250]/255, 'EdgeColor', cc)
        sa_x(i) = source_queue(1) + spotsize/2 - 1;  % Scaled for centre position 
        sa_y(i) = source_queue(2) + spotsize/2 - 1;  
        hold on
        i = i +1;
    
    elseif i > 7
        source_queue = [2.0-spotsize*(i)+spotsize Source(:,2)+1+0.64*spotsize*(i-(i-7))-0.5*spotsize spotsize spotsize];
        Sspot = [source_queue(1:2) source_queue(3:4)];
        %rectangle('Position', Sspot, 'FaceColor', [200 206 250]/255, 'EdgeColor', cc)
        sa_x(i) = source_queue(1) + spotsize/2 - 1;  % Scaled for centre position 
        sa_y(i) = source_queue(2) + spotsize/2 - 1;
        i = i +1;
    end

end
% coordinates for Source Area parking (already scaled)
sa_x = sprintf('%1.2f,',fliplr(sa_x));
sa_y = sprintf('%1.2f,',fliplr(sa_y));



source_spot1 = [1.9-spotsize 7-spotsize spotsize spotsize];
sspot1 = [source_spot1(1:2) source_queue(3:4)];
%rectangle('Position', sspot1, 'FaceColor', [135 206 250]/255, 'EdgeColor', cc)

source_spot2 = [1.9-2*spotsize 7-2*spotsize spotsize spotsize];
sspot2 = [source_spot2(1:2) source_queue(3:4)];
%rectangle('Position', sspot2, 'FaceColor', [135 206 250]/255, 'EdgeColor', cc)

source_spot3 = [1.9-2.5*spotsize 7-3*spotsize spotsize spotsize];
sspot3 = [source_spot3(1:2) source_queue(3:4)];
%rectangle('Position', sspot3, 'FaceColor', [135 206 250]/255, 'EdgeColor', cc)

% Material Processor coordinates
w = 0.2;
h = 0.4;
x_prcss = 0.15+1-0.5*w;
y_prcss = 4.7+1-0.5*h;
material_prcss = [x_prcss y_prcss w h];
mp = [material_prcss(1:2) material_prcss(3:4)];
%rectangle('Position', mp, 'FaceColor', [255 0 0]/255, 'EdgeColor', cc)
x_prcss = x_prcss + 1/2*w - 1;
y_prcss = y_prcss + 1/2*h - 1;

fprintf('Material Processer x,y-coordinates \n');
fprintf('%1.2f, %1.2f \n', x_prcss, y_prcss);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Plot Facility slots %%%%%%%%%%%%%%%%%%%%%%
f_x = zeros(1,8);
f_y = f_x;
spotsize = 0.15;
for i = 1:8
    if i<=4
    facility_queue = [9.5-spotsize+i*spotsize 10.6-spotsize spotsize spotsize];
    fspot = [facility_queue(1:2) facility_queue(3:4)];
    %rectangle('Position', fspot, 'FaceColor', [135 206 250]/255, 'EdgeColor', cc)
    hold on
    elseif i>4
        
        facility_queue = [9.5-spotsize+i*spotsize 10.6-0.5*(i-2)*spotsize spotsize spotsize];
        fspot = [facility_queue(1:2) facility_queue(3:4)];
     %   rectangle('Position', fspot, 'FaceColor', [135 206 250]/255, 'EdgeColor', cc)
        hold on
        
        
    end
    f_x(i)=facility_queue(1) + spotsize/2 - 1;
    f_y(i)=facility_queue(2) + spotsize/2 - 1;
end
f_x = sprintf('%1.3f,', fliplr(f_x));
f_y = sprintf('%1.3f,', fliplr(f_y));

txt_parking = 'Parking';
text(Parking(1)+Parking(3)/7+1 ,Parking(2)+Parking(4)/2+1,txt_parking,'FontSize',14)
%controlTower
CT=[ControlTower(1:2)+1 ControlTower(3:4)];
rectangle('Position',CT,'FaceColor',areacolor,'EdgeColor',cc)
txt_control = 'Control';
txt_tower = 'Tower';
text(ControlTower(1)+ControlTower(3)/7+1, ControlTower(2)+ControlTower(4)/2+1.2, txt_control,'FontSize',14)
text(ControlTower(1)+ControlTower(3)/6+1, ControlTower(2)+ControlTower(4)/2+0.9, txt_tower,'FontSize',14)

% ---------------- Plotting Roads -----------------------
%Plotting Wide roads
plot(Road_Wide1(1,:)+1,Road_Wide1(2,:)+1,'Color',cc,'LineWidth',8)
plot(Road_Wide2(1,:)+1,Road_Wide2(2,:)+1,'Color',cc,'LineWidth',8)
plot(Road_Wide3(1,:)+1,Road_Wide3(2,:)+1,'Color',cc,'LineWidth',8)
% %Plotting narrow roads

plot(Road_N1(1,:)+1,Road_N1(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N2(1,:)+1,Road_N2(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N3(1,:)+1,Road_N3(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N4(1,:)+1,Road_N4(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N5(1,:)+1,Road_N5(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N6(1,:)+1,Road_N6(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N7(1,:)+1,Road_N7(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N8(1,:)+1,Road_N8(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N9(1,:)+1,Road_N9(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N10(1,:)+1,Road_N10(2,:)+1,'Color',cc,'LineWidth',4);
plot(Road_N11(1,:)+1,Road_N11(2,:)+1,'Color',cc,'LineWidth',4);

%Plotting crossings
%plot(Crossings(1,:)+1,Crossings(2,:)+1,RoadColor)
%Plott hill
%plot(hill_x(1,:)+1,hill_y(1,:)+1,'k')
%plot(hill_x(2,:)+1,hill_y(2,:)+1,'k')
%plot(hill_x(3,:)+1,hill_y(3,:)+1,'k')
%axis definition
%axis([0 10 0 10])



