pragma solidity ^0.4.23;
pragma experimental ABIEncoderV2;



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

    // Do we need any check for setting the review, if so what it will be 
    function setReview(uint _rating, string _comment, address _consultantAccount, address _clientAccount) public {

        Review storage review = reviews[_clientAccount];

        review.rating = _rating;
        review.comment = _comment;
        review.consultantAccount = _consultantAccount;
        review.clientAccount = _clientAccount;

        reviewsArray.push(review);
        clientAccounts.push(_clientAccount);

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

    function getConsultantsReviews(address _clientAccount) public returns(uint[], string[], address[]){

        uint[] _ratings;
        string[] _comments;
        address[] _consultantAccounts;


        for (uint i = 0; i < reviewsArray.length; i++) {
            if (reviewsArray[i].clientAccount == _clientAccount){
                _ratings.push(reviewsArray[i].rating);
                _comments.push(reviewsArray[i].comment);
                _consultantAccounts.push(reviewsArray[i].consultantAccount);
            }
        }
        return (_ratings, _comments, _consultantAccounts);

    }


    function getConsultantReviews(address _clientAccount, address _consultantAccount) public returns(uint[], string[]){

        uint[] _ratings;
        string[] _comments;

        for (uint i = 0; i < reviewsArray.length; i++) {
            if (reviewsArray[i].clientAccount == _clientAccount && reviewsArray[i].consultantAccount == _consultantAccount){
                _ratings.push(reviewsArray[i].rating);
                _comments.push(reviewsArray[i].comment);
            }
        }
        return (_ratings, _comments);

    }


    function getClientFirstReviewNow(address _clientAccount) public view returns(uint, string){
        
        for(uint i = 0; i < reviewsArray.length; i++){
            if (reviewsArray[i].clientAccount == _clientAccount){
                return(reviewsArray[i].rating,reviewsArray[i].comment);  
            }
        }
        return(0,"");
    }

}



/*
	-- Just some comments

		Client storage client = clients[_address];

		client.firstName = _firstName;
		client.lastName = _lastName;
		client.company = _company;

		clientAccounts.push(_address) -1;

        function getConsultantsReviews(address _clientAccount) public returns(string[], string[], address[]);
    function getConsultantReviews(address _clientAccount, address _consultantAccount) public  returns(string[], string[]);

*/