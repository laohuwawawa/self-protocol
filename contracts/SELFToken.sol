pragma solidity ^0.4.18;

import "./BaseToken.sol";

contract SELFToken is BaseToken {

    address public administrator;
    uint public deployTime;

    function SELFToken(string tokenName,string tokenSymbol,uint256 initialSupply) public {

        name = tokenName;
        symbol = tokenSymbol;
        totalSupply = initialSupply * 10 ** uint256(decimals);
        deployTime = now;
        
        administrator = msg.sender;
        balances[administrator] = totalSupply;
    }

    function changeAdministrator(address newAdmin) public {
        
    }
}