pragma solidity ^0.4.23;


contract ConsultantReviewContract{
	
    uint public testNumber;

    struct Review{
        uint rating;
        string comment;
        address clientAccount;
        address consultantAccount;
    }

    mapping (address => Review) reviews;
    address[] public clientAccounts;
    Review[] public reviewsArray;

    constructor(){
	// Basic constructor for the contract
    }
    function setTestNumber(uint _testNumber){

        testNumber = _testNumber;
    }

    function getTestNumber() public view returns(uint){

        return testNumber;
    }


    function setReview(uint _rating, string _comment, address _consultantAccount) public {

        Review storage review = reviews[msg.sender];

        review.rating = _rating;
        review.comment = _comment;
        review.consultantAccount = _consultantAccount;
        review.clientAccount = msg.sender;

        reviewsArray.push(review);
        clientAccounts.push(msg.sender);

    }

    // Need to have multiple reviews retrivals 
    // 1) client's review
    // 2) client with specific consultant review 
    // 3) All reviews

    function getReview() public view returns(uint, string, address, address){
        
        return(reviewsArray[0].rating, reviewsArray[0].comment, reviewsArray[0].clientAccount, reviewsArray[0].consultantAccount);
    }

    function totalReviews() public view returns (uint){

        return reviewsArray.length;
    }

    function getClientAccounts() public view returns (address[]){

        return clientAccounts;

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