function flag = vaidateBook(mat1,mat2,R,C)

    X1 = max(mat1);
    X2 = min(mat1);

    Y1 = max(mat2);
    Y2 = min(mat2);
    

            theThreshold1 = 0.7;
            theThreshold_l = 0.020;
            theThreshold_u = 0.7;


            theWidth = sqrt((X1-X1)^2 + (Y1-Y2)^2);
            theDiagonal = sqrt((X1-X2)^2 + (Y1-Y2)^2);
            
        if theDiagonal < R*theThreshold1 || theWidth < C*theThreshold_l || theWidth > R*theThreshold_u
            flag = 0;
        else
            flag = 1;
        end

end