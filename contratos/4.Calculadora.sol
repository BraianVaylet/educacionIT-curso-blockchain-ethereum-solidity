// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Calculadora {

    // pure: funciones puras
    // - es de solo lectura y no usa ninguna variable del contrato (o nada relacionado al contrato).
    // - son mas liviandas que las views (optimiza el contrato).
    function sumar(uint num1, uint num2) public pure returns(uint) {
        return (num1 + num2);
    }
    
    function restar(uint num1, uint num2) public pure returns(uint) {
        return (num1 - num2);
    }

    function producto(uint num1, uint num2) public pure returns(uint) {
        return (num1 * num2);
    }

    function dividir(uint num1, uint num2) public pure returns(uint) {
        require(num2 != 0);       
        return (num1 / num2);        
    }
}