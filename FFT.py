# Code by: Mar Alcaraz Hurtado
# June 2021
# Python Script
##############################
# Description: this code computes the Fast Fourier Transform (FFT) of an input signal
# after the application of a Savitzky-Golay filter.


########## LIBRARIES NEEDED ################

import numpy as np
import matplotlib.pyplot as plotter
import scipy.signal
 

#Sampling Frequency: How many intervals of time need to be considered

samplingFrequency   = 10;

#Defining the begining and the ending time of the signal (in ns)

beginTime           = 0;
endTime             = 170; 

#Sampling interval: how many ns in each interval (is the inverse of the sampling frequency)

samplingInterval       = 1 / samplingFrequency;


# Creating the time matrix with the defined begining and ending time, with increments defined by the sampling interval.

time = np.arange(beginTime, endTime, samplingInterval);


# Import the raw signal from the directory

amplitude = np.genfromtxt ('countofions_KCl_x.csv')


#Applying the Savitzky-Golay filter to the signal. 
#Defined as follows: savgol_filter(data to filter, window chosen, polynomial degree)

amplitude1 = scipy.signal.savgol_filter(amplitude, 15, 3)

 
# FFT computation of the filtered data

fourierTransform = np.fft.fft(amplitude1)/len(amplitude1)           # Normalize amplitude

fourierTransform = fourierTransform[range(int(len(amplitude1)/2))]  # Exclude sampling frequency

tpCount     = len(amplitude1)

values      = np.arange(int(tpCount/2))

timePeriod  = tpCount*samplingInterval

frequencies = values/timePeriod #as time period is in ns, then frequencies are in GHz


#Output files to save the data

DataOut = np.column_stack((time,amplitude, amplitude1))
DataOut2= np.column_stack((frequencies, abs(fourierTransform)))
np.savetxt('filtersignal_x.dat', DataOut, fmt='%11.10f')
np.savetxt('fft_x.dat', DataOut2, fmt='%11.10f')
