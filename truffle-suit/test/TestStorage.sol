// Tests con Solidity

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "../contracts/Storage.sol";
import "truffle/Assert.sol";

contract TestStorage {
  
  function testInitialValueIsZero() public {
    Storage contrato = new Storage();
    Assert.equal(0, contrato.retrieve(), "El valor inicial del contrato no es 0");
  }

  function testStoreNewValue() public {
    Storage contrato = new Storage();    
    contrato.store(100);
    Assert.equal(100, contrato.retrieve(), "El valor almacenado no es 100");
  }
}