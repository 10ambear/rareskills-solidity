// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
import {console} from "forge-std/Test.sol";
contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    // keep track of user with highest balance
    address private userWithHighestBalance; 

    // keep track of the user's highest balance
    uint256 private  highestBalance; 

    // last highest time stamp
    uint256 private endTime; 


    error TransferFailed();
    error NotWinner();
    error ContestStillRunning();

    function bet() public payable {

        // save user balance if highest
        if(msg.value > highestBalance){
            // update the user with the highest balance
            highestBalance = msg.value;
            userWithHighestBalance = msg.sender;

            // reset timer
            endTime = block.timestamp;

        }

    }

    function claimPrize() public {
        // function can only be claimed by the winner
        if(msg.sender != userWithHighestBalance){
            revert NotWinner();
        }

        // check if contest is still in progress
        if(block.timestamp < endTime + 60 minutes){ 
            revert ContestStillRunning();
        }

        // transfer
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        if (!success) {
            revert TransferFailed();
        }
    }
}
