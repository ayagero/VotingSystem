// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Base contract to manage ownership
contract Ownable {
    address public owner;

    // Constructor sets the deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }
}

// Voting system contract inheriting from Ownable
contract VotingSystem is Ownable {
    // Struct to define a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mappings to store candidates, votes, and name uniqueness
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    mapping(string => bool) private nameExists;

    // Counter for total number of candidates
    uint public totalCandidates;

    // Events for better tracking and debugging
    event CandidateAdded(uint indexed id, string name, uint timestamp);
    event Voted(address indexed voter, uint indexed candidateId, uint voteCount, uint timestamp);

    // Fallback function to handle undefined function calls
    fallback() external {
        revert("Function does not exist");
    }

    // Receive function to handle plain Ether transfers
    receive() external payable {
        revert("Contract does not accept Ether");
    }

    // Function to add a new candidate (only owner)
    function addCandidate(string calldata name) external onlyOwner {
        // Validate input
        require(bytes(name).length > 0, "Candidate name cannot be empty");
        require(!nameExists[name], "Candidate name already exists");

        // Increment totalCandidates to get new ID
        totalCandidates++;
        // Store candidate in mapping
        candidates[totalCandidates] = Candidate(totalCandidates, name, 0);
        // Mark name as used
        nameExists[name] = true;

        emit CandidateAdded(totalCandidates, name, block.timestamp);
    }

    // Function to vote for a candidate
    function vote(uint candidateId) external {
        // Check if there are candidates
        require(totalCandidates > 0, "No candidates available");
        // Check if candidate exists
        require(candidateId > 0 && candidateId <= totalCandidates, "Invalid candidate ID");
        // Check if voter has already voted
        require(!voters[msg.sender], "You have already voted");

        // Mark voter as having voted
        voters[msg.sender] = true;
        // Increment vote count for candidate
        candidates[candidateId].voteCount++;

        emit Voted(msg.sender, candidateId, candidates[candidateId].voteCount, block.timestamp);
    }

    // Function to get candidate details
    function getCandidate(uint candidateId) 
        public 
        view 
        returns (string memory name, uint voteCount) 
    {
        // Check if candidate exists
        require(totalCandidates > 0, "No candidates available");
        require(candidateId > 0 && candidateId <= totalCandidates, "Invalid candidate ID");

        Candidate memory candidate = candidates[candidateId];
        return (candidate.name, candidate.voteCount);
    }

    // Function to get total number of candidates
    function getTotalCandidates() public view returns (uint) {
        return totalCandidates;
    }
}