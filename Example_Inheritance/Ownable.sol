// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Ownable{
    address owner;
    constructor(address _owner){
        owner = _owner;
    }
    modifier onlyOwner {
        require(msg.sender == owner, "Not an owner!");
        _;
    }

    function getOwner() public view returns (address){
        return owner;
    }
}