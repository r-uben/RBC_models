#include "../includes/functions.hpp"   // Include the corresponding header file
#include <algorithm> 
#include <cmath> // Include the cmath library for the exp() function

double expXplusY(double x, double y) {
    return exp(x + y); // Compute exp(x + y) and return the result
}

double valueIfGreaterThanOne(double x){
    double output;
    if (x-1 > 0){
        output = x-1;
    }
    else{
        output =0;
    }
    return output;
}

double expX(double x){
    return exp(x);
}