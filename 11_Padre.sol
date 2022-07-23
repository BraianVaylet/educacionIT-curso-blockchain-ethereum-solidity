// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Padre {
    string private nombre;

    constructor(string memory _nombre) {
        nombre = _nombre;
    }

    function mostrarDatos() public virtual returns(string memory) {
        return nombre;
    }
}

contract Hijo is Padre {
    string apellido;

    constructor (string memory _nombre, string memory _apellido) Padre(_nombre) {
        apellido = _apellido;
    }

    function mostrarDatos() public override returns(string memory) {
        string memory llamadaPadre = super.mostrarDatos();
        string memory temporal = (string)(abi.encodePacked(llamadaPadre, " ", apellido));
        
        return temporal;
    }
}