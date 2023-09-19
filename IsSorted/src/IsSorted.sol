// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
contract IsSorted {
    /**
     * The goal of this exercise is to return true if the members of "arr" is sorted (in ascending order -> low to high) or false if its not.
     */

    function isSorted(uint256[] calldata arr) public pure returns (bool) {
        // your code here
        bool sorted = true;
        for (uint256 i = 0; i < arr.length-1; i++) {

            if(arr[i] > arr[i+1])
            {
                sorted = false; 
            }
        }
        return sorted; 
        
    }
}
