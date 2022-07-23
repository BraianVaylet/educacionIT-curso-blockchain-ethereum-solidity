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

    function setOffer(uint value) external {
        // Tiempo límite 1 min.
        if (block.timestamp <= auctionClosing) {
            // Una oferta por usuario.
            if (lastUser.user != msg.sender ) {
                // Solo guardo la mayor oferta.
                if (lastUser.value < value) {
                    lastUser.user = msg.sender;
                    lastUser.value = value;            
                    lastOffer[msg.sender] = block.timestamp;
                    message = "Realizaste una ofertar.";                
                } else {
                    message = "No superaste la mejor oferta.";
                }
            } else {
                message = "No puedes volver a ofertar.";
            }
        } else {
            message = "La subasta termino.";
        }          
    }
    
    function getOffer() external view returns(address, uint, uint, string memory) {
        return (
            lastUser.user,
            lastUser.value,
            lastOffer[lastUser.user],
            message
        );
    }
}