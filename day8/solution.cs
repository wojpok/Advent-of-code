using System;
using System.IO;

class Tree {
    public bool topCovered, botCovered, leftCovered, rightCovered;

    public int height;

    public Tree(char height) {
        this.height = height - '0';
    }

    public bool isNotVisible() {
        return topCovered && botCovered && leftCovered && rightCovered;
    }
}


class Solution {
    static void Main(string[] args) {
        string[] data = File.ReadAllLines("data.in");
        
        int dimX = data[0].Length;
        int dimY = data.Length;

        Tree[][] arr = new Tree[dimY][];



        int k = 0;
        foreach(string line in data) {
            
            arr[k] = new Tree[dimX]; 

            int j = 0;
            foreach(char tree in line) {
                arr[k][j] = new Tree(tree);
                j++;
            }

            k++;
        }
        /*
        for(int i = 0; i < dimY; i++) {
            for(int j = 0; j < dimX; j++) {
                Tree curr = arr[i][j];

                if(curr == null) {
                    Console.Write('N');
                }
                else {
                    Console.Write(curr.height);
                }
            }
            Console.WriteLine("");
        }
        */

        // covering from right
        for(int i = 0; i < dimY; i++) {
            int h = -1;
            for(int j = 0; j < dimX; j++) {
                Tree curr = arr[i][j];

                if(curr.height > h) {
                    h = curr.height;
                }
                else {
                    curr.rightCovered = true;
                }
            }
        }

        // covering from left
        for(int i = 0; i < dimY; i++) {
            int h = -1;
            for(int j = dimX - 1; j >= 0; j--) {
                Tree curr = arr[i][j];

                if(curr.height > h) {
                    h = curr.height;
                }
                else {
                    curr.leftCovered = true;
                }
            }
        }
        
        // covering from top
        for(int j = 0; j < dimX; j++) {
            int h = -1;
            for(int i = 0; i < dimY; i++) {
                Tree curr = arr[i][j];

                if(curr.height > h) {
                    h = curr.height;
                }
                else {
                    curr.topCovered = true;
                }
            }
        }

        // covering from bottom
        for(int j = 0; j < dimX; j++) {
            int h = -1;
            for(int i = dimY - 1; i >= 0; i--) {
                Tree curr = arr[i][j];

                if(curr.height > h) {
                    h = curr.height;
                }
                else {
                     curr.botCovered = true;
                }
            }
        }

        int sum = 0;

        for(int i = 1; i < dimY - 1; i++) {
            for(int j = 1; j < dimX - 1; j++) {
                if(!arr[i][j].isNotVisible()) {
                    sum += 1;
                }
            }
        }

        sum += 2*dimX + 2*dimY - 4;

        Console.WriteLine(sum);
        

        int best = 0;
        //int prog = 0;
        // Screw optimalization, my time is precious
        for(int i = 1; i < dimY - 1; i++) {
            for(int j = 1; j < dimX - 1; j++) {
                Tree curr = arr[i][j];

                //Console.WriteLine(prog++);

                int top = 0, bot = 0, left = 0, right = 0;
                
                while(i - top - 1 >= 0) {
                    top++;
                    Tree t = arr[i - top][j];
                    if(t.height >= curr.height) { break; }
                }

                while(i + bot + 1 < dimY) {
                    bot++;
                    Tree t = arr[i + bot][j];
                    if(t.height >= curr.height) { break; }
                }

                while(j - left - 1 >= 0) {
                    left++;
                    Tree t = arr[i][j - left];
                    if(t.height >= curr.height) { break; }
                }
                while(j + right + 1< dimX) {
                    right++;
                    Tree t = arr[i][j + right];
                    if(t.height >= curr.height) { break; }
                }

                int score = (top) * (bot) * (left) * (right);

                if(score > best)
                    best = score;
                
            }
        }

        Console.WriteLine(best);
    }
}
