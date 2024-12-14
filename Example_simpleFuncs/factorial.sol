//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract MyContract {    
	function factorial(uint _symbol) public pure returns (uint result){
        uint solution = 1;
        for (uint i = 1; i <= _symbol; ++i)
            solution = solution * i;
        return solution;
    }
} 