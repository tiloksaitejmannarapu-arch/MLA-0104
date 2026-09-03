# 1. Breadth-First Search (BFS)

## Overview
Breadth-First Search (BFS) is an uninformed search algorithm that explores all neighboring nodes level by level before moving to the next level.

## Use Cases
* Finding the shortest path in an unweighted graph
* Social network analysis
* Web crawling
* Network broadcasting

## Pseudocode
```text
Algorithm BFS(Graph, Start)

1. Create an empty queue.
2. Mark the start node as visited.
3. Insert the start node into the queue.
4. While the queue is not empty:
      a. Remove the front node.
      b. Display the node.
      c. Visit all unvisited neighbouring nodes.
      d. Mark them as visited.
      e. Insert them into the queue.
5. Stop.
```
## Explanation

* Uses a **Queue (FIFO)**.
* Visits nodes level by level.
* Guarantees the shortest path in an unweighted graph.

---


# 2. Depth-First Search (DFS)

## Overview
Depth-First Search (DFS) explores a graph by visiting a node and then recursively exploring as far as possible before backtracking.

## Use Cases
* Maze solving
* Topological sorting
* Cycle detection
* Path finding

## Pseudocode
```text
Algorithm DFS(Graph, Node)

1. Mark the current node as visited.
2. Display the node.
3. For every adjacent node:
      If not visited:
            Call DFS recursively.
4. Stop.
```
## Explanation

* Uses **Recursion** or a **Stack (LIFO)**.
* Explores one branch completely before moving to another.

---


# 3. Uniform Cost Search (UCS)

## Overview
Uniform Cost Search expands the node with the lowest cumulative path cost from the start node.

## Use Cases
* GPS navigation
* Route optimisation
* Robotics
* Network routing

## Pseudocode
```text
Algorithm UniformCostSearch(Start, Goal)

1. Create a priority queue.
2. Insert the start node with cost 0.
3. While the queue is not empty:
      a. Remove the node with minimum cost.
      b. If goal reached:
            Return path.
      c. Expand neighbouring nodes.
      d. Insert neighbours with updated costs.
4. Stop.
```
## Explanation
* Uses a **Priority Queue**.
* Always selects the least-cost path first.
* Produces the optimal solution when edge costs are non-negative.

---


# 4. Water Jug Problem

## Overview
The Water Jug Problem is a state-space search problem where water is transferred between jugs to achieve a target quantity.

## Use Cases
* AI state-space search
* Problem-solving techniques
* Robotics planning
* Resource allocation

## Pseudocode
```text
Algorithm WaterJug()

1. Define jug capacities.
2. Set the initial state.
3. Insert the initial state into a queue.
4. While queue is not empty:
      a. Remove one state.
      b. If goal state reached:
            Display solution.
      c. Generate valid next states:
            • Fill
            • Empty
            • Pour
      d. Insert unvisited states.
5. Stop.
```
## Explanation
* Uses **Breadth-First Search**.
* Represents every water distribution as a state.
* Finds the shortest sequence of operations.

---

# 5. A* Search

## Overview
A* Search is an informed search algorithm that combines actual path cost and heuristic cost.

## Formula
```text
f(n) = g(n) + h(n)
```

Where:
* **g(n)** = Actual cost from start node
* **h(n)** = Estimated cost to goal
* **f(n)** = Evaluation function

## Use Cases
* GPS navigation
* Video games
* Robot navigation
* Path planning

## Pseudocode
```text
Algorithm AStar(Start, Goal)

1. Create a priority queue.
2. Insert the start node.
3. Compute:
      f(n) = g(n) + h(n)
4. While queue is not empty:
      a. Remove node with lowest f(n).
      b. If goal reached:
            Return path.
      c. Expand neighbours.
      d. Update g(n), h(n), and f(n).
5. Stop.
```

## Explanation
* Uses **actual cost + heuristic**.
* Efficiently finds the optimal path.
* One of the most widely used search algorithms.

---



# 6. Greedy Best-First Search

## Overview
Greedy Best-First Search selects the node with the smallest heuristic value.

## Formula
```text
f(n) = h(n)
```
## Use Cases
* Route finding
* AI games
* Maze solving
* Robot navigation

## Pseudocode
```text
Algorithm GreedyBestFirstSearch(Start, Goal)

1. Create a priority queue.
2. Insert start node.
3. While queue is not empty:
      a. Remove node with smallest heuristic.
      b. If goal reached:
            Return path.
      c. Expand neighbouring nodes.
      d. Insert neighbours using heuristic values.
4. Stop.
```
## Explanation
* Uses **only heuristic values**.
* Fast but may not always produce the optimal solution.

---


# 7. Minimax Algorithm

## Overview
Minimax is a decision-making algorithm used in two-player games where one player tries to maximise the score and the other tries to minimise it.

## Use Cases
* Chess
* Tic-Tac-Toe
* Checkers
* Connect Four

## Pseudocode
```text
Algorithm Minimax(Node, Depth, Maximizing)

1. If node is terminal:
      Return value.
2. If maximizing player:
      best = -∞
      Evaluate all children.
      Return maximum value.
3. Else:
      best = +∞
      Evaluate all children.
      Return minimum value.
4. Stop.
```

## Explanation
* Simulates all possible moves.
* MAX chooses the highest value.
* MIN chooses the lowest value.
* Produces the best possible move assuming both players play optimally.

---


# 8. Alpha-Beta Pruning

## Overview
Alpha-Beta Pruning is an optimisation of the Minimax algorithm that eliminates branches that cannot influence the final decision.

## Use Cases
* Chess engines
* Checkers
* Tic-Tac-Toe
* Game AI

## Pseudocode

```text
Algorithm AlphaBeta(Node, Depth, Alpha, Beta, Maximizing)

1. If node is terminal:
      Return value.
2. If maximizing:
      Update Alpha.
      If Alpha ≥ Beta:
            Prune remaining branches.
3. Else:
      Update Beta.
      If Alpha ≥ Beta:
            Prune remaining branches.
4. Return best value.
```

## Explanation

* Uses **Alpha (α)** and **Beta (β)** values.
* Prunes unnecessary branches.
* Returns the same result as Minimax while exploring fewer nodes.
* Faster and more efficient for large game trees.

---

# Technologies Used

* **Programming Language:** Python 3
* **IDE:** Python IDLE
* **Concepts:** Artificial Intelligence, Graph Search, Heuristic Search, Game Tree Search
* **Data Structures:** Queue, Stack, Priority Queue, Recursion

---
