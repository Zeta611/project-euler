#include <algorithm>
#include <cstring>
#include <fstream>
#include <iostream>
#include <limits>
#include <queue>
#include <sstream>
#include <string>
#include <utility>

constexpr int WIDTH{80};
int matrix[WIDTH][WIDTH];
int dist[WIDTH][WIDTH];

using pos_t = std::pair<int, int>;
constexpr pos_t DIRS[]{{-1, 0}, {0, 1}, {1, 0}};

constexpr auto cmp{[](const pos_t &p1, const pos_t &p2) {
    return dist[p1.first][p1.second] > dist[p2.first][p2.second];
}};
std::priority_queue<pos_t, std::vector<pos_t>, decltype(cmp)> pq;

int dijkstra()
{
    memset(dist, -1, sizeof dist);

    for (int y{0}; y < WIDTH; ++y) {
        dist[y][0] = matrix[y][0];
        pq.emplace(y, 0);
    }

    while (!empty(pq)) {
        const auto [y, x]{pq.top()};
        pq.pop();

        for (auto [dy, dx] : DIRS) {
            const int ny{y + dy};
            const int nx{x + dx};
            if (ny < 0 || ny >= WIDTH || nx < 0 || nx >= WIDTH) {
                continue;
            }
            if (const int nd{dist[y][x] + matrix[ny][nx]};
                dist[ny][nx] == -1 || dist[ny][nx] > nd) {
                dist[ny][nx] = nd;
                pq.emplace(ny, nx);
            }
        }
    }

    int min{std::numeric_limits<int>::max()};
    for (int y{0}; y < WIDTH; ++y) {
        min = std::min(min, dist[y][WIDTH - 1]);
    }
    return min;
}

int main()
{
    std::ifstream fs("082-matrix.txt");
    int i{0};
    for (std::string line; getline(fs, line); ++i) {
        std::stringstream ls(line);
        int j{0};
        for (std::string num; getline(ls, num, ','); ++j) {
            matrix[i][j] = stoi(num);
        }
    }
    std::cout << dijkstra() << '\n';
}
