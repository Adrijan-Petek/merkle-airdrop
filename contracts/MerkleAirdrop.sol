// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract MerkleAirdrop is Ownable {
  bytes32 public merkleRoot; IERC20 public token; mapping(address=>bool) public claimed;
  event Claimed(address indexed user, uint256 amount);
  constructor(address tokenAddress, bytes32 _merkleRoot) { token = IERC20(tokenAddress); merkleRoot = _merkleRoot; }
  function claim(uint256 amount, bytes32[] calldata proof) external {
    require(!claimed[msg.sender], "claimed");
    bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
    require(MerkleProof.verify(proof, merkleRoot, leaf), "invalid proof");
    claimed[msg.sender] = true; token.transfer(msg.sender, amount); emit Claimed(msg.sender, amount);
  }
  function setMerkleRoot(bytes32 r) external onlyOwner { merkleRoot = r; }
  function rescueTokens(address to, uint256 amount) external onlyOwner { token.transfer(to, amount); }
}
