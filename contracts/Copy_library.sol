// SPDX-License-Identifier: MIT 

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
