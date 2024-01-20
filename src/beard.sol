// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Beard is ERC20 { 
    uint256 public constant INITIAL_SUPPLY = 1_000_000_000 * 1 ether;
    uint256 public constant BURN_PERCENTAGE = 1; // 1‰
    address public constant BURN_ADDRESS = 0xDeaDbeefdEAdbeefdEadbEEFdeadbeEFdEaDbeeF;

    constructor() ERC20("Beard", "BEARD"){
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        address sender = super._msgSender();
        uint256 burnAmount = (amount * BURN_PERCENTAGE) / 1000;
        super._update(sender, recipient, amount - burnAmount);
        super._update(sender, BURN_ADDRESS, burnAmount);
        return true;
    }
}