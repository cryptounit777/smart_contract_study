//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MyContract {    
    uint[] _counter;
    function counter() public returns (uint){
    for(uint8 i = 48; i <= 203; i++) 
      if(i % 5 == 0) 
        _counter.push(i);

    return _counter.length;
  } 
} 