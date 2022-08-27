// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CajaAhorros {

    mapping(address => uint) balances; 

    receive() external payable {
        balances[msg.sender] += msg.value;
    }

    fallback() external payable {
        balances[msg.sender] += msg.value;
    }

    function recibirPago() external payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;       
    }

    function RetirarFondos (uint monto) external returns (uint _monto) {
        require(monto <= balances[msg.sender], "No tienes fondos suficientes.");
        (bool funciono, ) = msg.sender.call{value: monto}("");
        require(funciono, "Algo fallo!");
        balances[msg.sender] -= monto;
        return (monto);
    }

    function TransferirFondos (address destino, uint monto) external returns (address _destino, uint _monto) {
        require(monto <= balances[msg.sender], "No tienes fondos suficientes.");
        (bool funciono, ) = destino.call{value: monto}("");
        require(funciono, "Algo fallo!");
        balances[msg.sender] -= monto;
        return (destino, monto);
    }

    function verBalance() external view returns(uint total) {
        return balances[msg.sender];
    }

    function verBalanceContracto() external view {
        address(this).balance;
    }
  
}