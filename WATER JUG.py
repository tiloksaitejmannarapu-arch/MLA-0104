from collections import deque

def water_jug(cap1, cap2, target):
    visited = set()
    queue = deque()

    queue.append((0, 0, []))

    while queue:
        x, y, path = queue.popleft()

        if (x, y) in visited:
            continue

        visited.add((x, y))
        path = path + [(x, y)]

        if x == target or y == target:
            print("Solution Path:")
            for state in path:
                print(state)
            return

        next_states = [
            (cap1, y),                    # Fill Jug 1
            (x, cap2),                    # Fill Jug 2
            (0, y),                       # Empty Jug 1
            (x, 0),                       # Empty Jug 2
            (x - min(x, cap2 - y), y + min(x, cap2 - y)),  # Pour Jug 1 -> Jug 2
            (x + min(y, cap1 - x), y - min(y, cap1 - x))   # Pour Jug 2 -> Jug 1
        ]

        for state in next_states:
            if state not in visited:
                queue.append((state[0], state[1], path))

    print("No Solution")


# Example
jug1 = 4
jug2 = 3
target = 2

water_jug(jug1, jug2, target)
