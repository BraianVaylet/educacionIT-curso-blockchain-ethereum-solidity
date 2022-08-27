// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

interface iCalculadora {
    function sumar(uint a, uint b) external returns (uint c);
}

contract Calculadora is iCalculadora {
    function sumar(uint value1, uint value2) public pure override returns(uint) {
        return value1 + value2;
    }
}

// Revisar porque no funciona!
contract MyContract {
    function llamarSuma(address addressContract, uint value1, uint value2) public returns (uint) {
        (bool valid, bytes memory result) = addressContract.call(abi.encodeWithSignature("sumar(uint, uint)", value1, value2));
        require(valid, "Algo fallo!");
        return abi.decode(result, (uint));        
    }
}