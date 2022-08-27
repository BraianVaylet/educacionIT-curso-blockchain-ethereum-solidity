// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract API is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    bytes32 jobId;
    uint private comision;

    uint public respuestaOraculo;

    constructor() ConfirmedOwner(msg.sender) {
        setChainlinkToken(0x01BE23585060835E02B77ef475b0Cc51aA1e0709); // ERC20 de Link
        setChainlinkOracle(0xf3FBB7f3391F62C8fe53f89B41dFC8159EE9653f); // Oraculo / Intermediario

        jobId = "7d80a6386ef543a3abb52817f6707e3b"; // https://docs.chain.link/docs/any-api/testnet-oracles/#jobs
        comision = (1 * LINK_DIVISIBILITY) / 10;
    }

    function consultarValor() public returns(bytes32) {
        Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.obtenerRespuesta.selector);
        
        req.add("get", "https://swapi.dev/api/people/1?format=json");
        req.add("path","name");

        return sendChainlinkRequest(req, comision);

    }

    function obtenerRespuesta(bytes32 reqId, uint respuesta) public recordChainlinkFulfillment(reqId) {
        respuestaOraculo = respuesta;
    }



}