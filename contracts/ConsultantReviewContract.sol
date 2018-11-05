pragma solidity ^0.4.23;


contract ConsultantReviewContract{
	
    uint public testNumber;

    struct Review{
        uint rating;
        string comment;
        address clientAccount;
    }

    mapping (address => Review) reviews;
    address[] public consultantAccounts;
    Review[] public reviewsArray;

    constructor(){
	// Basic constructor for the contract
    }
    function setTestNumber(uint _testNumber){

        testNumber = _testNumber;
    }

    function getTestNumber()returns(uint){

        return testNumber;
    }


    function setReview(address _address,uint _rating, string _comment, address _clientAccount) public {

        Review storage review = reviews[_address];

        review.rating = _rating;
        review.comment = _comment;
        review.clientAccount = _clientAccount;

        reviewsArray.push(review);

    }

    function totalReviews() view public returns (uint){

        return reviewsArray.length;
    }
}



/*
	-- Just some comments

		Client storage client = clients[_address];

		client.firstName = _firstName;
		client.lastName = _lastName;
		client.company = _company;

		clientAccounts.push(_address) -1;
*/