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
#include <cmath>
using namespace std;

auto pairHash = [](const std::pair<int, int>& p){ return p.first * 31 + p.second; };
unordered_set<pair<int, int>, decltype(pairHash)> tailVisited(0, pairHash);
unordered_map<int, pair<int, int>> ropePos;

void log() {
    for (int i = 0; i < 21; i++) {
        for (int j = 0; j < 26; j++) {
            bool filled = false;
            if (ropePos[0].second == i && ropePos[0].first == j) {
                cout << "H";
                filled = true;
            }
            for (int k = 1; !filled && k < 10; k++) {
                if (ropePos[k].second == i && ropePos[k].first == j) {
                    cout << k;
                    filled = true;
                }
            }
            if (!filled) cout << ".";
        }
        cout << endl;
    }
    cout << endl;
}


void moveTail() {
    for (int i = 1; i <= 9; i++) {
        int tailX = ropePos[i].first, tailY = ropePos[i].second, curHeadX = ropePos[i - 1].first, curHeadY = ropePos[i - 1].second;
        while (sqrt((curHeadX - tailX)*(curHeadX - tailX) + (curHeadY - tailY)*(curHeadY - tailY)) > sqrt(2)) {
            if (curHeadX > tailX) {
                tailX++;
            } else if (curHeadX < tailX) {
                tailX--;
            }

            if (curHeadY > tailY) {
                tailY++;
            } else if (curHeadY < tailY) {
                tailY--;
            }
            ropePos[i] = make_pair(tailX, tailY);
            //log();
            if (i == 9) tailVisited.insert(make_pair(tailX, tailY));
        }
    }
}



int main(int argc, char** argv) {
    ifstream ifs(argv[1]);

    for (int i = 0; i < 10; i++) ropePos[i] = make_pair(11, 15);

    tailVisited.insert(make_pair(11, 15));
    for (string line; getline(ifs, line);) {
        int headX = ropePos[0].first, headY = ropePos[0].second;
        cout << headX << " " << headY << endl;
        istringstream iss(line);
        char dir;
        int amt;
        iss >> dir >> amt;
        switch(dir) {
            case 'R':
                for (int i = 0; i < amt; i++) {
                    headX++;
                    ropePos[0] = make_pair(headX, headY);
                    moveTail();
                }
                break;
            case 'U':
                for (int i = 0; i < amt; i++) {
                    headY--;
                    ropePos[0] = make_pair(headX, headY);
                    moveTail();
                }
                break;
            case 'L':
                for (int i = 0; i < amt; i++) {
                    headX--;
                    ropePos[0] = make_pair(headX, headY);
                    moveTail();
                }
                break;
            case 'D':
                for (int i = 0; i < amt; i++) {
                    headY++;
                    ropePos[0] = make_pair(headX, headY);
                    moveTail();
                }
                break;
        }


    }
        for (int i = 0; i < 21; i++) {
            for (int j = 0; j < 26; j++) {
                cout << (tailVisited.find(make_pair(j, i)) != tailVisited.end() ? "#" : ".");
            }
            cout << endl;
        }

    cout << tailVisited.size() << endl;

    // chase the head


    return 0;
}


