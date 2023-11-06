// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract VotingSoftware{

    //initialize contract. capture contract owner as VotingAdmin
    address public contractOwner;
    constructor() {
        contractOwner = msg.sender;
    }
    modifier onlyVotingAdmin() {
        require(msg.sender == contractOwner);
        _;
    }

        // Asset declarations
    struct Doctor {
        uint256 id;
        string name;
        string qualification;
        string workPlace;
        bool flag; //flag is set to true when doctor object is initialized by application

        address delegatedTo;
        bool hasVoted;
        uint256 cadidateId;
        
    }

    struct Patient {
        uint256 id;
        string name;
        uint256 age;
        string[] diseases;
        address patientAddress;
        uint256[] medicines;
        bool flag; //flag is set to true when patient object is initialized by application
    }

    struct Medicine {
        uint256 id;
        string name;
        string expiryDate;
        string dose;
        uint256 price;
    }
    //other variables
    uint256 doctorCount = 0; // doctor id starts from 1
    uint256 patientCount = 0; // patient id starts from 1
    uint256 medicineCount = 0; // medicine id starts from 1

    mapping(uint256 => Doctor) doctors;
    mapping(uint256 => Patient) patients;
    mapping(uint256 => Medicine) medicines;
    mapping(address => uint256) patiendAddressID; //patient address to id mapping
    
    // 1. Register a new doctor
    function registerNewDoctor(string memory _name, string memory _qualification, string memory _workPlace) public {
        uint256 doctorId = doctorCount+1;
        doctors[doctorId].id = doctorId;
        doctors[doctorId].name = _name;
        doctors[doctorId].qualification = _qualification;
        doctors[doctorId].workPlace = _workPlace;
        doctors[doctorId].flag = true;
    }

    // 2. Register a new patient
    function registerNewPatient(string memory _name, uint256 _age, address _patientAddress) public {
        uint256 patientId = patientCount+1;
        patients[patientId].id = patientId;
        patients[patientId].name = _name;
        patients[patientId].age = _age;
        patients[patientId].flag = true;
        patients[patientId].patientAddress = _patientAddress;
    }

    // 3. Add a patient's disease
    function addPatientDisease(uint256 _id, string memory _disease) public {
        patients[_id].diseases.push(_disease);
    }

    // 4. Add medicine
    function addMedicine(uint256 _id, string memory _name, string memory _expiryDate, string memory _dose, uint256 _price) public {
        medicineCount++;
        medicines[_id].id = _id;
        medicines[_id].name = _name;
        medicines[_id].expiryDate = _expiryDate;
        medicines[_id].dose = _dose;
        medicines[_id].price = _price;
    }

    // 5. Prescribe medicine
    function prescribeMedicine(uint256 _medicineId, address _patientAddress) public {
        uint256 patientId = patiendAddressID[_patientAddress];
        patients[patientId].medicines.push(_medicineId);
    }

    // 6. Update patient details by patient
    function updatePatientDetails(uint256 _patientId, uint256 _age) public {
        patients[_patientId].age = _age;
    }

    // 6.1 Update patient details by patient
    function updatePatientDetails(address _patientAddress, uint256 _age) public {
        uint256 patientId = patiendAddressID[_patientAddress];
        patients[patientId].age = _age;
    }

    // 7. View patient data
    function viewPatiendData(uint256 _patientId) public view
        returns(uint256 patientId, 
                uint256 age, 
                string memory name, 
                string[] memory diseases)
    {
        return(
            patients[_patientId].id,
            patients[_patientId].age,
            patients[_patientId].name,
            patients[_patientId].diseases
        );
    }

    // 7.1 View patient data
    function viewPatiendData(address _patientAddress) public view 
        returns(uint256 patientId, 
                uint256 age, 
                string memory name, 
                string[] memory diseases)
    {
        uint256 _patientId = patiendAddressID[_patientAddress];
        return viewPatiendData(_patientId);
    }

    // 8 View medicine detatils
    function viewMedicineDetails(uint256 _medicineId) public view 
        returns(string memory name, 
                string memory expiryDate, 
                string memory dose, 
                uint256 price)
    {
        return(
            medicines[_medicineId].name,
            medicines[_medicineId].expiryDate,
            medicines[_medicineId].dose,
            medicines[_medicineId].price
        );
    }
}