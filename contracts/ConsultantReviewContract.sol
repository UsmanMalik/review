pragma solidity ^0.4.23;



contract ConsultantReviewContract{
	
    uint public testNumber;

    struct Review{
        uint rating;
        bytes32 comment;
        address clientAccount;
        address consultantAccount;
    }

    mapping (address => Review) reviews;
    address[] public clientAccounts;
    Review[] public reviewsArray;

    constructor() public{
	// Basic constructor for the contract
    }

    event ConsultantReviewEvent(
        uint rating,
        bytes32 comment,
        address consultantAccount,
        address clientAccount
    );

    // Do we need any check for setting the review, if so what it will be 
    function setReview(uint _rating, bytes32 _comment, address _consultantAccount, address _clientAccount) public {

        Review storage review = reviews[_clientAccount];

        review.rating = _rating;
        review.comment = _comment;
        review.consultantAccount = _consultantAccount;
        review.clientAccount = _clientAccount;

        reviewsArray.push(review);
        clientAccounts.push(_clientAccount);

        emit ConsultantReviewEvent(_rating, _comment, _consultantAccount, _clientAccount);

    }

    // Need to have multiple reviews retrivals 
    // 1) client's review
    // 2) client with specific consultant review 
    // 3) All reviews

    function getReview() public view returns(uint, bytes32, address, address){
        return(reviewsArray[0].rating, reviewsArray[0].comment, reviewsArray[0].clientAccount, reviewsArray[0].consultantAccount);
    }

    function totalReviews() public view returns (uint){
        return reviewsArray.length;
    }

    function getClientAccounts() public view returns (address[]){
        return clientAccounts;
    }

    function getConsultantsReviews(address _clientAccount) public view returns(uint[], bytes32[20], address[]){

        uint[] memory _ratings = new uint[](10);
        bytes32[20] memory _comments;
        address[] memory _consultantAccounts = new address[](10);
        uint counter = 0; 


        for (uint i = 0; i < reviewsArray.length; i++) {
            if (reviewsArray[i].clientAccount == _clientAccount){
                // _ratings.push(reviewsArray[i].rating);
                _ratings[counter] = reviewsArray[i].rating;
                // _comments.push(reviewsArray[i].comment);
                _comments[counter] = reviewsArray[i].comment;
                _consultantAccounts[counter] = reviewsArray[i].consultantAccount;
                counter++;
            }
        }
        return (_ratings, _comments, _consultantAccounts);

    }

    // We might need event on this side aswell, will take a look
    function getConsultantReviews(address _clientAccount, address _consultantAccount) public view returns(uint[], bytes32[20]){

        uint[] memory _ratings = new uint[](10);
        bytes32[20] memory _comments;
        uint counter = 0; 

        for (uint i = 0; i < reviewsArray.length; i++) {
            if (reviewsArray[i].clientAccount == _clientAccount && reviewsArray[i].consultantAccount == _consultantAccount){
                _ratings[counter] = reviewsArray[i].rating;
                _comments[counter] = reviewsArray[i].comment;
                counter++;
                // _comments.push(reviewsArray[i].comment);
            }
        }
        return (_ratings, _comments);

    }


    function getClientFirstReviewNow(address _clientAccount) public view returns(uint, bytes32){
        
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