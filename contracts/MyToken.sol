// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract MyToken is ERC20, Ownable {
  constructor(string memory name_, string memory symbol_, uint256 initialSupply) ERC20(name_, symbol_) {
    _mint(msg.sender, initialSupply);
  }
  function mint(address to, uint256 amount) external onlyOwner { _mint(to, amount); }
}
