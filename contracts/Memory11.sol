//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {
    function work(uint[3] memory _arr) external pure returns(bytes32 data) {
        assembly {
            let ptr := mload(64)
            data := mload(sub(ptr, 64))
            
            // 192 - 32 ==> _str

            // 0x0000000000000000000000000000000000000000000000000000000000000003
            //0x0000000000000000000000000000000000000000000000000000000000000002
        }
    }
}