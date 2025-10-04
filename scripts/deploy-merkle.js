const hre = require("hardhat");
require("dotenv").config();
async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with", deployer.address);
  const Token = await hre.ethers.getContractFactory("MyToken");
  const token = await Token.deploy("AirdropToken", "ADT", hre.ethers.parseUnits("1000000", 18));
  await token.waitForDeployment();
  console.log("Token:", await token.getAddress());
  const zeroRoot = "0x0000000000000000000000000000000000000000000000000000000000000000";
  const Merkle = await hre.ethers.getContractFactory("MerkleAirdrop");
  const merkle = await Merkle.deploy(await token.getAddress(), zeroRoot);
  await merkle.waitForDeployment();
  console.log("MerkleAirdrop:", await merkle.getAddress());
}
main().catch(e => { console.error(e); process.exitCode = 1; });
