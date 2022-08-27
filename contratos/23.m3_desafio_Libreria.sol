// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

library SimpleMath {
    function esPar(int value) internal pure returns(bool) {
        int result = value % 2;        
        return result == 0;
    }
}

contract Par {
    using SimpleMath for uint;

    function esPar(int value) external pure returns(bool) {
        return SimpleMath.esPar(value);
    }
}