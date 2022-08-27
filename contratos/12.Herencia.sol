// SPDX-License-Identifier: GPL-3.0

// Ejercicio:
// Definir un molde de una figura geometrica generica usando contractos abstracos o interfaces
// Modelar perimetro y superficie.
// Hacer al menos 2 figuras.
// Poder hacer deploy de una figura geometrica, calcular su perimetro y superficie.

pragma solidity >=0.7.0 <0.9.0;

interface iGeometric {
    function getPerimeter() external view returns(uint);
    function getArea() external view returns(uint);
}

contract Circle is iGeometric {

    uint private _radio;

    function setRadio(uint radio) external {
        _radio = radio;
    }

    function getRadio() external view returns(uint radio) {
        return _radio;
    }

    // p = 2*pi*radio
    function getPerimeter() withRadio external override view returns(uint) {
        uint _pi = 3;
        return 2 * _pi * _radio;
    }

    // a = pi*radio^2
    function getArea() withRadio external override view returns(uint) {
        uint _pi = 3;
        return _pi * (_radio * _radio);
    }

    modifier withRadio {
        require(_radio > 0, "No information loaded");
        _;
    }
}

contract Square is iGeometric {

    uint private _side;

    function setSide(uint side) external {
        _side = side;
    }

    function getSide() external view returns(uint side) {
        return _side;
    }

    // p = 4*side
    function getPerimeter() withRadio external override view returns(uint) {
        return 4 * _side;
    }

    // a = side^2
    function getArea() withRadio external override view returns(uint) {
        return _side * _side;
    }
    
    modifier withRadio {
        require(_side > 0, "No information loaded");
        _;
    }
}

contract RightTriangle is iGeometric {

    using myMath for uint;

    uint private _base;
    uint private _height;

    function setData(uint base, uint height) external {
        _base = base;
        _height = height;
    }

    function getData() external view returns(uint base, uint height) {
        return (
            _base,
            _height
        );
    }

    // p = x + y + h
    function getPerimeter() withData external override view returns(uint) {
        uint hip = myMath.sqrt((_base * _base) + (_height * _height));
        return _base + _height + hip;
    }

    // a = (b*h)/2
    function getArea() withData external override view returns(uint) {
        return (_base * _height) / 2;
    }

    modifier withData {
        require(_base > 0 && _height > 0, "No information loaded");
        _;
    }
}

library myMath {
    // babylonian method
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
}