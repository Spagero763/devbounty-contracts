// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LeaderboardManager {
    address public owner;

    struct Builder {
        string username;
        uint256 score;
    }

    mapping(address => Builder) public builders;
    address[] public builderAddresses;

    event BuilderUpdated(address indexed user, string username, uint256 newScore);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addOrUpdateBuilder(address user, string memory username, uint256 score) external onlyOwner {
        Builder storage b = builders[user];
        if (bytes(b.username).length == 0) {
            builderAddresses.push(user);
        }
        b.username = username;
        b.score = score;

        emit BuilderUpdated(user, username, score);
    }

    function getBuilder(address user) external view returns (string memory username, uint256 score) {
        Builder storage b = builders[user];
        return (b.username, b.score);
    }

    function getTopBuilder() external view returns (address user, string memory username, uint256 score) {
        uint256 highestScore = 0;
        address topBuilder;
        for (uint256 i = 0; i < builderAddresses.length; i++) {
            address current = builderAddresses[i];
            if (builders[current].score > highestScore) {
                highestScore = builders[current].score;
                topBuilder = current;
            }
        }
        if (topBuilder == address(0)) return (address(0), "", 0);
        Builder storage b = builders[topBuilder];
        return (topBuilder, b.username, b.score);
    }

    function getAllBuilders() external view returns (address[] memory, string[] memory, uint256[] memory) {
        uint256 len = builderAddresses.length;
        string[] memory usernames = new string[](len);
        uint256[] memory scores = new uint256[](len);

        for (uint256 i = 0; i < len; i++) {
            Builder storage b = builders[builderAddresses[i]];
            usernames[i] = b.username;
            scores[i] = b.score;
        }
        return (builderAddresses, usernames, scores);
    }
}
