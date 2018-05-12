pragma solidity ^0.4.23;

import "./openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "./SimpleToken.sol";

contract SimpleCrowdsaleMinMax is Crowdsale {
    // function SimpleCrowdsale

    uint256 _rate = 2;
    address _wallet = msg.sender;
    ERC20 _token = new SimpleToken();

    uint256 public constant minimumWei = 0.1 ether;
    uint256 public constant maximumWei = 20 ether;


    //constructor(uint256 _rate, address _wallet, ERC20 _token) public
    constructor() public
    Crowdsale(_rate, _wallet, _token) {

    }

    /**
     * @dev Validation of an executed purchase. Observe state and use revert statements to undo rollback when valid conditions are not met.
     * @param _beneficiary Address performing the token purchase
     * @param _weiAmount Value in wei involved in the purchase
     */
    function _postValidatePurchase(address _beneficiary, uint256 _weiAmount) internal {
        require(_weiAmount >= minimumWei);
        require(maximumWei >= _weiAmount);
    }

}