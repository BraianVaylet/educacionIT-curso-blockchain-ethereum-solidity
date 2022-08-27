// const Storage = artifacts.require("Storage");
const LiderSeguro = artifacts.require("LiderSeguro");

module.exports = async function(callback) {
  // let contratoStorage = await Storage.deployed();
  // await contratoStorage.store(10);
  // console.log("Ejecuto ok!");
  

  let contratoLiderSeguro = await LiderSeguro.deployed();
  await contratoLiderSeguro.convertirseEnLider();
  console.log("Ejecuto ok!");
  
  callback();
}
