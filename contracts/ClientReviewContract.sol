pragma solidity ^0.4.23;


contract ClientReviewContract{
	
    struct Review{
        uint rating;
        bytes32 comment;
        address consultantAccount;
        address clientAccount;

    }

    mapping (address => Review) reviews;
    address[] public consultantAccounts;
    Review[] public reviewsArray;

    constructor() public{
	// Basic constructor for the contract
    }

    event ClientReviewEvent(
        uint rating,
        bytes32 comment,
        address consultantAccount,
        address clientAccount
    );

    function setReview(uint _rating, bytes32 _comment, address _clientAccount, address _consultantAccount) public {

        Review storage review = reviews[_consultantAccount];

        review.rating = _rating;
        review.comment = _comment;
        review.clientAccount = _clientAccount;
        review.consultantAccount = _consultantAccount;

        reviewsArray.push(review);
        consultantAccounts.push(_consultantAccount);

        emit ClientReviewEvent(_rating, _comment, _consultantAccount, _clientAccount);

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

    function getConsultantAccounts() public view returns (address[]){
        return consultantAccounts;
    }

    function getClientsReviews(address _consultantAccount) public view returns(uint[], bytes32[20], address[]){

        uint[] memory _ratings = new uint[](10);
        bytes32[20] memory _comments;
        address[] memory _clientAccounts = new address[](10);
        uint counter = 0; 


        for (uint i = 0; i < reviewsArray.length; i++) {
            if (reviewsArray[i].consultantAccount == _consultantAccount){
                _ratings[counter] = reviewsArray[i].rating;
                _comments[counter] = reviewsArray[i].comment;
                _clientAccounts[counter] = reviewsArray[i].clientAccount;
                counter++;
            }
        }
        return (_ratings, _comments, _clientAccounts);

    }

    // We might need event on this side aswell, will take a look
    function getClientReviews(address _consultantAccount, address _clientAccount) public view returns(uint[], bytes32[20]){

        uint[] memory _ratings = new uint[](10);
        bytes32[20] memory _comments;
        uint counter = 0; 

        for (uint i = 0; i < reviewsArray.length; i++) {
            if (reviewsArray[i].consultantAccount == _consultantAccount && reviewsArray[i].clientAccount == _clientAccount){
                _ratings[counter] = reviewsArray[i].rating;
                _comments[counter] = reviewsArray[i].comment;
                counter++;
            }
        }
        return (_ratings, _comments);

    }


    function getConsultantFirstReviewNow(address _consultantAccount) public view returns(uint, bytes32){
        
        for(uint i = 0; i < reviewsArray.length; i++){
            if (reviewsArray[i].consultantAccount == _consultantAccount){
                return(reviewsArray[i].rating,reviewsArray[i].comment);  
            }
        }
        return(0,"");
    }


    
}