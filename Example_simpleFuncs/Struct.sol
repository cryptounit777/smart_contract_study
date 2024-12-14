//SPDX-License-Identifier: GPL-3.0 
pragma solidity ^0.8.0;

contract MyContract {
  struct Friends {       
    string name;        
    bool invited;
    }
  Friends [] public listOfFriends ;
  Friends [] public guestList ;
  mapping (address => string) public myMap;
  while  myMap
  function addFriend(string memory _name, bool _invited) public {
    listOfFriends.push(Friends(_name,_invited));
  } 
}