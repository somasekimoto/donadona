// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {IDonationProject} from "./IDonationProject.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./DonationProject.sol";



contract DonationProjectFactory {
    address[] public projects;

    constructor() {}

    function create(
        uint256 _targetAmount,
        IERC20 _token,
        address[] memory _partners
    ) public returns (address) {
        DonationProject project = new DonationProject(
            _targetAmount,
            _token,
            msg.sender,
            _partners
        );
        address projectAddress = address(project);
        projects.push(projectAddress);
        return projectAddress;
    }

    function getProjects() public view returns (address[] memory) {
        return projects;
    }
}