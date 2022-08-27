// SPDX-License-Identifier: GPL-3.0

/**
 * Ejercicio:
 * ==========
 * Crear contrato de subasta conlas siguientes condiciones:
 * - Solo una oferta por usuario.
 * - La subasta dura solo 1 min.
 * - El usuario hace una subasta con un monto.
 */

pragma solidity >=0.7.0 <0.9.0;

contract Subasta {

    struct Offer {
        address user;
        uint value;     
    }

    Offer lastUser;
    uint auctionClosing;    
    string message;

    mapping(address => uint) lastOffer;

    constructor() {
        auctionClosing = block.timestamp + 60 seconds;
    }

    // podemos tener mas de un requirer, el _ puede estar en cualquier lugar, al inicio, al final o en el medio.
    modifier subastaActiva {
        // Tiempo límite 1 min.
        // los require combinan un if con un revert en una linea (no se pueden anidar)
        require(block.timestamp <= auctionClosing, "La subasta termino.");
        _;
    }

    modifier unicaOferta {
        // Una oferta por usuario.
        require(lastUser.user != msg.sender, "No puedes volver a ofertar.");
        _; // en que momento de la funcion voy a ejecutar el codigo de la funcion.
    }

    modifier mayorOferta(uint value) {
        // Solo guardo la mayor oferta.
        require(lastUser.value < value, "No superaste la mejor oferta.");
        _;
    }

    function setOffer(uint value) public subastaActiva unicaOferta mayorOferta(value) {                        
        lastUser.user = msg.sender;
        lastUser.value = value;            
        lastOffer[msg.sender] = block.timestamp;
        message = "Realizaste una ofertar.";                 
    }
    
    function getOffer() public view returns(address, uint, uint, string memory) {
        return (
            lastUser.user,
            lastUser.value,
            lastOffer[lastUser.user],
            message
        );
    }
}