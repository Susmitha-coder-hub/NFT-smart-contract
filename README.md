
# ERC-721 NFT Collection Smart Contract

This project implements a secure, tested, and containerized NFT smart contract following the ERC-721 standard. It includes features for supply management, administrative controls (pausing/minting), and a comprehensive automated test suite.

## 🚀 Features
- **ERC-721 Compliant**: Full support for ownership, transfers, and approvals.
- **Supply Control**: Fixed maximum supply to ensure scarcity.
- **Access Control**: Administrative roles for minting and pausing contract state.
- **Metadata Management**: Dynamic `tokenURI` generation using a Base URI pattern.
- **Security**: Protection against re-entrancy and zero-address transfers.

## 🛠 Tech Stack
- **Solidity**: Smart contract logic.
- **Hardhat**: Development environment and testing framework.
- **Ethers.js / Chai**: For writing descriptive unit tests.
- **Docker**: For reproducible, isolated testing environments.
- **OpenZeppelin**: Industry-standard base contracts for security.

## 📋 Prerequisites
- [Docker](https://www.docker.com/get-started) installed on your machine.
- (Optional) [Node.js v18+](https://nodejs.org/) if running locally without Docker.

## 📦 Getting Started

### Using Docker (Recommended)
The easiest way to validate the contract and run the test suite is via Docker. This ensures all dependencies and environment variables are correctly configured.

1. **Build the Image:**
   ```bash
   docker build -t nft-contract .
Run the Tests:

Bash

docker run nft-contract
The container is configured to automatically run the Hardhat test suite upon startup.

Local Development
If you prefer to run the project outside of Docker:

Install Dependencies:

Bash

npm install
Compile Contracts:

Bash

npx hardhat compile
Run Tests:

Bash

npx hardhat test
🧪 Test Suite Overview
The test suite validates the following scenarios:

Deployment: Verifies name, symbol, and initial supply configurations.

Minting: Confirms only authorized accounts can mint and respects maxSupply.

Transfers: Ensures safe transfers and correct balance updates.

Approvals: Validates operator permissions and revokes.

Edge Cases: Reverts on unauthorized calls, zero-addresses, and double-minting.

Gas Usage: Basic monitoring of mint and transfer costs.

🏗 Project Structure
contracts/: Solidity source files.

test/: Mocha/Chai test scripts.

Dockerfile: Containerization configuration.

hardhat.config.js: Hardhat environment settings
