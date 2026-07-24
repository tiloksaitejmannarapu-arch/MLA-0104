graphs = {

    "Graph 1": {
        'A': ['B', 'C'],
        'B': ['D', 'E'],
        'C': ['F'],
        'D': [],
        'E': [],
        'F': []
    },

    "Graph 2": {
        0: [1],
        1: [2, 3],
        2: [],
        3: [2, 4],
        4: [6, 5],
        5: [7],
        6: [],
        7: [6]
    },

    "Graph 3": {
        1: [2, 3],
        2: [5, 6],
        3: [7],
        4: [8],
        5: [],
        6: [],
        7: [],
        8: [7]
    },

    "Graph 4": {
        1: [2, 7],
        2: [3, 6],
        3: [4, 5],
        4: [],
        5: [],
        6: [],
        7: [8, 10],
        8: [9],
        9: [],
        10: []
    }
}

starts = {
    "Graph 1": 'A',
    "Graph 2": 0,
    "Graph 3": 1,
    "Graph 4": 1
}

def dfs(graph, node, visited):
    visited.add(node)
    print(node, end=" ")

    for neighbour in graph[node]:
        if neighbour not in visited:
            dfs(graph, neighbour, visited)

for name in graphs:
    print("\n", name)
    print("DFS Traversal:", end=" ")
    visited = set()
    dfs(graphs[name], starts[name], visited)
    print()
