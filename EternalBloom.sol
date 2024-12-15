
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EternalBloom is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;
    mapping(uint256 => uint256) public phase; // Tracks evolution phase of each token

    event NFTMinted(address indexed recipient, uint256 indexed tokenId, uint256 phase, string tokenURI);
    event NFTEvolved(uint256 indexed tokenId, uint256 newPhase, string newTokenURI);

    constructor() ERC721("The Eternal Bloom", "BLOOM") {
        tokenCounter = 0;
    }

    function mintNFT(address recipient, string memory initialURI) public onlyOwner {
        uint256 newTokenId = tokenCounter;
        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, initialURI);
        phase[newTokenId] = 1;
        tokenCounter += 1;

        emit NFTMinted(recipient, newTokenId, 1, initialURI);
    }

    function evolveNFT(uint256 tokenId, string memory newURI) public onlyOwner {
        require(_exists(tokenId), "Token does not exist");
        require(bytes(newURI).length > 0, "New URI must not be empty");

        phase[tokenId] += 1;
        _setTokenURI(tokenId, newURI);

        emit NFTEvolved(tokenId, phase[tokenId], newURI);
    }

    function getPhase(uint256 tokenId) public view returns (uint256) {
        require(_exists(tokenId), "Token does not exist");
        return phase[tokenId];
    }
}
