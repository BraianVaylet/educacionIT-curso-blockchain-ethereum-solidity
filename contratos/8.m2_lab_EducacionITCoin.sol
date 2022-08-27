// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EducacionITCoin {

    uint private _emision;
    address private _creador;

    mapping(address => uint) private _balances;
    
    constructor(uint emision) {        
        _emision = emision;
        _creador = msg.sender;
        _balances[_creador] = emision;
    }

    function enviarFondos(address destino, uint fondo) external soloCreador {
        _balances[_creador] = _balances[_creador] - fondo;
        _balances[destino] = fondo;
    }

    modifier soloCreador() {
        require(msg.sender == _creador, "No tienes permisos para realizar esta accion");
        _;
    }
}