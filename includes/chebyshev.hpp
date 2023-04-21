#ifndef CHEBYSHEV_HPP
#define CHEBYSHEV_HPP

#include <iostream>

double scaleToTorus(int a, int b, double z);

double scaleFromTorus(int a, int b, double x);

// Function to calculate the kth Chebyshev node of degree n:
double chebNode(int n, int k);

// Function to evaluate a number x in the nth degree Chebyshev polynomial:

std::vector<double> chebEval(int n, double x);

double chebPointApproximation(double (*f)(double), int a, int b, double x, int n, int m);

// Function for collocation with Chebyshev polynomials
double cheb2DPointApproximation( double (*f)(double, double), int a_x, int b_x, int a_y, int b_y, double x, double y, int n_x, int n_y, int m_x, int m_y);

void 
chebIter(double (*f)(double), int a, int b, int num_x, int n, int m, std::string name_function);

void
cheb2DIter(double (*f)(double, double), int a_x, int b_x, int a_y, int b_y, int num_x, int num_y, int n_x, int n_y, int m_x, int m_y, std::string name_function);

#endif // CHEBYSHEV_HPP