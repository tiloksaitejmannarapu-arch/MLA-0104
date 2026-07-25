import heapq

def uniform_cost_search(graph, start, goal):
    priority_queue = [(0, start)]
    visited = set()

    while priority_queue:
        cost, node = heapq.heappop(priority_queue)

        if node in visited:
            continue

        visited.add(node)

        if node == goal:
            print("Goal reached!")
            print("Minimum Cost:", cost)
            return

        for neighbor, weight in graph[node]:
            if neighbor not in visited:
                heapq.heappush(priority_queue, (cost + weight, neighbor))

    print("Goal not reachable")


# Graph Representation
graph = {
    'A': [('B', 1), ('C', 4)],
    'B': [('D', 2), ('E', 5)],
    'C': [('F', 3)],
    'D': [('G', 1)],
    'E': [('G', 2)],
    'F': [('G', 2)],
    'G': []
}

start = 'A'
goal = 'G'

uniform_cost_search(graph, start, goal)
