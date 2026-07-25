# MLA0104 – Artificial Intelligence & Expert Systems 

This repository contains implementations of **Artificial Intelligence and Expert Systems  laboratory programs using **Python**.

The programs demonstrate important Artificial Intelligence concepts such as **graph traversal, uninformed search, state-space search, heuristic search, and game-playing algorithms**.

Each program includes:

- Python source code (`.py`)
- Problem statement
- Algorithm explanation
- Step-by-step working
- Pseudocode
- Use cases
- Output screenshots


# 1. Breadth First Search (BFS)

## Problem

Traverse a graph using **Breadth First Search (BFS)** starting from a given node.

## Explanation

**Breadth First Search (BFS)** is an uninformed search algorithm used to traverse or search a graph or tree.

BFS explores nodes **level by level**. It first visits the starting node, then visits all its neighbouring nodes, followed by the neighbours of those nodes.

BFS uses a **Queue** data structure that follows the **FIFO (First In, First Out)** principle.

A `visited` list is maintained to avoid visiting the same node multiple times.

## How It Works

1. Select a starting node.
2. Create an empty queue.
3. Add the starting node to the queue.
4. Mark the starting node as visited.
5. Remove the first node from the queue.
6. Visit and process the node.
7. Find all unvisited neighbours.
8. Add the unvisited neighbours to the queue.
9. Repeat the process until the queue becomes empty or the goal is found.

## Key Concept

```text
BFS
 ↓
Queue
 ↓
FIFO (First In, First Out)
 ↓
Level-by-Level Search
```

## Pseudocode

```text
BFS(Graph, StartNode)

1. Create an empty list called visited
2. Create an empty queue

3. Add StartNode to visited
4. Add StartNode to queue

5. While queue is not empty:

      Remove first element from queue → node
      Print node

      For each neighbour of node:

            If neighbour is not in visited:
                  Add neighbour to visited
                  Add neighbour to queue


## Use Cases

- Finding the shortest path in an unweighted graph
- Social networking applications for finding connections
- Web crawling
- Network broadcasting
- Finding nearby locations in navigation systems
- Peer-to-peer network searching
- Level-order traversal of trees

## Advantages

- Finds the shortest path in an unweighted graph.
- Simple and easy to implement.
- Complete when the search space is finite.

## Limitation

- Requires more memory because it stores many nodes in the queue.
- Can be inefficient for very large search spaces.



# 2. Depth First Search (DFS)

## Problem

Traverse a graph using **Depth First Search (DFS)**.

## Explanation

**Depth First Search (DFS)** is an uninformed search algorithm that explores a graph by going as **deep as possible along one branch** before backtracking.

DFS can be implemented using a **Stack** or **Recursion**.

Unlike BFS, which explores nodes level by level, DFS follows one path deeply until it reaches a dead end. It then backtracks and explores another path.

## How It Works

1. Select a starting node.
2. Mark the node as visited.
3. Process the current node.
4. Select an unvisited neighbour.
5. Recursively visit the neighbour.
6. Continue until there are no unvisited neighbours.
7. Backtrack to the previous node.
8. Explore the remaining unvisited branches.

## Key Concept

```text
DFS
 ↓
Stack / Recursion
 ↓
LIFO (Last In, First Out)
 ↓
Deep Search
```

## Pseudocode

```text
DFS(Graph, Node, Visited)

1. If Node is not in Visited:

      Print Node
      Add Node to Visited

2. For each neighbour of Node:

      If neighbour is not in Visited:

            Call DFS(Graph, neighbour, Visited)


## Use Cases

- Maze solving
- Path finding
- Cycle detection in graphs
- Topological sorting
- Finding connected components
- Puzzle solving
- Exploring file and folder structures
- Backtracking problems

## Advantages

- Requires less memory than BFS in many cases.
- Simple to implement using recursion.
- Useful for exploring deep search spaces.
- Effective for backtracking problems.

## Limitation

- Does not always find the shortest path.
- Can get stuck exploring a very deep branch.
- Recursive implementations may cause stack overflow for very deep graphs.



# 3. Uniform Cost Search (UCS)

## Problem

Find the **least-cost path** from a start node to a goal node in a weighted graph.

## Explanation

**Uniform Cost Search (UCS)** is an uninformed search algorithm that always expands the node with the **lowest total path cost** from the starting node.

UCS is useful when different paths have different costs.

It uses a **Priority Queue**, where the node with the smallest path cost is selected first.

Unlike BFS, which mainly considers the number of edges, UCS considers the **actual cost of reaching a node**.

## How It Works

1. Start from the initial node with cost `0`.
2. Add the starting node to the priority queue.
3. Select the node with the lowest path cost.
4. If the selected node is the goal, return the solution.
5. Otherwise, expand the node.
6. Calculate the cost of reaching each neighbouring node.
7. Add the neighbours with their updated costs to the priority queue.
8. Repeat until the goal is found.

## Key Concept

```text
UCS
 ↓
Priority Queue
 ↓
Lowest Path Cost First
 ↓
Optimal Cost Path


## Pseudocode

```text
UCS(Graph, Start, Goal)

