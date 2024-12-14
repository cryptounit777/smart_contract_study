// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";

contract LibDemo {
  function testConvert(uint num) public pure returns(string memory) {
    return Strings.toString(num);  
  }
}