pragma solidity ^0.4.23;

import "./Owned.sol";

contract ClientContract is Owned{

    struct Client {
        string firstName;
        string lastName; // change string to bytes16
        string company;
        address account;
    }

    mapping (address => Client) clients;
    address[] public clientAccounts;

    constructor() public { //Default constructor

    }

    event ClientEvent(
       string firstName,
       string lastName, // change string to bytes16
       string company,
       address account
    );

    event ClientAlreadyExistsEvent(
        string message
    );

    function clientExist(address _address) public view returns(bool){
        for (uint i = 0; i < clientAccounts.length; i++) {
            if (clientAccounts[i] == _address)
               return true;
        }
        return false;
    }
	
    function clientDoesNotExist(address _address) public view returns(bool){
        for (uint i = 0; i < clientAccounts.length; i++) {
            if (clientAccounts[i] == _address)
               return false;
        }
        return true;

    }

    function setClient(address _address, string _firstName, string _lastName, string _company) public {

        string storage messageToClient;

        if(clientDoesNotExist(_address)){
            Client storage client = clients[_address];

            client.firstName = _firstName;
            client.lastName = _lastName;
            client.company = _company;
            client.account = _address;

            emit ClientEvent(_firstName, _lastName, _company, _address);

            clientAccounts.push(_address) -1;
        }else{
            messageToClient = "Client Already exists";
            emit ClientAlreadyExistsEvent(messageToClient);
        }
    }

    function getClients() public view returns(address[]){

        return clientAccounts;
    }


    function getClient(address _address) public view returns (string, string, string){

        return (clients[_address].firstName, clients[_address].lastName, clients[_address].company);
    }

    function countClients() public onlyOwner  view returns (uint){

        return clientAccounts.length;
    }

    // Send client address explicity in the function
    function setConsultantReview(address _contractAddr, uint _rating, bytes32 _comment, address _consultantAccount, address _clientAccount) 
    
    public{

        ConsultantReviewContract crc = ConsultantReviewContract(_contractAddr);
        crc.setReview(_rating, _comment, _consultantAccount,_clientAccount);
    }

    function getConsultantReview(address _contractAddr) public view returns(uint, bytes32, address, address){

        ConsultantReviewContract crc = ConsultantReviewContract(_contractAddr);
        return crc.getReview();

    }

    // All the reviews by this client to his/her consultants
    // Check only authorized cleint can see the comments
    function getConsultantsReviews(address _contractAddr, address _clientAccount) public view returns(uint[], bytes32[20], address[]){
        
        ConsultantReviewContract crc = ConsultantReviewContract(_contractAddr);
        return crc.getConsultantsReviews(_clientAccount);
    }


    // All reviews of a particular consultant by the client
    function getConsultantReviews(address _contractAddr, address _consultantAccount, address _clientAccount)   
    public view returns(uint[], bytes32[20]){
        ConsultantReviewContract crc = ConsultantReviewContract(_contractAddr);
        return crc.getConsultantReviews(_clientAccount,_consultantAccount);
    }

    function getClientFirstReview(address _contractAddr, address _clientAccount)public view returns(uint, bytes32){
        ConsultantReviewContract crc = ConsultantReviewContract(_contractAddr);
        return crc.getClientFirstReviewNow(_clientAccount);
    }

}

// Get consultant first review
// change string to fixed sized bytes array



contract ConsultantReviewContract{
	
    // function getTestNumber() public view returns(uint);
    function getReview() public view returns(uint, bytes32, address, address);
    // function setTestNumber(uint _testNumber);
    function setReview(uint _rating, bytes32 _comment, address _consultantAccount, address _clientAccount) public;
    function totalReviews() public returns (uint);
    function getClientAccounts() public returns (address[]);
    function getConsultantsReviews(address _clientAccount) public view returns(uint[], bytes32[20], address[]);
    function getConsultantReviews(address _clientAccount, address _consultantAccount) public view returns(uint[], bytes32[20]);
    function getClientFirstReviewNow(address _clientAccount) public view returns(uint, bytes32);

}