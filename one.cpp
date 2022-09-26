#include <iostream>
#include <bits/stdc++.h>

using namespace std;

string reverst(string s)
{
    // Reverse string where character in string is an alphabet
    string ans = "";
    bool changeLeft = false;
    bool changeRight = false;

    int start = 0;
    int end = s.size() - 1;
    while (end > start)
    {
        if (isalpha(s[start]))
        {

            changeLeft = true;
        }
        else
        {
            start++;
        }
        if (isalpha(s[end]))
        {
            changeRight = true;
        }
        else
        {
            end--;
        }

        if (changeLeft && changeRight)
        {

            swap(s[start], s[end]);
            changeLeft = false;
            changeRight = false;
            end--;
            start++;
        }
    }

    return s;
}

int main()
{
    string s = "a-bC-dEf=ghIj!!";
    cout << reverst(s) << endl;
    return 0;
}