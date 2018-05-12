pragma solidity ^0.4.23;

// File: Library/Mobile Documents/com~apple~CloudDocs/git/contracts/solidity-korea/crowdsale-A-to-Z/MathUtils.sol

/* from https://github.com/LanguageNetwork/smart-contracts
* @title MathUtils
* @author dongsamb, LangNet.io
*/

library MathUtils {

    function ceil(uint256 input, uint256 decimals) pure internal returns (uint256) {
        uint256 target = 10 ** decimals;
        require(input > target);
        return ((input + target - 1) / target) * target;
    }

    function round(uint256 input, uint256 decimals) pure internal returns (uint256) {
        uint256 target = 10 ** decimals;
        require(input > target);
        return (input / target) * target;
    }

    function roundOff(uint256 input, uint256 decimals) pure internal returns (uint256) {
        uint256 target = 10 ** decimals;
        require(input > target);
        if ( input % target >= 5 * target / 10 ) {
            return ((input + target - 1) / target) * target;
        }
        else {
            return (input / target) * target;
        }
    }
}

// File: Library/Mobile Documents/com~apple~CloudDocs/git/contracts/solidity-korea/crowdsale-A-to-Z/openzeppelin-solidity/contracts/math/SafeMath.sol

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    if (a == 0) {
      return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return a / b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}

// File: Library/Mobile Documents/com~apple~CloudDocs/git/contracts/solidity-korea/crowdsale-A-to-Z/openzeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

// File: Library/Mobile Documents/com~apple~CloudDocs/git/contracts/solidity-korea/crowdsale-A-to-Z/openzeppelin-solidity/contracts/token/ERC20/BasicToken.sol

/**
 * @title Basic token
 * @dev Basic version of StandardToken, with no allowances.
 */
contract BasicToken is ERC20Basic {
  using SafeMath for uint256;

  mapping(address => uint256) balances;

  uint256 totalSupply_;

  /**
  * @dev total number of tokens in existence
  */
  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  /**
  * @dev transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balances[msg.sender]);

    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public view returns (uint256) {
    return balances[_owner];
  }

}

// File: Library/Mobile Documents/com~apple~CloudDocs/git/contracts/solidity-korea/crowdsale-A-to-Z/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: Library/Mobile Documents/com~apple~CloudDocs/git/contracts/solidity-korea/crowdsale-A-to-Z/openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol

/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * @dev https://github.com/ethereum/EIPs/issues/20
 * @dev Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract StandardToken is ERC20, BasicToken {

  mapping (address => mapping (address => uint256)) internal allowed;


  /**
   * @dev Transfer tokens from one address to another
   * @param _from address The address which you want to send tokens from
   * @param _to address The address which you want to transfer to
   * @param _value uint256 the amount of tokens to be transferred
   */
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    return true;
  }

  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   *
   * Beware that changing an allowance with this method brings the risk that someone may use both the old
   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   * @param _spender The address which will spend the funds.
   * @param _value The amount of tokens to be spent.
   */
  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(address _owner, address _spender) public view returns (uint256) {
    return allowed[_owner][_spender];
  }

  /**
   * @dev Increase the amount of tokens that an owner allowed to a spender.
   *
   * approve should be called when allowed[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _addedValue The amount of tokens to increase the allowance by.
   */
  function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
   * @dev Decrease the amount of tokens that an owner allowed to a spender.
   *
   * approve should be called when allowed[_spender] == 0. To decrement
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _subtractedValue The amount of tokens to decrease the allowance by.
   */
  function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

}

// File: Library/Mobile Documents/com~apple~CloudDocs/git/contracts/solidity-korea/crowdsale-A-to-Z/InflationToken.sol

/* from https://github.com/LanguageNetwork/smart-contracts
* @title InflationToken
* @author dongsamb, LangNet.io
*/





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
