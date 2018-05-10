pragma solidity ^0.4.23;

import "./openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "./SimpleToken.sol";

contract FinalizableCrowdsaleExample is FinalizableCrowdsale {

    uint256 _rate = 2;
    address _wallet = msg.sender;
    ERC20 _token = new SimpleToken();
    uint256 _openingTime = now;
    uint256 _closingTime = now + 60 * 10; // Sample Data, 10 min

    //constructor(uint256 _rate, address _wallet, ERC20 _token) public
    constructor() public
    Crowdsale(_rate, _wallet, _token)
    TimedCrowdsale(_openingTime, _closingTime) {

    }

    function finalization() internal {
        _deliverTokens(owner, token.balanceOf(this));
        //token.transfer(owner, token.balanceOf(this));
        super.finalization();
    }

}