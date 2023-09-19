// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Divide {
    uint256 public constant PERCENTAGE_INTEREST = 3;

    /**
     * The calculate interst function is buggy because of how it calculates interest of amount parsed into it
     * Make it return the right value.
     */
    // "3% of 1_000_000 should return 30_000 in solidity"
    // for 7.5% of 200 -> uint256 interest = 200 * 75 / 1000;

    function calculateInterest(uint256 amount) external pure returns (uint256) {
        uint256 x = (amount * PERCENTAGE_INTEREST) /100;
        return x;
    }
}
