%Prioritize roads
function OutList=Prio(Inlist,Roads)
List=sortrows(Inlist,2);
%OutList=cell(length(List),9)
for i=1:length(Inlist)
Road=Roads{List(i,1),:};
    OutList{i,:}=Road;
end
end