//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {
    function sel() external pure returns (bytes4) {
        return bytes4(keccak256(bytes("work(uint256[3])")));
    }

    function work(uint[3] calldata _arr) external pure returns (bytes32 _el1) {
        assembly {
            _el1 := calldataload(4)
            //0x00000000000000000000000000000000000000000000000000000000001
        }
    }
}
