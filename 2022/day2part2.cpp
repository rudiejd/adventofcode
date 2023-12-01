#include<iostream>
#include<fstream>
#include<unordered_map>

using namespace std;
unordered_map<char, int> points =
        {{'X', 1},
         {'Y', 2},
         {'Z', 3},
         {'A', 1},
         {'B', 2},
         {'C', 3}};
unordered_map<char, char> beats =
        {{'A', 'Y'},
         {'B', 'Z'},
         {'C', 'X'}};
unordered_map<char, char> loses =
        {{'A', 'Z'},
         {'B', 'X'},
         {'C', 'Y'}};

int main(int argc, char** argv) {
    ifstream stream(argv[1]);
    int score = 0;
    for (string line; getline(stream, line);) {
        char need = line[2], opp = line[0];
        if (need == 'Z') {
            score += 6 + points[beats[opp]];
        } else if (need == 'X') {
          score += points[loses[opp]]; 
        } else {
          score += 3 + points[opp];
        }
    }
    cout << score << endl;
    return 0;
}


