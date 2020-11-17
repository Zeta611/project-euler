solution_list = {
    0: set([frozenset({1: 0, 2: 0, 5: 0, 10: 0, 20: 0, 50: 0, 100: 0, 200: 0}.items())])
}


def solve(price):
    if price in solution_list:
        return solution_list[price]
    coin_list = [1, 2, 5, 10, 20, 50, 100, 200]
    result = set([])
    for coin in coin_list:
        if price >= coin:
            previous_solution = solve(price - coin)
            for each_solution in previous_solution:
                each_solution = dict(each_solution)
                each_solution[coin] += 1
                each_solution = frozenset(each_solution.items())
                result |= {each_solution}
    solution_list[price] = result
    return result


print len(solve(200))
