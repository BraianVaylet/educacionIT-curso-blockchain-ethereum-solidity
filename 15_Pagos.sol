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

}