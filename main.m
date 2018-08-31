P = phantom(256);

reconstruction = FFB(P, 'lowpasscosine', 0.01, 8, 1, 'linear');



[global_sim, local_sim] = ssim(reconstruction, P);

%figure, imshow(local_sim,[])
X = ['SSIM VALUE: ',num2str(global_sim)];
disp(X);

err = immse(reconstruction, P);
fprintf('\n The mean-squared error is %0.4f\n', err);

subplot(1,2,1), imshow(P); 
title('original phantom');
subplot(1,2,2), imshow(reconstruction);
title('reconstruction');
