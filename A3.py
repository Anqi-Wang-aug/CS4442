# This is a test to test open cv
import cv2
import matplotlib.pyplot as plt
import numpy as np
from skimage import filters
#from Computer_Vision.Sobel_Edge_Detection.convolution import convolution
def canny1(img, sigma, low, high):   
    k = cv2.getGaussianKernel(3,sigma)
    gauss = cv2.sepFilter2D(img, -1, k, k)
    plt.imshow(gauss)
    plt.show()
    resultx = cv2.Sobel(gauss, -1, dx=1,dy=0)
    plt.imshow(resultx)
    plt.show()
    resulty = cv2.Sobel(gauss, -1, dx=0,dy=1)
    plt.imshow(resulty)
    plt.show()

    result = np.hypot(resultx, resulty)
    result = result/result.max()*255
    plt.imshow(result)
    plt.show()
    theta = np.arctan2(resulty, resultx)
    M,N = result.shape
    Z = np.zeros((M,N), dtype=np.int32)
    angle = theta*180./np.pi
    angle[angle<0]+=180
    for i in range(1,M-1):
        for j in range(1,N-1):
            q = 255
            r = 255
            if (0 <= angle[i,j] < 22.5) or (157.5 <= angle[i,j] <= 180):
                q = result[i, j+1]
                r = result[i, j-1]
            elif (22.5 <= angle[i,j] < 67.5):
                q = result[i+1, j-1]
                r = result[i-1, j+1]
            elif (67.5 <= angle[i,j] < 112.5):
                q = result[i+1, j]
                r = result[i-1, j]
            elif (112.5 <= angle[i,j] < 157.5):
                q = result[i-1, j-1]
                r = result[i+1, j+1]

            if (result[i,j] >= q) and (result[i,j] >= r):
                Z[i,j] = result[i,j]
            else:
                Z[i,j] = 0

    plt.imshow(Z)
    plt.show()
    edge = filters.apply_hysteresis_threshold(Z, low, high)
    return edge

def harris(img):

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    M= img.shape[0]
    N = img.shape[1]
    matrix_R = np.zeros((M,N))
    gauss = cv2.GaussianBlur(gray, (3,3), 0)
    resultx = cv2.Sobel(gauss, cv2.CV_64F, 1,0, ksize = 3)
    resulty = cv2.Sobel(gauss, cv2.CV_64F, 0,1, ksize = 3)
    resultx2 = np.square(resultx)
    resulty2 = np.square(resulty)
    result = resultx*resulty
   
    offset = int(5/2)
    for y in range(offset, M-offset):
        for x in range(offset, N-offset):
            Sx2 = np.sum(resultx2[y-offset:y+1+offset, x-offset:x+1+offset])
            Sy2 = np.sum(resulty2[y-offset:y+1+offset, x-offset:x+1+offset])
            Sxy = np.sum(result[y-offset:y+1+offset, x-offset:x+1+offset])

            H = np.array([[Sx2,Sxy],[Sxy,Sy2]])

            det=np.linalg.det(H)
            tr=np.matrix.trace(H)
            R=det-0.04*(tr**2)
            matrix_R[y-offset, x-offset]=R   
    
    plt.imshow(matrix_R)
    plt.show()
    cv2.normalize(matrix_R, matrix_R, 0, 1, cv2.NORM_MINMAX)
    plt.imshow(matrix_R)
    plt.show()
    for y in range(offset, M-offset):
        for x in range(offset, N-offset):
            value=matrix_R[y, x]
            if value>0.3:
                cv2.circle(img,(x,y),1,(0,255,0))
    return img


img = cv2.imread("image1.jfif")
plt.imshow(img)
plt.show()
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
plt.imshow(gray)
plt.show()
# edge = filters.apply_hysteresis_threshold(gray, 2.55/3, 2.55)
edge = canny1(gray,  0.0001,49,49.5)
# edge = cv2.Canny(gray, 50, 150)
plt.imshow(edge)
plt.show()
corner = harris(img)
plt.imshow(corner)
plt.show()

