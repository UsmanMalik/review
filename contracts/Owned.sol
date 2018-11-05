pragma solidity ^0.4.23;


contract Owned{
	
	// This is a base contract use to make sure only owner can perform specific actions.
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    modifier exceptOwner{
        require(msg.sender != owner);
        _;
    }

    function getOwner() public view returns (address){
        return owner;
    }
}