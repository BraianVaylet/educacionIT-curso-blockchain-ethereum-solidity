// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

contract ContratoSolucionado {
    address public liderDelContrato;
    uint public apuestaMaxima;

    mapping (address => uint) transferenciasPendientes;

    constructor() payable {
        liderDelContrato = msg.sender;
        apuestaMaxima = msg.value;
    }

    function convertirseEnLider() public payable {
        require(msg.value > apuestaMaxima, "Monto insuficiente.");
        transferenciasPendientes[liderDelContrato] += msg.value;
        liderDelContrato = msg.sender;
        apuestaMaxima = msg.value;
    }

    function SaldarDeudas() public {
        uint monto = transferenciasPendientes[msg.sender];
        transferenciasPendientes[msg.sender] = 0;
        payable(msg.sender).transfer(monto);
    }
}