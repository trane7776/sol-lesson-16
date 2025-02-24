//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {
    function sel() external pure returns (bytes4) {
        return bytes4(keccak256(bytes("work(uint256[3])")));
    }

    function work(uint[3] memory _arr) external pure returns (bytes4) {
        return bytes4(msg.data[0:4]);

        //0x1c28968b000000000000000000000000000000000000000000000000000000000000000 - сигнатура (первые 4 байта)
        //100000000000000000000000000000000000000000000000000000000000000
        //200000000000000000000000000000000000000000000000000000000000000
        //3
    }
}
