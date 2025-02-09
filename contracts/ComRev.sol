// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;


contract ComRev {
    address[] public candidates = [
        0xdD870fA1b7C4700F2BD7f44238821C26f7392148,
        0x583031D1113aD414F02576BD6afaBfb302140225,
        0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB
    ];

    address owner;
    mapping(address => bytes32) public commits;
    mapping(address => uint) public votes;
    bool votingStopped;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not an owner");
        _;
    }

    function commitVote(bytes32 _hashedVote) external {
        require(!votingStopped);
        require(commits[msg.sender] == bytes32(0));

        commits[msg.sender] = _hashedVote;
    }

    function revealVote(address _candidate, bytes32 _secret) external {
        require(votingStopped);
        bytes32 commit = keccak256(abi.encodePacked(_candidate, _secret, msg.sender));

        require(commit == commits[msg.sender], "invalid commit");
        delete commits[msg.sender];

        votes[_candidate] += 1;
    }

    function stopVoting() external onlyOwner {
        require(!votingStopped);
        votingStopped = true;
    }

    // keccak256(abi.encodePacked())
    // ethers.encodeBytes32String('secret') => '0x7365637265740000000000000000000000000000000000000000000000000000'
    // ethers.solidityPackedKeccak256(['address', 'bytes32', 'address'],
    //      ['0xdD870fA1b7C4700F2BD7f44238821C26f7392148', 
    //       '0x7365637265740000000000000000000000000000000000000000000000000000',
    //       '0x5B38Da6a701c568545dCfcB03FcB875f56beddC4']) => 0x9c080ad924754e2edc99986b6705242ef74b1894b938fdbb20bc12e0b1e51447
}