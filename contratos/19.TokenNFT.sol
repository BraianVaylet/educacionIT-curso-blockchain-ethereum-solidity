// SPDX-License-Identifier: MIT

// Crear un token NFT con OpenZepellin

// 1. Usar testnet de rinkeby
// 2. Probar en https://testnet.rarible.com/

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTGenerator is ERC721URIStorage {

    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;

    uint256 public maxSupply = 10; 
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: console; font-size: 20px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    
    constructor() ERC721("String NFT", "STR") {}
    
    function mintNFT(string memory str) public {        
        uint256 newItemId = _tokenIds.current();
        require(newItemId < maxSupply, "No NFTs left :(");

        string memory finalSvg = string(
            abi.encodePacked(baseSvg, str, "</text></svg>")
        );

        //> Obtengo metadatos JSON, se codifican en base64.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',                        
                        str,
                        '", "description": "Coleccion de STR NFTs.", "image": "data:image/svg+xml;base64,',
                        //> Agregamos data:image/svg+xml;base64 y luego agregamos nuestra codificación base64 a nuestro svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );        

        //> anteponemos data:application/json;base64 a nuestros datos.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );


        _safeMint(msg.sender, newItemId); //> Acuñamos NFT al remitente
        _setTokenURI(newItemId, finalTokenUri); //> Establece los datos de NFT.
        _tokenIds.increment();        
    }

    function getCurrentTotalNFTs() public view returns (uint256) {
        return _tokenIds.current();
    }

    function getTotalNFTs() public view returns (uint256) {
        return maxSupply;
    }
}

/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
    bytes internal constant TABLE =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(input, 0x3F))), 0xFF)
                )
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}