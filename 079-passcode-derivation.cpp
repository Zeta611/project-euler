#include <fstream>
#include <iostream>
#include <stack>
#include <string>
#include <vector>

int main()
{
    std::vector<int> adj_list[10];
    bool visited[10]{};

    std::ifstream fs("079-keylog.txt");
    for (std::string line; getline(fs, line);) {
        adj_list[line[0] - '0'].push_back(line[1] - '0');
        adj_list[line[1] - '0'].push_back(line[2] - '0');
    }

    std::vector<int> sorted;
    std::stack<int> stk;
    for (int d{0}; d <= 9; ++d) {
        if (visited[d] || adj_list[d].empty()) {
            continue;
        }

        stk.push(d);
        while (!empty(stk)) {
            const auto u{stk.top()};
            stk.pop();

            if (u < 0) {
                sorted.push_back(-u - 1);
                continue;
            }

            if (visited[u]) {
                continue;
            }
            visited[u] = true;
            stk.push(-u - 1);

            for (int v : adj_list[u]) {
                if (!visited[v]) {
                    stk.push(v);
                }
            }
        }
    }

    for (auto it{crbegin(sorted)}; it != crend(sorted); ++it) {
        std::cout << *it;
    }
    std::cout << '\n';
}
