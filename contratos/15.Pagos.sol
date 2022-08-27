// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Pagos {
    // Enviar ETH

    // OPC1: 
    // la mas moderna y segura, evolucion de send.
    // tiene gas limit de 2300 (para la seguridad del usuario)
    function enviarTransfer(address destino, uint monto) external {
        payable(destino).transfer(monto);
    }
    
    // OPC2: 
    // tanto send como transfer vienen de payable a partir de la v6 para reemplazar al call.
    // tiene gas limit de 2300
    function enviarSend(address destino, uint monto) external {
        bool funciono = payable(destino).send(monto);
        require(funciono);
    }

    // OPC3
    // no tiene gas limit, se le puede setear.
    // es mas recomendable que las nuevas formas transfer y send.
    function enviarCall(address destino, uint monto) external {
        (bool funciono, ) = destino.call{value: monto}("");
        require(funciono);
    }

    // Recibir ETH
    // Los contratos no saben como recibir eth.
    // Para esto se usa la funcion receive() que es externa y payable. Esta se ejecuta cuando se le manda eth al contrato.
    // La funcion

    mapping(address => uint) balances; 
    string public dondeEntro;

    // Para el caso de pagos que llegan sin parametros.
    receive() external payable {
        balances[msg.sender] += msg.value; // mapeo cuanto eth ingreso cada usuario.
        dondeEntro = "receive";
    }

    // Para el caso de pagos que vienen con parametros.    
    fallback() external payable {
        balances[msg.sender] += msg.value; // mapeo cuanto eth ingreso cada usuario.
        dondeEntro = "fallback";
    }

    // por medio de una funcion.
    function recibirEthers() external payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value; // mapeo cuanto eth ingreso cada usuario.
        dondeEntro = "funcion";
    }

    // Casos bordes:
    // Si tengo fallback y receive, fallback recive las que no tiene parametros y fallback los que si
    // Si tengo solo fallback y no receive, fallback suplanta a receive que recive todas los pagos con y sin parametros.
    // Si tengo solo receive y no fallback, receive solo recive pagos sin parametros y los que tienen no puedo recibirlos.


}