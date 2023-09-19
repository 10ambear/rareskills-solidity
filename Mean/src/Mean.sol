// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Mean {
    /**
     * The goal of this exercise is to return the mean of the numbers in "arr"
     It is easy to calculate: add up all the numbers, then divide by how many numbers there are.
     */
    function mean(uint256[] calldata arr) public view returns (uint256) {
        uint256 sumOfArrayNumbers; 
        for (uint256 i = 0; i < arr.length; i++) {
            sumOfArrayNumbers += arr[i];
        } 

        return sumOfArrayNumbers / arr.length;
    }
}
