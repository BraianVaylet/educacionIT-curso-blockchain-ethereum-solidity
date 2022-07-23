// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./11_Padre.sol";

contract LlamadorHijos {

    function verHijo(address direccionHijo) external returns (string memory) {
        Padre hijo = Padre(direccionHijo);
        return hijo.mostrarDatos();
    }
}