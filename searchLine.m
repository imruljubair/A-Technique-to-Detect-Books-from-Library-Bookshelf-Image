function returnedImage = searchLine(lineImage,bookSpineImageEdgePad,centerLine,theInc,thresholdVal)

    [Row Col] = size(bookSpineImageEdgePad);
    x1 = 1;
    y1 = theInc;

    x2 = centerLine;
    y2 = 1;

    m =  (y2-y1)/(x2-x1);

       for i = 1:Col
           count = 0;
           total = 0;
                for j = 1:Row

                    X = j;
                    Y = y1 + (m)*(X - x1);
                    Y = ceil(Y);
                         if (X > 0 && X < Row) && (Y > 0 && Y < Col)
                                if bookSpineImageEdgePad(X,Y) == 1
                                    count = count + 1;
                                else
                                    total = total + 1;
                                end
                         end
                end

                if count > total * thresholdVal

                        for j = 1:Row

                            X = j;
                            Y = y1 + m*(X - x1);
                            Y = ceil(Y);
                                if (X > 0 && X < Row) && (Y > 0 && Y < Col)
                                   lineImage(X,Y) = 1;
                                end
                        end

                end

                x1 = x1 + 1;
                y1 = y1 + 1;

       end

       returnedImage = lineImage;
 
end