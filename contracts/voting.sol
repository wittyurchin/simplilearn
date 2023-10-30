// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract VotingSoftware{

    //initialize contract. capture contract owner as VotingAdmin
    address public votingAdmin;
    constructor() {
        votingAdmin = msg.sender;
    }
    modifier onlyVotingAdmin() {
        require(msg.sender == votingAdmin);
        _;
    }
    modifier ALLOWVOTE() {
        require(status == VotingStatus.ONGOING, "Voting is going on.");
        _;
    }
    // Asset declarations
    struct Voter {
        uint256 id;
        string name;
        address addressVoter;
        address delegatedTo;
        uint256 cadidateId;
    }

    struct Candidate {
        uint256 id;
        string name;
        string proposal;
    }

    //voting status enum
    enum VotingStatus {NOT_STARTED, ONGOING, COMPLETED};
    VotingStatus status = VotingStatus.NOT_STARTED;

    //other variables
    uint256 candidateCount = 0;
    uint256 voterCount = 0;
    mapping(uint256 => Candidate) candidates;
    mapping(address => Voter) voters;
    mapping(uint256 => uint256) voteCounts; // candidate id - > votecount

    // 1. Add a new candidate
    function addNewCandidate(
        string memory _name,
        string memory _proposal
    ) public onlyVotingAdmin {
        require(status==VotingStatus.NOT_STARTED, "Voting already started or completed");
        candidateCount++;
        uint256 candidateId = candidateCount;
        candidates[candidateId].name = _name;
        candidates[candidateId].proposal = _proposal;
    }

    // 2. Add a new voter
    function addNewVoter(
        address _addressVoter,
        string memory _name
    ) public onlyVotingAdmin {
        require(status==VotingStatus.NOT_STARTED, "Voting already started or completed");
        voterCount++;
        uint256 voterId = voterCount;
        voters[_addressVoter].id = voterId;
        voters[_addressVoter].addressVoter = _addressVoter;
        voters[_addressVoter].name = _name;
    }

    error CanNotStartElection(VotingStatus status, string message);
    // 3. Start Election
    function startElection() public onlyVotingAdmin{
        require(voterCount>0, "0 voters registered");
        require(candidateCount>0, "0 candidates registered");
        if(status==VotingStatus.ONGOING){
            revert CanNotStartElection({status: status, message: "Voting ongoing"});
        }else if(status==VotingStatus.COMPLETED){
            revert CanNotStartElection({status: status, message: "Voting completed"});
        }
        status=VotingStatus.ONGOING;
    }
    
    // 4. Display the candidate details
    function displayCandidateDetails(uint256 _candidateId)
        public view returns (
            uint256 candidateId,
            string memory proposal,
            string memory name
        )
    {
        return (
            candidates[candidateId].id,
            candidates[candidateId].proposal,
            candidates[candidateId].name
        );
    }

    // 5. Show the winner of the election
    // function showWinner() public view{
    //     uint256[] memory winnerCandidateIds;
    //     uint256 highestVoteCount;
    //     for(uint i=0; i<candidateCount; i++){
    //         if (voteCounts[i] == highestVoteCount){
    //             winnerCandidateIds.push(i);

    //         }
    //     }
    // }

    // 6. Delegate the voting right
    function delegateVotingRight(address _delegatedTo, address _addressVoter) public {
        require(status==VotingStatus.ONGOING, "Voting not in progress. You can not deletegate now.");
        voters[_addressVoter].delegatedTo = _delegatedTo;
    }

    // 7. Cast the vote
    function castVote(uint256 _candidateId, address _addressVoter) public {
        voteCounts[_candidateId] =  voteCounts[_candidateId] + 1;
        voters[_addressVoter].cadidateId = _candidateId;
    }

    // 8. End the election
    function endElection() public onlyVotingAdmin(){
        status = VotingStatus.COMPLETED;
    }

    // 9. Show Election Results
    function showElectionResults(uint256 _candidateId) public view 
        returns(uint256 candidateId, 
                string memory name,
                uint256 voteCount
        )
    {
        return(
            _candidateId,
            candidates[_candidateId].name,
            voteCounts[_candidateId]
        );
    }
    
    // 10. View the voter's profile
    function viewVoterDetails(address _addressVoter) public view returns (
            address addressVoter,
            string memory name,
            bool isVoteDelegated
        )
    {
        return(
            voters[_addressVoter].addressVoter,
            voters[_addressVoter].name,
            voters[_addressVoter].delegatedTo == addressVoter ? false : true
        );
    }
}