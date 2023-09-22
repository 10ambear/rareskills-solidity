// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
import {console} from "forge-std/Test.sol";

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public immutable depositedTime;
    uint256 public constant PERCENTAGE_LOSS = 11574;

    constructor() payable {
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        // 1 second deducts 0.0011574% from the current
        // 0.0011574 * 1e7 = 11574
        uint256 percentageLossPerSecond = PERCENTAGE_LOSS;

        // time passed from deposited time
        uint256 timePassedInHours = block.timestamp - depositedTime;

        // percentage lost over time passed
        uint256 percentageLost = percentageLossPerSecond * timePassedInHours;

        // convert the percentageLost to eth
        uint256 lostEth = (1 ether * percentageLost) / 1e7;

        // send etherleft to return
        uint256 etherLeft = 1 ether - lostEth;

        payable(msg.sender).transfer(etherLeft);
    }
    
// test function in remix todo 
//     function withdraw() public view returns(uint256, uint256, uint256, uint256){

//         // 1 second deducts 0.0011574% from the current
//         // 0.0011574 * 1e7 = 11574
//         uint256 percentageLossPerSecond = PERCENTAGE_LOSS;

//         // time passed from deposited time
//         uint256 timePassedInSeconds = block.timestamp - depositedTime;

//         // percentage lost over time passed
//         uint256 percentageLostInSeconds = percentageLossPerSecond * timePassedInSeconds;

//         // convert the percentageLost to eth
//         uint256 lostEth = (1 ether * percentageLostInSeconds) / 1e15;

//         // send etherleft to return
//         uint256 payout = 1 ether - lostEth;

//         return (timePassedInSeconds, percentageLostInSeconds, 1 ether,0);
//     //return(timePassedInSeconds, percentageLost, lostEth, payout);
// }

