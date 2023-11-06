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
        address doctorAddress;        
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
        bool flag; //flag is set to true when medicine object is initialized by application
    }
    //other variables
    uint256 doctorCount = 0; // doctor id starts from 1
    uint256 patientCount = 0; // patient id starts from 1
    uint256 medicineCount = 0; // medicine id starts from 1

    mapping(uint256 => Doctor) doctors;
    mapping(uint256 => Patient) patients;
    mapping(uint256 => Medicine) medicines;
    mapping(address => uint256) patientAddressID; //patient address to id mapping
    mapping(address => uint256) doctordAddressID; //patient address to id mapping

    
    // 1. Register a new doctor
    function registerNewDoctor(string memory _name, string memory _qualification, string memory _workPlace) public {
        require(doctordAddressID[msg.sender]==0, "Doctor account already exists with this blockchain address");
        uint256 doctorId = doctorCount+1;
        doctors[doctorId].id = doctorId;
        doctors[doctorId].name = _name;
        doctors[doctorId].qualification = _qualification;
        doctors[doctorId].workPlace = _workPlace;
        doctors[doctorId].doctorAddress = msg.sender;
        doctors[doctorId].flag = true;
        doctordAddressID[msg.sender] = doctorId;
    }

    // 2. Register a new patient
    function registerNewPatient(string memory _name, uint256 _age) public {
        require(patientAddressID[msg.sender]==0, "Patient account already exists with this blockchain address");
        uint256 patientId = patientCount+1;
        patients[patientId].id = patientId;
        patients[patientId].name = _name;
        patients[patientId].age = _age;
        patients[patientId].flag = true;
        patients[patientId].patientAddress = msg.sender;
    }

    // 3. Add a patient's disease
    function addPatientDisease(string memory _disease) public {
        require(patientAddressID[msg.sender]!=0, "Patient account with blockchain address does not exist. Please register");
        uint256 patientId = patientAddressID[msg.sender];
        patients[patientId].diseases.push(_disease);
    }

    // 4. Add medicine
    function addMedicine(uint256 _id, string memory _name, string memory _expiryDate, string memory _dose, uint256 _price) public {
        require(medicines[_id].flag==false, "Medicine with id already exists");
        medicineCount++;
        medicines[_id].id = _id;
        medicines[_id].name = _name;
        medicines[_id].expiryDate = _expiryDate;
        medicines[_id].dose = _dose;
        medicines[_id].price = _price;
        medicines[_id].flag = true;
    }

    // 5. Prescribe medicine
    function prescribeMedicine(uint256 _medicineId, address _patientAddress) public {
        require(patientAddressID[_patientAddress]!=0, "Patient with address does not exist");
        require(medicines[_medicineId].flag, "Medicine with id does not exist");
        uint256 patientId = patientAddressID[_patientAddress];
        patients[patientId].medicines.push(_medicineId);
    }

    // 6. Update patient details by patient
    function updatePatientDetails(uint256 _age) public {
        require(patientAddressID[msg.sender]!=0, "Patient account with blockchain address does not exist. Please register");
        uint256 patientId = patientAddressID[msg.sender];
        patients[patientId].age = _age;
    }

    // 7. View patient data
    function viewPatientDataSelf() public view
        returns(uint256 patientId, 
                uint256 age, 
                string memory name, 
                string[] memory diseases)
    {
        require(patientAddressID[msg.sender]!=0, "Patient account with blockchain address does not exist. Please register");
        uint256 _patientId = patientAddressID[msg.sender];
        return(
            patients[_patientId].id,
            patients[_patientId].age,
            patients[_patientId].name,
            patients[_patientId].diseases
        );
    }

    // 8 View medicine detatils
    function viewMedicineDetails(uint256 _medicineId) public view 
        returns(string memory name, 
                string memory expiryDate, 
                string memory dose, 
                uint256 price)
    {
        require(medicines[_medicineId].flag, "Medicine with id does not exist");
        return(
            medicines[_medicineId].name,
            medicines[_medicineId].expiryDate,
            medicines[_medicineId].dose,
            medicines[_medicineId].price
        );
    }

    // 9. View patient data by doctor
    function viewPatientDatabyDoctor(uint256 _patientId) public view
        returns(uint256 patientId, 
                uint256 age, 
                string memory name, 
                string[] memory diseases)
    {
        require(patients[_patientId].flag, "Patient with id does not exist");
        return(
            patients[_patientId].id,
            patients[_patientId].age,
            patients[_patientId].name,
            patients[_patientId].diseases
        );
    }

    // 10. View prescribed medicines to the patient
    function viewPatientMedicines(address _patientAddress) public view
        returns(uint256[] memory meds)
    {
        require(patientAddressID[_patientAddress]!=0, "Patient with address does not exist");
        uint256 _patientId = patientAddressID[_patientAddress];
        return(
            patients[_patientId].medicines
        );
    }

    // 11. View doctor details
    function viewDoctorDetails(uint256 _doctorId) public view
        returns(uint256 doctorId, 
                string memory name, 
                string memory qualification,
                string memory workPlace)
    {
        require(doctors[_doctorId].flag, "Doctor with id does not exist");
        return(
            doctors[_doctorId].id,
            doctors[_doctorId].name,
            doctors[_doctorId].qualification,
            doctors[_doctorId].workPlace
        );
    }
}