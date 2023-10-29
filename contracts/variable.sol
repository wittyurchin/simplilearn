//version of the solidity

// SPDX-License-Identifier: MIT 

//pragma solidity ^0.6.0;

//pragma solidity >=0.6.0 <0.7.0;
pragma solidity >=0.8.2 <0.9.0;

 

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