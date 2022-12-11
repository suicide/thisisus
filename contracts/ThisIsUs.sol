// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/// @title ThisIsUs NFT
/// @author suiiii
/// @notice Simple profile picture NFT for fun
contract ThisIsUs is ERC721 {
    struct TokenDetails {
        string name;
        string description;
        string fileName;
    }

    event Destroyed (
      address indexed destroyer
    );

    mapping(uint256 => TokenDetails) private _tokenDetails;
    string public baseUri;
    address public admin;

    constructor(address to, string memory baseUri_) ERC721("This Is Us", "ThisIsUs") {
        baseUri = baseUri_;
        admin = msg.sender;

        uint i = 0;

        _safeMint(to, i++, "All-Row", "All of Us in a row", "all-row.png");
        _safeMint(to, i++, "All-Bed", "All of Us chill in bed", "all-bed.png");
        _safeMint(to, i++, "All-Paws", "All of Us just meow", "all-meow.png");
        _safeMint(to, i++, "Fan", "Fanny!", "fan.png");
        _safeMint(to, i++, "Patrick", "Patrick!", "patrick.png");
        _safeMint(to, i++, "Taro", "Taroll!", "taro.png");
    }

    function _safeMint(
        address to,
        uint256 tokenId,
        string memory name,
        string memory description,
        string memory fileName
    ) internal virtual {
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

        /* solhint-disable quotes */
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        abi.encodePacked(
                            "{",
                            '"name": "',
                            details.name,
                            '", ',
                            '"description": "',
                            details.description,
                            '", ',
                            '"image": "',
                            baseURI,
                            details.fileName,
                            '"',
                            "}"
                        )
                    )
                )
            );
        /* solhint-enable quotes */
    }

    function destroy() public {
      require(msg.sender == admin, "not the admin");

      emit Destroyed(msg.sender);

      selfdestruct(payable(admin));
    }
}
