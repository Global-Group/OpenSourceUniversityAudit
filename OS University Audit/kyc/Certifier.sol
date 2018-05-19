// Audit COPYRIGHT © 2018 - GLOBALIZED.IO 
// ALL RIGHTS RESERVED.

//@audit - NOTE: Use latest version of solidity
pragma solidity ^0.4.15;

contract Certifier {
    event Confirmed(address indexed who);
    event Revoked(address indexed who);
    function certified(address) public constant returns (bool);
    function get(address, string) public constant returns (bytes32);
    function getAddress(address, string) public constant returns (address);
    function getUint(address, string) public constant returns (uint);
}