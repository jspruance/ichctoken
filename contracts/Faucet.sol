// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Faucet {
    address payable owner;
    IERC20 private _token;

    // default  withdrawal amount - 50 tokens
    uint256 public withdrawalAmount = 50 * (10 ** 18);
    // default wait time - 3 days
    uint256 public waitTime = 4320 minutes;

    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

    mapping(address => uint256) lastAccessTime;

    constructor (IERC20 token) {
        _token = token;
        owner = payable(msg.sender);
    }

    // Accept any incoming amount
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // Give out ether to anyone who asks
    function withdraw() public {
        require(allowedToWithdraw(msg.sender), "Insufficient time elapsed since last withdrawal - try again later");
        require(withdrawalAmount <= 1000 * (10 ** 18), "Request exceeds maximum withdrawal amount of 1000 ICHC");
        require(_token.balanceOf(address(this)) >= withdrawalAmount, "Insufficient balance in faucet for withdrawal request");
        require(msg.sender != address(0), "Request must not originate from a zero account");
        
        // Send the amount to the address that requested it
        _token.transfer(msg.sender, withdrawalAmount);
        
        lastAccessTime[msg.sender] = block.timestamp + waitTime;
    }

    function getBalance() public view returns (uint256) {
      return _token.balanceOf(address(this));
    }

    function allowedToWithdraw(address _address) public view returns (bool) {
        if (lastAccessTime[_address] == 0) {
            return true;
        } else if (block.timestamp >= lastAccessTime[_address]) {
            return true;
        }
        return false;
    }

    // setter for withdrawl amount
    function setWithdrawalAmount(uint256 amount) public onlyOwner {
        // Limit max withdrawal amount to 10,000 tokens
        require(amount <= 10000 * (10 ** 18));
        withdrawalAmount = amount * (10 ** 18);
    }

    // setter for wait time
    function setWaitTime(uint256 amount) public onlyOwner {
        waitTime = amount * 1 minutes;
    }

    // Contract destructor
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    // Access control modifier
    modifier onlyOwner {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
}