1. Create a priority queue storing (node, cost)

2. Insert (Start, 0) into queue

3. Create an empty visited list

4. While queue is not empty:

      Find node with minimum cost
      Remove it from queue

      If node already visited:
            Continue

      Add node to visited

      If node equals Goal:
            Print cost
            Stop

      For each neighbour of node:

            Calculate new cost

            Add (neighbour, new cost) to queue


## Use Cases

- Finding the cheapest route in a transportation network
- Network routing based on communication cost
- Robot navigation where movement has different costs
- Finding minimum-cost paths
- Logistics and delivery route planning
- Resource optimization problems

## Advantages

- Finds the least-cost path.
- Works well with different edge costs.
- Complete when step costs are positive.

## Limitation

- Can be slower than heuristic-based algorithms.
- May explore many unnecessary nodes.
- Requires priority queue management.



# 4. Water Jug Problem

## Problem

Measure a target amount of water using two jugs of given capacities.

## Explanation

The **Water Jug Problem** is a classic **state-space search problem** in Artificial Intelligence.

The objective is to measure a specific amount of water using two jugs with fixed capacities.

Each state represents the amount of water currently present in both jugs.

The state is represented as:

```text
(x, y)
```

Where:

```text
x = Amount of water in Jug 1

y = Amount of water in Jug 2
```

The initial state is:

```text
(0, 0)
```

The algorithm generates new states by performing valid operations.

## Possible Operations

- Fill Jug 1
- Fill Jug 2
- Empty Jug 1
- Empty Jug 2
- Pour Jug 1 into Jug 2
- Pour Jug 2 into Jug 1

The search continues until the target amount is reached.

## How It Works

1. Start with state `(0,0)`.
2. Add the initial state to the queue.
3. Check whether the target amount has been reached.
4. Generate all possible valid operations.
5. Create new states from those operations.
6. Mark visited states to avoid repetition.
7. Add new states to the queue.
8. Continue until the target state is reached.

## Key Concept

```text
Water Jug Problem
 ↓
State Space
 ↓
Initial State
 ↓
Operators
 ↓
Goal State
```

## Pseudocode

```text
WaterJug(Jug1Capacity, Jug2Capacity, Target)

1. Start with initial state (0,0)

2. Create an empty visited list

3. Create a queue and add (0,0)

4. While queue is not empty:

      Remove first state (x,y)

      If state is already visited:
            Continue

      Add state to visited
      Print state

      If x == Target OR y == Target:
            Print "Target Achieved"
            Stop

5. Generate all possible operations:

      Fill Jug1
      Fill Jug2
      Empty Jug1
      Empty Jug2
      Pour Jug1 → Jug2
      Pour Jug2 → Jug1

6. Add each new unvisited state to the queue


## Use Cases

- AI state-space problem solving
- Planning and decision-making systems
- Puzzle-solving applications
- Automated problem-solving agents
- Resource measurement problems
- Demonstrating search algorithms in AI education

## Advantages

- Demonstrates state-space representation clearly.
- Useful for understanding AI problem-solving.
- Can find a solution by exploring possible states.

## Limitation

- The number of states can increase as problem complexity grows.
- Requires tracking visited states to avoid loops.


# 5. A* Search Algorithm

## Problem

Find the **optimal path** from a start node to a goal node in a weighted graph using A* Search.

## Explanation

**A* (A-Star) Search** is an informed search algorithm that uses both the **actual path cost** and a **heuristic estimate** to find an optimal path.

A* evaluates each node using:

```text
f(n) = g(n) + h(n)


Where:

text
g(n) = Actual cost from Start Node to node n

h(n) = Estimated cost from node n to Goal Node

f(n) = Total estimated cost


The algorithm selects the node with the lowest `f(n)` value.

## How It Works

1. Add the starting node to the open list.
2. Set the starting node's actual cost `g(n)` to `0`.
3. Calculate the heuristic value `h(n)`.
4. Calculate `f(n) = g(n) + h(n)`.
5. Select the node with the lowest `f(n)`.
6. If the node is the goal, return the path.
7. Otherwise, expand its neighbours.
8. Calculate the cost for each neighbour.
9. Update the path if a better route is found.
10. Continue until the goal is reached.

## Key Concept

```text
A*
 ↓
Actual Cost + Estimated Cost
 ↓
f(n) = g(n) + h(n)
 ↓
Optimal Path
```

## Pseudocode

