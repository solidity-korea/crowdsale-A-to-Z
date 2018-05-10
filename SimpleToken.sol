pragma solidity ^0.4.23;

import "./openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract SimpleToken is StandardToken {
    string public constant name = "My Simple Token";
    string public constant symbol = "MST";
    uint8 public constant decimals = 18;

    uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(decimals));

    constructor() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        emit Transfer(0x0, msg.sender, INITIAL_SUPPLY);
    }

//    constructor(uint256 _initialSupply) public {
//        if ( _initialSupply != 0) totalSupply_ = _initialSupply;
//    }
}