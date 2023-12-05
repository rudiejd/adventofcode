#include <fstream>
#include <string>
#include <sstream>
#include <iostream>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

void trimRightDelimiter(string &s) {
  if (!isalpha(s.back())) {
      s.pop_back();
  }
}

unordered_map<string, int> getDesiredColorCounts() {
  return {
      {"red", 12},
      {"green", 13},
      {"blue", 14},
  };
}

int getColorCounts(istringstream &ss, int id) {
  string count, color;
  int colorsSatisifed = 0;
  // unordered_map<string, int> counts;
  unordered_set<string> satisifed = {
      "red", "green", "blue"
  };
  auto maxCounts = getDesiredColorCounts();
  while (ss >> count >> color) {
    trimRightDelimiter(color);
    std::cout << "count: " << count << " color: " << color << endl;
    if (stoi(count) > maxCounts[color]) {
        satisifed.erase(color);
    }
    // counts[color] = counts[color] + stoi(count);
  }

  if (satisifed.size() == maxCounts.size()) {
    std::cout << "Game " << id << " is valid" << endl;
    return id;
  }

  return 0;
}

int getColorPowers(istringstream& ss, int id) {
  string count, color;

  unordered_map<string, int> necessaryCubes;

  while (ss >> count >> color) {
    trimRightDelimiter(color);
    auto countNumber = stoi(count);
    if (countNumber > necessaryCubes[color]) {
        necessaryCubes[color] = countNumber;
    }
  }

  int acc = 1;

  for (auto e : necessaryCubes) {
      acc *= e.second;
  }

  return acc;
}

void part1(const string& fileName) {
  ifstream ifs(fileName);
  string line;
  int acc = 0;
  // each line is a game
  int id = 1;
  while (getline(ifs, line)) {
    istringstream ss(line);
    string count, color;
    // discard game N:
    ss >> count >> count;

    acc += getColorCounts(ss, id);

    id++;
  }
  std::cout << "part 1: " << acc << endl;
}

void part2(const string& fileName) {
  ifstream ifs(fileName);
  string line;
  auto acc = 0;
  // each line is a game
  int id = 1;
  while (getline(ifs, line)) {
    istringstream ss(line);
    string count, color;
    // discard game N:
    ss >> count >> count;

    acc += getColorPowers(ss, id);

    id++;
  }
  std::cout << "part 2" << acc << endl;

}

int main(int argc, char **argv) {
    part1(argv[1]);
    part2(argv[1]);
}
