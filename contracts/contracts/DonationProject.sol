// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


import {IDonationProject} from "./IDonationProject.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract DonationProject is IDonationProject {
    uint256 public targetAmount = 0;
    IERC20 public token;
    address public owner;

    struct Partner {
        address addr;
        uint256 share;
    }

    Partner[] public partners;

    constructor(
        uint256 _targetAmount,
        IERC20 _token,
        address _owner, 
        address[] memory _partners
    )
    {
        targetAmount = _targetAmount;
        token = _token;
        owner = _owner;
        for (uint256 i = 0; i < _partners.length; i++) {
            partners.push(Partner(_partners[i], 100 / _partners.length));
        }
    }

    function donate(uint256 amount) public  {
        token.transferFrom(msg.sender, address(this), amount);
    }

    function withdraw() public  {
        uint256 withdrawalAmount = targetAmount > currentAmount() ? targetAmount : currentAmount();
        uint256 extraAmount = targetAmount > currentAmount() ? targetAmount - currentAmount() : 0;
        token.transfer(msg.sender, withdrawalAmount);
        redistribute(extraAmount);
    }

    function redistribute(uint256 extraAmount) internal {
        for (uint256 i = 0; i < partners.length; i++) {
            uint256 amount = extraAmount * partners[i].share / 100;
            token.transfer(partners[i].addr, amount);
        }
    }

    function currentAmount() public view returns (uint256 balance) {
        balance = token.balanceOf(address(this));
    }

}