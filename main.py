import subprocess 
import os

def plot_cheb_approximation_data():
    # Execute the Python script
    subprocess.call(["python3", "mains/main_cheb.py"])


def main():
    plot_cheb_approximation_data()

if __name__ == "__main__":
    main()
