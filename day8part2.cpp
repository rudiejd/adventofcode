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
            int curVal = grid[i][j];
            int leftScore = 0, rightScore = 0, upScore = 0, downScore = 0;
            for (int x = j + 1; x < N; x++) {
                leftScore++;
                if (grid[i][x] >= curVal) break;
            }
            for (int x = j - 1; x >= 0; x--) {
                rightScore++;
                if (grid[i][x] >= curVal) break;
            }
            for (int x = i - 1; x >= 0; x--) {
                upScore++;
                if (grid[x][j] >= curVal) break;
            }
            for (int x = i + 1; x < N && grid[x][j] < curVal; x++) {
                downScore++;
                if (grid[x][j] >= curVal) break;
            }

            highScore = max(leftScore * rightScore * upScore * downScore, highScore);
        }
    }
    cout << highScore << endl;

    return 0;
}

