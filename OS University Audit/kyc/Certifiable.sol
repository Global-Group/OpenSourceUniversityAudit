// Audit COPYRIGHT © 2018 - GLOBALIZED
// ALL RIGHTS RESERVED.

pragma solidity ^0.4.23;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Certifier {
    event Confirmed(address indexed who);
    event Revoked(address indexed who);
    function certified(address) public constant returns (bool);
    function get(address, string) public constant returns (bytes32);
    function getAddress(address, string) public constant returns (address);
    function getUint(address, string) public constant returns (uint);
}

contract Certifiable is Ownable {
    Certifier public certifier;
    event CertifierChanged(address indexed newCertifier);
    
    //@audit - Owner: 0xf0DC9F2099B46EFb471007bFa337809D82bCEb4F
    //@audit - Certifier: 0xf0DC9F2099B46EFb471007bFa337809D82bCEb4F
    constructor(address _certifier) public {
        certifier = Certifier(_certifier);
    }
    
    //@audit - Certifier updated successfully by Owner with the address: 0x897866dd1ef88d1b9d34b3b4e3586a31f76f298a
    //@audit - Certifier update failed by the Certifier with the address: 0xf0DC9F2099B46EFb471007bFa337809D82bCEb4F
    function updateCertifier(address _address) public onlyOwner returns (bool success) {
        require(_address != address(0));
        emit CertifierChanged(_address);
        certifier = Certifier(_address);
        return true;
    }
}