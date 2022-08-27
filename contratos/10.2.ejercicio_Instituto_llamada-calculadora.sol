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

    using SafeMath for uint;
    
    address _owner;        

    mapping (address => uint[]) Notas;
    
    event NotaCargada(address alumno, uint nota, string mensaje);

    constructor() {
        _owner = msg.sender;
    }

    function llamarSumCalculadora(address contrato, uint num1, uint num2) private returns(uint) {
        (bool resultado, bytes memory respuesta) = contrato.call(abi.encodeWithSignature("sumar(uint256, uint256)",num1, num2));
        return abi.decode(respuesta, (uint));
    }

    function cargaDeNota(address alumno, uint nota) NotaValida(nota) public UnicamenteInstituto {         
        Notas[alumno].push(nota);
        emit NotaCargada(alumno, nota, "Se cargo una nota a un alumno");
    }

    function notasDeAlumno(address alumno) public view UnicamenteAlumnoInstituto(alumno) returns (address, uint[] memory notas) {        
        return (
            alumno, 
            Notas[alumno]
        );
    }

    function promedioDeAlumno(address alumno) public UnicamenteAlumnoInstituto(alumno) returns (address, uint notas) {       
        uint sum;
        for (uint i = 0; i < Notas[alumno].length; i++) {
            // sum = sum +  Notas[alumno][i];
            sum = llamarSumCalculadora(0x3328358128832A260C76A4141e19E2A943CD4B6D, sum, Notas[alumno][i]);
        }
        return (
            alumno, 
            sum / Notas[alumno].length
        );
    }

    function notasDeAlumnoSinPermisos(address alumno) public view returns (address, uint[] memory notas) {        
        return (
            alumno, 
            Notas[alumno]
        );
    }

    function promedioDeAlumnoSinPermisos(address alumno) public view returns (address, uint notas) {       
        uint sum;
        for (uint i = 0; i < Notas[alumno].length; i++) {
            sum = sum +  Notas[alumno][i];
        }
        return (
            alumno, 
            sum / Notas[alumno].length
        );
    }   

    // Usando SafeMath
    function SafeMath_promedioDeAlumno(address alumno) public view UnicamenteAlumnoInstituto(alumno) returns (address, uint notas) {        
        uint sum;
        for (uint i = 0; i < Notas[alumno].length; i++) {
            sum = sum.add(Notas[alumno][i]);
        }        
        return (
            alumno, 
            sum.div(Notas[alumno].length)
        );
    }
    
    // Validaciones
    modifier UnicamenteInstituto {
        require(_owner == msg.sender, "No tienes permisos de administrador");
        _;
    }

    modifier UnicamenteAlumnoInstituto(address alumno) {
        require(alumno == msg.sender || _owner == msg.sender, "No tienes permisos suficientes");
        _;
    }

    modifier NotaValida(uint nota) {
        require(nota >= 0 && nota <= 10, "La nota ingresada es incorrecta");
        _;
    }
}