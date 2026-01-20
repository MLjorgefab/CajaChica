// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract CajaChica {
    // Constant for the reserve percentage
    uint256 constant RESERVE_PERCENTAGE = 10;
    // Mapping to track balances for each address
    mapping(address => uint256) public balances;

    // State variable for the total liquidity in the vault
    uint256 public s_totalBalance;

    // Function to deposit funds
    function deposit() public payable {
        // msg.value is the amount of ETH sent
        balances[msg.sender] += msg.value;
        s_totalBalance += msg.value;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient balance");
        require(
            balances[msg.sender] >= (s_totalBalance * RESERVE_PERCENTAGE) / 100,
            "Insufficient balance"
        );
    }

    // Function to check the contract's actual ETH balance
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
