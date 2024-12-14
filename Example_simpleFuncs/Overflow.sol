// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.8.0;

contract Overflow {
  uint8 public myUint8;

  function setMyUint(uint8 _newVal) public {
    myUint8 = _newVal;
  }

  function increment() public {
      myUint8++;
  }
}