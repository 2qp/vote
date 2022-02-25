// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.10;
// written for Solidity version 0.4.18 and above that doesnt break functionality

contract Ballot {
    // an event that is called whenever a Candidate is added so the frontend could
    // appropriately display the candidate with the right element id (it is used
    // to vote for the candidate, since it is one of arguments for the function "vote")
    event AddedCandidate(uint candidateID);
    event AddedEntry(string rid);
    event Error(string rid);

    // describes a Voter, which has an id and the ID of the candidate they voted for
    address owner;

    constructor ()  {
        owner = msg.sender;

    }
    modifier onlyOwner {
       require(msg.sender == owner);
        _;
    }
    struct Voter {
        uint candidateIDVote;
    }
    // describes a Candidate
    struct Candidate {
        string name;
        string party;
        // "bool doesExist" is to check if this Struct exists
        // This is so we can keep track of the candidates 
        bool doesExist;
    }

    struct Anon {
        string rid;
        bool voted;
    }

    // These state variables are used keep track of the number of Candidates/Voters 
    // and used to as a way to index them     
    uint numCandidates; // declares a state variable - number Of Candidates
    uint numVoters;


    // Think of these as a hash table, with the key as a uint and value of 
    // the struct Candidate/Voter. These mappings will be used in the majority
    // of our transactions/calls
    // These mappings will hold all the candidates and Voters respectively
    mapping(uint => Candidate) candidates;
    mapping(uint => Voter) voters;
    mapping(string => bool) anony;

    /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
     *  These functions perform transactions, editing the mappings *
     * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
    // 4da Validations
    function entry(string memory rid) onlyOwner public {
        
        anony[rid] = (false);
        emit AddedEntry(rid);
    }


    function addCandidate(string memory name, string memory party) onlyOwner public {
        // candidateID is the return variable
        uint candidateID = numCandidates++;
        // Create new Candidate Struct with name and saves it to storage.
        candidates[candidateID] = Candidate(name,party,true);
        emit AddedCandidate(candidateID);
    }

    function vote(uint candidateID, string memory rid) public {
        // checks if the struct exists for that candidate
        if (candidates[candidateID].doesExist == true && anony[rid] == false ) {
            uint voterID = numVoters++;
            //voterID is the return variable
            voters[voterID] = Voter(candidateID);
            // set
            anony[rid] = true; 
        }
        else {
            emit Error(rid);
        }
    }

    /* * * * * * * * * * * * * * * * * * * * * * * * * * 
     *  Getter Functions *
     * * * * * * * * * * * * * * * * * * * * * * * * * */


    // finds the total amount of votes for a specific candidate by looping
    // through voters 
    function totalVotes(uint candidateID) view public returns (uint) {
        uint numOfVotes = 0;
        // we will return this
        for (uint i = 0; i < numVoters; i++) {
            // if the voter votes for this specific candidate, we increment the number
            if (voters[i].candidateIDVote == candidateID) {
                numOfVotes++;
            }
        }
        return numOfVotes;
    }

    function getNumOfCandidates() public view returns (uint) {
        return numCandidates;
    }

    function getNumOfVoters() public view returns (uint) {
        return numVoters;
    }
    // returns candidate information, including its ID, name, and party
    function getCandidate(uint candidateID) public view returns (uint, string memory, string memory) {
        return (candidateID, candidates[candidateID].name, candidates[candidateID].party);
    }

    function returnMappingValue(string memory rid) public view returns ( bool) {
        return (anony[rid]);
    }  
}