
//version of the solidity
// SPDX-License-Identifier: MIT 
//pragma solidity ^0.6.0;
pragma solidity >=0.6.0 <0.7.0;

//define the contract 
contract variable{

    //define variables 
    //integer variable --> signed and unsigned integer 
    //signed integer --> + and - values
    //unsigned integer --> + values 
    //uint256 --> 0.1 KB
    //uint8 --> 0.001KB

    uint8 age;
    uint8 height;
    uint128 amount;
    int128 balance;

    //string datatype --> string & bytes 
    string name;
    bytes name1 = "Alice";

    //bool variable --> true or false 
    bool car;

}

2nd Code 
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.3;

contract enumSample{

    //enumeration 
    enum Status {orderReceived, packaged, shipped, trackorder}
    Status status;

    function set() public {
        status=Status.packaged;
    }
}

3rd code 
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.3;

contract arraySample{
    //array --> fixed and dynamic 
    //fixed length array 
    //age[0]=38, age[1]=40........age[29]=25
    uint8[30] age;

    function setData(uint8 _index, uint8 _value) public {
        age[_index]=_value;
    }

    function readData(uint8 _index) public view returns(uint){
        return age[_index];
    }
   //dynamic array 
    uint[] phoneNumber;

    function setDynamicArray(uint _phoneno) public {
        phoneNumber.push(_phoneno);
    }

    function readDynamicArray(uint _index) public view returns(uint){
        return phoneNumber[_index];
    }
}

4th code

pragma solidity ^0.6.3;

contract structSample{

struct learner{
  string name;
  uint8 age;
}

//mapping 
//mapping (key => value) mapping name;
mapping(uint => learner) learners;
//1 => ("Alice", 40)
//2 => ("Tom", 25)
//3 => ("Jerry", 28)

function setLearnerDetails(uint8 _key, string memory _name, uint8 _age) public {
      //learners[1].name="alice"
      //learners[1].age=40
      learners[_key].name=_name;
      learners[_key].age=_age;

}

function getLearnerDetails(uint8 _key) public view returns(string memory, uint8){
  return(learners[_key].name,learners[_key].age);
}
  
}

5th code 

pragma solidity ^0.6.0;

contract Money{
    address alice = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    //balance --> give you the balance of the address 
    //transfer --> used to send/transfer to the address 

    function getMoney() public payable {}

    function TransferMoney() public {
        payable(alice).transfer(address(this).balance);
    }
}

6th code 
pragma solidity ^0.8.0;

contract local{

    uint amount; 
    uint age;
    string name;

    //local variable
    //view: read the details from the blockchain 
    //pure: not be able to read the details from the blockchain 

    function getvalue() public pure returns(uint){
        uint value;
        return value;
    }

    function hello() public pure returns(string memory){
        return "hello everyone!";
    }
}

7th code

pragma solidity ^0.8.0;

contract parent{

    string internal name;
    uint8 age;

    function getAge() public view returns(uint8){
        return age;
    }
}

contract child is parent {
 
    function getName() public view returns(string memory){
        return name;
    }

}

contract functionVisbility{

    string name;

    function getName() internal view returns(string memory){
        return name;
    }
}


constructor & Access Modifier & Event

pragma solidity ^0.6.3;

contract structSample{

  address public Simplilearn;

  constructor() public{
    Simplilearn = msg.sender;
    //0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678
  }

  modifier onlySimplilearn(){
    require(msg.sender == Simplilearn);
    _;
  }

  //event
  event newLearner (string name, uint8 age);

struct learner{
  string name;
  uint8 age; //State Variables
}

//mapping 
//mapping (key => value) mapping name;
mapping(uint => learner) learners;
//1 => ("Alice", 40)
//2 => ("Tom", 25)
//3 => ("Jerry", 28)

function setLearnerDetails(uint8 _key, string memory _name, uint8 _age) public onlySimplilearn {
      //learners[1].name="alice"
      //learners[1].age=40
      learners[_key].name=_name;
      learners[_key].age=_age;
      emit newLearner (_name,_age);

}

function getLearnerDetails(uint8 _key) public view returns(string memory, uint8){
  return(learners[_key].name,learners[_key].age);
}


  
}

8th code

pragma solidity ^0.8.0;

contract overloadingSample{

     string name;
     uint8 age;

     //function overloading
     /* This function helps me to define the 
     function overloading*/
     function setDetails(string memory _name, uint8 _age) public {
         name=_name;
         age=_age;
     }

     function setDetails(string memory _name) public {
         name=_name;
     }

      function setDetails(uint8 _age) public {
         age=_age;
     }

}

9th code

pragma solidity ^0.8.0;

contract ValueAlert{

    uint price =100;

    //define the event
    event priceEvent (bool returnvalue);

    function bid(uint _amount) public returns(bool){
        if(_amount>price){
            //fire the event
            emit priceEvent(true);
        }
        
        return true;
    }
}

10th code

pragma solidity ^0.8.0;

