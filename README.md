# CT Reconstruction using Fourier Filtered Backprojection
 
 
## Overview

Tomography is a technique to investigate the structure and composition of an object
non-invasively, along spatial and temporal dimensions using photonic radiation, acoustic or
electromagnetic waves, such as X-rays and gamma rays. Initially, the tomographic system
acquires a set of partial measurements by scanning. These measurements are then used for
tomographic projection and reconstruction of optimal tomographic images.

The purpose of this report is to use Fourier Filtered Backprojection on a Shepp-Logan phantom
image generated in MATLAB. After construction of the image, it is transformed into the radon
and frequency domains. Next, nine filters are applied on the image, followed by a
one-dimensional fast inverse fourier transform and backprojection. After reconstruction, the
effects of sampling, missing projection, filtering, noise and other artifacts on the image are
analyzed and discussed briefly.


## Files

Overview of the files

* [FFB.m](https://github.com/bijiuni/CT_reconstruction/blob/master/FFB.m) - Implementation of the Fourier Filtered Backprojection method
* [main.m](https://github.com/bijiuni/CT_reconstruction/blob/master/main.m) - The main program to perform the reconstruction
* [fan_beam_compare.m](https://github.com/bijiuni/CT_reconstruction/blob/master/fan_beam_compare.m) - Compare the performance of pencil-beam and fan-beam
* [own_radon.m](https://github.com/bijiuni/CT_reconstruction/blob/master/own_radon.m) - Realizing radon transform without using built-in fuction


## Explanations


### FFB function
```
function final_img = FFB(phantom_img, filter_type, dtheta, coe_transform, cut_off, interpolation)
```


The function has six parameters. It takes in the original phantom, perform radon transform, and output the reconstructed image

```
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
```

### own_radon

Realizing radon transform without using built-in fuction

```
function processed_img = own_radon(img, theta) 
```

### main

* Create a phantom image
* Calling the FFB function with specific parameters
* Calculate the SSIM and MSE of the reconstruction to evaluate the process
* Plot the result for analysis


## Sample results

**For detailed results please refer the [Report](https://github.com/bijiuni/CT_reconstruction/blob/master/CT%20Reconstruction%20using%20Fourier%20Filtered%20Backprojection.pdf)**


### Effect of Sampling

When the sampling interval decreases, the SSIM value increases and the MSE value decreases.
This is intuitively true as for a single point, more projection means that the sum of
backprojection is closer to the complete integral.
![Result sample 4](https://github.com/bijiuni/CT_reconstruction/blob/master/img/sample4.jpg)

### Effect of filters

From the graph, it can be deduced that the image with the Bartlett-Hanning filter has the lowest MSE and highest
SSIM, showing it has the best image quality. On the other hand, the Barlett filtered image has the
lowest SSIM while the MSE is comparable to the other values, thus, having the worst image
quality.
![Result sample 5](https://github.com/bijiuni/CT_reconstruction/blob/master/img/sample5.JPG)
![Result sample 2](https://github.com/bijiuni/CT_reconstruction/blob/master/img/sample2.PNG)


### Noise Propagation

When noise is added to left-half or right-half of the radon
transform, the influence seems to be
universal, or at least distributed evenly in the whole picture. The noise added to one half of the
radon transform exists in half of the projections, since R has a shape of (number of detectors,
number of angles). The noise in the final reconstruction is distributed evenly. This is because any
projection selected affects all the point reconstruction in the process of backprojection.


The reconstruction shows distinct features in the upper-half and
lower-half parts when we add noise to the upper half or lower half of the radon transform. We
are essentially adding noise to one half of the detectors’ data. For a certain point in an image, most of its
projection will be detected by one half of the detectors only.

![Result sample 7](https://github.com/bijiuni/CT_reconstruction/blob/master/img/sample7.JPG)

### Effect of missing projection

For the SSIM, it can be seen that the value drop
dramatically when the no. of missing projection increase from 1 to 25, and start flattening after
that. This indicate that the image quality compared to the original phantom will decrease at first
and no longer decrease when the no. of missing projection is large. However, in terms of the
MSE, the value surprisingly drops when the no. of missing projection increases, which is
contradict to the real case. It could be possibly due to the scaling factor that used for every
reconstruction. This scaling factor is strongly related to the number of projection we used. When
there are missing projection, the decrease in projection is unconventional in real cases, which do
not take into account by the reconstruction. And because MSE is strongly depends on the
intensity scaling, therefore the abnormal results happened. This can also be shown that the SSIM
is a better evaluation than MSE here.

![Result sample 8](https://github.com/bijiuni/CT_reconstruction/blob/master/img/sample8.JPG)

### Effect of missing detectors

The results show that the image quality drop in the similar way as the
effect of missing projection do. From quantify statistics, the SSIM of the image drop rapidly on
first two sets of no. of missing detector and start flattening afterwards. On the other hand, the
value of MSE increase rapidly from 1 to 50 missing detectors and start to slow down afterward.

![Result sample 3](https://github.com/bijiuni/CT_reconstruction/blob/master/img/sample3.PNG)


### Effect of Gaussian noise in radon domain

Gaussian noise has a normal distribution in the time domain, and white noise is a random signal
having equal intensity at different frequencies. Therefore, Gaussian white noise should be the
most popular noise in the detection process if there are no big defects in the detector.
Different degree of Gaussian noise was added in the Radon space to analog the noise generated
in the detection process. Sampling interval of 0.1 degree and the ramlak filter (coefficient of
transform=5, cut off frequency=0.5) were used reconstruct all images under the same conditions.
The results are shown below.

![Result sample 6](https://github.com/bijiuni/CT_reconstruction/blob/master/img/sample6.JPG)

### Fan-beam and Pencil-beam

In order to ensure that our project has practical meaning, we compared the projections of the
phantom using pencil-beam and fan-beam respectively. The two sets of projection data was
obtained by using MATLAB radon and fanbeam functions. Two angles of 45 degrees and 90
degrees were sampled and values in radon domain for different detectors were plotted as below.
We can see that the two projections are close to each other in terms of values and shape.

![Result sample 9](https://github.com/bijiuni/CT_reconstruction/blob/master/img/sample9.JPG)


## Authors

* **Zach Lyu** 

## Acknowledgments

* Prof Ed. Wu for supervising the project
* Other group mates: Chui Mei Yee; Dey Poonam Aditi; Fung Chun Hin.
