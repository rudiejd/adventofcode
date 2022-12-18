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


void log(int headX, int headY, int tailY, int tailX) {
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 6; j++) {
            if (i == headY && j == headX) {
                cout << "H";
            } else if (i == tailY && j == tailX) {
                cout << "T";
            } else {
                cout << ".";
            }
        }
        cout << endl;
    }
    cout << endl;
}


int main(int argc, char** argv) {
    int headX = 0, headY = 4, tailX = 0, tailY = 4;
    ifstream ifs(argv[1]);
    auto hash = [](const std::pair<int, int>& p){ return p.first * 31 + p.second; };
    unordered_set<pair<int, int>, decltype(hash)> tailVisited(0, hash);
    tailVisited.insert(make_pair(0, 0));
    for (string line; getline(ifs, line);) {
        istringstream iss(line);
        char dir;
        int amt;
        iss >> dir >> amt;
        switch(dir) {
            case 'R':
                headX += amt;
                break;
            case 'U':
                headY -= amt;
                break;
            case 'L':
                headX -= amt;
                break;
            case 'D':
                headY += amt;
                break;
        }
        while (sqrt((headX - tailX)*(headX - tailX) + (headY - tailY)*(headY - tailY)) > sqrt(2)) {
            if (headX > tailX) {
                tailX++;
            } else if (headX < tailX) {
                tailX--;
            }

            if (headY > tailY) {
                tailY++;
            } else if (headY < tailY) {
                tailY--;
            }
            tailVisited.insert(make_pair(tailX, tailY));
        }
        log(headX, headY, tailY, tailX);
    }
    cout << tailVisited.size() << endl;

    // chase the head


    return 0;
}


