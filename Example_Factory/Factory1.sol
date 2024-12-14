// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract RecordFactory{
    address owner;
    bytes[] public records;

    function addRecord(address _record) external {
        AddressRecord _AddressRecord = new AddressRecord(_record);
        records.push(abi.encode(_record));
    }

    function addRecord(string calldata _record) external {
        StringRecord _StringRecord = new StringRecord(_record);
        records.push(abi.encode(_record));
    }
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