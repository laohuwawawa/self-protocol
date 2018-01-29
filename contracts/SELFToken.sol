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

    struct LockedBalance {
        uint id;
        address holder;
        uint256 step;
        uint8 counter;
        uint timer;
        uint timerStep;
    }

    uint256 initialSupply;
    uint256 public lockedBalance;

    //---------------------------
    address add1;
    address add2;

    LockedBalance[9] lockedBalances;

    uint public deployTime;
    
    function SELFToken(string tokenName,string tokenSymbol,uint256 initialSupply) public {
        name = tokenName;
        symbol = tokenSymbol;
        totalSupply = initialSupply * 10 ** uint256(decimals);
        initialSupply = totalSupply;

        


    }

    function withdrawLockedBalance(uint id) public returns (bool success) {
        LockedBalance _lockedBalance;
        bool exised = false;
        for (var index = 0;index < lockedBalances.length;index++) {
            if (id == lockedBalances[index].id) {
                _lockedBalance = lockedBalances[index];
                exised = true;
            }
        }

        require(exised && lockedBalance > 0 && _lockedBalance.counter > 0);

        uint timeElapsed = now - _lockedBalance.timer;

        require (timeElapsed >= _lockedBalance.timerStep);

        _lockedBalance.timer = now;
        _lockedBalance.counter -= 1;
        balances[_lockedBalance.holder] += _lockedBalance.step;
        lockedBalance -= _lockedBalance.step;
        return true;
    }



}