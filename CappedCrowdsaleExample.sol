pragma solidity ^0.4.23;

import "./openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "./openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "./MyMintableToken.sol";

contract CappedCrowdsaleExample is CappedCrowdsale, FinalizableCrowdsale {

    function MyCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, uint256 _cap, address _wallet) public
    CappedCrowdsale(_cap)
    Crowdsale(_startTime, _endTime, _rate, _wallet) {

    }
}