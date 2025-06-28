// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token {
    // String type variables to identify the token
    string public name = "My Hardhat Token";
    string public symbol = "MHT";

    // The fixed amount of tokens
    // Stored in an unsigned integer type variable
    uint256 public totalSupply = 1000000;

    // Address type variable used to store ethereum accounts
    address public owner;

    // Mapping is a key/value map
    // Token balance of each token is stored
    mapping (address => uint256) balances;

    // Transfer event helps off-chain applications understand
    // What is taking place in the contract
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * Contract initialization
     */
    constructor() {
        // Total supply is assigned to the transaction sender
        // The sender is the account that is deploying the contract
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    /**
     * Function to transfer tokens
     * 
     * The `external` modifier makes a function *only* callable from *outside*
     * the contract.
     */
    function transfer(address to, uint256 amount) external {
        // Check if transaction sender has enough tokens
        // If `require`'s firt argument evaluates to `false`,
        // Transaction reverts
        require(balances[msg.sender] >= amount, "Not enough tokens");

        // Transfer the amount
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // Notify off-chain applications of the transfer
        emit Transfer(msg.sender, to, amount);
    }

    /**
     * Read only function to retrieve the token balance of a given account
     * 
     * The `view` modifier indicates that it doesn't modify the contract's
     * state, which allows us to call it without executing a transaction
     */
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}