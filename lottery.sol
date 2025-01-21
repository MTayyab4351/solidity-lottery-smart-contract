// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lottary{
    address public manager;
    address payable[] public particpent;  // payable use becacuse participent pay or sent ether to take part in lottary
    constructor()
    {
        manager=msg.sender; 
        
    }
    receive() external payable {
        require(msg.value==2 ether);
        particpent.push(payable(msg.sender));
     }
     
  function getbalance() public view returns(uint)
  {
    require(msg.sender==manager);
    return  address(this).balance;
  }
  function random() public view returns (uint){
   return  uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,particpent.length)));
  }
  function selectWinner() public 
  {
    require (msg.sender==manager);
    particpent.length>=3;
    uint r=random();
    address payable winner;
    uint index= r % particpent.length;
    winner=particpent[index];
     winner.transfer(getbalance());
     particpent=new address payable [](0);
  }
}
/*
1 recieve:
          A special function to accept ether. It gets triggered when someone 
          sends ether to the contract, and it doesn't require any data to be sent along
2 require:
          A function used to check if a condition is true. If it's false, it stops the 
          execution and reverts any changes made during the transaction. 
msg.sender:
           A global variable that gives the address of the person or contract calling the function.

msg.value:
          A global variable that represents the amount of ether (in wei) sent along with the transaction.
keccak256:
          A cryptographic hashing function used to create a fixed-size hash (unique value) from input data. 
          It’s often used for generating random values or for verifying data integrity.
*/