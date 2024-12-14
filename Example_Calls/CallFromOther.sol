//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract toCallFromOther{
    function callGetName(CallFromOther _demoAddr) public view returns (string memory){
        return _demoAddr.getName();
    }

    function callSetName(CallFromOther _name) public{
        _name.setName("New Name");
    }

    function callPay(CallFromOther _pay) public payable {
        _pay.pay{value: msg.value}(msg.sender);
    }
}

contract CallFromOther{
    string name = "John";
    mapping (address => uint) public payments;

    function getName() external view returns (string memory) {
        return name;
    }

    function setName(string calldata _newName) external {
        name = _newName;
    }

    function pay(address _payer) external payable {
        payments[_payer] = msg.value;
    }
}