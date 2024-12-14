//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo{
    string public name = "John";
    uint256 public age = 30;
    mapping (address => uint) public payments;
    address public sender;

    function getBalance() public view returns (uint256){
        return address(this).balance;
    }

    function setData(string calldata _newName, uint _newAge) external {
        name = _newName;
        age = _newAge;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function pay(address _payer) external payable{
        payments[_payer] = msg.value;
    }

    fallback() external payable {
    sender = msg.sender;
    payments[msg.sender] = msg.value;
  }
}