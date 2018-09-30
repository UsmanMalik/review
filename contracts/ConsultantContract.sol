pragma solidity ^0.4.23;

import "./Owned.sol";

contract ConsultantContract is Owned{

	constructor() public{

	}
	
    struct Consultant {
        string firstName;
        string lastName;
    }

    mapping (address => Consultant) consultants;
    address[] public consultantAccounts;

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

	function countConsultants() exceptOwner view public returns (uint){

		return consultantAccounts.length;
	}

}