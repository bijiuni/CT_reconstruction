% Realizing radon transform without using built-in fuction
% param img
%        the original image to be radon transformed
% param theta
%        the interval of the projection angles

function processed_img = own_radon(img, theta) 
 
[n_row, n_column] = size(img); Dia = sqrt(n_row + n_column); row_Pad = ceil(Dia - n_row) + 2; col_Pad = ceil(Dia - n_column) + 2; pad = zeros(n_row+row_Pad, n_column+col_Pad); pad(ceil(row_Pad/2):(ceil(row_Pad/2)+n_row-1), ...     ceil(col_Pad/2):(ceil(col_Pad/2)+n_column-1)) = img; 
 
angle = length(theta); processed_img = zeros(size(pad,2), angle); for i = 1:angle    tic    tmpimg = imrotate(pad, 90-theta(i), 'bilinear', 'crop');    processed_img(:,i) = (sum(tmpimg))';    theta(i)    toc end
