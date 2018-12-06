pragma solidity ^0.4.23;

import "./Owned.sol";

contract ConsultantContract is Owned{
	
    struct Consultant { // change string to bytes16
        string firstName;
        string lastName;
    }

    mapping (address => Consultant) consultants;
    address[] public consultantAccounts;

    constructor() public{
    }

    function consultantExist(address _address) public view returns(bool){
        for (uint i=0; i<consultantAccounts.length; i++) {
            if (consultantAccounts[i] == _address)
               return true;
        }

        return false;
    }

    function setConsultant(address _address, string _firstName, string _lastName) public {

        Consultant storage consultant = consultants[_address];

        consultant.firstName = _firstName;
        consultant.lastName = _lastName;

        consultantAccounts.push(_address);
    }

    function getConsultants() view public returns(address[]){

        return consultantAccounts;
    }


    function getConsultant(address _address) view public returns (string, string){

        return (consultants[_address].firstName, consultants[_address].lastName);
    }

    function countConsultants() onlyOwner view public returns (uint){

        return consultantAccounts.length;
    }

    // Send client address explicity in the function
    function setClientReview(address _contractAddr, uint _rating, string _comment, address _clientAccount,address _consultantAccount) public{
        ClientReviewContract crc = ClientReviewContract(_contractAddr);
        crc.setReview(_rating, _comment, _consultantAccount, _clientAccount);
    }

    function getClientReview(address _contractAddr) public view returns(uint, string, address, address){

        ClientReviewContract crc = ClientReviewContract(_contractAddr);
        return crc.getReview();

    }    

}


contract ClientReviewContract{
	
    function getReview() public view returns(uint, string, address, address);
    function setReview(uint _rating, string _comment, address _consultantAccount, address _clientAccount) public;
    function totalReviews() public returns (uint);
    function getConsultantsAccounts() public returns (address[]);

}