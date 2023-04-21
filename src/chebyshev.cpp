#include "../includes/chebyshev.hpp"
#include "../includes/functions.hpp"
#include <cmath>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>


double 
scaleToTorus(int a, int b, double z) {
    if (a == b) {
        std::cerr << "Error: division by zero in computeTheta() function." << std::endl;
        exit(1);
    }

    double denominator = (b-a);
    double theta0, theta1;
    theta1 = 2. / denominator;
    theta0 = - (b+a) * 1./ denominator;
    return theta0 + theta1 * z;
}

double 
scaleFromTorus(int a, int b, double x){
    double phi0, phi1;
    phi0 = (a+b)/2.;
    phi1 = (b-a)/2.;
    return phi0 + phi1 * x;
}

double 
chebNode(int n, int k){
    double pi = M_PI;
    double theta = ((2.*k-1) / (2.*n))* pi;
    return cos(theta);
}

std::vector<double> 
chebEval(int n, double x){
    std::vector<double> T(n+1);
    T[0] = 1;
    T[1] = x;
    for (int i = 2; i <= n; i++) {
        T[i] = 2. * x * T[i-1] - T[i-2];
    }
    return T;
}

double
chebPointApproximation(double (*f)(double), int a, int b, double x, int n, int m){
    // Take a, b in order:
    int new_a, new_b;
    if (a> b){
        new_a = b;
        new_b = a;
        b = new_b;
        a = new_a;
    }
    // Initialise the output:
    double output;
    // Compute the transformed x in the torus domain:
    double cheb_x = scaleToTorus(a, b, x);
    // Warning message:
    if (n > m){
        std::cerr << "Error: n > m, which may result in inaccurate approximation." << std::endl;
        exit(1);
    }

    // Initialise the vector of coefficients of the chebyshev polynomial:
    std::vector<double> alpha(n+1);
    // Initialise the matrix containing the values of Chebyhev polynomials on the chebyshev nodes:
    std::vector<std::vector<double> > T(m+1, std::vector<double>(n+1));
    // Initialise the vector containing the value of the Chebyshev polynomials at x:
    std::vector<double> actual_T(n+1);
    double yk, sum;
    double x_cheb_node, x_node;
    for (int k=1; k<=m; k++) {
        // 1. COMPUTE THE m CHEBYSHEV NODES: First, we take and save the kth chebyshev node (we want m nodes):
        x_cheb_node = chebNode(m, k);
        // Now, take it back to the original domain:
        x_node = scaleFromTorus(a, b, x_cheb_node);
        // 2. COMPUTE THE VALUES OF THE CHEBYSHEV NODES UNDER F:
        yk = f(x_node);
        // 3. COMPUTE THE CHEBYSHEV COEFFICIENTS: First, initialise the chebyshev polynomials:
        T[k][0] = 1.;
        T[k][1] = x_cheb_node;
        if (k == m){ // This is just to compute it just once;
            actual_T[0] = 1.;
            actual_T[1] = cheb_x;
        }
        // Evaluate all the Chebyshev polynomials:
        for (int j=0;j<=n;j++) {
            if (j==0) { alpha[j] +=  1./((double)m) * yk;}
            else{
                if (j+1 < n) {T[k][j+1] = 2.* x_cheb_node*T[k][j]-T[k][j-1];}
                if (k==m && j+1 < n) {actual_T[j+1] = 2.*cheb_x*actual_T[j] - actual_T[j-1];}
                alpha[j] += 2./((double)m) * yk * T[k][j];
            }
        }
    }
    // CALCULATE THE OUTPUT:
    for (int j=0; j<=n; j++) {
        output += alpha[j]*actual_T[j];
    }  
    return output;
}

