pragma solidity ^0.4.23;

import "./openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";

contract MyMintableToken is MintableToken {
  string public constant name = "My Mintable Token";
  string public constant symbol = "MMT";
  uint8 public constant decimals = 18;
}