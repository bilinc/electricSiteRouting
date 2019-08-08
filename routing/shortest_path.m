%%  Dijkstra Shortest Path Algorithm for Electric Site
% Translate "path" to corresponding road Name
clear all; close all;
%~~~~~~~~~~~~~~~~ INPUT START & FINISH ~~~~~~~~~~~~~~~~

sid = [5];          % Start node ID
fid = [1];           % End node ID
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
n = 14;
[A, C, Roads] = fun_configSite(n);   % A is the node-connection-matrix, C is the cost matrix
% mm = 1;
% nn = 2;
% A(mm,nn) = 0;
% A(nn,mm) = 0;
% 
% mm = 2;
% nn = 3;
% A(mm,nn) = 0;
% A(nn,mm) = 0;
Location=cell(n,1);
Location{1}='Source'; Location{5}='Facility'; Location{8}='ControlTower';Location{11}='Parking';Location{13}='Charging';    

%%
% First 2 columns connected nodes.  Third column cost to traverse on the connected edge

V = [1 2.5 4 7.5 9 7.8 5.2 9 8 5 9 8 9 8
    5 9 8 9 9 7 6 5 4.6 3 3 3 1 1]'; % Last to coords (1,5) and (9,9) are Source and Facility

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[cost, paths] = dijkstra(A, C, sid, fid);

gplot(A, V, 'b.:'); hold on;
xlim([0 10]);
ylim([0 10]);
grid on
for k = 1:n
    text(V(k,1), V(k,2), ['' num2str(k)], 'Color', 'k');
end

for i = 1:length(fid)
    if length(fid) == 1 && length(sid) == 1
        paths = {paths};    % Convert to cell array when single destination
        plot(V(cell2mat(paths(1,i)),1), V(cell2mat(paths(1,i)),2), 'ro-', 'LineWidth', 2)
    elseif length(fid) > 1 && length(sid) == 1
        plot(V(cell2mat(paths(1,i)),1), V(cell2mat(paths(1,i)),2), 'ro-', 'LineWidth', 2)
    end
end
% Add 'text-descriptions' to data points


% Display Start and End Positions
disp(['Start: ', num2str(sid)])
disp(['End: ', num2str(fid)])

% Display the chosen route to take
routing = {};
for i = 1:length(paths)
    if isempty(Location{paths{i}(1)}) == true
        for j = 1:length(paths{1,i})-1
            routing{i,j} = cell2mat( Roads(paths{i}(j),paths{i}(j+1)) );
        end
    else
        routing{i,1} = Location{paths{i}(1)};    % {paths{i} (1)} is the index(1) value of the paths{i} array
        for j = 1:length(paths{1,i})-1
            routing{i,j+1} = cell2mat( Roads(paths{i}(j),paths{i}(j+1)) );
        end
    end
   
    if isempty(Location{paths{i}(end)}) == false    % Adding the last node to the route if it is a Location
        routing{i,j+2}=Location{paths{i}(end)};     
    end
end
routing
disp(['Traversed distance: ', num2str(cost), ' m'])
% Save Locations Input
% Location = Location';
% file_locs = cell2table(Location);
% writetable(file_locs, 'locations_vector.txt')


% file_roads = cell2table(Roads);
% writetable(file_roads, 'roads_matrix.txt')

% file_costs = matrix2table(C);
% dlmwrite('costs_matrix.txt',C)

% dlmwrite('nodelink_matrix.txt',A)
