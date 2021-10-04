#include <numeric>
#include <algorithm>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

constexpr int WIDTH{80};
int matrix[WIDTH][WIDTH];
int dist[WIDTH][WIDTH];

int main()
{
    std::ifstream fs("081-matrix.txt");
    int i{0};
    for (std::string line; getline(fs, line); ++i) {
        std::stringstream ls(line);
        int j{0};
        for (std::string num; getline(ls, num, ','); ++j) {
            matrix[i][j] = stoi(num);
        }
    }

    std::partial_sum(std::begin(matrix[0]), std::end(matrix[0]), std::begin(dist[0]));
    for (int i{1}; i < WIDTH; ++i) {
        dist[i][0] = matrix[i][0] + dist[i - 1][0];
        for (int j{1}; j < WIDTH; ++j) {
            dist[i][j] =
                matrix[i][j] + std::min(dist[i - 1][j], dist[i][j - 1]);
        }
    }
    std::cout << dist[WIDTH - 1][WIDTH - 1] << '\n';
}
