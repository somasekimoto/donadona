// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IDonationProject {
    function donate(uint256 amount) external;
    function withdraw() external;
    function currentAmount() external view returns (uint256 balance);
}