// Function for collocation with Chebyshev polynomials:
double 
cheb2DPointApproximation(double (*f)(double, double), int a_x, int b_x, int a_y, int b_y, double x, double y, int n_x, int n_y, int m_x, int m_y) {
    // Initialise the output:
    double output;
    // Compute the transformed x and y in the torus domain:
    double cheb_x, cheb_y;
    cheb_x = scaleToTorus(a_x, b_x, x);
    cheb_y = scaleToTorus(a_y, b_y, y);
    // Warning message:
    if (n_x > m_x) {
        std::cerr << "Warning: n_x is greater than m_x, which may result in inaccurate approximation." << std::endl;
        exit(1);
    }
    if (n_y > m_y) {
        std::cerr << "Warning: n_y is greater than m_y, which may result in inaccurate approximation." << std::endl;
        exit(1);
    }

    // Initialise the vector of coefficients of the chebyshev polynomial:
    std::vector< std::vector<double> > alpha(n_x+1, std::vector<double>(n_y+1));
    // Initialise the matrix containing the values of Chebyhev polynomials on the chebyshev nodes:
    std::vector<std::vector<double> > Tx(m_x+1, std::vector<double>(n_x+1)), Ty(m_y+1, std::vector<double>(n_y+1));
    // Initialise the vector containing the value of the Chebyshev polynomials at x:
    std::vector<double> actual_Tx(n_x+1), actual_Ty(n_y+1);
    double zk;
    double x_cheb_node, x_node, y_cheb_node, y_node;
    for (int k_x = 1; k_x <= m_x; k_x++) {
        // 1. COMPUTE THE m CHEBYSHEV NODES: First, we take and save the kth chebyshev node (we want m nodes):
        x_cheb_node = chebNode(m_x, k_x);
        // Now, take it back to the original domain:
        x_node = scaleFromTorus(a_x, b_x, x_cheb_node);
        // Initialise the Chebyshev polynomials for the first coordinate:
        Tx[k_x][0] = 1.;
        Tx[k_x][1] = x_cheb_node;
        // Iterate over the j_x = 0,...,n_x to compute the values of the Chebyshev polynomials on the nodes:
        if (k_x == m_x){ // This is just a control to compute it just once:
            actual_Tx[0] = 1.;
            actual_Tx[1] = cheb_x;
        }
        for (int k_y=0; k_y <= m_y; k_y++) {
            // 1. COMPUTE THE m CHEBYSHEV NODES: First, we take and save the kth chebyshev node (we want m nodes):
            y_cheb_node = chebNode(m_y, k_y);
            // Now, take it back to the original domain:
            y_node = scaleFromTorus(a_y, b_y, y_cheb_node);
            // Initialise the Chebyshev polynomials for the second coordinate:
            Ty[k_y][0] = 1.;
            Ty[k_y][1] = y_cheb_node;
            // 2. COMPUTE THE VALUES OF THE CHEBYSHEV NODES UNDER F:
            zk = f(x_node, y_node);
            // Evaluate all the Chebyshev polynomials:
            if (k_y == m_y){
                actual_Ty[0] = 1.;
                actual_Ty[1] = cheb_y;
            }
            // 3. COMPUTE THE CHEBYSHEV COEFFICIENTS: 
            for (int j_x=0; j_x <= n_x; j_x++) {
                if (j_x+1 < n_x && j_x > 0){Tx[k_x][j_x+1] = 2.*x_cheb_node*Tx[k_x][j_x] - Tx[k_x][j_x-1];}
                if (j_x+1 < n_x && k_x==m_x && j_x>0) {actual_Tx[j_x+1] = 2. * cheb_x * actual_Tx[j_x] - actual_Tx[j_x-1];}

                for (int j_y=0; j_y <= n_y; j_y++) {
                    if (j_y+1 < n_y && j_y > 0) {Ty[k_y][j_y+1] = 2.*y_cheb_node*Ty[k_y][j_y] - Ty[k_y][j_y-1];}
                    if (j_y+1 < n_y && k_y==m_y && j_y > 0) {actual_Ty[j_y+1] = 2.*cheb_y *actual_Ty[j_y] - actual_Ty[j_y-1];}
                    if (j_x == 0 && j_y == 0) {
                        alpha[j_x][j_y] += zk / (double)m_x / (double)m_y;
                    } else if (j_x == 0 && j_y!= 0) {
                        alpha[j_x][j_y] += 2. * zk * Ty[k_y][j_y] / (double)m_x / (double)m_y;
                    } else if (j_x != 0 && j_y == 0) {
                        alpha[j_x][j_y] += 2. * zk * Tx[k_x][j_x] / (double)m_x / (double)m_y;
                    } else if (j_x != 0 && j_y != 0) {
                        alpha[j_x][j_y] += 4. * zk * Tx[k_x][j_x] * Ty[k_y][j_y] / (double)m_x / (double)m_y;
                    }
                }
            }
        }
    }

    // Calculate the output:
    for (int j_x=0; j_x <= n_x; j_x++) {
        for (int j_y=0; j_y <= n_y; j_y++) {
            output += alpha[j_x][j_y] * actual_Tx[j_x] * actual_Ty[j_y];
        }
    }
    return output;
}

