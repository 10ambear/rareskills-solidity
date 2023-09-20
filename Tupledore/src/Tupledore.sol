// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Tupledore {
    /* This exercise assumes you know about tuples/struct in solidity.
        1. Create a struct named `UserInfo` with types address 
           and uint256. - done
        2. Create a variable of type UserInfo, named `userInfo`. - done
        3. Create a function called `setTuple` that takes in 
           a address and uint256 and sets the all values 
           the `userInfo` variable you created above. - done
        4. Create a function called `returnTuple`, 
           that returns `userInfo` (as a tuple) - done
    */

    struct UserInfo {
        address addr;
        uint256 number;
    }

    UserInfo userInfo; 

    function setTuple (address _a, uint256 _number) public {
      userInfo = UserInfo(_a, _number);
    }

    function returnTuple() public view returns(address a, uint256 number){
      return  (userInfo.addr, userInfo.number);
    }

    
}
