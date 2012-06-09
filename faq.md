---
layout: default
title: OpenPIV-Matlab Frequently Asked Questions
---

# Frequently Asked Questions about OpenPIV semantics

## Important parameters

### `sclt` or `scale` or `scaling` parameter: 

This is a conversion constant from pixel/dt displacement to the velocity units. E.g. 
if the time between the two consecutive image is dt = 0.5 seconds and 1 pixel in 
the image corresponds to 50 cm, the value of `sclt` would be:


PIV gives displacement in pixels, therefore first multiply the displacement in pixels 
by the scaling of cm/pixel, i.e. by 50 cm/pixel. To know the speed, the displacement 
is divided by the time separation, i.e. by 0.5 seconds, then we get: 
	scaling = sclt = 50 cm/pixels / 0.5 = 100 (cm/seconds/pixels]

For example, if the vector is 10 pixels, then the result will be 100 * 10 = 1000 cm/s


### `crop vector` not existing in GUI version 

This is a vector that includes a number of rows or columns of interrogation windows to crop 
from the borders of the image. For example, if I do 32 x 32 interrogation windows and 
I want to remove the top 100 pixels, I use 
	`crop_vector = [0 3 0 0]`

i.e. (3 x 32 = 96 pixels). 


### S/N type: 
1 - peak-to-mean = the ratio of the peak in the correlation plan to the mean of the correlation window is estimated
2 - peak-to-peak = the ratio of the first peak to the second peak is estimated

### S/N value: 
this is a threshold of the S/N type, above which the vector is accepted or rejected if S/N type value is below the threshold

### Outlier filter:
a threshold of the velocity in the point of interest as compared to the neighbors - above this value the velocity vector is rejected

### Jump:
1 - if you use every second image or every pair
N - if you want to correlate image i with image i+N, e.g. useful for oversampled cases and for time-resolved PIV analysis


##  General PIV questions:

### Whats the purpose of the local and global filtering?

Global filtering supposingly removes the obvious outliers, i.e. the vectors which length 
is different from the mean of the flow field by at least 3  times its standard deviation. 
These are global outliers in the statistical sense.

Local filtering is performed on small neighborhoods of vectors, e.g. 3 x 3 or 5 x 5, 
in order to find local outliers - the vectors that are dissimilar from the close neighbors.
 Typically there are about 5 per-cent of erroneous vectors and these are removed and later
  the missing values are interpolated from the neighbor vector values. This is also a
   reason for the Matlab version to generate three lists of files:
Raw data in `_noflt.txt`
Filtered (after global and local filters) - `_flt.txt`
Filtered and interpolated data - `.txt`



### In the ``cross_correlate`` function, why the average value of the pixels are subtracted 
from the sub images (`a2,b2`):
	a2 = a2 - mean2(a2);
	b2 = b2 - mean2(b2);


This is well described in the book by Raffel et al. (2007) and others. In one sentence, if
 your images have not absolutely black background (zero), then the background 
(which is a kind of noise) contributes to the correlation and this is 
undesirable. you're welcome to change it and check. maybe in some
cases it is not true. I didn't find such a case.



### Also in the same function while taking the FFT:

    ffta = fft2(a2,Nfft,Nfft);            
    fftb = fft2(b2,Nfft,Nfft);


why the size has been specified as Nfft which is twice the interrogation
window size.

In PIV  correlation analysis is applied to finite size windows therefore, the input `Nfft`
is given to create first padding of the window with zeros followed by correlation.



### Why sub image `b2` is rotated before taking the correlation
	b2 = b2(end:-1:1,end:-1:1);
	
Without rotation the inverse FFT of the product of two FFTs gives a convolution. 
Correlation needs a conjugate term, therefore: 

	ifft( fft(a) x fft(conj(b)) )	
	
For images `conj ( )` is replaced by rotation in the case of real values. 
It is more computationally efficient.



### In the `find_displacement(c,s2nm)` function for finding `peak2`, why neighbourhood pixels 
around `peak1` are removed?   


We need to search for the "real" second peak that is not a part of the same first `peak1` 
hey appear as 'false second peak', but they are the part <br />



### The `.txt` files contain the variable `vel`. Is it in metres/second?


It is not in general case, it depends on the `scaling` or `sclt` variable. If it's 1, then
it `vel` is still in pixels/dt
