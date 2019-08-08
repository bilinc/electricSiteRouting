%% Electric Site - Scheduling Expansion, Start: 2018.07.11 End: TBD
clear all; close all; clc
n = 14;
[A, C, roads] = fun_configSite(n);   % A = node matrix, C = cost matrix
v_max = 23;                 % km/h
T = round(C./(v_max/3.6));         % Time to travel the arc [s]

chrgWin = 2 * 3600;      % Charging window in seconds

% ~~~~~~~~~~~~ Start and Stop destination ~~~~~~~~~~~~
% (1) S-F, (2) F-CH, (3) CH-S
sid = [1 5 13];           % Start node ID
fid = [5 13 1];           % End node ID
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%% Source-Facility
% Input nodes to disconnect between Source-Facility
%================================%
to_delete = {'None','A','B','C','D','F','G','H','I','K','L','M','N1','N2','N3','N4','N5','N6','N7','N8','N9','N10','N11'}; 
%================================%
[legalSF, costsSF] = fun_modroads(to_delete,A,T,roads,n,sid(1),fid(1));
% legalSF{1:end};

%% Facility - Charging
% Input nodes to disconnect between Facility-Charging
%================================%
to_delete; 
%================================%
[legalFC,costsFC] = fun_modroads(to_delete,A,T,roads,n,sid(2),fid(2));
% legalFC{1:end};

%% Charging - Source
% Input nodes to disconnect between Charging-Source
%================================%
to_delete; 
%================================%
[legalCS,costsCS] = fun_modroads(to_delete,A,T,roads,n,sid(3),fid(3));
% legalCS{1:end};

%%
% Removing duplicates
wdcs=legalCS;               % With duplicates
wdfc=legalFC;
wdsf=legalSF;
[~,idxcs]=unique(strcat(wdcs(:,1),wdcs(:,2),wdcs(:,3),wdcs(:,4),wdcs(:,5)));
[~,idxfc]=unique(strcat(wdfc(:,1),wdfc(:,2),wdfc(:,3),wdfc(:,4),wdfc(:,5)));
[~,idxsf]=unique(strcat(wdsf(:,1),wdsf(:,2),wdsf(:,3),wdsf(:,4),wdsf(:,5)));
ulegalCS=wdcs(idxcs,:);     % Unique legal paths, without duplicates
ulegalFC=wdfc(idxfc,:);
ulegalSF=wdsf(idxsf,:);
%% Sort by most efficient
[rowsize, ~] = size(ulegalCS);
[sortedListCS] = fun_sorting(rowsize,ulegalCS);

[rowsize, ~] = size(ulegalSF);
[sortedListSF] = fun_sorting(rowsize,ulegalSF);

[rowsize, ~] = size(ulegalFC);
[sortedListFC] = fun_sorting(rowsize,ulegalFC);


% (Test) Create moste efficient route
most_efficient = 1;
route = {sortedListSF{most_efficient}{1,:} sortedListFC{most_efficient}{1,:} sortedListCS{most_efficient}{1,:}};
route(cellfun('isempty',route)) = [];   % Removes empty elements

% % Generate to path to text file for PTC input
% file_roads = cell2table(sortedListFC);      % Change the name depending on road
% writetable(file_roads, 'sortedListFC.txt')  % Change the name depending on road


% % Create a path which is the combination of roads with the least cost
% path = {};
% for i = 1:length(sortedList)
%     for j = 1:length(sortedList{i})
%         path{i,j} = sortedList{i}{j};
%     end
% end
% pathtime = 0;
% for i = 1:size(path,1)  % count the rows
%     pathtime = pathtime + timeCosts(i,ind(i));
% end
% laps = floor(chrgWin/pathtime)  % Checking total lapse possible within the
%                                 % the given chargin window (2h)
% path