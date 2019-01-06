pragma solidity ^0.4.23;


contract ClientReviewContract{
	
    struct Review{
        uint rating;
        string comment;
        address consultantAccount;
        address clientAccount;

    }

    mapping (address => Review) reviews;
    address[] public consultantAccounts;
    Review[] public reviewsArray;

    constructor() public{
	// Basic constructor for the contract
    }

    function setReview(uint _rating, string _comment, address _consultantAccount, address _clientAccount) public {

        Review storage review = reviews[_consultantAccount];

        review.rating = _rating;
        review.comment = _comment;
        review.clientAccount = _clientAccount;
        review.consultantAccount = _consultantAccount;

        reviewsArray.push(review);
        consultantAccounts.push(_consultantAccount);

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

    function getConsultantAccounts() public view returns (address[]){

        return consultantAccounts;

    }
}