// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Ruleta is VRFConsumerBaseV2 {

    uint64 idSuscripcion = 2906; // Obtener el id desde chainlink

    VRFCoordinatorV2Interface contratoCoordinator = VRFCoordinatorV2Interface(0x6168499c0cFfCaCD319c818142124B7A15E857ab);
    bytes32 keyHash = 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;

    uint32 gasLimit = 1000000;
    uint16 confirmaciones = 3;
    uint32 cantidadNumeros = 5;

    uint[] public numerosSorteados;
    uint public request_id;
    address owner;

    constructor() VRFConsumerBaseV2(address(contratoCoordinator)) {
        owner = msg.sender;
    }

    function pedirSorteo() external onlyOwner {
        request_id = contratoCoordinator.requestRandomWords(
            keyHash,
            idSuscripcion,
            confirmaciones,
            gasLimit,
            cantidadNumeros
        );
    }

    function fulfillRandomWords(uint _request_id, uint[] memory _numerosAleatorios) internal override {
        numerosSorteados = _numerosAleatorios;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

}