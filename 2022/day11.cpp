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
using ull = unsigned long long;

struct Monkey;
vector<Monkey> monkeys;

struct Monkey {
    vector<ull> inventory;
    function<ull(ull)> operation;
    function<ull(ull)> test;
    ull inspections = 0;
    ull divVal;

    void takeTurn() {
        for (auto item : inventory) {
            // monkey inspects the item
            item = operation(item);
            inspections++;
            // before testing worry level, decrease it bc not damaged
            item /= 3;

            // test the item and throw it
            monkeys[test(item)].inventory.push_back(item);
        }
        inventory = {};
    }
};



int main(int argc, char** argv) {
    ifstream ifs(argv[1]);

    while (ifs.good()) {
        string line;
        Monkey m;
        // Monkey 0:
        getline(ifs, line);
        // Starting items: 79, 98
        getline(ifs, line);
        istringstream iss(line);
        iss >> line >> line;
        while (iss >> line)
            m.inventory.push_back(stoi(line.find(',') == string::npos ? line : line.substr(0, line.find(','))));
//        Operation: new = old * 19
        getline(ifs, line);
        istringstream opIss(line);
        opIss >> line >> line >> line >> line >> line;
        switch(line[0]) {
            case '*':
                opIss >> line;
                if (line == "old") {
                    m.operation = [](ull x) { return x * x; };
                } else {
                    ull val = stoi(line);
                    m.operation = [val](ull x) { return x * val; };
                }
                break;
            case '+':
                opIss >> line;
                ull val = stoi(line);
                m.operation = [val](ull x) { return x + val;};
                break;
        }
//        Test: divisible by 23
        getline(ifs, line);
        istringstream divIss(line);
        divIss >> line >> line >> line >> line >> line >> line;
        ull divNum = stoi(line);
//        If true: throw to monkey 2
        getline(ifs, line);
        istringstream iss2(line);
        iss2 >> line >> line >> line >> line >> line >> line;
        ull trueMonkey = stoi(line);
//        If false: throw to monkey 3
        getline(ifs, line);
        istringstream iss3(line);
        iss3 >> line >> line >> line >> line >> line >> line;
        ull falseMonkey = stoi(line);

        // construct throw function
        m.test = [divNum, trueMonkey, falseMonkey](ull x) { return x % divNum == 0 ? trueMonkey : falseMonkey; };
        m.divVal = divNum;

        monkeys.push_back(m);

        // get extra blank line if there
        if (ifs.good()) getline(ifs, line);
    }

    // 20 rounds
    for (ull i = 0; i < 20; i++) {
        for (auto& monkey : monkeys) {
           monkey.takeTurn();
        }
//        cout << "After round " << i << endl;
//        for (ull j = 0; j < monkeys.size(); j++) {
//            cout << "Monkey " << j << ": ";
//            for (auto item : monkeys[j].inventory) {
//                cout << item << ", ";
//            }
//            cout << endl;
//        }
    }

    ull firstMax = 0, secondMax = 0;
    for (const auto& monkey : monkeys) {
        if (monkey.inspections > firstMax) {
            secondMax = firstMax;
            firstMax = monkey.inspections;
        } else if (monkey.inspections > secondMax) {
            secondMax = monkey.inspections;
        }
    }

    cout << "Monkey business level " << firstMax * secondMax << "!!" << endl;



    return 0;
}


