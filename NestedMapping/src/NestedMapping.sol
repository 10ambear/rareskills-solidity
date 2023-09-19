// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract NestedMapping {

    // address => uint256 => bool
    mapping(address => mapping(uint256 => bool)) public nestedBool;

    /* This exercise assumes you know how nested mappings work.
        1. Create a public nested mapping of (address => uint256 => bool). - done
        2. The name of the mapping must be `nestedBool` - done
        3. Set the boolean value of the arguments to `true` in the 'setNestedDetails' function - done
        4. use the 'returnNestedDetails' function to return the values of a nested data - done
    */

    function setNestedDetails(address _addr, uint256 _num) public {
        nestedBool[_addr][_num] = true;
    }

    function returnNestedDetails(
        address _addr,
        uint256 _num
    ) public view returns (bool) {
        return nestedBool[_addr][_num];
    }
}
