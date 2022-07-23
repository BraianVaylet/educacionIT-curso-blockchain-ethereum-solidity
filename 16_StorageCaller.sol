// Usar el contrato de Storage por defecto
// hacer un llamador de Storage con call.

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract StorageCaller {

    function handleStore(address addressContract, uint value) external {
        (bool status, ) = addressContract.call(abi.encodeWithSignature("store(uint256)", value));
        require(status, "Error");              
    }

    function handleRetrieve(address addressContract) external returns (uint) {
        (bool status, bytes memory value) = addressContract.call(abi.encodeWithSignature("retrieve()"));
        require(status, "Error");
        return abi.decode(value, (uint));        
    }
}