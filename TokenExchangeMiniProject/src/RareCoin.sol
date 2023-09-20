// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

// Skillscoin to Rarecoin exchange
contract RareCoin {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address immutable skillsCoinAddress; 

    // owner -> coins
    mapping(address => uint256) public balanceOf;

    error TransferFailed();

    constructor(string memory _name, string memory _symbol, address addr) {
        name = _name;
        symbol = _symbol;
        decimals = 18;
        skillsCoinAddress = addr;
    }

    function trade(uint256 amount)public{
        
        // add to total supply
        totalSupply += amount;

        // add to your balance or rareCoin
        balanceOf[msg.sender] += amount;

        // todo it needs the skills contract address
        (bool ok,) = skillsCoinAddress.call(abi.encodeWithSignature("transferFrom(address,address,uint256)", msg.sender, address(this), amount));
        
        // if transfer failed
        if (!ok){
            revert TransferFailed();
        }

    }

}