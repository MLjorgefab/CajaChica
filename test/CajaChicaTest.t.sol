// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {CajaChica} from "../src/CajaChica.sol";

contract CajaChicaTest is Test {
    CajaChica public vault;

    function setUp() public {
        vault = new CajaChica();
    }

    function test_InitialState() public view {
        assertEq(vault.getContractBalance(), 0);
    }

    function test_SuccesfulDeposit() public {
        uint256 depositAmount = 1 ether;

        vault.deposit{value: depositAmount}();

        assertEq(vault.getContractBalance(), depositAmount);
        assertEq(vault.balances(address(this)), depositAmount);
    }
}
