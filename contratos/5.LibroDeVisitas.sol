// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract LibroDeVisitas {

    struct Mensaje {
        address usuario;
        string mensaje;     
    }

    Mensaje ultimoMensaje;

    mapping(address => uint) ultimaFirma;

    function firmarLibro(string memory mensajeNuevo) public {
        // para que no se pueda firmar dos veces seguidas (esperar 1min)
        if (ultimaFirma[ultimoMensaje.usuario] < block.timestamp - 60 seconds) {
            ultimoMensaje.usuario = msg.sender;
            ultimoMensaje.mensaje = mensajeNuevo;            
        }
    }

    function firmarLibroPorUsuario(string memory mensajeNuevo) public {
        // el mismo usuario no puede firmar 2 veces seguidas
        if (ultimaFirma[msg.sender] < block.timestamp - 60 seconds) {
            ultimoMensaje.usuario = msg.sender;
            ultimoMensaje.mensaje = mensajeNuevo;            
            ultimaFirma[msg.sender] = block.timestamp;
        }
    }

    // memory: 
    // - Suele pasar con los struct, arrays, string que suelen pasarse del espacio de memoria.
    // - agregamos memory para guardar en memoria.
    // - lo suele pedir cuando se lo pasa como parametro o como retorno.
    function verFirma() public view returns(address, string memory, uint) {
        return (
            ultimoMensaje.usuario,
            ultimoMensaje.mensaje,
            ultimaFirma[ultimoMensaje.usuario]
        );
    }
}