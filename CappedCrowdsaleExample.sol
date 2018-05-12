pragma solidity ^0.4.23;

import "./openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "./SimpleToken.sol";

contract CappedCrowdsaleExample is CappedCrowdsale {
    uint256 _rate = 2;
    address _wallet = msg.sender;
    ERC20 _token = new SimpleToken();
    uint256 _cap = 10 ether;

    // constructor(uint256 _cap, uint256 _rate, address _wallet, ERC20 _token) public
    constructor() public
    CappedCrowdsale(_cap)
    Crowdsale(_rate, _wallet, _token) {

    }
}