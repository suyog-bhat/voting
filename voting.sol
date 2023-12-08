// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract Voting{
    
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    event Voted(address indexed voter, uint indexed candidateId);
    
    mapping (uint => Candidate) public candidates;
    uint public candidatecount;
    mapping (address => bool) public citizen;
    
    constructor() {
        addCandidate("Godlin");  //candidate is = 1
        addCandidate("Hilda");   //candidate id = 2
    }
    
    function addCandidate(string memory _name) private{
        candidatecount++;
        candidates[candidatecount] = Candidate(candidatecount, _name, 0);
    }
    function getCandidateList() public view returns (uint[] memory, string[] memory) {
    uint[] memory candidateIds = new uint[](candidatecount);
    string[] memory candidateNames = new string[](candidatecount);

    for (uint i = 1; i <= candidatecount; i++) {
        candidateIds[i - 1] = candidates[i].id;
        candidateNames[i - 1] = candidates[i].name;
    }

    return (candidateIds, candidateNames);
}
    function vote(uint _candidateid) public{
        require(!citizen[msg.sender]);
        
        citizen[msg.sender] = true;
        candidates[_candidateid].voteCount ++;

        emit Voted(msg.sender, _candidateid);
        
    }
    function winningCandidate() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 1; p <= candidatecount; p++) {
            if (candidates[p].voteCount > winningVoteCount) {
                winningVoteCount = candidates[p].voteCount;
                winningProposal_ = p;
            }
        }
    }
}
