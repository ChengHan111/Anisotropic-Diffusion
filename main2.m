%%%%%%%%%%%%% main1.m file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First we select the image from two of the
% images:'cwheelnoise','cameraman', we have g(.) in two forms and these two
% forms can have different effects when using them on these images. After
% choosing the image, we call histogram.m to find the histogram of the
% chosen image. Then we do AnisotropicDiffusion to the selected image and
% also get the histogram of it. 
%
% Restrictions/Notes:
%
% The following functions are called:
%      histogram.m        Get the image's gray-scale histogram
%
%  Author:      Zhicheng Chen, Cheng Han, Wenxing Cao
%  Date:        3/16/2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
%% Step 1 SELECT IMAGE 
prompt = 'input 1 to cwheelnoise or 2 to cameraman: ';%switch cases
x = input(prompt);
switch (x)
    case 1
        img = imread('cwheelnoise.gif');
    case 2
        img = imread('cameraman.tif');
    otherwise
        disp('No image selected');
end

if ndims(img)==3
  error('AnisotropicDiffusion only operates on 2D gray-scale image');
end
%% Step 2 AnisotropicDiffusion 
k=36;           %an appropriate value of K. k=2,20,200,2000
lambda=0.25;    %choosing of lambda, which is a constant in project3
N=5;           %iteration steps
img=double(img);
temp_img = img; %save a original image
imshow(img,[]);
[m,n]=size(img);
typeg =1; % typeg=1 exponetial typeg=2 inverse  
imgn=zeros(m,n);

% plot(img(:,128));

%% histogram of original image
% Compute the histogram and the cdf of the image f,g,fnew and gnew
pr_f = histogram1(img, m, n);

% Make labeled plots of the histogram and cdf of f,g,fnew and gnew
x = 1: 256;

figure,bar(x, pr_f, 0.4);
xlabel('Grayscale');
ylabel('The number of pixels');
title('Histogram of original image');

%% Step 2 AnisotropicDiffusion Continue
for i=1:N % iteration steps
    for p=2:m-1
        for q=2:n-1 %scan the pixels in the image, noticed that the boundary is ignored.
            NI=img(p-1,q)-img(p,q);
            SI=img(p+1,q)-img(p,q);
            EI=img(p,q-1)-img(p,q);
            WI=img(p,q+1)-img(p,q);
            %choose one type of g(.) to do the calculation
            if typeg == 1
            cN=exp(-NI^2/(k*k));
            cS=exp(-SI^2/(k*k));
            cE=exp(-EI^2/(k*k));
            cW=exp(-WI^2/(k*k));

            elseif typeg == 2
            cN = 1./(1 + (NI/k).^2);
            cS = 1./(1 + (SI/k).^2);
            cE = 1./(1 + (EI/k).^2);
            cW = 1./(1 + (WI/k).^2);
            end
            
            imgn(p,q)=img(p,q)+lambda*(cN*NI+cS*SI+cE*EI+cW*WI);
            if imgn(p,q)>=255
                imgn(p,q)=255;
            elseif imgn(p,q)<=0
                imgn(p,q)=0;
            end
        end
    end
    
    img=imgn;       
end

imtool(imgn,[]);


%% Histogram of image after doing AnisotropicDiffusion
% Compute the histogram and the cdf of the image f,g,fnew and gnew
imgn = int16(imgn);

pr_f2 = histogram1(imgn, m, n);

% Make labeled plots of the histogram and cdf of f,g,fnew and gnew
x = 1: 256;

figure,bar(x, pr_f2, 0.4);
xlabel('Grayscale');
ylabel('The number of pixels');
title('Histogram of image after doing AnisotropicDiffusion');

%% line y = 128
plot(imgn(:,128)); %choose y=128 line, save as Line128
%% segmented out the 'spokes'
% spokes = findspokes(imgn,80,110);
% imtool(spokes,[]);
