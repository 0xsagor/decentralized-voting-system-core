// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title VotingSystem
 * @dev Implements a secure voting mechanism for proposals.
 */
contract VotingSystem is Ownable {

    struct Proposal {
        string description;
        uint256 voteCount;
    }

    struct Voter {
        bool isAuthorized;
        bool hasVoted;
        uint256 voteIndex;
    }

    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    event VoterAuthorized(address indexed voter);
    event VoteCast(address indexed voter, uint256 indexed proposalIndex);
    event ProposalCreated(string description);

    constructor() Ownable(msg.sender) {}

    /**
     * @dev Grant an address the right to vote.
     * @param _voter Address of the voter.
     */
    function authorizeVoter(address _voter) public onlyOwner {
        voters[_voter].isAuthorized = true;
        emit VoterAuthorized(_voter);
    }

    /**
     * @dev Create a new proposal for the community.
     * @param _description Title or details of the proposal.
     */
    function createProposal(string memory _description) public onlyOwner {
        proposals.push(Proposal({
            description: _description,
            voteCount: 0
        }));
        emit ProposalCreated(_description);
    }

    /**
     * @dev Cast a vote for a specific proposal.
     * @param _proposalIndex The index of the proposal in the array.
     */
    function vote(uint256 _proposalIndex) public {
        Voter storage sender = voters[msg.sender];
        require(sender.isAuthorized, "Not authorized to vote");
        require(!sender.hasVoted, "Already voted");
        require(_proposalIndex < proposals.length, "Invalid proposal index");

        sender.hasVoted = true;
        sender.voteIndex = _proposalIndex;
        proposals[_proposalIndex].voteCount += 1;

        emit VoteCast(msg.sender, _proposalIndex);
    }

    /**
     * @dev Get the total number of proposals.
     */
    function getProposalsCount() public view returns (uint256) {
        return proposals.length;
    }
}
