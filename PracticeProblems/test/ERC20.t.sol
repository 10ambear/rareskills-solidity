// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ERC20.sol";

contract ERC20Test is Test {

    address deployer;
    ERC20 public token;
    uint32 public constant EXCEED_MAX_SUPPLY_ALLOWED = 1_000_001;
    uint32 public constant MAX_SUPPLY_ALLOWED = 1_000_000;


    function setUp() public {
        deployer = address(1);

        // deploy token
        vm.startPrank(deployer);
        token = new ERC20("Grizzly token", "Bear");
        vm.stopPrank();
    }

    function testRevertExceedMaxSupply() public {
        vm.expectRevert(ERC20.ExceedMaxSupply.selector);
        vm.prank(deployer);
        token.mint(deployer, EXCEED_MAX_SUPPLY_ALLOWED);
    }

        function testMaxSupplyAllowed() public {
        vm.prank(deployer);
        token.mint(deployer, MAX_SUPPLY_ALLOWED);
        assertEq(token.balanceOf(deployer), MAX_SUPPLY_ALLOWED);
    }



}