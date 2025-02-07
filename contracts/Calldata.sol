//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {
    function work(uint[3] memory _arr) external pure returns(bytes calldata) {
        return msg.data;

        //0x1c28968b000000000000000000000000000000000000000000000000000000000000000 - сигнатура (первые 4 байта)
        //1000000000000000000000000000000000000000000000000000000000000000
        //2000000000000000000000000000000000000000000000000000000000000000
        //3
    }
}