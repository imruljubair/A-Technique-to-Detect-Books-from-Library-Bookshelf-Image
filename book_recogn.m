function book_recogn()

clc;
%% deleting exisiting results from the output folders
delete ./OUTPUT/DETECT/*.jpg
delete ./OUTPUT/SHELF/*.jpg
delete ./OUTPUT/BOOKS/*.jpg


%% inputting image and edge detecting
inputImage = imread('INPUT/1 (1).jpg');
X = rgb2gray(inputImage);
[Row Col] = size(X);
theEdge = edge(X,'canny',.1);

tic;

%% step 1: detecting horizontal line for shelf extracting
pixRemove = 100;
completeHorizonLine = shelfLines(theEdge,pixRemove);

%% step 2: extracing each shelf
[numberOfShelves,detectedImage] = shelfRegion(completeHorizonLine,inputImage);

disp(['total ' num2str(numberOfShelves) ' shelves detected']);
disp('---------------------------------');


imwrite(detectedImage,'OUTPUT/DETECT/horizontal.jpg');

%% step 3: 


for x = 1:numberOfShelves
    
    bookSpine = imread(['OUTPUT/SHELF/' int2str(x) '.jpg']);
    angleDetectStandalone(bookSpine, x);

end


    theTime = toc;
    proTime = (theTime/(Row*Col))*10000;
    
    disp('---------------------------------');
    disp(['proportional time: ' num2str(proTime) ' seconds']);
    

%% saving
save all;
end