import cv2
import numpy as np

def get_cloud_cov(img_path):
  total_pixels = 1536**2
  not_sky_pixels = 434000       #approx not sky pixel count
  img = cv2.imread(img_path)    #read image
  white = np.array([255, 255, 255])     #white pixels as upper bound of colorspace in mask
  lowerBound = np.array([50,100,100])   #RGB for lower bound of colorspace in mask
  mask = cv2.inRange(img, lowerBound, white)        #create mask
  masked = cv2.bitwise_and(img, img, mask=mask)     #apply mask
  masked = cv2.cvtColor(masked,cv2.COLOR_BGR2GRAY)  #convert to grayscale to use np.count_nonzero()
  return int(100*(np.count_nonzero(masked)/(total_pixels-not_sky_pixels)))    #percentage calculation
