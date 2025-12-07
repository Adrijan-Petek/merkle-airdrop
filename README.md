# Merkle Airdrop Starter (Base)

 
Example Merkle-distributor style airdrop contract.

## Quickstart
1. `npm ci`
2. `npm run compile`
3. Deploy locally: `npx hardhat run scripts/deploy-merkle.js --network hardhat`
4. Generate merkle tree off-chain and call `setMerkleRoot()` for production.
