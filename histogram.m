%%%%%%%%%%%%%  Function histogram %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose:
%      compute the histogram of the input image
%
% Input Variables:
%      f           the image to be computed
%      M,N         rows (M) and columns (N) in image
%
% Returned Results:
%      pr          the histogram of the input image
%
% Processing Flow:
%      1.  find the number of each graylevels of the image f
%      2.  output the histogram array
%
% The following functions are called:
%      zero.m      to set up an MxN image full of zeros
%
% Author:      Zhicheng Chen, Cheng Han, Wenxing Cao
% Date:        11/21/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pr = histogram(f, M, N)

pr = zeros(1, 256);

for i = 1: M
    for j = 1: N
        pr(f(i, j) + 1) = pr(f(i, j) + 1) + 1;
    end
end