// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BountyEscrow {
    address public owner;
    uint256 public bountyIdCounter;

    struct Bounty {
        address funder;
        address hunter;
        uint256 amount;
        bool claimed;
    }

    mapping(uint256 => Bounty) public bounties;

    event BountyCreated(uint256 indexed bountyId, address indexed funder, uint256 amount);
    event BountyAssigned(uint256 indexed bountyId, address indexed hunter);
    event BountyClaimed(uint256 indexed bountyId, address indexed hunter);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice Fund a bounty with ETH
    function createBounty() external payable returns (uint256) {
        require(msg.value > 0, "No ETH sent");

        uint256 bountyId = bountyIdCounter++;
        bounties[bountyId] = Bounty({
            funder: msg.sender,
            hunter: address(0),
            amount: msg.value,
            claimed: false
        });

        emit BountyCreated(bountyId, msg.sender, msg.value);
        return bountyId;
    }

    /// @notice Owner assigns a hunter to the bounty
    function assignHunter(uint256 bountyId, address hunter) external onlyOwner {
        Bounty storage bounty = bounties[bountyId];
        require(bounty.hunter == address(0), "Hunter already assigned");
        require(!bounty.claimed, "Already claimed");

        bounty.hunter = hunter;

        emit BountyAssigned(bountyId, hunter);
    }

    /// @notice Hunter claims bounty once completed
    function claimBounty(uint256 bountyId) external {
        Bounty storage bounty = bounties[bountyId];
        require(msg.sender == bounty.hunter, "Not assigned hunter");
        require(!bounty.claimed, "Already claimed");

        bounty.claimed = true;
        payable(bounty.hunter).transfer(bounty.amount);

        emit BountyClaimed(bountyId, msg.sender);
    }

    /// @notice View bounty details
    function getBounty(uint256 bountyId) external view returns (address funder, address hunter, uint256 amount, bool claimed) {
        Bounty memory bounty = bounties[bountyId];
        return (bounty.funder, bounty.hunter, bounty.amount, bounty.claimed);
    }
}
