pragma solidity ^0.4.18;

import "./BaseToken.sol";
import "./Copyright.sol";

contract Owned {

    address public owner;

    function Owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function getOwner() public returns (address owner) {
        return owner;
    }

    function transferOwnership (address newOwner) onlyOwner public {
        owner = newOwner;
    }
}

contract SELFToken is BaseToken, Copyright, Owned {

    uint public deployTime;

    uint public month = 30 days;
    
    function SELFToken(string tokenName,string tokenSymbol,uint256 initialSupply) public {
        name = tokenName;
        symbol = tokenSymbol;
        totalSupply = initialSupply * 10 ** uint256(decimals);
        deployTime = now;
    }

    
}