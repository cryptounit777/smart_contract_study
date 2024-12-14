// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract RecordStorage is Ownable(msg.sender){
    bytes[] public records;
    // mapping (address => bool) public factories;

    function addRecord(bytes memory _packedrecord) public {
        //require (factories[msg.sender] == true, "Not in factories!");
        records.push(_packedrecord);
    }

    // function addFactory(address _addrFactory) external onlyOwner {
    //     factories[_addrFactory] = true;
    // }

    function testAdd(address _record) public {
        addRecord(abi.encode(_record));
    }

    function decodeRecord(bytes memory data) public returns (address _record){
        (_record) = abi.decode(data,(address));
    }

    // function encodeRecords(uint256 _num) external returns (address){
    //     return abi.encodeWithSignature(records[_num]);
    // }
}
