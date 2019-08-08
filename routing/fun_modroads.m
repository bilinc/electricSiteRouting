function [legal, costs] = fun_modroads(to_delete,A,C,roads,n,sid,fid)
delete = [];
ind = 1;
for i = 1:length(to_delete)
    % Index of Road segment to delete
    mod_roads = roads;  % Modifying road segments individually 
                        % uncomment for multiple node modification
                        % and change back mod_roads to roads
                        
    delete = [delete; find(strcmp(mod_roads, to_delete{i}))'];
    % Add the None disconnected road as reference

    if strcmp(mod_roads, to_delete{i}) == false
        delete = [1 1];
    end
    % Start "deleting" roads
    mod_roads{delete(i,1)} = [];
    
    if isempty(mod_roads{delete(i,1)} ) == true
        mod_roads{delete(i,2)} = [];
    end
    % Update A - node matrix
    AA = A;
    for ii = 1:14*14
        if isempty(mod_roads{ii}) == false
            AA(ii) = 1;
        else
            AA(ii) = 0;
        end
    end
    % Send the disconnect node matrix for processing
    [routing,cost] = fun_roads(AA,C,mod_roads,n,sid,fid);
    costs(ind) = cost;
    
    for idx = 1:length(routing)
        legal{ind,idx} = routing{1,idx};	% Save the road segments from routing as legal roads, index-wise
        
    end
    legal{ind,length(routing)+1} = cost;    % Add costs to the end of legal roads
    ind = ind + 1;
    
%     if strcmp(roads, to_delete{i+1}) == false % if the node are duplicate exit
%         return % Exit the function
%     end
    
end

end % end of function