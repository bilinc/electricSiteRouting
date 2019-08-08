function [sortedList, ucost] = fun_sorting(rowsize,ulegal)

for i = 1:rowsize
    
    ind = find(~cellfun('isempty', ulegal(i,:)));   % Finds the cost in each row
    if length(ind) == length(ulegal)
        ucost(i) = ulegal{i,end};
    elseif length(ind) < length(ulegal)
        ucost(i) = ulegal{i, length(ind)};
        
    end
   
end
sortedList = {};
ind = 0;
inf = 10^3;
for i = 1:length(ucost)                 % Finds the index for the least cost 
    [~,ind] = min(ucost);               % and sorts the corresponding path accordingly
    sortedList{i,1} = ulegal(ind,:);
    ucost(ind) = inf;
end
