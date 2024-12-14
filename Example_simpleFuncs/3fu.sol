// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract First {
  function sendMoney(address payable _to) public payable {
    _to.transfer(msg.value);
  } 
} 
contract Second {
    function checkBalance() public view returns (uint256 balance) {
        return address(this).balance;
    }

    fallback() external payable { 

    }

    receive() external payable { 

    }


}
contract Third {

} 