// Function to iterrate the Chebyshev approximation (1D):
void
chebIter(double (*f)(double), int a, int b, int num_x, int n, int m, std::string name_function){
    // Take a, b in order:
    int new_a, new_b;
    if (a> b){
        new_a = b;
        new_b = a;
        b = new_b;
        a = new_a;
    }

    // FILENAME
    std::string filename = name_function + "_n" + std::to_string(n) + "_m" + std::to_string(m);

    // CREATE THE OUTPUT FILE:
    std::ofstream file("../data/" + filename + ".csv"); // Create a file stream for writing;

    if (file.is_open()){ // Check if the file is successfully opened
        // Write column headers
        file << "x,y,cheb_y" << std::endl;
        // Calculate the interval between numbers:
        double D = (b-a)/((double)num_x);
        std::cout << D << std::endl;
        // Write the 
        for (int i=1; i<=num_x; i++) {
            double x = a + i*D;
            double cheb_y = chebPointApproximation(f, a, b, x, n, m);
            std::string col1 = std::to_string(x);
            std::string col2 = std::to_string(f(x));
            std::string col3 = std::to_string(cheb_y);
            // Write data to the file
            file << col1 << "," << col2 << "," << col3 << std::endl;
        } 
    file.close(); // Close the file
    std::cout << "File created successfully." << std::endl;
    } else {
    std::cout << "Failed to create the file." << std::endl;
    }

}

// Function to iterate the Chebyshev approximation:
void
cheb2DIter(double (*f)(double, double), int a_x, int b_x, int a_y, int b_y,  int num_x, int num_y, int n_x, int n_y, int m_x, int m_y,  std::string name_function){

    // FILENAME
    std::string filename = name_function + "_nx" + std::to_string(n_x) + "_ny" + std::to_string(n_y) + "_mx" + std::to_string(m_x) + "_my" + std::to_string(m_y);

    // CREATE THE OUTPUT FILE:
    std::ofstream file("../data/" + filename + ".csv"); // Create a file stream for writing

    if (file.is_open()) { // Check if file is successfully opened
        // Write column headers
        file << "x,y,z,cheb_z" << std::endl;

        // Calculate interval between numbers
        double D_x = (b_x-a_x) / (double)num_x;
        double D_y = (b_y-a_y) / (double)num_y;

        for (int i = 1; i <= num_x; i++) {
            double x = a_x + i * D_x;
            std::string col1 = std::to_string(x);
            for (int j = 1; j <= num_y; j++) {
                double y= a_y + j * D_y;
                std::string col2 = std::to_string(y);
                std::string col3 = std::to_string(f(x, y));
                std::string col4 = std::to_string(cheb2DPointApproximation(f, a_x, b_x, a_y, b_y, x, y, n_x, n_y, m_x, m_y));

                // Write data to the file
                file << col1 << "," << col2 << "," << col3 << "," << col4 << std::endl;
            }
        }

        file.close(); // Close the file
        std::cout << "File created successfully." << std::endl;
    } else {
        std::cout << "Failed to create the file." << std::endl;
    }
}