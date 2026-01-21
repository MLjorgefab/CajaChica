// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {CajaChica} from "../src/CajaChica.sol";

contract ReserveGuardTest is Test {
    CajaChica public vault;
    address public user = address(1);

    function setUp() public {
        vault = new CajaChica();
        vm.deal(user, 1000 ether);
    }

    function test_AllowMaxTenPercent() public {
        // Arrange
        uint256 depositAmount = 100 ether;
        vm.prank(user);
        vault.deposit{value: depositAmount}();

        // Act: Withdraw exactly 10% (10 ETH)
        // totalBalance = 100, 10% = 10.
        uint256 maxWithdrawal = 10 ether;

        vm.prank(user);
        vault.withdraw(maxWithdrawal);

        // Assert
        assertEq(vault.balances(user), 90 ether);
    }

    function test_RevertIf_ExceedsLimit() public {
        // Arrange
        uint256 depositAmount = 100 ether;
        vm.prank(user);
        vault.deposit{value: depositAmount}();

        // Act: Try to withdraw 11% (11 ETH)
        uint256 tooMuch = 11 ether;

        vm.expectRevert("Exceeds max withdrawal limit (10%)");
        vm.prank(user);
        vault.withdraw(tooMuch);
    }
}
