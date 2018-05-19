// Audit COPYRIGHT © 2018 - GLOBALIZED.IO 
// ALL RIGHTS RESERVED.

//@audit - NOTE: Use latest version of solidity
pragma solidity ^0.4.15;

contract Owned {
    //@audit - Maybe you should make constructor and initialize the "owner" there
    
    //@audit - "only_owner" the convention for naming is camelCase
	modifier only_owner {
        require (msg.sender == owner);
        _;
    }

	event NewOwner(address indexed old, address indexed current);

	function setOwner(address _new) public only_owner {
	    //@audit - emit the "NewOwner" event
	    //@audit - "owner = _new;" should on new row
        NewOwner(owner, _new); owner = _new;
    }
    
    //@audit - Should be on top of the contract
	address public owner = msg.sender;
}