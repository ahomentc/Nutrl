pragma solidity ^0.4.20;

contract ContractManager
{       
    // hash of a generated password gives an array of contract addresses for that password
    mapping(uint => address[]) public ContractLists;

    /// <summary>
    /// - Create a new contract and get the address.
    /// - Adds that contract address to the list of contract 
    ///   addresses in ContractLists.
    /// </summary>
    function createNewContract(uint password_hash, string name, string content)
    {
        IndividualContract new_contract = new IndividualContract();
        new_contract.init(name,content,msg.sender);
        appendToContractLists(password_hash, new_contract);
    }

    /// <summary>
    /// - Adds the contract address to the end of the array at the
    ///   coresponding place in the ContractLists map
    /// </summary>
    /// <param name="password_hash">Hash of the generated password user has</param>
    /// <param name="contract_address">Address of the contract we're adding</param>
    function appendToContractLists(uint password_hash, address contract_address)
    {
        ContractLists[password_hash].push(contract_address);
    }

    function modifyContract(string content, string name, IndividualContract individual_contract)
    {
        individual_contract.createProposal(content, name);
    }

}

contract IndividualContract
{
    string name;
    string content;
    address[] participants;
    address[] proposals;
    
    function init(string set_name, string set_content, address set_user)
    {
        name = set_name;
        content = set_content;
        participants.push(set_user);
    }

    /// <summary>
    /// - Creates a new contract proposal
    /// </summary>
    /// <param name="new_content">The new content that is being proposed</param>
    function createProposal(string new_content, string new_name)
    {
        contractProposal new_proposal = new contractProposal();
        new_proposal.init(new_name, new_content);
        proposals.push(new_proposal);
    }

    /// <summary>
    /// - Replaces name of contract with the name of the proposal 
    /// - Replaces the content of the contract with the content of the proposal 
    /// </summary>
    /// <param name="proposal">The proposal that is being accepted</param>
    function acceptProposal(contractProposal proposal)
    {
        name = proposal.getName();
        content = proposal.getContent();
    }

    function voteToAcceptProposal(address user, contractProposal proposal)
    {
        // require the user to be one of the participants
        require(_userInPartipants(user));

        // if the user isn't in the yes array, add the user 
        if(!proposal.userInYesVotes(user))
        {
            proposal.addUserToYesVotes(user);
        }

        // if the yes array contains everyone, accept it
        if(proposal.getNumYesVotes() == participants.length)
        {
            acceptProposal(proposal);
        }

    }

    /// <summary>
    /// - Adds a participant to the contract
    /// </summary>
    /// <param name="participant">The user's address that is being added</param>
    function addParticipant(address participant)
    {
        participants.push(participant);
    }


    // Helper functions

    /// <summary>
    /// - Check if user in particpants list
    /// </summary>
    /// <param name="_user">The user's address that is being checked</param>
    function _userInPartipants(address _user) returns (bool)
    {
        for( uint i=0; i < participants.length; i++)
        {
            if(participants[i] == _user)
            {
                return true;
            }
        }
        return false;
    }
}

contract contractProposal
{
    string name;
    string content;

    address[] yesVotes;
    
    function init(string set_name, string new_content)
    {
        name = set_name;
        content = new_content;
    }
    
    function getName() returns (string)
    {
        return name;
    }
    
    function getContent() returns (string)
    {
        return content;
    }

    function userInYesVotes(address _user) returns (bool)
    {
        for( uint i=0; i < yesVotes.length; i++)
        {
            if(yesVotes[i] == _user)
            {
                return true;
            }
        }
        return false;
    }

    function addUserToYesVotes(address _user)
    {
        yesVotes.push(_user);
    }

    function getNumYesVotes() returns (uint)
    {
        return yesVotes.length;
    }
}
