// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract FixReentrancy {

    mapping(address => uint) balances;

   function retirar(uint monto) public {
        require(balances[msg.sender] >= monto);        
        msg.sender.call{value:monto}("");     
        balances[msg.sender] -= monto;
    } 

    function retirarFixOpc1(uint monto) public {
        require(balances[msg.sender] >= monto);        
        balances[msg.sender] -= monto;
        (bool status, ) = msg.sender.call{value:monto}("");
        if (!status) {
            balances[msg.sender] += monto;
        }
    } 

    function retirarFixOpc2(uint monto) public {
        require(balances[msg.sender] >= monto);        
        msg.sender.call{value:monto, gas: 10000}("");     
        balances[msg.sender] -= monto;
    } 
}