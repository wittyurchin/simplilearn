// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract enumSample{

    //enumeration
    enum Status {OrderRecevied, packaged, shippied, trackorder}
    Status status;

    function set() public {
        status =Status.packaged;
    }

}