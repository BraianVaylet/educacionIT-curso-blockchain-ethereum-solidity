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
        uint256 value;
    }

    Offer lastUser;
    uint256 auctionClosing;
    string message;

    mapping(address => uint256) lastOffer;

    constructor() {
        auctionClosing = block.timestamp + 60 seconds;
    }

    function setOffer(uint256 value)
        public
        subastaActiva
        unicaOferta
        mayorOferta(value)
    {
        lastUser.user = msg.sender;
        lastUser.value = value;
        lastOffer[msg.sender] = block.timestamp;
        message = "Realizaste una ofertar.";
    }

    function getOffer()
        public
        view
        returns (
            address,
            uint256,
            uint256,
            string memory
        )
    {
        return (
            lastUser.user,
            lastUser.value,
            lastOffer[lastUser.user],
            message
        );
    }

    // podemos tener mas de un requirer, el _ puede estar en cualquier lugar, al inicio, al final o en el medio.
    modifier subastaActiva() {
        // Tiempo límite 1 min.
        // los require combinan un if con un revert en una linea (no se pueden anidar)
        require(block.timestamp <= auctionClosing, "La subasta termino.");
        _;
    }

    modifier unicaOferta() {
        // Una oferta por usuario.
        require(lastUser.user != msg.sender, "No puedes volver a ofertar.");
        _; // en que momento de la funcion voy a ejecutar el codigo de la funcion.
    }

    modifier mayorOferta(uint256 value) {
        // Solo guardo la mayor oferta.
        require(lastUser.value < value, "No superaste la mejor oferta.");
        _;
    }
}
