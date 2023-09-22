// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */
    
    // user -> balance
    mapping(address => uint256) public balances;

    // user -> time
    mapping(address => uint256) public lastDeposit;

    error InsufficientBalance();
    error TransferFailed();
    error HasNotBeenAWeek();

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        return balances[user];
    }

    function depositEther() external payable {
        /// add code here
        balances[msg.sender] += msg.value;
        lastDeposit[msg.sender] = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
        /// add code here
        uint256 userBalance = balances[msg.sender];
        uint256 lastDepositDate = lastDeposit[msg.sender];

        if (userBalance < amount) {
            revert InsufficientBalance();
        }
        if(block.timestamp < lastDepositDate + 7 days){
            revert HasNotBeenAWeek();
        }
        (bool success, ) = msg.sender.call{value: amount}("");
        if (!success) {
            revert TransferFailed();
        }

        balances[msg.sender] -= amount;
    }
}
