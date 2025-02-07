//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {

    function sel() external pure returns(bytes4) {
        return bytes4(keccak256(bytes("work(uint256[3])")));
    }

    function work(string calldata _str) external pure returns(bytes32 _el1) {
        assembly {
            _el1:=calldataload(add(4,64))
        }

        //0x0000000000000000000000000000000000000000000000000000000000000020 - через 32 байта начало строки
        //0x0000000000000000000000000000000000000000000000000000000000000004 - длина строки 4 байта нужно еще +32 байта
        //0x7465737400000000000000000000000000000000000000000000000000000000 - строка
    }
}