```text
AStar(Graph, Heuristic, Start, Goal)

1. Create an open_list

2. Add (Start, 0, [Start]) to open_list

3. Create an empty closed list

4. While open_list is not empty:

      Select node with the lowest
      f(n) = g(n) + h(n)

      Remove that node from open_list

      If node == Goal:

            Print path
            Print total cost
            Stop

      Add node to closed

      For each neighbour of node:

            If neighbour is not in closed:

                  Calculate new_cost

                  Calculate:
                  f(n) = g(n) + h(n)

                  Add neighbour to open_list


## Use Cases

- GPS navigation systems
- Google Maps-style route planning
- Robot path planning
- Autonomous vehicle navigation
- Video game character movement
- Warehouse robot navigation
- Network routing
- Artificial intelligence planning systems

## Advantages

- Usually faster than uninformed search algorithms.
- Uses domain knowledge through heuristics.
- Can find an optimal path when the heuristic is appropriate.
- Efficient for many path-finding problems.

## Limitation

- Performance depends on the quality of the heuristic.
- Requires additional memory for maintaining search lists.
- A poor heuristic can make the algorithm slower.



# 6. Alpha-Beta Pruning

## Problem

Optimize the **Minimax algorithm** by eliminating branches of the game tree that cannot influence the final decision.

## Explanation

**Alpha-Beta Pruning** is an optimization technique used with the **Minimax algorithm**.

It improves the efficiency of Minimax by avoiding the evaluation of branches that cannot affect the final decision.

Two values are maintained:

text
Alpha (α)


Alpha represents the best value that the **MAX player** can guarantee.

text
Beta (β)


Beta represents the best value that the **MIN player** can guarantee.

When:

text
Beta ≤ Alpha


the remaining branches can be safely ignored or **pruned**.

## How It Works

1. Start with `Alpha = -∞`.
2. Start with `Beta = +∞`.
3. Explore the game tree.
4. At MAX nodes, select the maximum value.
5. Update Alpha.
6. At MIN nodes, select the minimum value.
7. Update Beta.
8. If `Beta ≤ Alpha`, prune the remaining branch.
9. Return the best value.

## Key Concept

text
Alpha-Beta Pruning
        ↓
Minimax Optimization
        ↓
Evaluate Necessary Branches
        ↓
Prune Unnecessary Branches


## Pseudocode

text
AlphaBeta(depth, nodeIndex, maximizingPlayer, values, alpha, beta)

1. If depth == maximum depth:

       Return value of leaf node

2. If maximizingPlayer:

       best = -∞

       For each child node:

             val = AlphaBeta(
                   depth + 1,
                   childIndex,
                   False,
                   values,
                   alpha,
                   beta
             )

             best = max(best, val)

             alpha = max(alpha, best)

             If beta <= alpha:

                    Break
                    // Beta Cutoff (Pruning)

       Return best

3. Else (Minimizing Player):

       best = +∞

       For each child node:

             val = AlphaBeta(
                   depth + 1,
                   childIndex,
                   True,
                   values,
                   alpha,
                   beta
             )

             best = min(best, val)

             beta = min(beta, best)

             If beta <= alpha:

                    Break
                    // Alpha Cutoff (Pruning)

       Return best


## Use Cases

- Chess-playing AI
- Tic-Tac-Toe AI
- Checkers
- Connect Four
- Board game AI
- Strategic decision-making systems
- Two-player competitive games

## Advantages

- Reduces the number of game-tree nodes evaluated.
- Makes Minimax significantly faster.
- Produces the same optimal result as Minimax.
- Allows deeper game-tree searches.

## Limitation

- Most effective when good moves are evaluated first.
- Still computationally expensive for very large game trees.
- Mainly used for two-player adversarial games.



# 7. Minimax Algorithm

## Problem

Determine the best possible move for a player in a two-player game by assuming that both players play optimally.

## Explanation

**Minimax** is a decision-making algorithm used in **two-player, zero-sum games**.

It assumes that both players play optimally.

There are two types of players:

text
MAX Player


The MAX player tries to maximize the final score.

text
MIN Player


The MIN player tries to minimize the final score.

The algorithm creates a **game tree** representing possible moves and evaluates the possible outcomes.

The MAX player chooses the highest value, while the MIN player chooses the lowest value.

## How It Works

1. Start from the current game state.
2. Generate all possible moves.
3. Create a game tree.
4. Continue until a terminal state or maximum search depth is reached.
5. Assign evaluation values to the terminal states.
6. At MAX levels, select the maximum value.
7. At MIN levels, select the minimum value.
8. Propagate the values back to the root.
9. Select the best move.

## Key Concept

```text
MAX Player → Select Maximum Value

MIN Player → Select Minimum Value
```

## Pseudocode

text
Minimax(node, depth, maximizingPlayer)

1. If depth == 0 OR node is a terminal node:

       Return evaluation value of node

2. If maximizingPlayer:

       best = -∞

       For each child node:

             value = Minimax(
                     child,
                     depth - 1,
                     False
             )

             best = max(best, value)

       Return best

3. Else (Minimizing Player):

       best = +∞

       For each child node:

             value = Minimax(
                     child,
                     depth - 1,
                     True
             )

             best = min(best, value)

       Return best

4. Select the move with the best Minimax value


## Use Cases

- Chess AI
- Tic-Tac-Toe
- Checkers
- Connect Four
- Board game artificial intelligence
- Turn-based strategy games
- Competitive decision-making systems
- Game-playing intelligent agents

## Advantages

- Provides optimal decision-making when the complete game tree is available.
- Simple and conceptually easy to understand.
- Useful for two-player competitive games.
- Forms the foundation for more advanced game-playing algorithms.

## Limitation

- Can be computationally expensive.
- Requires large amounts of computation for complex games.
- The search depth is often limited in practical applications.






