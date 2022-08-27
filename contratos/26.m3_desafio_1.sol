// Refactor del codigo:
// contract Storage { int256 NumBer; function Store( uint256 NUM ) public {NumBer=NUM ;}
// function retrieve() private view returns ( uint256 ){ return NumBer; } }

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Storage { 
    uint NumBer;

    function Store( uint NUM ) public {
        NumBer = NUM;
    }

    function retrieve() private view returns ( uint256 ){
        return NumBer;
    } 
}