# CT Reconstruction using Fourier Filtered Backprojection

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


### Files

The explanation of the files

* [FFB.m](https://github.com/bijiuni/CT_reconstruction/blob/master/FFB.m) - Implementation of the Fourier Filtered Backprojection method
* [main.m](https://github.com/bijiuni/CT_reconstruction/blob/master/main.m) - The main program to perform the reconstruction
* [fan_beam_compare.m](https://github.com/bijiuni/CT_reconstruction/blob/master/fan_beam_compare.m) - Compare the performance of pencil-beam and fan-beam
* [own_radon.m](https://github.com/bijiuni/CT_reconstruction/blob/master/own_radon.m) - Realizing radon transform without using built-in fuction

## Authors

**For much more detailed results please refer the PDF file**

![Result sample 1](https://github.com/bijiuni/CT_reconstruction/blob/master/sample1.PNG)
![Result sample 2](https://github.com/bijiuni/CT_reconstruction/blob/master/sample2.PNG)
![Result sample 3](https://github.com/bijiuni/CT_reconstruction/blob/master/sample3.PNG)


## Authors

* **Zach Lyu** - *Code Writing*


## Acknowledgments

* Prof Ed. Wu for supervising the project
* Other group mates: Chui Mei Yee; Dey Poonam Aditi; Fung Chun Hin.
