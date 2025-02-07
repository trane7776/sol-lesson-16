//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {

    function sel() external pure returns(bytes4) {
        return bytes4(keccak256(bytes("work(uint256[3])")));
    }

    function work(uint[] calldata a) external pure returns(
        bytes32 _startIn, bytes32 _elCount, bytes32 _firstEl
    ) {
        assembly {
            _startIn := calldataload(4)
            _elCount := calldataload(add(_startIn, 4))
            _firstEl := calldataload(add(_startIn, 36))
        }

    }
}