// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract FundsDemo {
  uint balanceReceived;

  function withdrawMoney() public {
  address payable receiver = payable(msg.sender);
  receiver.transfer(this.getBalance());
}

  function receiveMoney() public payable {
    balanceReceived += msg.value;
  }

  function getBalance() public view returns (uint) {
    return address(this).balance;
  }

  mapping(address => bool) public addrMap;
    
  function addAddress() public {
    addrMap[msg.sender] = true;
  }
}
