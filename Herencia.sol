// SPDX-License-Identifier: GPL-3.0

// Ejercicio:
// Definir un molde de una figura geometrica generica usando contractos abstracos o interfaces
// Modelar perimetro y superficie.
// Hacer al menos 2 figuras.
// Poder hacer deploy de una figura geometrica, calcular su perimetro y superficie.

pragma solidity >=0.7.0 <0.9.0;

interface iGeometric {
    function getPerimeter() external view returns (uint256);

    function getArea() external view returns (uint256);
}

contract Circle is iGeometric {
    uint256 private _radio;

    function setRadio(uint256 radio) external {
        _radio = radio;
    }

    function getRadio() external view returns (uint256 radio) {
        return _radio;
    }

    // p = 2*pi*radio
    function getPerimeter() external view override withRadio returns (uint256) {
        uint256 _pi = 314159;
        return (2 * _pi * _radio) / 100000;
    }

    // a = pi*radio^2
    function getArea() external view override withRadio returns (uint256) {
        uint256 _pi = 314159;
        return (_pi * (_radio * _radio)) / 100000;
    }

    modifier withRadio() {
        require(_radio > 0, "No information loaded");
        _;
    }
}

contract Square is iGeometric {
    uint256 private _side;

    function setSide(uint256 side) external {
        _side = side;
    }

    function getSide() external view returns (uint256 side) {
        return _side;
    }

    // p = 4*side
    function getPerimeter() external view override withRadio returns (uint256) {
        return 4 * _side;
    }

    // a = side^2
    function getArea() external view override withRadio returns (uint256) {
        return _side * _side;
    }

    modifier withRadio() {
        require(_side > 0, "No information loaded");
        _;
    }
}

contract RightTriangle is iGeometric {
    using myMath for uint256;

    uint256 private _base;
    uint256 private _height;

    function setData(uint256 base, uint256 height) external {
        _base = base;
        _height = height;
    }

    function getData() external view returns (uint256 base, uint256 height) {
        return (_base, _height);
    }

    // p = x + y + h
    function getPerimeter() external view override withData returns (uint256) {
        uint256 hip = myMath.sqrt((_base * _base) + (_height * _height));
        return _base + _height + hip;
    }

    // a = (b*h)/2
    function getArea() external view override withData returns (uint256) {
        return (_base * _height) / 2;
    }

    modifier withData() {
        require(_base > 0 && _height > 0, "No information loaded");
        _;
    }
}

library myMath {
    // babylonian method
    function sqrt(uint256 y) internal pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
}
