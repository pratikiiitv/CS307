import heapq
import random

class Node:
    def __init__(self, state, parent=None, g=0, h=0, w1=1,w2=1):
        self.state = state
        self.parent = parent
        self.g = g  # Cost from start to current node
        self.h = h  # Heuristic cost estimate to goal
        self.f = w1*g + w2*h  # Total cost

    def __lt__(self, other):
        return self.f < other.f

def manhattan_distance(state, goal):
    distance = 0
    for i in range(1, 9):
        index1 = state.index(i)
        index2 = goal.index(i)
        x1, y1 = index1 // 3, index1 % 3
        x2, y2 = index2 // 3, index2 % 3
        distance += abs(x1 - x2) + abs(y1 - y2)
    return distance

def get_successors(node):
    successors = []
    index = node.state.index(0)
    moves = [-1, 1, 3, -3]
    for move in moves:
        im = index + move
        if im >= 0 and im < 9:
            new_state = list(node.state)
            temp = new_state[im]
            new_state[im] = new_state[index]
            new_state[index] = temp
            successor = Node(new_state, node)
            successors.append(successor)
    return successors

def a_star(start_state, goal_state):
    start_node = Node(start_state)
    goal_node = Node(goal_state)
    open_list = []
    heapq.heappush(open_list, (start_node.f, start_node))
    visited = set()
    nodes_explored = 0

    while open_list:
        _, node = heapq.heappop(open_list)
        if tuple(node.state) in visited:
            continue
        visited.add(tuple(node.state))
        print(node.state)
        nodes_explored += 1

        if node.state == list(goal_node.state):
            path = []
            while node:
                path.append(node.state)
                node = node.parent
            print('Total nodes explored', nodes_explored)
            return path[::-1]

        for successor in get_successors(node):
            successor.g = node.g + 1
            successor.h = manhattan_distance(successor.state, goal_node.state)
            successor.f = successor.g + successor.h
            heapq.heappush(open_list, (successor.f, successor))

    print('Total nodes explored', nodes_explored)
    return None

start_state = [1, 2, 3, 4, 5, 6, 7, 8, 0]
s_node = Node(start_state)
D = 20


d = 0
while d <= D:
    goal_state = random.choice(list(get_successors(s_node))).state
    s_node = Node(goal_state)
    d += 1

# goal_state = [1, 2, 3, 4, 5, 6, 8, 7, 0]

solution = a_star(start_state, goal_state)
if solution:
    print("Solution found:")
    for step in solution:
        print(step)
else:
    print("No solution found.")