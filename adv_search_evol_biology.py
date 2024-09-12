# Case Study: Host-Pathogen Interaction in Evolutionary Biology Using Adversarial Search
# In evolutionary biology, the interaction between a host and a pathogen can be represented as a dynamic, adversarial process. Both players (the host and the pathogen) evolve over time, with each trying to outcompete the other. Hosts evolve stronger immune responses, while pathogens evolve mechanisms to evade or suppress these defenses. This expanded case study adds more complexity and realism to the utility functions representing the host's and pathogen's fitness, incorporating environmental factors, immune evasion, and pathogen virulence.
# Host Utility:
# The host's fitness increases with stronger immune defenses but is penalized by the energy costs of maintaining these defenses.
# Environmental stressors (e.g., lack of resources) reduce the host's overall fitness, especially if the pathogen is not completely neutralized.
# The host's fitness is also influenced by the pathogen’s virulence. More virulent pathogens inflict greater damage on the host, even if the host mounts a strong immune response.
# Pathogen Utility:
# The pathogen's fitness increases with its virulence (its ability to damage the host), but at a cost: highly virulent pathogens may trigger stronger immune responses.
# The pathogen’s fitness decreases if the host successfully mounts an immune defense. Evasion strategies that reduce detectability help the pathogen survive longer.
# Environmental factors, such as the host's health and resource availability, also influence the pathogen's success. A weakened host may allow a pathogen to thrive even with minimal virulence.
# Expanded Fitness Functions

# Host Fitness Function:
# Host Fitness=max⁡(0,Base Fitness+a×Immune Response Strength−b×Energy Cost of Defense−c×Pathogen Virulence+d×Environmental Factor)
# a: Scaling factor for immune response strength.
# b: Penalty for energy cost associated with immune response.
# c: Penalty due to pathogen virulence.
# d: Environmental boost factor.

# Pathogen Fitness Function:
# Pathogen Fitness=max(0,Base Fitness+e×Virulence−f×Host Immune Response+g×Host Environmental Weakness)
# e: Scaling factor for virulence (how much the pathogen damages the host).
# f: Penalty due to the host's immune response.
# g: Advantage due to a weakened host environment.

import random

# Define the fitness functions for the host and pathogen
def host_fitness(immune_strength, virulence, energy_cost, env_factor):
    base_fitness = 100
    a = 5  # Scaling factor for immune response
    b = 3  # Energy cost for immune response
    c = 4  # Pathogen virulence penalty
    d = 2  # Environmental factor scaling
    
    return max(0, base_fitness + a * immune_strength - b * energy_cost - c * virulence + d * env_factor)

def pathogen_fitness(virulence, immune_strength, env_factor):
    base_fitness = 100
    e = 6  # Scaling factor for virulence
    f = 4  # Penalty due to host immune response
    g = 3  # Host environmental weakness benefit
    
    return max(0, base_fitness + e * virulence - f * immune_strength + g * env_factor)

# Adversarial search function with alpha-beta pruning
def adversarial_search(depth, alpha, beta, maximizing_player, immune_strength, virulence, energy_cost, env_factor):
    if depth == 0:
        host_score = host_fitness(immune_strength, virulence, energy_cost, env_factor)
        pathogen_score = pathogen_fitness(virulence, immune_strength, env_factor)
        return host_score - pathogen_score  # Fitness difference

    if maximizing_player:
        max_eval = float('-inf')
        for mutation in range(-5, 6, 2):  # Host evolves its immune strength
            new_immune_strength = immune_strength + mutation
            eval = adversarial_search(depth - 1, alpha, beta, False, new_immune_strength, virulence, energy_cost, env_factor)
            max_eval = max(max_eval, eval)
            alpha = max(alpha, eval)
            if beta <= alpha:
                break  # Beta cutoff
        return max_eval
    else:
        min_eval = float('inf')
        for mutation in range(-5, 6, 2):  # Pathogen evolves its virulence
            new_virulence = virulence + mutation
            eval = adversarial_search(depth - 1, alpha, beta, True, immune_strength, new_virulence, energy_cost, env_factor)
            min_eval = min(min_eval, eval)
            beta = min(beta, eval)
            if beta <= alpha:
                break  # Alpha cutoff
        return min_eval

# Simulation parameters
initial_immune_strength = 50
initial_virulence = 50
energy_cost = 10  # Energy cost of immune defense
env_factor = 10   # Environmental condition factor (positive or negative)
depth = 3  # Number of evolutionary steps

# Run the adversarial search simulation
optimal_value = adversarial_search(
    depth=depth,
    alpha=float('-inf'),
    beta=float('inf'),
    maximizing_player=True,  # Host starts as the maximizing player
    immune_strength=initial_immune_strength,
    virulence=initial_virulence,
    energy_cost=energy_cost,
    env_factor=env_factor
)

print("Optimal fitness difference (Host - Pathogen):", optimal_value)

# Display final fitness values for host and pathogen
final_host_fitness = host_fitness(initial_immune_strength, initial_virulence, energy_cost, env_factor)
final_pathogen_fitness = pathogen_fitness(initial_virulence, initial_immune_strength, env_factor)
print(f"Final Host Fitness: {final_host_fitness}")
print(f"Final Pathogen Fitness: {final_pathogen_fitness}")