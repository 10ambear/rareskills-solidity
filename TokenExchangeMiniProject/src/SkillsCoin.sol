// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

// Anyone can mint skillscoin
contract SkillsCoin {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply; 

    // owner -> coin
    mapping(address => uint256) public balanceOf;
    // owner -> spender -> allowance
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        decimals = 18;
    }

    function mint(uint256 amount) public {
        totalSupply += amount;
        balanceOf[msg.sender] += amount;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        if (msg.sender != from) {
            require(
                allowance[from][msg.sender] >= amount,
                "not enough allowance"
            );

            allowance[from][msg.sender] -= amount;
        }

        return helperTransfer(from, to, amount);
    }

    // it's very important for this function to be internal!
    function helperTransfer(
        address from,
        address to,
        uint256 amount
    ) internal returns (bool) { 
        require(balanceOf[from] >= amount, "not enough money");
        require(to != address(0), "cannot send to address(0)");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        totalSupply -= amount;
        return true;
    }
}

