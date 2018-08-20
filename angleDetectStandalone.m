function angleDetectStandalone(bookSpine, shelfId)
      
    bookSpineImage = rgb2gray(bookSpine);
    [Row Col] = size(bookSpine);

    centerLine = ceil(Row/2);

    bookSpineImageEdge =  edge(bookSpineImage,'canny',.1);
    bookSpineImageEdgePad = bwareaopen(bookSpineImageEdge,100);


    lineImage = bookSpineImageEdgePad*0;
    finalDetectIine = lineImage;

    thresholdVal = 0.35;

    startPix = ceil(-Col/2);
    endPix = ceil(Col/2);
    incPix = 1;

    

    for theInc = startPix:incPix:endPix
    returnedImage= searchLine(lineImage,bookSpineImageEdgePad,centerLine,theInc,thresholdVal);

         if sum(returnedImage(:))~=0
            finalDetectIine = finalDetectIine + returnedImage;
         end

    end


    SE = strel('disk', 2, 4);
    finalDetectIine = imdilate(finalDetectIine,SE);

    SE = strel('disk', 1, 4);
    finalDetectIine = imerode(finalDetectIine,SE);

    generateRGB(bookSpine,~finalDetectIine,shelfId);


    CCA(finalDetectIine,bookSpine,shelfId);



end




function generateRGB(bookSpine,finalDetectIine,shelfId)

    Ir = bookSpine(:,:,1);
    Ig = bookSpine(:,:,2);
    Ib = bookSpine(:,:,3);

    [R C] = size(finalDetectIine);

    for i = 1:R
        for j =1:C

            if (finalDetectIine(i,j)== 0)
                Ir(i,j) = 255;
                Ig(i,j) = 255;
                Ib(i,j) = 0;
            end

        end
    end

    colorLineImage = cat(3,Ir,Ig,Ib);

    imwrite(colorLineImage,['OUTPUT/DETECT/shelf_' int2str(shelfId) '.jpg']);

end



function CCA(finalDetectIine,inputImage,shelfId)

    finalDetectIine = ~finalDetectIine;
    [R C] = size(finalDetectIine);

    count=0;
    count2=0;
    [L1, num1] = bwlabel(finalDetectIine, 8);

    for i = 1:num1

        Ir = inputImage(:,:,1);
        Ig = inputImage(:,:,2);
        Ib = inputImage(:,:,3);

        [r1 c1]=find(L1==i);
        rc1 = [r1 c1];
        mat1 = rc1(:,1);
        mat2 = rc1(:,2);

        flag = vaidateBook(mat1,mat2,R,C);

      if flag == 1
          
         degr = bookOrient(L1,mat1,mat2,i);

          
        for p=1:R
            for q=1:C

                if(L1(p,q)~=i)

                    Ir(p,q)=0;
                    Ig(p,q)=0;
                    Ib(p,q)=0;

                
                end
                

            end
        end

        extractedBook1 =  Ir(min(mat1):max(mat1),min(mat2):max(mat2));
        extractedBook2 =  Ig(min(mat1):max(mat1),min(mat2):max(mat2));
        extractedBook3 =  Ib(min(mat1):max(mat1),min(mat2):max(mat2));

        extractedBook = cat(3,extractedBook1,extractedBook2,extractedBook3);
        extractedBook = imrotate(extractedBook,degr+90,'bilinear');
          count = count+1;
          imwrite(extractedBook, ['OUTPUT/BOOKS/' int2str(shelfId) '_' int2str(count) '.jpg']);

       end
    end

disp(['   -> ' num2str(count) ' books detected in shelf ' num2str(shelfId)]);

end
