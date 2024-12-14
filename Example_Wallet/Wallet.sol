//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./SharedWallet.sol";

contract Wallet is SharedWallet {
    constructor(address initialOwner) SharedWallet(initialOwner) {}
  event MoneyWithdrawn(address indexed _to, uint _amount);
  event MoneyReceived(address indexed _from, uint _amount);
  event LimitChanged(address indexed _for, uint _amountBefore, uint _amountAfter);
    
  function withdrawMoney(uint _amount) public ownerOrWithinLimits(_amount) {
    require(_amount <= address(this).balance, "Not enough funds to withdraw!");
        
    if(!isOwner()) {
      emit LimitChanged(_msgSender(),  members[_msgSender()], members[_msgSender()] - _amount); 
      deduceFromLimit(_msgSender(), _amount); 
    }
        
    address payable _to = payable(_msgSender());
    _to.transfer(_amount);
        
    emit MoneyWithdrawn(_to, _amount);
  }
    
  function deleteMember(address _member) external {
    delete members[_member];
  }  

  function sendToContract(address _to) public payable {
    address payable to = payable(_to);
    to.transfer(msg.value);
        
    emit MoneyReceived(_msgSender(), msg.value);
  }
    
  function getBalance() public view returns(uint) {
    return address(this).balance;
  }
    
  fallback() external payable {}
    
  receive() external payable { 
    emit MoneyReceived(_msgSender(), msg.value); 
  }
}