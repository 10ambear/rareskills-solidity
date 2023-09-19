// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Fibonacci {
    /*
        This exercise assumes you understand what Fibonacci sequence is.
        1. Function `fibonacci` takes a uint256 as argument and returns nth fibonacci number.
        
        Fibonacci sequence are 0,1,1,2,3,5,8,13,....

        pos -> 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 ,  8 ,  9, , 10 
        seq -> 0 , 1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34 , 55

        
        calling fibonacci(6) would return 8, because the 6th Fibonacci number is 8.
    */

    function fibonacci(uint256 _position) public pure returns (uint256) {
        uint256 x; 
        // your code here
        for (uint256 i = 0; i <= _position; i++) {
            if (i == 0) {
                x = 0;
            } else if (i == 1) {
                x = 1;
            } else {
                x = fibonacci(i - 1) + fibonacci(i - 2);
            }
        }
        return x;
    }
}
