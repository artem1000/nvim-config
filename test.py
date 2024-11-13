import sympy as sp
from sympy import Derivative

# Declare the variable
x = sp.symbols('x')

# Define the function f(x)
f = x**3 + 2*x**2 - x

# Compute the first derivative
f_prime = sp.diff(f, x)

# Compute the second derivative
f_double_prime = sp.diff(f_prime, x)
f_expr =  x**2 + 2*x + 1

ansA = sp.diff(x**3 + 2*x**2 - x, x, 2)
ansB = sp.diff(x**3 + 2*x**2 - x, x, 3)
ansC = Derivative(x**3 + 2*x**2 - x, x, 2).doit()

# Print the results
print("Function:", f)
print("First Derivative:", f_prime)
#print("Second Derivative:", f_double_prime)
#print("A:", ansA)
#print("B:", ansB)
#print("C:", ansC)
