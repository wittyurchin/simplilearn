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

    // Asset declarations
    struct Voter {
        uint256 id;
        string name;
        address addressVoter;
        address delegatedTo;
        bool hasVoted;
        uint256 cadidateId;
        bool flag;
    }

    struct Candidate {
        uint256 id;
        string name;
        string proposal;
        bool flag;
    }

    //voting status enum
    enum VotingStatus {NOT_STARTED, ONGOING, COMPLETED}
    VotingStatus status = VotingStatus.NOT_STARTED;

    //other variables
    uint256 candidateCount = 0; // candidate id starts from 1
    uint256 voterCount = 0; // voter id starts from 1
    mapping(uint256 => Candidate) candidates;
    mapping(address => Voter) voters;
    mapping(uint256 => uint256) voteCounts; // candidate id - > votecount

    // 1. Add a new candidate
    function addNewCandidate(string memory _name, string memory _proposal, address _contractOwner) public onlyVotingAdmin {
        require(_contractOwner == votingAdmin, "Only admin has access to do this.");
        require(status==VotingStatus.NOT_STARTED, "Voting already started or completed");
        candidateCount++;
        uint256 candidateId = candidateCount;
        candidates[candidateId].id = candidateId;
        candidates[candidateId].name = _name;
        candidates[candidateId].proposal = _proposal;
        candidates[candidateId].flag = true;
    }

    // 2. Add a new voter
    function addNewVoter(address _addressVoter, string memory _name, address _contractOwner) public onlyVotingAdmin {
        require(_contractOwner == votingAdmin, "Only admin has access to do this.");
        require(status==VotingStatus.NOT_STARTED, "Voting already started or completed");
        require(voters[_addressVoter].flag==false, "voter already added.");
        voterCount++;
        uint256 voterId = voterCount;
        voters[_addressVoter].id = voterId;
        voters[_addressVoter].addressVoter = _addressVoter;
        voters[_addressVoter].name = _name;
        voters[_addressVoter].flag = true;
    }

    error CanNotStartElection(VotingStatus status, string message);
    // 3. Start Election
    function startElection(address _contractOwner) public onlyVotingAdmin{
        require(_contractOwner == votingAdmin, "Only admin has access to do this.");
        require(candidateCount>0, "0 candidates registered");
        require(voterCount>0, "0 voters registered");
        if(status==VotingStatus.ONGOING){
            revert CanNotStartElection({status: status, message: "Voting ongoing"});
        }else if(status==VotingStatus.COMPLETED){
            revert CanNotStartElection({status: status, message: "Voting completed"});
        }
        status=VotingStatus.ONGOING;
    }
    
    // 4. Display the candidate details
    function displayCandidateDetails(uint256 _candidateId) public view 
        returns (
            uint256 candidateId,
            string memory proposal,
            string memory name
        )
    {
        require(candidates[_candidateId].flag, "Candidate with id does not exist");
        return (
            candidates[_candidateId].id,
            candidates[_candidateId].proposal,
            candidates[_candidateId].name
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
        require(msg.sender==_addressVoter, "Only address owner can delegate voting rights to another address.");
        require(voters[_addressVoter].hasVoted == false, "You can not delegate voting rights. You have already voted.");
        voters[_addressVoter].delegatedTo = _delegatedTo;
    }

    // 7. Cast the vote
    function castVote(uint256 _candidateId, address _addressVoter) public {
        require(candidateCount>0, "0 candidates registered");
        require(candidates[_candidateId].flag, "candidate with id does not exist");
        require(voters[_addressVoter].flag, "voter with address does not exist");
        require(voters[_addressVoter].hasVoted, "Vote already placed");
        if (voters[_addressVoter].delegatedTo != msg.sender){
            require(msg.sender==_addressVoter, "you can not vote");
        }
        voteCounts[_candidateId] =  voteCounts[_candidateId] + 1;
        voters[_addressVoter].cadidateId = _candidateId;
        voters[_addressVoter].hasVoted = true;
    }

    // 8. End the election
    function endElection() public onlyVotingAdmin(){
        if( status == VotingStatus.NOT_STARTED){
            revert("voting not started");
        }else if (status == VotingStatus.COMPLETED){
            revert("voting ended");
        }
        status = VotingStatus.COMPLETED;
    }

    // 9. Show Election Results
    function showElectionResults(uint256 _candidateId) public view 
        returns(uint256 candidateId, 
                string memory name,
                uint256 voteCount
        )
    {
        require(status!=VotingStatus.NOT_STARTED, "Voting not started");
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
        require(voters[_addressVoter].flag, "voter with address does not exist");
        return(
            voters[_addressVoter].addressVoter,
            voters[_addressVoter].name,
            voters[_addressVoter].delegatedTo == addressVoter ? false : true
        );
    }
}