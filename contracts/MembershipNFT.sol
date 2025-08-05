// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MembershipNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    uint256 public mintPrice = 0.001 ether;

    constructor() ERC721("Spagero Membership Pass", "SMP") Ownable(msg.sender) {}

    /// @notice Owner can mint to any address (e.g., for giveaways or rewards)
    function ownerMint(address to, string memory tokenURI) external onlyOwner {
        _safeMint(to, nextTokenId);
        _setTokenURI(nextTokenId, tokenURI);
        nextTokenId++;
    }

    /// @notice Public minting with token URI and optional fee
    function publicMint(string memory tokenURI) external payable {
        require(msg.value >= mintPrice, "Insufficient ETH sent");

        _safeMint(msg.sender, nextTokenId);
        _setTokenURI(nextTokenId, tokenURI);
        nextTokenId++;
    }

    /// @notice Withdraw funds collected from public minting
    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    /// @notice Owner can set or update the mint price
    function setMintPrice(uint256 newPrice) external onlyOwner {
        mintPrice = newPrice;
    }

    receive() external payable {}
}
