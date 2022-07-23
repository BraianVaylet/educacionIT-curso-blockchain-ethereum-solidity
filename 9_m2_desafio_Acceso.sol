// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Acceso {
    uint numero;
    address owner;
    
    constructor() {
        owner = tx.origin;
    }

    function guardarNumero(uint num) public {
        require(tx.origin == owner);
        numero = num;
    }

    // Ejercicio1
    modifier PositiveBalance() {
        require(msg.sender.balance > 0, "La cuenta no tiene saldo");
        _;
    }
}