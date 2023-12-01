#include <iostream>
#include <queue>
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

void log() {

}

struct VecHash {
    std::size_t operator()(std::vector<unsigned int> const& vec) const {
        std::size_t seed = vec.size();
        for(auto& i : vec) {
            seed ^= i + 0x9e3779b9 + (seed << 6) + (seed >> 2);
        }
        return seed;
    }
};
unordered_map<vector<unsigned int>, unsigned int, VecHash> vecDiags;

void countDiag(const vector<unsigned int>& v) {
    vector<unsigned int> flip = {v[3], v[4], v[5], v[0], v[1], v[2]};
    if (vecDiags.find(flip) != vecDiags.end()) {
        vecDiags[flip]++;
    } else {
        vecDiags[v]++;
    }
}

int main(int argc, char** argv) {

    ifstream ifs(argv[1]);
    unsigned int maxX = 0, maxY = 0, maxZ = 0, minX = UINT32_MAX, minY = UINT32_MAX, minZ = UINT32_MAX;
    for (string line; getline(ifs, line);) {
        istringstream iss(line);
        vector<unsigned int> cubeCoord;
        for (string num; getline(iss, num, ',');) {
            cubeCoord.push_back((unsigned int) stoi(num));
        }
        // let cubeCoord = x, y, z
        auto x = cubeCoord[0], y = cubeCoord[1], z = cubeCoord[2];
        maxX = max(x, maxX), maxY = max(y, maxY), maxZ = max(z, maxZ);
        minX = min(x, minX), minY = min(y, minY), minZ = min(z, minZ);
        cout << x << " " << y << " " << z << endl;
        // diagonals = (x, y, z), (x - 1, y - 1, z)
        countDiag({x, y, z, x - 1, y - 1, z});

        // (x, y, z), (x, y - 1, z - 1)
        countDiag({x, y, z, x, y - 1, z - 1});
        // (x, y,(, (x - 1, y, z ))
        countDiag({x, y, z, x - 1, y, z - 1});
        // (x - 1( - 1, z - 1), (x, y, z ))
        countDiag({x - 1, y - 1, z - 1, x, y, z - 1});
        // (x - 1( - 1, z - 1), (x , y - 1))
        countDiag({x - 1, y - 1, z - 1, x, y - 1, z});
        // (x - 1( - 1, z - 1), (x - 1, y))
        countDiag({x - 1, y - 1, z - 1, x - 1, y, z});
    }
    auto surfaceArea = 0;
    for (auto e : vecDiags) {
        if (e.second == 1) {
            bool add = false;
            unsigned int x0 = e.first[0], x1 = e.first[3], y0 = e.first[1], y1 = e.first[4], z0 = e.first[2], z1 = e.first[5];
            // constant wrt x
            if (x0 == x1)  {
                auto cnt = 0;
                for (unsigned int i = x0 - 1; i >= minX && i > 0; i--) {
                    if (vecDiags.find({i, y0, z0, i, y1, z1}) == vecDiags.end()) {
                        cnt++;
                    }
                }
                add = x0 - minX == cnt;
                cnt = 0;
                for (unsigned int i = x0 + 1; !add && i <= maxX; i++) {
                    if (vecDiags.find({i, y0, z0, i, y1, z1}) != vecDiags.end()) {
                        cnt++;
                    }
                }
                add |= cnt == maxX - x0;
            } else if (y0 == y1) {
                // constant wrt y
                auto cnt = 0;
                for (unsigned int i = y0 - 1; i >= minY && i > 0; i--) {
                    if (vecDiags.find({x0, i, z0, x1, i, z1}) == vecDiags.end()) {
                        cnt++;
                    }
                }
                add = y0 - minY == cnt;
                cnt = 0;
                for (unsigned int i = !add && y0 + 1; i <= maxY; i++) {
                    if (vecDiags.find({x0, i, z0, x1, i, z1}) == vecDiags.end()) {
                        cnt++;
                    }
                }
                add |= maxY - y0 == cnt;

            } else if (z0 == z1) {

                // constant wrt z
                auto cnt = 0;
                for (unsigned int i = z0 - 1; i >= minZ && i >= 0; i--) {
                    if (vecDiags.find({x0, y0, i, x1, y1, i}) == vecDiags.end()) {
                        cnt++;
                    }
                }
                add = cnt == z0 - minZ;
                cnt = 0;
                for (unsigned int i = !add && z0 + 1; i <= maxZ; i++) {
                    if (vecDiags.find({x0, y0, i, x1, y1, i}) == vecDiags.end()) {
                        cnt++;
                    }
                }
                add |= maxZ - z0 == cnt;
            }
            if (add) surfaceArea++;
        }
    }
    cout << surfaceArea << endl;
    return 0;
}


