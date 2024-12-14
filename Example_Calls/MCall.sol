//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
//  ["0x9a2E12340354d2532b4247da3704D2A5d73Bd189","0x9a2E12340354d2532b4247da3704D2A5d73Bd189"]
//  ["0xc47f0027000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000044a6f686e00000000000000000000000000000000000000000000000000000000","0x9ec06e69000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000064265747369650000000000000000000000000000000000000000000000000000"]
contract Person{
    string public name;
    string public surname;

    function setName(string memory _name) public {
        name = _name;
    }

    function setSurname(string memory _surname) public {
        surname = _surname;
    }

    function getName() external view returns (string memory){
        return name;
    }

    function getSurname() external view returns (string memory){
        return surname;
    }

    function encGetName() external pure returns (bytes memory){
        return abi.encodeWithSelector(this.getName.selector);
    }

    function encGetSurname() external pure returns (bytes memory){
        return abi.encodeWithSelector(this.getSurname.selector);
    }    
}

contract Caller{
    function multiCall(address[] calldata targets, bytes[] calldata data) public view returns (string[] memory) {
        require(targets.length == data.length, "invalid targets/data");
        string[] memory results = new string[](targets.length);
   
        for (uint i; i < targets.length; ++i){
            (bool result,bytes memory tmp) = targets[i].staticcall(data[i]);
            require(result,"tx failed");
            results[i] = abi.decode(tmp, (string));
        }

        return results;
    }
    function multiCallTx(address[] calldata targets, bytes[] calldata data) public{
        require(targets.length == data.length, "invalid targets/data");

        for (uint i; i < targets.length; ++i){
            (bool result,) = targets[i].call(data[i]);
            require(result,"tx failed");
        }
    }

    function encode(string calldata _func, string calldata _arg) public pure returns(bytes memory) {
        return abi.encodeWithSignature(
            _func,_arg
        );
    } 
}