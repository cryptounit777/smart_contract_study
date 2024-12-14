//SPDX-License-Identifier: GPL-3.0 
pragma solidity ^0.8.0;

contract ENS {
    struct nameInfo {
        address userAddress;
        uint purchaseTime;
        uint namePrice;
        uint rentUntil;  
    }
    
    address owner;
    uint public annualCost;
    uint public discountCoef;
    mapping (address => string) addressMap;
    mapping (string => nameInfo) nameMap;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(msg.sender == owner, "Not an owner!");
        _;
    }
    modifier checkTime(uint _yearsOfRent) {
        require(_yearsOfRent >= 1 && _yearsOfRent <= 10, "Wrong rental time!");
        _;
    }
    
    function setAnnualCost(uint _annualCost) public isOwner{
        annualCost = _annualCost;
    }

    function setDiscountCoef(uint _discountCoef) public isOwner{
        discountCoef = _discountCoef;
    }

    function  extendRent(string memory _name, uint _yearsOfExtension) public checkTime(_yearsOfExtension) payable {
        require(nameMap[_name].userAddress == msg.sender && nameMap[_name].rentUntil >= block.timestamp, "Not domain owner!");
        require(msg.value == _yearsOfExtension * annualCost * discountCoef);
        nameMap[_name].rentUntil += _yearsOfExtension * 365 * 60 * 60 * 24;
    }

    function buyName(string memory _name, uint _yearsOfRent) public checkTime(_yearsOfRent) payable  {
        require(nameMap[_name].rentUntil <= block.timestamp, "Domain is busy");
        require(msg.value == _yearsOfRent * annualCost, "Wrong value!");
        uint _rentUntil = block.timestamp + _yearsOfRent * 365 * 60 * 60 * 24;
        addressMap[msg.sender] = _name;
        nameMap[_name] = nameInfo(msg.sender,block.timestamp,msg.value,_rentUntil);
    }

    function getAddr(string memory _name) public view returns (address) {
        return nameMap[_name].userAddress;
    }

    function withdrawFunds() public isOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}