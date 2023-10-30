// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;
contract JobPortal {
    //initialize contract 
    address public contractOwner;
    constructor() public {
        contractOwner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == contractOwner);
        _;
    }

    // Asset declarations
    struct Applicant {
        uint256 id;
        string name;
        string applicantType;
        uint8 rating;
        //uint256 area;
    }

    struct Job {
        uint256 id;
        string name;
    }

    mapping(uint256 => Applicant) applicants;
    mapping(uint256 => Job) jobs;
    mapping(uint256 => uint256[]) jobApplications; // job id->list of applicant ids

    // applicant contract functions
    function addApplicant(
        uint256 _applicantId,
        string memory _name,
        string memory _applicantType
        //uint256 _value,
        //uint256 _area
    ) public onlyOwner {
        applicants[_applicantId].id = _applicantId;
        applicants[_applicantId].name = _name;
        applicants[_applicantId].applicantType = _applicantType;
    }

    function queryApplicantById(uint256 _applicantId)
        public view returns (
            uint256 id,
            string memory name,
            string memory applicantType
        )
    {
        return (
            applicants[_applicantId].id,
            applicants[_applicantId].name,
            applicants[_applicantId].applicantType
        );
    }

    function queryApplicantTypeById(uint256 _applicantId)
        public view returns (
            string memory applicantType
        )
    {
        return (
            applicants[_applicantId].applicantType
        );
    }
    // applicant contract functions
    function giveApplicantRating(
        uint256 _applicantId,
        uint8 _rating
        //uint256 _value,
        //uint256 _area
    ) public onlyOwner {
        require(_rating<=10, "rating can not be more than 10");
        applicants[_applicantId].rating = _rating;
    }

    function fetchApplicantRating(
        uint256 _applicantId
    ) public view returns (
            uint8 rating
    ) {
        return(
        applicants[_applicantId].rating
        );
    }

    //job related contract functions
    function addJob(
        uint256 _jobId,
        string memory _name
    ) public onlyOwner {
        applicants[_jobId].id = _jobId;
        applicants[_jobId].name = _name;
    }

    function queryJobById(uint256 _jobId)
        public view returns (
            uint256 id,
            string memory name
        )
    {
        return (
            jobs[_jobId].id,
            jobs[_jobId].name
        );
    }

    //apply to job
    function applyJob(uint256 _applicantId, uint256 _jobId) public  
    {
        jobApplications[_jobId].push(_applicantId);
    }

}