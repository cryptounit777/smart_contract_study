// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract NoMore {
    address[] bigAdrArr;
    address owner;
    constructor() {
        owner = msg.sender;
    }
    function addrChecker(address[100] memory _adrArr) public {
        for (uint i = 0; i <= _adrArr.length; ++i) {
            if (_adrArr[i].balance > 3 ether)
                bigAdrArr.push(_adrArr[i]);
            if (bigAdrArr.length > 30 && msg.sender == owner)
                break;
        }
    } 
}  