// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import { Ownable } from "./Ownable.sol";

abstract contract UserSaver is Ownable {
    mapping (address => string) users;

    function receiveUsers(address _addr, string memory _name) public virtual;

    function saveUser(address _addr, string memory _name) internal{
        users[_addr] = _name;
    }

    function getUsersName(address _addr) public view onlyOwner returns (string memory) {
        return users[_addr];
    }
}

contract UserStorage is Ownable, UserSaver{
    constructor() Ownable(msg.sender) {}

    function receiveUsers(address _addr, string memory _name) public override {
        super.saveUser(_addr,_name);
        emit UserStoder(_addr, _name);
    }

    event UserStoder(address _addr, string _name);
}