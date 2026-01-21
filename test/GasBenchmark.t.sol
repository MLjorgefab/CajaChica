// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {CajaChica} from "../src/CajaChica.sol";

contract GasBenchmark is Test {
    CajaChica public vault;

    function setUp() public {
        vault = new CajaChica();
    }

    function test_WithdrawGas() public {
        // Setup scenarios: deposit enough to withdraw
        uint256 depositAmount = 10 ether;
        uint256 withdrawAmount = 2 ether; // > 10% of total

        vm.deal(address(this), depositAmount);
        vault.deposit{value: depositAmount}();

        // Snapshot gas before
        uint256 gasStart = gasleft();

        vault.withdraw(withdrawAmount);

        // Snapshot gas after
        uint256 gasEnd = gasleft();

        uint256 gasUsed = gasStart - gasEnd;
        // We log it so we can see it in output with -vv
        console.log("Gas Used for Withdraw:", gasUsed);
    }

    // Fallback to receive ETH
    receive() external payable {}
}
