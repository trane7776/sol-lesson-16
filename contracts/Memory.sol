//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {
    function work(string memory _str) external pure returns(uint ptr) {
        assembly {
            ptr := mload(64)
            // ptr 192
            // 192 - 32 ==> _str
        }
    }
}