pragma solidity ^0.4.20;

contract contractFactory
{
	mapping(address => participant) public users;
	// using SafeMath for uint256;

	event NewIndividualContract(uint contractId, string name);

	struct individualContract
	{
		string name;

		string mainContract;
		mapping(uint => proposalContract) proposalContracts;
	}

	struct proposalContract
	{
		string content;
		uint yes_votes;
		address[] voters;
	}

	struct participant
	{
		mapping(uint => individualContract) participatingContracts;
	}

	function createNewUser()
	{
		users[msg.sender] = participant();
	}

	function createNewIndividualContract(string _name, uint _individualContractId)
   	{
   		participant the_user = users[msg.sender];
   		individualContract new_contract = new individualContract(_name,"",string[]);
   		uint the_contract = the_user.participatingContracts[new_contract.id] = new_contract;
   	}

   	function joinIndividualContract(uint _individualContractId)
   	{
   		participant the_user = users[msg.sender];
   		individualContract = individualContracts[_individualContractId]

   		the_user.participatingContracts[_individualContractId] = individualContract;
   	}

   	function createProposalForContract(string _newContent, uint _individualContractId)
   	{
   		participant the_user = users[msg.sender];
   		require(the_user.participatingContracts[_individualContractId] != null);

   		proposalContract new_proposal = new proposalContract(_newContent,0,address[]);

   		the_user.participatingContracts[_individualContractId].proposalContracts[new_proposal.id] = new_proposal;
   	}

   	function voteOnProposal(){}
}






// --------------------------------





pragma solidity ^0.4.20;

contract contractFactory
{
	mapping(address => participant) users;
	// using SafeMath for uint256;

	event NewIndividualContract(uint contractId, string name);

	struct participant
	{
		mapping(uint => individualContract) participatingContracts;
	}

	function createNewUser()
	{
		users[msg.sender] = participant();
	}
	
	function createNewIndividualContract(string _name, uint _individualContractId)
   	{
   		participant the_user = users[msg.sender];
   		individualContract new_contract = new individualContract();
   		new_contract.setName(_name);
   		new_contract.addParticipant(msg.sender);
   	}
   	
    function createProposalForContract(string _newContent, uint _individualContractId)
   	{
   		participant the_user = users[msg.sender];
   		require(the_user.participatingContracts[_individualContractId] != 0);

   		proposalContract new_proposal = new proposalContract();
   		new_proposal.setContent(_newContent);

   		the_user.participatingContracts[_individualContractId].proposalContracts[new_proposal.id] = new_proposal;
   	}
	
}

contract individualContract
{
    string name;
	string mainContract;
	mapping(uint => proposalContract) proposalContracts;
	address[] participants;
	
	function setName(string _name)
	{
	    name = _name;
	}
	
	function setMainContract(string _newMain)
	{
	    mainContract = _newMain;
	}
	
	function addParticipant(address user)
	{
	    participants.push(user);
	}
	
	function userInParticipantList(address user)
	{
	    for(int i = 0; i < participants.length; i++)
	    {
	        if(participants[i] == user) return true;
	    }
	    return false;
	}
}

contract proposalContract
{
	string content;
	uint yes_votes;
	address[] voters;
	
	function setContent(string _content)
	{
	    content = _content;
	}
}







