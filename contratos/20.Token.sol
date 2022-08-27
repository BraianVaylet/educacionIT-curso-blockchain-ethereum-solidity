// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenCredit is ERC20("Token Credit", "TC") {
    uint cotizacionTokenEth;

    constructor(uint cotizacion) {
        cotizacionTokenEth = cotizacion;
    }

    receive() external payable {
        require(msg.value > 0, "El valor debe ser mayor a 0");
        _mint(msg.sender, msg.value * cotizacionTokenEth);
    }

    function retirarEth(uint monto) external {
        require(balanceOf(msg.sender) >= monto, "Balance insuficiente");
        _burn(msg.sender, monto * cotizacionTokenEth);
        (bool resultado, ) = msg.sender.call{value: monto}("");
        require(resultado);
    }
}