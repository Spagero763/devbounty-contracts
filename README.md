# 🛠️ DevBounty Protocol - Smart Contracts (Base Sepolia)

A suite of fully verified smart contracts deployed on Base Sepolia to power the **DevBounty Protocol** — a decentralized system for open-source bounties, reputation, governance, and leaderboard tracking.

> ✅ All contracts were written, compiled, deployed, and verified using [Remix IDE](https://remix.ethereum.org).  


## 🧠 Overview

This repository includes 5 independently deployed smart contracts, each fulfilling a distinct role in the **DevBounty ecosystem**:

| Contract Name         | Role                                                                 |
|-----------------------|----------------------------------------------------------------------|
| `Bounty.sol`          | Handles bounty creation, submission, and review                      |
| `MembershipNFT.sol`   | Mints onchain membership passes as NFTs                              |
| `SimpleGovernance.sol`| Allows decentralized proposal voting using tokens                    |
| `ReputationClaim.sol` | Enables users to claim reputation for completed bounties             |
| `LeaderboardManager.sol` | Tracks top contributors and provides leaderboard functionality |

---

## 📦 Contracts

| Name | File | Verified Address (Base Sepolia) |
|------|------|----------------------------------|
| Bounty | [`Bounty.sol`](contracts/Bounty.sol) | [`0x49a5BD81a4AA3BbaABae0Ec846645FE8354B1e3b`](https://sepolia.basescan.org/address/0x49a5BD81a4AA3BbaABae0Ec846645FE8354B1e3b) |
| Membership NFT | [`MembershipNFT.sol`](contracts/MembershipNFT.sol) | [`0x9Fe13e45883d9e7A8Cf1EF2f8cE6B1400BCEFa81`](https://sepolia.basescan.org/address/0x9Fe13e45883d9e7A8Cf1EF2f8cE6B1400BCEFa81) |
| Governance | [`SimpleGovernance.sol`](contracts/SimpleGovernance.sol) | [`0xD2d41692b83E7CC428A01A8e9d0Dd38b2878D23d`](https://sepolia.basescan.org/address/0xD2d41692b83E7CC428A01A8e9d0Dd38b2878D23d) |
| Reputation | [`ReputationClaim.sol`](contracts/ReputationClaim.sol) | [`0x34272536B3c2fa0D21D63e451B490D0be56D26d0`](https://sepolia.basescan.org/address/0x34272536B3c2fa0D21D63e451B490D0be56D26d0) |
| Leaderboard | [`LeaderboardManager.sol`](contracts/LeaderboardManager.sol) | [`0x029549CA7179769Bd934B41F4c8F17979A743DE6`](https://sepolia.basescan.org/address/0x029549CA7179769Bd934B41F4c8F17979A743DE6) |


## 🌍 Network

- **Testnet**: Base Sepolia  
- **Block Explorer**: [BaseScan Sepolia](https://sepolia.basescan.org)

---

## ⚙️ Deployment Notes

- All contracts were deployed directly from **Remix IDE**
- Each contract was verified manually on [BaseScan](https://sepolia.basescan.org)
- No framework (Hardhat/Foundry) was used


