// SPDX-License-Identifier: GPL-3.0

// Ejercicio:
// ==========
// Crear contrato para un instituto con sus alumnos y sus notas.
// - alumnos identificados por su address.
// - alumno puede ver su promedio.
// - solo el instituto puede agregarle una nota.
// - opcional: otros alumnos podran ver la nota de un compañero
// usar arrays, modificadores, requires, etc

// ---------------------------------------------------------------------------
//  ALUMNO |    ID                                            |      NOTA
// ---------------------------------------------------------------------------
//  Marcos |    0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2    |      5, 10, 3
//  Joan   |    0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db    |      9, 9, 9
//  Maria  |    0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB    |      2, 6, 7

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Instituto {
    using SafeMath for uint256;

    address _owner;

    mapping(address => uint256[]) Notas;

    event NotaCargada(address alumno, uint256 nota, string mensaje);

    constructor() {
        _owner = msg.sender;
    }

    function cargaDeNota(address alumno, uint256 nota)
        public
        NotaValida(nota)
        UnicamenteInstituto
    {
        Notas[alumno].push(nota);
        emit NotaCargada(alumno, nota, "Se cargo una nota a un alumno");
    }

    function notasDeAlumno(address alumno)
        public
        view
        UnicamenteAlumnoInstituto(alumno)
        returns (address, uint256[] memory notas)
    {
        return (alumno, Notas[alumno]);
    }

    function promedioDeAlumno(address alumno)
        public
        view
        UnicamenteAlumnoInstituto(alumno)
        returns (address, uint256 notas)
    {
        uint256 sum;
        for (uint256 i = 0; i < Notas[alumno].length; i++) {
            sum = sum + Notas[alumno][i];
        }
        return (alumno, sum / Notas[alumno].length);
    }

    function notasDeAlumnoSinPermisos(address alumno)
        public
        view
        returns (address, uint256[] memory notas)
    {
        return (alumno, Notas[alumno]);
    }

    function promedioDeAlumnoSinPermisos(address alumno)
        public
        view
        returns (address, uint256 notas)
    {
        uint256 sum;
        for (uint256 i = 0; i < Notas[alumno].length; i++) {
            sum = sum + Notas[alumno][i];
        }
        return (alumno, sum / Notas[alumno].length);
    }

    // Usando SafeMath
    function SafeMath_promedioDeAlumno(address alumno)
        public
        view
        UnicamenteAlumnoInstituto(alumno)
        returns (address, uint256 notas)
    {
        uint256 sum;
        for (uint256 i = 0; i < Notas[alumno].length; i++) {
            sum = sum.add(Notas[alumno][i]);
        }
        return (alumno, sum.div(Notas[alumno].length));
    }

    // Validaciones
    modifier UnicamenteInstituto() {
        require(_owner == msg.sender, "No tienes permisos de administrador");
        _;
    }

    modifier UnicamenteAlumnoInstituto(address alumno) {
        require(
            alumno == msg.sender || _owner == msg.sender,
            "No tienes permisos suficientes"
        );
        _;
    }

    modifier NotaValida(uint256 nota) {
        require(nota >= 0 && nota <= 10, "La nota ingresada es incorrecta");
        _;
    }
}
