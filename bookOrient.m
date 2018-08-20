function degr = bookOrient(cca_mat,mat1,mat2,id)

cropBook = cca_mat(min(mat1):max(mat1),min(mat2):max(mat2));
[Row Col] = size(cropBook);
theTemp = zeros(Row,Col);
% theTemp = zeros(Row,Col);

for i = 1:Row
    for j = 1:Col
       
        if cropBook(i,j)== id
            theTemp(i,j) = 1;
        end
        
    end
end

 centerLine = ceil(Row/2);

thinImage = bwmorph(theTemp,'thin',Inf);
lineImage = zeros(Row,Col);
finalDetectIine = lineImage;

thresholdVal = 0.30;
startPix = ceil(-Col);
endPix = ceil(Col);
incPix = 3;
incVal = [];
c = 0;
    for theInc = startPix:incPix:endPix
    returnedImage = searchLine(lineImage,thinImage,centerLine,theInc,thresholdVal);

         if sum(returnedImage(:))~=0
            finalDetectIine = finalDetectIine + returnedImage;
            c = c+1;
            incVal(c) = theInc;
         end

    end
    
%  thinDetect = finalDetectIine;
 degr = calculateAngel(incVal,Col,Row);
 degr = degr*(-1);
 
%  thinDetect = imrotate(finalDetectIine,degr+90);
 
end


function degr = calculateAngel(incr,Col,Row)
 
    avgInc = ceil(mean(incr));

    oppositeVal = ceil(Col/2) + avgInc;
   
    tanValue = ((Col/2-oppositeVal)/(Row/2));
    degr = atand(tanValue);
%     disp(degr);
end
