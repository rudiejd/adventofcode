#include<iostream>
#include<fstream>
#include<unordered_map>

using namespace std;
static const unordered_map<char, int> points =
        {{'X', 1},
         {'Y', 2},
         {'Z', 3},
         {'A', 1},
         {'B', 2},
         {'C', 3}};
static const unordered_map<char, char> beats =
        {{'X', 'C'},
         {'Y', 'A'},
         {'Z', 'B'}};
int main(int argc, char** argv) {
    ifstream stream(argv[1]);
    int score = 0;
    for (string line; getline(stream, line);) {
        char me = line[2], opp = line[0];
        cout << me << " " << opp << endl;
        if (beats.at(me) == opp) {
            score += 6;
            cout << "I won" << endl;
        } else if (points.at(me) == points.at(opp)) {
            score += 3;
        }
        score += points.at(me);
        cout << score << endl;
    }
    cout << score << endl;
    return 0;
}


