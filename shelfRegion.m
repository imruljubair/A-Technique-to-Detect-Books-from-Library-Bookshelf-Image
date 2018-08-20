function [count,inputImage] = shelfRegion(completeHorizonLine,inputImage)
 
sel=ones(10);

completeHorizonLine = imdilate(completeHorizonLine,sel);



Ir = inputImage(:,:,1);
Ig = inputImage(:,:,2);
Ib = inputImage(:,:,3);

Ir(find(completeHorizonLine==1))= 255;
Ig(find(completeHorizonLine==1))= 0;
Ib(find(completeHorizonLine==1))= 0;

inputImage = cat(3,Ir,Ig,Ib);


count = CCA(completeHorizonLine,inputImage);

end


function count = CCA(completeHorizonLine,inputImage)

completeHorizonLine = ~completeHorizonLine;
 maxH =100;
count=0;
[L1, num1] = bwlabel(completeHorizonLine, 8);

for i = 1:num1
    
    [r1 c1]=find(L1==i);
    rc1 = [r1 c1];
    mat1 = rc1(:,1);
    mat2 = rc1(:,2);
    
    
    Ir = inputImage(:,:,1);
    Ig = inputImage(:,:,2);
    Ib = inputImage(:,:,3);
    
       
    extractedShelf1 =  Ir(min(mat1):max(mat1),min(mat2):max(mat2));
    extractedShelf2 =  Ig(min(mat1):max(mat1),min(mat2):max(mat2));
    extractedShelf3 =  Ib(min(mat1):max(mat1),min(mat2):max(mat2));
    
    extractedShelf = cat(3,extractedShelf1,extractedShelf2,extractedShelf3);
    
  [a b] = size(extractedShelf);
   if a > maxH
      count = count+1;
      imwrite(extractedShelf, ['OUTPUT/SHELF/' int2str(count) '.jpg']);
   end
    
end
end