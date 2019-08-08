%% Function which creates the legal roads by using a disconnected node Matrix
function [routing,cost] = fun_roads(AA,C,Roads,n,sid,fid)
        
%         [A, C, ~] = fun_configSite(n);      % Ignore the first output,
%                                             % Instead uses the disconnected
%                                             % node Matrix A

[cost, paths] = dijkstra(AA, C, sid, fid);
paths = {paths};
Location=cell(n,1);
Location{1}='Source'; Location{5}='Facility'; Location{8}='ControlTower';
Location{11}='Parking'; Location{13}='Charging'; 

        % Display the chosen route to take
routing = {};
for i = 1:length(paths)
    routing{i,1} = Location{paths{i}(1)};    % {paths{i} (1)} is the index(1) value of the paths{i} array
    for j = 1:length(paths{1,i})-1
        routing{i,j+1} = cell2mat( Roads(paths{i}(j),paths{i}(j+1)) );
    end
    routing{i,j+2}=Location{paths{i}(end)}; % Adding the last node to the route
end


end