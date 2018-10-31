pragma solidity ^0.4.23;

import "./Owned.sol";

contract ClientContract is Owned{

	constructor() public {

	}
	
    struct Client {
        string firstName;
        string lastName;
        string company;
    }

    mapping (address => Client) clients;
    address[] public clientAccounts;

	function setClient(address _address, string _firstName, string _lastName, string _company) public {

		Client storage client = clients[_address];

		client.firstName = _firstName;
		client.lastName = _lastName;
		client.company = _company;

		clientAccounts.push(_address) -1;
	}

	function getClients() view public returns(address[]){

		return clientAccounts;
	}


	function getClient(address _address) view public returns (string, string, string){

		return (clients[_address].firstName, clients[_address].lastName, clients[_address].company);
	}

	function countClients() onlyOwner view public returns (uint){

		return clientAccounts.length;
	}

	// Adding functions to call other contract
	/*
		function giveReviewToConsultant(address _addr, uint _rating, string _comment, address _consultantAddress) public{

			ConsultantContract consultantContract = ConsultantContract(_addr);


		}
	*/


	function setTestNumberOnReview(address _contractAddr, uint _number) returns(uint){

		ConsultantReviewContract crc = ConsultantReviewContract(_contractAddr);
		crc.setTestNumber(_number);
		return crc.getTestNumber();
	}


	function getTestNumberOnReview(address _contractAddr) returns(uint){

		ConsultantReviewContract crc = ConsultantReviewContract(_contractAddr);
		return crc.getTestNumber();

	}

}


contract ConsultantReviewContract{
	
	function setTestNumber(uint _testNumber);
	function getTestNumber() returns(uint);
}