%{ Implementation of the Fourier Filtered Backprojection method
	 
	 %@param phantom_img
	         %the original image
	 %@param filter_type
	         %string, can either be none, ramlak, shepplogan, hamming, or lowpasscosine
	 %@param dtheta
                 %interval betwen projection angles, in degrees
         %@param coe_transform
                 %a coefficient adjusting the size of the Fourier Transform
         %@param cut_off
                 %the cut off ratio for the filters, values larger than width*cut_off are set to zeroes
         %@param interpolation
                 %interpolation method, can either be linear or nearest
%}

function final_img = FFB(phantom_img, filter_type, dtheta, coe_transform, cut_off, interpolation)
    P = phantom_img;    %Load the phantom

    [n_row, n_column] = size(P);
    theta = 0:dtheta:(180-dtheta);  % Set the projection angle

    [R,xp] = radon(P,theta); %Perform radon transorm, Xp is a vector containing 
    %the radial coordinates corresponding to each row of R

    [num_detectors ,num_angles]  = size(R);
    xp_offset = abs(min(xp)) +1;

    width = 2^nextpow2(num_detectors)*(2^coe_transform); %Get power of 2 for FFT
                                       %at least large enough to fit a column of R
    proj_fft = fft(R, width);
    
    ram_lak = 2*[0:(width/2-1), width/2:-1:1]'/width;
    if (strcmp(filter_type,'none')==1)
        filter = ones(width, 1);
    elseif(strcmp(filter_type,'ramlak')==1)  %Ram-Lak
        filter = ram_lak;
    elseif(strcmp(filter_type,'shepplogan')==1)  %Shepp-Logan
        Sinc = abs(sinc(2*(0:width-1)/(2*width)));
        temp = [Sinc(1:(width/2)), Sinc(width/2:-1:1)];
        filter = ram_lak .* temp';
    elseif(strcmp(filter_type,'hamming')==1)   %hamming
        Hamming = 0.54 - 0.46*cos(2*pi*(0:width-1)/width);
        temp = [Hamming(width/2:width) Hamming(1:width/2-1)];
        filter = ram_lak .* temp';
    elseif(strcmp(filter_type,'lowpasscosine')==1)   %Lowpass Cosine
        Cosine = abs(cos(2*pi*(0:width-1)/(2*width)));
        filter = ram_lak .* Cosine';
    end
    
    filter(width*cut_off:end)=0;

    for w = 1:num_angles
        filtered(:, w) = proj_fft(:, w).*filter;
    end

    inverse_f = real(ifft(filtered));

    final_img = zeros(n_row, n_column);
    
    if (strcmp(interpolation,'linear')==1)
        
         for iprog=1:num_angles
            G = inverse_f(:, iprog);
            rad = theta(iprog)*pi/180;

            for x=1:n_column
                for y=1:n_row
                    t = (x-(n_column/2))*cos(rad) - (y-(n_row)/2)*sin(rad) + xp_offset;

                    if (ceil(t) == floor(t))
                        g1 = G(ceil(t));
                        g2=0;
                    else
                        g1 = G(ceil(t)) * (t-floor(t));
                        g2 = G(floor(t)) * (ceil(t) -t);
                    end

                    final_img(y,x) = final_img(y,x) +g1 +g2;
                end
            end
         end
         
    elseif(strcmp(interpolation,'nearest')==1)
        for iprog=1:num_angles
            G = inverse_f(:, iprog);
            rad = theta(iprog)*pi/180;

            for x=1:n_column
                for y=1:n_row
                    t = (x-(n_column/2))*cos(rad) - (y-(n_row)/2)*sin(rad) + xp_offset;

                    if (t-floor(t))<(ceil(t) -t)
                        g = G(floor(t));
                    else
                        g = G(ceil(t));
                    end

                    final_img(y,x) = final_img(y,x) +g;
                end
            end
         end
    end
    
    final_img = (pi/num_angles)*final_img;

    return
end

