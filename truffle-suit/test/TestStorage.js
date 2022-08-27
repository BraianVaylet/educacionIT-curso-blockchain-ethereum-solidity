// Tests con JavaScript

const Storage = artifacts.require("Storage");

contract("Storage", function(accounts) {
  it("El valor inicial del contrato es 0", async() => {
    let contrato = await Storage.new();
    assert.equal(0, await contrato.retrieve());
  })

  it("Almacenar un valor", async() => {
    let contrato = await Storage.new({from: accounts[2]});
    await contrato.store(10, {from: accounts[5]});
    assert.equal(10, await contrato.retrieve({from: accounts[2]}));
  });
})