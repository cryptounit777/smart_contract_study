// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Overflow { 
  uint8 public newNum;
  modifier LessThan(uint16 _num){
        require(_num < 256, "More than 2^8!");
        _;
    }


  function counter(uint8 _num) public LessThan(_num) returns(uint8) {
    newNum =  _num + 5;
    return newNum;  
  }
} 