//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Sign {
    function vetify(address _signer, string memory _message, bytes memory _sig) external pure returns (bool){
        bytes32 msgHash = messageHash(_message);
        bytes32 signedMsgHash = ethSignedMessageHash(msgHash);
        // hash
        // hash with string "\x19Ethereum Signed Message:\n32"
        // call recover
        return recover(signedMsgHash, _sig) == _signer;
    }

    function messageHash(string memory _msg) public pure returns (bytes32){
        return keccak256(abi.encodePacked(_msg));
    }

    function ethSignedMessageHash(bytes32 _msgHash) public pure returns (bytes32){
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",_msgHash
            ));
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns(address){
        (bytes32 r,bytes32 s,uint8 v) = splitSig(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSig(bytes memory _sig) internal pure returns(bytes32 r,bytes32 s,uint8 v){
        require(_sig.length == 65, "invalid signature");
        assembly {
            r := mload(add(_sig,32))
            s := mload(add(_sig,64))
            v := byte(0, mload(add(_sig,96)))

        }
    }
}