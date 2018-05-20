// Audit COPYRIGHT © 2018 - GLOBALIZED
// ALL RIGHTS RESERVED.

pragma solidity ^0.4.23;

contract Certifier {
    event Confirmed(address indexed who);
    event Revoked(address indexed who);
    function certified(address) public constant returns (bool);
	//@audit - Do you use the following functions 
    function get(address, string) public constant returns (bytes32);
    function getAddress(address, string) public constant returns (address);
    function getUint(address, string) public constant returns (uint);
}