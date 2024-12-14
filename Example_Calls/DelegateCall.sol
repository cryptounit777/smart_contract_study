//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IDemo {
    function pay(address _payer) external payable;
}

contract DelegateCall{
    string public name = "John";
    uint256 public age = 30;
    mapping (address => uint) public payments;
    address public sender;

    function getBalance() public view returns (uint256){
        return address(this).balance;
    }

    function callPay(address _demo) external payable {
        (bool result,) = _demo.delegatecall(
            // abi.encodeWithSignature(
            //     "pay()"
            // )
            abi.encodeWithSelector(
                IDemo.pay.selector
            )
        );

        require (result, "False");
    }
}