pragma solidity ^0.4.23;


contract ClientContract{
	

    struct Client {
        string firstName;
        string lastName;
        string company;
    }

    mapping (address => Client) clients;
    address[] public clientAccounts;

	function setClient(address _address, string _firstName, string _lastName, string _company) public {

		var client = clients[_address];

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

	function countClients() view public returns (uint){

		return clientAccounts.length;
	}

}