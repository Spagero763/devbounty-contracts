// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReputationClaim {
    address public owner;
    mapping(address => bool) public hasClaimed;
    mapping(bytes32 => address) public castClaims;

    event ReputationClaimed(address indexed user, bytes32 indexed castHash);

    constructor() {
        owner = msg.sender;
    }

    function claimReputation(bytes32 castHash) external {
        require(!hasClaimed[msg.sender], "Already claimed");
        require(castClaims[castHash] == address(0), "Cast already claimed");

        hasClaimed[msg.sender] = true;
        castClaims[castHash] = msg.sender;

        emit ReputationClaimed(msg.sender, castHash);
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}
