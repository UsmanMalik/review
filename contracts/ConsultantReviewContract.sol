pragma solidity ^0.4.23;


contract ConsultantReviewContract{
	

	constructor(){
	// Basic constructor for the contract
	}

	struct Review{
		uint rating;
		string comment;
		address clientAccount;
	}

    mapping (address => Review) reviews;
    address[] public consultantAccounts;

}