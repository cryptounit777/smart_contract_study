//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Encode {
    function doHash(string memory str1, uint int1) public pure returns(bytes32) {
        return keccak256(doEncode(str1, int1));
    }

    function doEncode(string memory str1, uint int1) public pure returns(bytes memory){
        bytes memory res1 = abi.encode(str1, int1);
        //abibytes memory res2 = abi.encodePacked(str1, int1);
        return res1;
    } 
}