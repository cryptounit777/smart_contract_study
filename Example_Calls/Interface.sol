//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ICallFromOther {
    function getName() external view returns (string memory);
    function setName(string calldata _newName) external;
    function pay(address _payer) external payable;
}

contract toCallFromOther{
    function callGetName(ICallFromOther _demoAddr) public view returns (string memory){
        return _demoAddr.getName();
    }

    function callSetName(ICallFromOther _name) public{
        _name.setName("New Name");
    }

    function callPay(ICallFromOther _pay) public payable {
        _pay.pay{value: msg.value}(msg.sender);
    }
}