//define the library 
library MathFunc{

    function divide (int a, int b) public pure returns(int){
        require(b!=0, "Denominator can't be 0");
        return a/b;
    }
}

//using the library 
contract LibrarySample{
    using MathFunc for int;

    function div (int a, int b) public pure returns(int){
        return a.divide(b);
    }
}


11th code

pragma solidity ^0.8.0;

//define the library 
library MathFunc{

    function add (int a, int b, int c, int d) public pure returns(int){
        
        return a+b+c+d;
    }
}

//using the library 
contract LibrarySample{
    using MathFunc for int;

    function adding (int a, int b, int c, int d) public pure returns(int){
        return a.add(b,c,d);
    }
}


12th code

pragma solidity ^0.8.0;

contract errorhandlingSample{

    uint balance =100;

    function deductBal(uint _amount) public returns(uint){
        if(_amount < 2){
            revert("Input amount is not valid");
        }
        balance=balance - _amount;
        return balance;
        }
     function deductBal1(uint _amount) public returns(uint){
        require(_amount>1,"Input amount is not valid");
        balance=balance - _amount;
        return balance;
        }
    function deductBal2(uint _amount) public returns(uint){
        assert(_amount>1);
        balance=balance - _amount;
        return balance;
        }
    
}
Property Case Study

pragma solidity ^0.5.12;
contract PropertyTransferApp {
    address public contractOwner;
    constructor() public {
        contractOwner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == contractOwner);
        _;
    }
    struct Property {
        uint256 id;
        string name;
        string owner;
        uint256 value;
        uint256 area;
    }

    mapping(uint256 => Property) properties;
    function addProperty(
        uint256 _propertyid,
        string memory _name,
        string memory _owner,
        uint256 _value,
        uint256 _area
    ) public onlyOwner {
        properties[_propertyid].name = _name;
        properties[_propertyid].owner = _owner;
        properties[_propertyid].value = _value;
        properties[_propertyid].area = _area;
    }
    function queryPropertyById(uint256 _propertyid)
        public view returns (
            string memory name,
            string memory owner,
            uint256 area,
            uint256 value
        )
    {
        return (
            properties[_propertyid].name,
            properties[_propertyid].owner,
            properties[_propertyid].area,
            properties[_propertyid].value
        );
    }
    function transferPropertyOwnership(
        uint256 _propertyid,
        string memory _newOwner) public {
        properties[_propertyid].owner = _newOwner;
    }
}

//token code

pragma solidity ^0.4.16;

interface tokenRecipient {
    function receiveApproval(
        address _from,
        uint256 _value,
        address _token,
        bytes _extraData
    ) external;
}

contract TokenERC20 {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
    event Burn(address indexed from, uint256 value);

    constructor(
        uint256 initialSupply,
        string tokenName,
        string tokenSymbol
    ) public {
        totalSupply = initialSupply * 10**uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        name = tokenName;
        symbol = tokenSymbol;
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _value
    ) internal {
        require(_to != 0x0);
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        uint256 previousBalances = balanceOf[_from] + balanceOf[_to];
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    function transfer(address _to, uint256 _value)
        public returns (bool success)
    {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]); // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value)
        public returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function approveAndCall(
        address _spender,
        uint256 _value,
        bytes _extraData
    ) public returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }

    function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        emit Burn(msg.sender, _value);
        return true;
    }

    function burnFrom(address _from, uint256 _value)
        public returns (bool success)
    {
        require(balanceOf[_from] >= _value);
        require(_value <= allowance[_from][msg.sender]);
        balanceOf[_from] -= _value;
        allowance[_from][msg.sender] -= _value;
        totalSupply -= _value;
        emit Burn(_from, _value);
        return true;
    }
}


property:

pragma solidity ^0.5.12;
contract PropertyTransferApp {
    address public contractOwner;
    constructor() public {
        contractOwner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == contractOwner);
        _;
    }
    struct Property {
        uint256 id;
        string name;
        string owner;
        uint256 value;
        uint256 area;
    }

    mapping(uint256 => Property) properties;
    function addProperty(
        uint256 _propertyid,
        string memory _name,
        string memory _owner,
        uint256 _value,
        uint256 _area
    ) public onlyOwner {
        properties[_propertyid].name = _name;
        properties[_propertyid].owner = _owner;
        properties[_propertyid].value = _value;
        properties[_propertyid].area = _area;
    }
    function queryPropertyById(uint256 _propertyid)
        public view returns (
            string memory name,
            string memory owner,
            uint256 area,
            uint256 value
        )
    {
        return (
            properties[_propertyid].name,
            properties[_propertyid].owner,
            properties[_propertyid].area,
            properties[_propertyid].value
        );
    }
    function transferPropertyOwnership(
        uint256 _propertyid,
        string memory _newOwner) public {
        properties[_propertyid].owner = _newOwner;
    }
}


Hyperledger:

sudo chmod 666 /var/run/docker.sock

sudo curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.4.2 1.5.2


