pragma solidity ^0.4.23;

import "./Owned.sol";

contract ConsultantContract is Owned{
	
    struct Consultant { // change string to bytes16
        string firstName;
        string lastName;
        address account; // client account 
    }

    mapping (address => Consultant) consultants;
    address[] public consultantAccounts;

    constructor() public{
    }


    event ConsultantEvent(
       string firstName,
       string lastName, // change string to bytes16
       address account
    );

    event ConsultantAlreadyExistsEvent(
        string message
    );

    function consultantExist(address _address) public view returns(bool){
        for (uint i = 0; i < consultantAccounts.length; i++) {
            if (consultantAccounts[i] == _address)
               return true;
        }
        return false;
    }

    function consultantDoesNotExist(address _address) public view returns(bool){
        for (uint i = 0; i < consultantAccounts.length; i++) {
            if (consultantAccounts[i] == _address)
               return false;
        }
        return true;
    }


    function setConsultant(string _firstName, string _lastName) public {

        if(consultantDoesNotExist(msg.sender) && (msg.sender != address(0))){
            Consultant storage consultant = consultants[msg.sender];

            consultant.firstName = _firstName;
            consultant.lastName = _lastName;
            consultant.account = msg.sender;

            emit ConsultantEvent(consultant.firstName, consultant.lastName, consultant.account);

            consultantAccounts.push(msg.sender) -1;
        }else{
            emit ConsultantAlreadyExistsEvent("Consultant Already exists");
        }

        // Consultant storage consultant = consultants[_address];

        // consultant.firstName = _firstName;
        // consultant.lastName = _lastName;

        // consultantAccounts.push(_address);
    }

    function getConsultants() public view returns(address[]){

        return consultantAccounts;
    }


    function getConsultant() public view returns (string, string){

        return (consultants[msg.sender].firstName, consultants[msg.sender].lastName);
    }

    function countConsultants() public onlyOwner view  returns (uint){

        return consultantAccounts.length;
    }

    // Send client address explicity in the function
    function setClientReview(address _contractAddr, uint _rating, bytes32 _comment, address _clientAccount) 
    
    public{
        ClientReviewContract crc = ClientReviewContract(_contractAddr);
        crc.setReview(_rating, _comment, _clientAccount, msg.sender);
    }
    //****** Make sure to change the Client Review contarct aswell
    
     /////// ConsultantContract.deployed().then(function(contractInstance) { contractInstance.setClientReview('0x38563ac0aabb090b306d9db879c4df7317fa98a8',7,"meow",web3.eth.accounts[1],{from: web3.eth.accounts[2]}).then(function(v) {console.log(v)})})


    function getClientReview(address _contractAddr) public view returns(uint, string, address, address){

        ClientReviewContract crc = ClientReviewContract(_contractAddr);
        return crc.getReview();

    }    

    // ********* Retrival of comments ****************
    // All the reviews by this client to his/her consultants
    // Check only authorized cleint can see the comments
    function getClientsReviews(address _contractAddr) public view returns(uint[], bytes32[20], address[]){
        
        ClientReviewContract crc = ClientReviewContract(_contractAddr);
        return crc.getClientsReviews(msg.sender);
    }


    // All reviews of a particular consultant by the client
    function getClientReviews(address _contractAddr, address _clientAccount)   
    public view returns(uint[], bytes32[20]){
        ClientReviewContract crc = ClientReviewContract(_contractAddr);
        return crc.getClientReviews(msg.sender,_clientAccount);
    }

    function getConsultantFirstReview(address _contractAddr)public view returns(uint, bytes32){
        ClientReviewContract crc = ClientReviewContract(_contractAddr);
        return crc.getConsultantFirstReviewNow(msg.sender);
    }




}


contract ClientReviewContract{
	
    function getReview() public view returns(uint, string, address, address);
    function setReview(uint _rating, bytes32 _comment, address _clientAccount, address _consultantAccount) public;
    function totalReviews() public returns (uint);
    function getConsultantsAccounts() public returns (address[]);

    function getClientsReviews(address _consultantAccount) public view returns(uint[], bytes32[20], address[]);
    function getClientReviews(address _consultantAccount, address _clientAccount) public view returns(uint[], bytes32[20]);
    function getConsultantFirstReviewNow(address _consultantAccount) public view returns(uint, bytes32);


}