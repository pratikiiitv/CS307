# Case of machine shop expansion
# You are the owner of a machine shop. You are planning for an expansion by purchasing some new machies - presses and lathes. You have estimated that each press is going to increase your profit by 100 INR/ Day, and each lathe will increase your profit by 150 INR/ Day. The cost of procurment of each machine and floor space required are as follows:
# Press, 15 sqft, 8000 INR
# Lathe, 30 sqft, 4000 INR
# You have a budget of 40000 INR for purchasing machines and 200 sqft of available floor space.
# ? How many machines of each type would you procure for maximizing your daily increase in profit
# Objective Function: 
# 100*x1 + 150*x2
# Constraints: 
# 8000*x1 + 4000*x2 <= 40000
# 15*x1 + 30*x2 <= 200

from pulp import LpMaximize, LpProblem, LpVariable, lpSum

# Define the problem
problem = LpProblem("Maximize_Z", LpMaximize)

# Define variables
x1 = LpVariable("x1", lowBound=0)  # x1 >= 0
x2 = LpVariable("x2", lowBound=0)  # x2 >= 0

# Objective function
problem += 100 * x1 + 150 * x2, "Objective"

# Constraints
problem += 8000 * x1 + 4000 * x2 <= 40000, "Constraint1"
problem += 15 * x1 + 30 * x2 <= 200, "Constraint2"
problem += x1 >= 0, "Constraint3"
problem += x2 >= 0 , "Constraint4"

# Solve the problem
status = problem.solve()

# Print the results
print(f"Status: {status}")
print(f"x1 = {x1.varValue}")
print(f"x2 = {x2.varValue}")
print(f"Optimal objective value: {problem.objective.value()}")