function completeHorizonLine = shelfLines(theEdge, pixRemove)

se1=ones(1,7);
erodeHorizon = imerode(theEdge,se1);

smallPixRemove = bwareaopen(erodeHorizon,pixRemove);
completeHorizonLine = complete_line(smallPixRemove');


end

function completeHorizonLine = complete_line(smallPixRemove)

completeHorizonLine = smallPixRemove;

C=size(smallPixRemove,2);

for x = 1:C
    temp_mat = smallPixRemove(:,x);
    N = find(temp_mat==1);
    r = size(N,1);
   
    if r>0
        completeHorizonLine(:,x) = 1;
    end 
end

completeHorizonLine = completeHorizonLine';
    
end
