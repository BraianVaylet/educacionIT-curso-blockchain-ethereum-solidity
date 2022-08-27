// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract RockPaperScissorsTokens is ERC1155 {
    uint256 public constant ROCK = 0;
    uint256 public constant PAPPER = 1;
    uint256 public constant SCISSOR = 2;
    
    constructor() ERC1155("") {
        _mint(msg.sender, ROCK, 100, "");
        _mint(msg.sender, PAPPER, 1000, "");
        _mint(msg.sender, SCISSOR, 1, "");
    }
}