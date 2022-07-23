// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {

    uint256 number;
    address owner;

    // Eventos
    // - Tienen costo de gas
    // - Quedan registrados en el nodo
    // - Podemos indexar hasta 3 valores para luego crear filtros. Usamos indexed
    event ModificacionValor (uint fecha, uint valorViejo, uint valorNuevo, address indexed usuario);

    constructor() {
        owner = msg.sender;
    }

    modifier validAccess {
        require(msg.sender ==  owner, "no tienes permisos para ejecutar la funcion store");
        _;
    }

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public validAccess {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}