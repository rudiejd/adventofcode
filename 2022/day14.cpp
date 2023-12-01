#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_set>
#include <vector>
#include <unordered_map>
#include <stack>
#include <deque>
#include <tuple>
#include <algorithm>

using namespace std;

int visibleCount = 0;

vector<vector<int>> grid;

int x = 0, y = 0;
int main(int argc, char** argv) {
    ifstream ifs(argv[1]);
    for (string line; getline(ifs, line);) {
        grid.push_back({line[0] - '0'});
        for (auto i = 1; i < line.size(); i++) {
            grid[y].push_back(line[i] - '0');
        }
        y++;
    }

    // assume a symmetric matrix
    int N = grid.size();

    int highScore = 0;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            // if it's an edge
            if (i == 0 || j == 0 || i == N - 1 || j == N - 1) {
                visibleCount++;
                continue;
            }
            int curVal = grid[i][j];
            int leftScore = 0, rightScore = 0, upScore = 0, downScore = 0;
            for (int x = i + 1; x < grid[i].size() && grid[i][x] < curVal; i++) leftScore++;
            for (int x = i - 1; x >= 0 && grid[i][x] < curVal; x++) rightScore++;
            for (int x = j - 1; x >= 0 && grid[x][j] < curVal; x--) upScore++;
            for (int x = j + 1; x < N && grid[x][j] < curVal; x++) downScore++;

            highScore = max(leftScore * rightScore * upScore * downScore, highScore);
        }
    }
    // left to right

    // right to left

    // bottom to top


    cout << visibleCount;


    return 0;
}


