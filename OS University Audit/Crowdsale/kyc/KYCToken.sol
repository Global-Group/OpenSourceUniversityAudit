// Audit COPYRIGHT © 2018 - GLOBALIZED
// ALL RIGHTS RESERVED.

pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "./Certifiable.sol";

//@audit KYCToken can be only interface and it should not inherit ERC20 ???
contract KYCToken is ERC20, Certifiable {
    mapping (address => bool) public kycPending;
    mapping (address => bool) public managers;

    modifier onlyManager() {
        require(managers[msg.sender] == true);
        _;
    }

    modifier isKnownCustomer(address _address) {
        require(!kycPending[_address] || certifier.certified(_address));
        if (kycPending[_address]) {
            kycPending[_address] = false;
        }
        _;
    }

    constructor(address _certifier) public Certifiable(_certifier)
    {

    }
    
    //@audit - Successfully transfer to wallet by manager: 0xf0dc9f2099b46efb471007bfa337809d82bceb4f
    //@audit - Failed - transfering by person who is not manager with the address: 0xca35b7d915458ef540ade6068dfe2f44e8fa733c
    function delayedTransferFrom(address _tokenWallet, address _to, uint256 _value) public onlyManager returns (bool) {
        transferFrom(_tokenWallet, _to, _value);
        kycPending[_to] = true;
    }
    
    //@audit - Successfully added manager by owner: 0xf0dc9f2099b46efb471007bfa337809d82bceb4f
    //@audit - Failed - adding manager by person with the address: 0xca35b7d915458ef540ade6068dfe2f44e8fa733c
    function addManager(address _address) external onlyOwner {
        managers[_address] = true;
		//@audit - emit Event
    }
    
    //@audit - Successfully removed manager by owner: 0xf0dc9f2099b46efb471007bfa337809d82bceb4f
    //@audit - Failed - removing manager by person with the address: 0xca35b7d915458ef540ade6068dfe2f44e8fa733c
    function removeManager(address _address) external onlyOwner {
        managers[_address] = false;
		//@audit - emit Event
    }

}