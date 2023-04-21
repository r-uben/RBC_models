import numpy as np
from matplotlib import cm
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import pandas as pd
import os


class ChebyshevApproximation:

    def __init__(self, f, x, domain, params):
        
        ## function to be approximated
        self.f = f
        ## point at which the function is approximated
        self.x = x
        # domain of the function
        self.domain = domain
        # lower and upper bounds of the function
        self.a = domain[0]
        self.b = domain[1]
        # parameters of the algorithm:
        self.params = params
        self.n = params[0] # order of the polynomial
        self.m = params[1] # number of Chebyshev nodes
        if self.m < self.n:
            raise ValueError("Number of Chebyshev nodes must be greater than order of the polynomial")
        
    ## Difomorphism between initial domain and the Chebyshev polynomials domain:
    def scale_to_torus(self, z):
        denominator = (self.b - self.a)
        theta1 = 2 / denominator
        theta0 = - (self.b+self.a) / denominator
        return theta0 + theta1 * z
    
    ## Difomorphism between Chebyshev polynomials domain and initial domain:
    def scale_from_torus(self, x):
        phi0 = (self.a + self.b) / 2
        phi1 = (self.b - self.a) / 2
        return phi0 + phi1 * x
    
    ## kth node of degree n Chebyshev polynomial:
    def cheb_node(self, n, k):
        theta = ((2*k-1) / 2 / n) * np.pi
        return np.cos(theta)

    ## Function to approximate the functioN using Chebyshev collocation
    def cheb_point_approximation(self):
        alpha = np.zeros((self.n+1,1))
        T = np.zeros((self.m+1, self.n+1))
        actual_T = np.zeros((self.n+1,1))
        for k in range(1, self.m+1):
            last_k = k==self.m
            # 1. COMPUTE THE kth (OUT OF m) CHEBYSHEV NODES: 
            x_cheb_node = self.cheb_node(self.m, k)
            print("x_cheb_node = ", x_cheb_node)
            # Take it to the initial domain:
            x_node = self.scale_from_torus(x_cheb_node)
            print("x_node = ", x_node)
            # 2. COMPUTE THE VALUES OF THE CHEBYSHEV NODES UNDER F:
            yk = self.f(x_node)
            print("yk =", yk)
            # 3. COMPUTE THE CHEBYSHEV COEFFICIENTS: Initial values:
            T[k,0] = 1
            T[k,1] = x_cheb_node
            if k==self.m: 
                actual_T[0] = 1
                actual_T[1] = self.cheb_x
            # Evaluate all the Chebyshev nodes:
            for j in range(0,self.n+1):
                index_limit = j+1 < self.n
                if j == 0: alpha[j] += 1 / self.m * yk
                else:
                    if index_limit: T[k,j+1] = 2*x_cheb_node*T[k,j] - T[k,j-1]
                    if index_limit and last_k: actual_T[j+1] = 2*self.cheb_x*actual_T[j]-actual_T[j-1]
                    alpha[j] += 2/self.m*yk*T[k,j]
        # CALCULATE THE OUTPUT
        output = 0
        for j in range(self.n+1): output += alpha[j]*actual_T[j]
        return float(output)

    @property
    def cheb_x(self):
        return self.scale_to_torus(self.x)
        
    @property
    def approx_x(self):
        return self.cheb_point_approximation()

def main():

    def f(x):
        return np.exp(x)
    domain = [0,1]
    params = [3,3]
    x = 0.8
    print(x) #for x in [0.22,0.34,0.5,0.8,0.9]:
    cheb = ChebyshevApproximation(f, x, domain, params)
    print(f(x),cheb.approx_x)


if __name__ == '__main__':
    main()
