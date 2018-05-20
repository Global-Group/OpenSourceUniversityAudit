// Audit COPYRIGHT © 2018 - GLOBALIZED
// ALL RIGHTS RESERVED.

pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./Certifier.sol";

contract Certifiable is Ownable {
    Certifier public certifier;
    event CertifierChanged(address indexed newCertifier);
    
    //@audit - Owner: 0xca35b7d915458ef540ade6068dfe2f44e8fa733c
    //@audit - Certifier: 0xdd870fa1b7c4700f2bd7f44238821c26f7392148
    constructor(address _certifier) public {
        certifier = Certifier(_certifier);
    }
    
    //@audit - Certifier updated successfully by Owner with the address: 0x583031d1113ad414f02576bd6afabfb302140225
    //@audit - Certifier update failed by person with the address: 0x14723a09acff6d2a60dcdf7aa4aff308fddc160c
    function updateCertifier(address _address) public onlyOwner returns (bool success) {
        require(_address != address(0));
        emit CertifierChanged(_address);
        certifier = Certifier(_address);
        return true;
    }
}