// SPDX-License-Identifier: CC-BY-SA-4.0
// This work is licensed under a Creative Commons Attribution Share-Alike CC-BY-SA-4.0 License.
// Modified version of Faucet contract from 'Mastering Ethereum' by A. M. Antonopoulos & Dr. Gavin Wood
// https://github.com/ethereumbook/ethereumbook/blob/develop/code/Solidity/Faucet8.sol

// Version of Solidity compiler this program was written for
pragma solidity ^0.8.0;

contract Owned {
    address payable owner;

    // Contract constructor: set owner
    constructor() {
        owner = payable(msg.sender);
    }

    // Access control modifier
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
}

contract Mortal is Owned {
    // Contract destructor
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }
}

contract FaucetBook is Mortal {
    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

    uint withdrawalAmount = 100 * (10 ** 18);

    constructor() {
      //
    }

    // Accept any incoming amount
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // Give out ether to anyone who asks
    function withdraw() public {
        // Limit withdrawal amount to 1,000 tokens
        require(withdrawalAmount <= 1000 * (10 ** 18));

        require(
            address(this).balance >= withdrawalAmount,
            "Insufficient balance in faucet for withdrawal request"
        );

        // Send the amount to the address that requested it
        payable(msg.sender).transfer(withdrawalAmount);

        emit Withdrawal(msg.sender, withdrawalAmount);
    }
}