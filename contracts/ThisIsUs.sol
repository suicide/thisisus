// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import { Base64 } from "@openzeppelin/contracts/utils/Base64.sol";


/// @title ThisIsUs NFT
/// @author suiiii
/// @notice Simple profile picture NFT for fun
contract ThisIsUs is ERC721 {

  struct TokenDetails {
    string name;
    string description;
    string fileName;
  }

  mapping(uint256 => TokenDetails) private _tokenDetails;
  string public baseUri;

  constructor(address to, string memory baseUri_)
    ERC721("ThisIsUs", "US") {

    baseUri = baseUri_;

    uint i = 0;

    _safeMint(to, i++, "All-Row", "All of Us in a row", "all-row.jpeg");
    _safeMint(to, i++, "All-Bed", "All of Us in bed", "all-bed.jpeg");
    _safeMint(to, i++, "All-Paws", "All of Us with paws", "all-paws.jpeg");
  }

  function _safeMint(address to, uint256 tokenId,
                     string memory name, string memory description,
                     string memory fileName)
                     internal virtual {
    super._safeMint(to, tokenId);

    _tokenDetails[tokenId] = TokenDetails(name, description, fileName);
  }


  /**
   * @dev See {IERC721Metadata-tokenURI}.
   */
  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    _requireMinted(tokenId);

    string memory baseURI = baseUri;
    TokenDetails memory details = _tokenDetails[tokenId];

    return string(abi.encodePacked('data:application/json;base64,', Base64.encode(abi.encodePacked(
      '{',
        '"name": "', details.name, '", ',
        '"description": "', details.description, '", ',
        '"image": "', baseURI, details.fileName, '"',
      '}'
      ))
    ));
  }
}
