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
    uint public discountCoefinPercent;
    mapping (string => nameInfo) nameMap;

    fallback() external payable { }
    receive() external payable { }  
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
    modifier DomainOwner(string calldata _name){
        require(nameMap[_name].userAddress == msg.sender && isBusy(_name), "Not domain owner!");
        _;
    }

    function isBusy(string calldata _name) internal view returns (bool){
        return nameMap[_name].rentUntil >= block.timestamp;
    }
    function yearsToSec(uint _years) internal pure returns (uint) {
        return _years * 365 * 60 * 60 * 24;
    }

    function setAnnualCost(uint _annualCost) public isOwner{
        annualCost = _annualCost;
    }
    function setDiscountCoef(uint _discountCoefinPercent) public isOwner{
        discountCoefinPercent = _discountCoefinPercent;
    }

    function  extendRent(string calldata _name, uint _yearsOfExtension) public checkTime(_yearsOfExtension) DomainOwner(_name) payable {
        require(msg.value == _yearsOfExtension * annualCost * (100 - discountCoefinPercent) / 100, "Wrong value!");
        nameMap[_name].rentUntil += yearsToSec(_yearsOfExtension);
    }
    function buyName(string calldata _name, uint _yearsOfRent) public checkTime(_yearsOfRent) payable  {
        if (isBusy(_name))
            revert("Domain is busy!");
        require(msg.value == _yearsOfRent * annualCost, "Wrong value!");
        uint _rentUntil = block.timestamp + yearsToSec(_yearsOfRent);
        nameMap[_name] = nameInfo(msg.sender,block.timestamp,msg.value,_rentUntil);
    }

    function getAddr(string calldata _name) external view returns (address) {
        return nameMap[_name].userAddress;
    }
    function withdrawFunds() external payable isOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}