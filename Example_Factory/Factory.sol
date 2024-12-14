// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract RecordStorage is Ownable(msg.sender){
    address owner;
    bytes32[] public records;
    mapping (address => bool) public factories;

    function addRecord(bytes32 _record) public {
        require (factories[msg.sender] == true, "Not in factories!");
        records.push(_record);
    }

    function addFactory(address _addrFactory) public onlyOwner {
        factories[_addrFactory] = true;
    }
}

abstract contract FactoryParent{
    address  addressRecordStorage;

    constructor (address _addressRecordStorage) {
        addressRecordStorage = _addressRecordStorage;
    }

    function onRecordAdding() internal virtual;

}

contract AddressFactory is FactoryParent {
    
}

abstract contract RecordParent {
    uint256 public immutable timeOfCreation;
    constructor (uint256 _timeOfCreation){
        timeOfCreation = _timeOfCreation;
    }
    function getRecordType() external view virtual returns (string memory);

}

contract AddressRecord is RecordParent{
    address public record;

    constructor(address _record) RecordParent(block.timestamp) {
        record = _record;
    }
    
    function getRecordType() external pure override returns (string memory){
        return "address";
    }

    function setRecord(address _addr) public {
        record = _addr;
    }

}

contract StringRecord is RecordParent{
    string public record;

    constructor(string memory _record) RecordParent(block.timestamp) {
        record = _record;
    }
    
    function getRecordType() external pure override returns (string memory){
        return "string";
    }

    function setRecord(string calldata _str) public {
        record = _str;
    }
}

contract EnsRecord is RecordParent{
    string public domain;
    address public owner;

    constructor(string memory _domain, address _owner) RecordParent(block.timestamp) {
        domain = _domain;
        owner = _owner;
    }
    
    function getRecordType() external pure override returns (string memory){
        return "ens";
    }

    function setOwner(address _owner) public {
        owner = _owner;
    }
}