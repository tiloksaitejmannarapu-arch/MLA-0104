import heapq

def astar(graph, h, start, goal):
    open_list = []
    heapq.heappush(open_list, (0, start))

    g = {start: 0}
    parent = {start: None}

    while open_list:
        f, current = heapq.heappop(open_list)

        if current == goal:
            path = []
            while current:
                path.append(current)
                current = parent[current]
            print("Path:", " -> ".join(path[::-1]))
            print("Total Cost =", g[goal])
            return

        for neighbor, cost in graph[current]:
            g_new = g[current] + cost
            f_new = g_new + h[neighbor]     # f(n) = g(n) + h(n)

            if neighbor not in g or g_new < g[neighbor]:
                g[neighbor] = g_new
                parent[neighbor] = current
                heapq.heappush(open_list, (f_new, neighbor))

    print("Goal not found")

# Graph
graph = {
    'A': [('B', 1), ('C', 4)],
    'B': [('D', 2), ('E', 5)],
    'C': [('F', 3)],
    'D': [('G', 1)],
    'E': [('G', 2)],
    'F': [('G', 2)],
    'G': []
}

# Heuristic values h(n)
h = {
    'A': 7,
    'B': 6,
    'C': 4,
    'D': 2,
    'E': 1,
    'F': 2,
    'G': 0
}

astar(graph, h, 'A', 'G')
