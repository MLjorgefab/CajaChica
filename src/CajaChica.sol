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

    function withdraw(uint256 _amount) public {
        // Step 1: Cache storage variables (Gas Optimization)
        // Reads from storage (expensive) to stack (cheap)
        uint256 userBalance = balances[msg.sender];
        uint256 totalBalance = s_totalBalance;

        // Check 1: User balance
        require(userBalance >= _amount, "Not enough balance");

        // Phase 2 - Act: The Reserve Check
        // Rule: Cannot withdraw more than 10% of total liquidity at once
        require(
            _amount <= (totalBalance * RESERVE_PERCENTAGE) / 100,
            "Exceeds max withdrawal limit (10%)"
        );

        // Effects
        // Update local stack variables
        userBalance -= _amount;
        totalBalance -= _amount;

        // Write back to storage once (SSTORE)
        balances[msg.sender] = userBalance;
        s_totalBalance = totalBalance;

        // Interactions
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
    }

    // Function to check the contract's actual ETH balance
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
