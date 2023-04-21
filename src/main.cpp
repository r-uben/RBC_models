#include <iostream>
#include <cmath>

// MY FILES:
#include "../includes/functions.hpp"   
#include "../includes/chebyshev.hpp"

int main()
{
    double x, y;
    x=0.8;
    y=0.1;
    // std::cout <<"hello world!" << std::endl;
    double cheb_x = chebPointApproximation(expX,0,1,x,3,3);
    //std::cout <<"exp(x) = " << expX(x) << " cheb_x = " << cheb_x << std::endl;
    //std::cout <<"x = " << x << " cheb_x = " << chebPointApproximation(expX,0,2,x,5,10) << std::endl;
    // chebPointApproximation(valueIfGreaterThanOne,x,3,3);
    // chebIter(valueIfGreaterThanOne, 0, 2, 20, 3, 3, "valueIfGreaterThanOne");
    // chebIter(valueIfGreaterThanOne, 0, 2, 20, 5, 5, "valueIfGreaterThanOne");
    // chebIter(valueIfGreaterThanOne, 0, 2, 20, 10, 10, "valueIfGreaterThanOne");
    std::cout << expXplusY(x,y) << "; " << cheb2DPointApproximation(expXplusY,0,1,-1,0,x,y,3,3,4,4) <<std::endl;
    // cheb2DIter(expXplusY,0,1,-1,0,100,100,3,3,10,10,"expXplusY");
    // cheb2DIter(expXplusY,100,100,5,5,10,10,"expXplusY");
    // cheb2DIter(expXplusY,100,100,10,10,10,10,"expXplusY");
    // cheb2DIter(expXplusY,100,100,20,20,20,20,"expXplusY");
}