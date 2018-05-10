pragma solidity ^0.4.23;

import "./openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "./SimpleToken.sol";

contract SimpleCrowdsale is Crowdsale {
    // function SimpleCrowdsale

    uint256 public _rate = 2;
    address _wallet;
    ERC20 _token;

    //constructor(uint256 _rate, address _wallet, ERC20 _token) public
    constructor() public
    Crowdsale(_rate, _wallet, _token) {
    
    }
}