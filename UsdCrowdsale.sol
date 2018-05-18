pragma solidity 0.4.23;

import "./openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "./openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./SimpleToken.sol";
//import "./ETHUSD.sol";

//contract UsdCrowdsale is Crowdsale, ETHUSD {
contract UsdCrowdsale is Crowdsale{
    using SafeMath for uint256;
    uint256 _rate = 1;  // USD <-> token rate,  not ETH
    address _wallet = msg.sender;
    uint256 public ethUsdPrice = 68939;  // test init value of ETH <-> USD price
    uint256 floatingPoint = 2;

    ERC20 _token = new SimpleToken();

    uint256 public constant minimumWei = 0.1 ether;
    uint256 public constant maximumWei = 20 ether;

    //constructor(uint256 _rate, address _wallet, ERC20 _token) public
    function UsdCrowdsale() public
    Crowdsale(_rate, _wallet, _token) {

    }


    function getRateWei(uint256 _wei) public view returns (uint256) {
        // 구현 실습 ethUsdPrice, rate 기반으로 주어진 wei 에 대해 몇 Token 을 주어야되는지 계산
    }

    function getRateEther(uint256 _ether) public view returns (uint256) {
        // 구현 실습 ethUsdPrice, rate 기반으로 주어진 ether 에 대해 몇 Token 을 주어야되는지 계산
    }

    /**
    * @dev Validation of an executed purchase. Observe state and use revert statements to undo rollback when valid conditions are not met.
    * @param _beneficiary Address performing the token purchase
    * @param _weiAmount Value in wei involved in the purchase
    */
    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal {
        super._preValidatePurchase(_beneficiary, _weiAmount);
        //require(_beneficiary != address(0));
        //require(_weiAmount != 0);
        require(_weiAmount >= minimumWei);
        require(maximumWei >= _weiAmount);
    }

    /**
     * @dev Override to extend the way in which ether is converted to tokens.
     * @param _weiAmount Value in wei to be converted into tokens
     * @return Number of tokens that can be purchased with the specified _weiAmount
     */
    function _getTokenAmount(uint256 _weiAmount) internal view returns (uint256) {
        // return _weiAmount.mul(rate);
        // 구현 실습 getRateWei 를 재활용하여 구현
    }

}