// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract LlamadorGenerico {

    // Contra: tengo que pagar gas, es mas complejo.
    // Pros: no necesito conocer la estructura del contrato. Solo necesito la direccion del contrato y el nombre y los parametros de la funcion.
    function verPerimetro(address direccionFigura, string memory action) external returns (uint) {
        (bool funciono, bytes memory resultado) = direccionFigura.call(abi.encodeWithSignature(action));
        require(funciono);
        uint salida = abi.decode(resultado, (uint));
        return salida;
    }
}