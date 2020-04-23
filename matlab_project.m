clear all;
close all;
Ireal = imread('/home/dell/Desktop/500real.jpg'); % Real
Iscaned = imread('/home/dell/Desktop/500fake1.jpg'); % scaned

%%//Pre-analysis
hsvImageReal = rgb2hsv(Ireal);
hsvImagescaned = rgb2hsv(Iscaned);
figure;
%image1
imshow([hsvImageReal(:,:,1) hsvImageReal(:,:,2) hsvImageReal(:,:,3)]) ;
figure;
%image2
imshow([hsvImagescaned(:,:,1) hsvImagescaned(:,:,2) hsvImagescaned(:,:,3)]);


%%//Initial segmentation
croppedImageReal = hsvImageReal(:,900:940,:);
croppedImagescaned = hsvImagescaned(:,190:200,:);
satThresh = 0.4;
valThresh = 0.3;
BWImageReal = (croppedImageReal(:,:,2) > satThresh & croppedImageReal(:,:,3) < valThresh);
figure;
subplot(1,2,1);
%image3
imshow(BWImageReal);
title('Real');
BWImagescaned = (croppedImagescaned(:,:,2) > satThresh & croppedImagescaned(:,:,3) < valThresh);
subplot(1,2,2);
imshow(BWImagescaned);
title('fake');

%%//Post-process
se = strel('line', 6, 90);
BWImageCloseReal = imclose(BWImageReal, se);
BWImageClosescaned = imclose(BWImagescaned, se);

%%//Area open the image
figure;
areaopenReal = bwareaopen(BWImageCloseReal, 15);
subplot(1,2,1);
%image4
imshow(areaopenReal);
title('Real');
subplot(1,2,2);
areaopenscaned = bwareaopen(BWImageClosescaned, 15);
imshow(areaopenscaned);
title('fake');



blackStripReal = Ireal(280:530,250:400,:);
blackStripscaned = Iscaned(58:110,50:80,:);

figure;
subplot(1,3,1);
%image5
imshow(blackStripReal);
title('Real');
subplot(1,3,2);
imshow(blackStripscaned);
title('fake');
%%//Convert into grayscale then threshold
blackStripReal = rgb2gray(blackStripReal);
blackStripscaned = rgb2gray(blackStripscaned);

figure;
subplot(1,3,1);
%image6
imshow(blackStripReal);
title('Real');
subplot(1,3,2);
imshow(blackStripscaned);
title('fake');