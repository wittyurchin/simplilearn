pragma solidity ^0.6.0;

contract Money{
    address alice = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C;
    //balance --> give you the balance of the address 
    //transfer --> used to send/transfer to the address 

    function getMoney() public payable {}

    function TransferMoney() public {
        payable(alice).transfer(address(this).balance);
    }
}