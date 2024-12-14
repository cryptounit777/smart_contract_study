// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract RecordStorage is Ownable(msg.sender){
    bytes[] public records;
    mapping (address => bool) public factories;

    function addRecord(bytes memory _encodeRecord) external {
        require (factories[msg.sender] == true, "Not in factories!");
        records.push(_encodeRecord);
    }

    function addFactory(address _addrFactory) external onlyOwner {
        factories[_addrFactory] = true;
    }

    // function decodeAddrRecord(bytes memory data) public pure returns (address _record){
    //     (_record) = abi.decode(data,(address));
    // }
    // function decodeStringRecord(bytes memory data) public pure returns (string memory _record){
    //     (_record) = abi.decode(data,(string));
    // }

    // function decodeEnsRecord(bytes memory data) public pure returns (string memory _domain, address _owner){
    //     (_domain,_owner) = abi.decode(data,(string,address));
    // }
}

abstract contract FactoryParent{
    address addressRecordStorage;

    constructor (address _addressRecordStorage) {
        addressRecordStorage = _addressRecordStorage;
    }

    function onRecordAdding(address _addressRecordStorage, bytes memory _encodeRecord) internal {
        (bool result,) = _addressRecordStorage.call(
            abi.encodeWithSignature(
                "addRecord(bytes)",
                _encodeRecord
            )
        );
        require(result, "failed");
    }
}

contract AddressFactory is FactoryParent{
    constructor (address _addressRecordStorage) FactoryParent (_addressRecordStorage) {}

    function addRecord(address _record) external {
        AddressRecord _AddressRecord = new AddressRecord(_record);
        onRecordAdding(addressRecordStorage,abi.encode(_record));
    }
}

contract StringFactory is FactoryParent {
    constructor (address _addressRecordStorage) FactoryParent (_addressRecordStorage) {}

    function addRecord(string memory _record) external {
        StringRecord _StringRecord = new StringRecord(_record);
        onRecordAdding(addressRecordStorage,abi.encode(_record));
    }
}

contract EnsFactory is FactoryParent {
    constructor (address _addressRecordStorage) FactoryParent (_addressRecordStorage) {}

    function addRecord(string calldata _domain, address _owner) external {
        EnsRecord _EnsRecord = new EnsRecord(_domain,_owner);
        onRecordAdding(addressRecordStorage,abi.encode(_domain,_owner));
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

    function setRecord(address _addr) external {
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

    function setRecord(string calldata _str) external {
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

    function setOwner(address _owner) external {
        owner = _owner;
    }
}