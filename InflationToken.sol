pragma solidity ^0.4.23;

/* from https://github.com/LanguageNetwork/smart-contracts
* @title InflationToken
* @author dongsamb, LangNet.io
*/

import "./openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "./openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./MathUtils.sol";


contract InflationToken is StandardToken {
    using SafeMath for uint256;
    using MathUtils for uint256;

    uint256 public annualInflationRate;
    uint256 public inflationPeriod;
    uint256 public periodicInflationRate;
    uint256 public inflationStartTime;
    uint256 public inflationCallRewardAmount;
    uint8 public decimals;
    uint256 public inflationCount;
    uint256 constant yearUTC = 60 * 60 * 24 * 365; //  31,536,000
    uint256 public inflationVault;

//    event Logging(uint256);
    // inflation event
    event Inflation(uint256 indexed inflationCount, address indexed inflationCaller, uint256 totalSpply, uint256 inflationValue, uint256 inflationTime);

    // start time
    constructor(uint256 _annualInflationRate, uint256 _inflationPeriod, uint8 _decimals, uint256 _inflationStartTime, uint256 _inflationCallRewardAmount) public {

        decimals = _decimals;
        
        // default settings
        if ( _annualInflationRate == 0 ){
            _annualInflationRate = 3 * (10 ** uint256(decimals));  // default, annual 3% inflation
        }
        if ( _inflationPeriod == 0 ){
             _inflationPeriod = 7 * (60 * 60 * 24);  // default, weekly
//            _inflationPeriod = 10;  // default, weekly
        }
        if ( _inflationStartTime == 0 ){
            _inflationStartTime = now;  // default, now(current block time)
        }
        if ( _inflationCallRewardAmount == 0 ){
            _inflationCallRewardAmount = 3 * (10 ** uint256(decimals));
        }
        

        annualInflationRate = _annualInflationRate;
        inflationPeriod = _inflationPeriod;
        inflationStartTime = _inflationStartTime;
        periodicInflationRate = annualInflationRate.div(yearUTC.div(_inflationPeriod));
        inflationCallRewardAmount = _inflationCallRewardAmount;
    }
    function inflate() private returns (bool _result){
        //uint256 inflation_value = totalSupply_.mul(periodicInflationRate_).div(10 ** (uint256(decimals)+2));
        uint256 inflation_value = totalSupply_.mul(periodicInflationRate).div(10 ** (uint256(decimals)+2));
//        emit Logging(inflation_value);
        inflation_value = inflation_value.roundOff(decimals);
//        emit Logging(inflation_value);
        totalSupply_ = totalSupply_.add(inflation_value);
        balances[this] = balances[this].add(inflation_value);
        inflationVault = inflationVault.add(inflation_value);
        inflationCount += 1;

        emit Inflation(inflationCount, msg.sender, totalSupply_, inflation_value, now);
        emit Transfer(0, this, inflation_value);
        return true;
    }

    function nowTime() public view returns (uint256) {
        return now;
    }
    
    // check can inflate for this period
    function canInflate() public view returns (bool) {
        return now > nextInflationTime();
    }

    function delayedInflationCount() public view returns (uint256) {
        return now.sub(nextInflationTime()).div(inflationPeriod)+1;
    }
    
    function nextInflationTime() public view returns (uint256) {
        return inflationStartTime.add((inflationCount+1).mul(inflationPeriod));
        // Todo: Fix logic for changed InflationRate
    }

    function periodicInflate() public returns (bool _result) {
        require(canInflate());
        bool result = inflate();
        require(result);
        if (inflationCallRewardAmount!=0) {
            balances[this] = balances[this].sub(inflationCallRewardAmount);
            balances[msg.sender] = balances[msg.sender].add(inflationCallRewardAmount);
            emit Transfer(this, msg.sender, inflationCallRewardAmount);
        }
        return result;
    }

//// Todo: need governance, DAO
//    function changeInflationPeriod(uint256 _inflationPeriod) internal returns (bool _result){
//        inflationPeriod = _inflationPeriod;
//    }
//    function changeInflationRate(uint256 _annualInflationRate) internal returns (bool _result){
//        annualInflationRate = _annualInflationRate;
//        periodicInflationRate = annualInflationRate.div(yearUTC.div(_inflationPeriod));
//    }
//    function changeInflationCallRewardAmount(uint256 _inflationCallRewardAmount) internal returns (bool _result){
//        _inflationCallRewardAmount;
//    }

}

contract MyInflationToken is InflationToken {
    string public constant name = "My Inflation Token";
    string public constant symbol = "MIT";
    uint8 public constant decimals = 18;
    //uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(decimals));
    uint256 public constant INITIAL_SUPPLY = 4000000000 * (10 ** uint256(decimals));

    constructor(uint256 _annualInflationRate, uint256 _inflationPeriod, uint256 _inflationStartTime, uint256 _inflationCallRewardAmount) public
    InflationToken(_annualInflationRate, _inflationPeriod, decimals, _inflationStartTime, _inflationCallRewardAmount) {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        emit Transfer(0x0, msg.sender, INITIAL_SUPPLY);
    }
}
