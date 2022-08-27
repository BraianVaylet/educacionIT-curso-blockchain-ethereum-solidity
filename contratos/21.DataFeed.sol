// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Goerli
// ETH a USD: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

contract DataFeed {

    AggregatorV3Interface contratoFeed;

    constructor() {
        contratoFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    }

    function obtenerETHaUSD() external view returns (int) {
        (, int resultado, , , ) = contratoFeed.latestRoundData();
        return resultado;
    }

}
