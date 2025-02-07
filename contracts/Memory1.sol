//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {
    function work(string memory _str) external pure returns(bytes32 data) {
        assembly {
            let ptr := mload(64)
            data := mload(sub(ptr, 32))
            
            // 192 - 32 ==> _str

            // 0x7465737400000000000000000000000000000000000000000000000000000000
        }
    }
}