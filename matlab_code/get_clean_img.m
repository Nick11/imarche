%% extract images
step = 8;
extractFrames('MVI_0661.MOV', 'input_imgs/', step);

%% load images
% find the folder
folder = 'input_imgs';
verbose = false;
% get the names of all image files
searchFor = strcat(folder,'/*.jpg');
dirListing = dir(searchFor);
% get number of images
numFrames = length(dirListing);
% open images and store it in array

for i = 1:numFrames
    % use full path because the folder may not be the active path
    fileName = fullfile(folder,dirListing(i).name);
    img = imread(fileName);
    img = im2double(img);
    images(:,:,:,i) = img;
    if verbose
        figure;
        imshow(img);
        title(['Input image ',num2str(i)]);
    end
    
end
for step = 6:10
        %compute median
        lessImages = images(:,:,:,1:step:end);
        med = median(lessImages,4);
        percOfImgToKeep=1;
%         %find 75% best matches and throw away the others
%         diff = lessImages - repmat(med,1,1,1,size(lessImages,4));
%         diff = abs(diff);
%         diff = sum(sum(sum(diff,1),2),3);
%         
%         [~, sortIndex] = sort(diff);
%         percOfImgToKeep = 0.5;
%     for percOfImgToKeep = [0.1,0.25,0.5]
%         goodIndices = sortIndex(1:int32(length(diff)*percOfImgToKeep));
% 
%         %recalculate median
%         med = median(lessImages(:,:,:,goodIndices),4);
% 
%         figure;
%         imshow(med)
%         title(['Output: Median image using a total of ',num2str(size(lessImages,4)),' images and selecting the ',num2str(percOfImgToKeep*100),'% best images'])
%         
        imwrite(med,['results/med-totImg_',num2str(size(lessImages,4)),'-used_',num2str(percOfImgToKeep*100),'pc.jpg']);
%     end
end
% disp('The median image chooses for each pixle and color the one that is closest to the median of the colors of this pixle in each image.')