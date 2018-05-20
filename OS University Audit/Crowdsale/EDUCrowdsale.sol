// Audit COPYRIGHT © 2018 - GLOBALIZED
// ALL RIGHTS RESERVED.

pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/AllowanceCrowdsale.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./EDUToken.sol";
import "./kyc/Certifiable.sol";

contract EDUCrowdsale is AllowanceCrowdsale, CappedCrowdsale, TimedCrowdsale, Ownable, Certifiable {
    using SafeMath for uint256;

    EDUToken public token;
    
    //@audit - why we have rate here ??? we have getCurrentRate function 
    
    //@audit - _rate = 1800
    //@audit - _wallet = "0x14723a09acff6d2a60dcdf7aa4aff308fddc160c"
    //@audit - _token = "0x0dcd2f752394c41875e259e00bb44fd505297caf"
    //@audit - _tokenWallet = "0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db"
    //@audit - _cap = 1800000
    //@audit - _openingTime = 1526737000
    //@audit - _closingTime = 1526739000
    //@audit - _certifier = "0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C"
    constructor(
        uint256 _rate,
        address _wallet,
        EDUToken _token,
        address _tokenWallet,
        uint256 _cap,
        uint256 _openingTime,
        uint256 _closingTime,
        address _certifier
    ) public
      Crowdsale(_rate, _wallet, _token)
      AllowanceCrowdsale(_tokenWallet)
      CappedCrowdsale(_cap)
      TimedCrowdsale(_openingTime, _closingTime)
      Certifiable(_certifier)
    {
        token = _token;
    }

    function _deliverTokens(address _beneficiary, uint256 _tokenAmount) internal {
        if (certifier.certified(_beneficiary)) {
            token.transferFrom(tokenWallet, _beneficiary, _tokenAmount);
        } else {
            token.delayedTransferFrom(tokenWallet, _beneficiary, _tokenAmount);
        }
    }

    /**
     * @dev Returns the rate of tokens per wei at the present time.
     * Note that, as price _increases_ with time, the rate _decreases_.
     * @return The number of tokens a buyer gets per wei at a given time
     */
     
    //@audit - First stage = 1526737200
    //@audit - Second stage = 1526737800
    //@audit - Third stage = 1526738400
    function getCurrentRate() public view returns (uint256) {
        if (block.timestamp < 1528718400) {
            return 1050;
        } else if (block.timestamp < 1529323200) {
            return 950;
        } else if (block.timestamp < 1529928000) {
            return 850;
        } else {
            return 750;
        }
    }

    /**
     * @dev Overrides parent method taking into account variable rate.
     * @param _weiAmount The value in wei to be converted into tokens
     * @return The number of tokens _weiAmount wei will buy at present time
     */
    function _getTokenAmount(uint256 _weiAmount) internal view returns (uint256)
    {
        uint256 currentRate = getCurrentRate();
        return currentRate.mul(_weiAmount);
    }
    
    //@audit - require(_tokenWallet != address(0x0))
    function changeTokenWallet(address _tokenWallet) external onlyOwner {
        tokenWallet = _tokenWallet;
    }
    
    //@audit - require(_wallet != address(0x0))
    function changeWallet(address _wallet) external onlyOwner {
        wallet = _wallet;
    }

}