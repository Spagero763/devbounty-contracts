// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleGovernance {
    address public owner;
    uint256 public proposalCount;

    enum ProposalStatus { Active, Passed, Failed }

    struct Proposal {
        uint256 id;
        string description;
        uint256 yesVotes;
        uint256 noVotes;
        uint256 deadline;
        ProposalStatus status;
        mapping(address => bool) hasVoted;
    }

    mapping(uint256 => Proposal) private proposals;

    event ProposalCreated(uint256 indexed id, string description, uint256 deadline);
    event Voted(uint256 indexed proposalId, address voter, bool support);
    event ProposalFinalized(uint256 indexed proposalId, ProposalStatus result);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /// @notice Submit a proposal with a voting deadline (in seconds)
    function createProposal(string memory description, uint256 duration) external onlyOwner {
        uint256 proposalId = proposalCount++;
        Proposal storage p = proposals[proposalId];
        p.id = proposalId;
        p.description = description;
        p.deadline = block.timestamp + duration;
        p.status = ProposalStatus.Active;

        emit ProposalCreated(proposalId, description, p.deadline);
    }

    /// @notice Vote for or against a proposal
    function vote(uint256 proposalId, bool support) external {
        Proposal storage p = proposals[proposalId];
        require(block.timestamp < p.deadline, "Voting ended");
        require(!p.hasVoted[msg.sender], "Already voted");

        p.hasVoted[msg.sender] = true;

        if (support) {
            p.yesVotes += 1;
        } else {
            p.noVotes += 1;
        }

        emit Voted(proposalId, msg.sender, support);
    }

    /// @notice Finalize the proposal and determine outcome
    function finalizeProposal(uint256 proposalId) external onlyOwner {
        Proposal storage p = proposals[proposalId];
        require(block.timestamp >= p.deadline, "Voting still active");
        require(p.status == ProposalStatus.Active, "Already finalized");

        if (p.yesVotes > p.noVotes) {
            p.status = ProposalStatus.Passed;
        } else {
            p.status = ProposalStatus.Failed;
        }

        emit ProposalFinalized(proposalId, p.status);
    }

    /// @notice View proposal details
    function getProposal(uint256 proposalId) external view returns (
        uint256 id,
        string memory description,
        uint256 yesVotes,
        uint256 noVotes,
        uint256 deadline,
        ProposalStatus status
    ) {
        Proposal storage p = proposals[proposalId];
        return (p.id, p.description, p.yesVotes, p.noVotes, p.deadline, p.status);
    }
}
