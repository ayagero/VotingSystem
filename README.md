# Decentralized Voting System Smart Contract

## Overview

The `VotingSystem` smart contract is a decentralized voting application built on Ethereum using Solidity. It allows an owner to register candidates, users to vote for candidates, and anyone to view candidate details and results. The contract uses inheritance, structs, mappings, and proper memory management to ensure security and efficiency.

---

## Features

- **Candidate Management**: Only the contract owner can add candidates with unique names.
- **Voting**: Users can vote for a candidate once, with double-voting prevention.
- **Result Viewing**: Anyone can view candidate details (name and vote count) and the total number of candidates.
- **Security**: Includes ownership control, input validation, and fallback/receive functions to handle undefined calls and Ether transfers.
- **Events**: Emits events for candidate addition and voting for transparency and debugging.

---

## Contract Details

- **Solidity Version**: `^0.8.20`
- **License**: MIT
- **Main Contract**: `VotingSystem` (inherits from `Ownable`)

### Key Components

- `Candidate` struct: Stores `id`, `name`, and `voteCount`.
- **Mappings**:
  - `candidates`: candidate ID → details
  - `voters`: address → voting status
  - `nameExists`: ensures name uniqueness
- **Functions**: `addCandidate`, `vote`, `getCandidate`, `getTotalCandidates`
- **Fallback and Receive**: Present for robustness

---

## Setup

### Prerequisites

- **Remix IDE**: Use [Remix](https://remix.ethereum.org) for deployment and testing.
- **Ethereum Wallet**: Optional for testnets (e.g., MetaMask with Sepolia test Ether).
- **Solidity Knowledge**: Basic understanding of Solidity and smart contract deployment.

### Installation

1. **Open Remix**:
   - Go to [Remix IDE](https://remix.ethereum.org).
   - Create a new file named `VotingSystem.sol`.

2. **Paste Contract Code**:
   - Copy the code from the repository/source.
   - Paste it into `VotingSystem.sol`.

3. **Compile the Contract**:
   - Go to the "Solidity Compiler" tab.
   - Set the compiler version to `0.8.20` or higher.
   - Select `VotingSystem` to compile.
   - Click "Compile VotingSystem.sol" and ensure there are no errors.

---

## Deployment

1. **Select Environment**:
   - Navigate to "Deploy & Run Transactions".
   - Choose:
     - `JavaScript VM (London)` for local testing
     - `Injected Web3` for testnets (e.g., Sepolia via MetaMask)

2. **Deploy the Contract**:
   - Ensure deploying account has enough Ether.
   - In the "Contract" dropdown, select `VotingSystem`.
   - Click "Deploy".
   - Note the contract owner's address.

---

## Usage

### Interacting with the Contract

After deployment, expand the contract under "Deployed Contracts" to access the following:

---

### 1. `addCandidate(string name)`

- **Purpose**: Adds a new candidate (owner only)
- **Input**: A string (e.g., `"Alice"`)
- **Steps**:
  - Use the owner account
  - Input candidate name
  - Click `transact`
- **Notes**:
  - Name must be unique and non-empty
  - Reverts if not called by owner or name is duplicate

---

### 2. `vote(uint candidateId)`

- **Purpose**: Casts a vote
- **Input**: Candidate ID (e.g., `1`)
- **Steps**:
  - Use any account (including owner)
  - Input candidate ID
  - Click `transact`
- **Notes**:
  - Each address can vote once
  - Reverts on invalid ID or double voting

---

### 3. `getCandidate(uint candidateId)`

- **Purpose**: Returns a candidate’s name and vote count
- **Input**: Candidate ID
- **Output**: `(string name, uint voteCount)`
- **Steps**:
  - Input candidate ID
  - Click `call`

---

### 4. `getTotalCandidates()`

- **Purpose**: Returns the total number of candidates
- **Output**: `uint`
- **Steps**:
  - Click `call`

---

### 5. `owner()`

- **Purpose**: Returns the contract owner’s address
- **Steps**:
  - Click `call`

---

### Fallback and Receive Functions

- **Fallback**:
  - Triggered by calling non-existent functions.
  - Use low-level call like `0x1234`.
  - Expected to revert with "Function does not exist".

- **Receive**:
  - Triggered when Ether is sent directly.
  - Set value (e.g., 1 wei) and call with empty calldata.
  - Expected to revert with "Contract does not accept Ether".

---

## Example Workflow

1. Deploy using the owner account
2. Add candidates:
   ```solidity
   addCandidate("Alice");
   addCandidate("Bob");
