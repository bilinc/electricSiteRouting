%Cost of roads
function Cost=Cost_function(Roads,Road_Names,R_costs)

maximum=size(Roads);
Length=maximum(1);
Cost=zeros(Length,2);

for i=1:Length
Path=Roads{i,:};
cost=0;
for j=1:length(Path)
    TheRoadPiece=Path{j};
for k=1:length(Road_Names)
  
    if TheRoadPiece==Road_Names(k)
   cost=cost+R_costs(k);
    else
    end
end
end

 Cost(i,2)=cost;
 Cost(i,1)=i;
end

