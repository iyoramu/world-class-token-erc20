// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";

/**
 * @title WorldClassToken
 * @dev A comprehensive ERC-20 token implementation with advanced features:
 * - Voting capabilities (ERC20Votes)
 * - Permit approvals (ERC20Permit)
 * - Flash minting (ERC20FlashMint)
 * - Pausable transfers
 * - Burnable functionality
 * - Ownable with transfer control
 * 
 * Designed to meet world-class standards for UI/UX, functionality, performance, and code quality.
 */
contract WorldClassToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit, ERC20Votes, ERC20FlashMint {
    uint256 private constant INITIAL_SUPPLY = 1_000_000_000 * 10 ** 18; // 1 billion tokens with 18 decimals
    
    /**
     * @dev Sets up the token with initial supply and grants all roles to the deployer.
     * @param initialOwner The address that will receive the initial supply and become the owner
     */
    constructor(address initialOwner)
        ERC20("WorldClassToken", "WCT")
        ERC20Permit("WorldClassToken")
        Ownable(initialOwner)
    {
        _mint(initialOwner, INITIAL_SUPPLY);
    }

    /**
     * @dev Pauses all token transfers. Only callable by owner.
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev Unpauses all token transfers. Only callable by owner.
     */
    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * @dev Creates `amount` new tokens for `to`. Only callable by owner.
     * @param to The address that will receive the minted tokens
     * @param amount The amount of tokens to mint
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity for multiple inheritance

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}
