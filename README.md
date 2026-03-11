# Decentralized Voting System

This repository contains a high-quality Solidity implementation of a decentralized voting protocol. It is designed to allow organizers to create proposals and registered voters to cast their ballots securely on the blockchain.

## Features
- **Proposal Management:** Only the owner (admin) can create and authorize new proposals.
- **Voter Registration:** Controlled access to voting rights to prevent Sybil attacks.
- **Transparency:** All votes and results are stored immutably on the blockchain.
- **One Vote Per Person:** Built-in logic to ensure each address can only vote once per proposal.

## Usage
1. **Deployment:** Deploy the contract to initialize the chairperson.
2. **Authorize:** Chairperson registers eligible voter addresses.
3. **Propose:** Chairperson adds a new proposal with a descriptive title.
4. **Vote:** Authorized voters cast their choice for specific proposal IDs.

## Security
- Uses `Ownable` for administrative functions.
- Prevents double-voting via mapping checks.
- Logic is gas-optimized for batch processing in future iterations.

## License
MIT
