
//SPDX-License-Identifier: GPL-3.0 
pragma solidity ^0.8.0;

contract MyContract {
  string [] public myList = ["abc", "bdf9", "wer85"];

  function getValue(uint _index) public view returns(string memory) {
    return myList[_index];
  }

    uint[] public items = [1,2,3,4,5];
  function checker() public view returns (bool){
    return items.length < 10;
  }
}