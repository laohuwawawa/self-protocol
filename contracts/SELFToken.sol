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

    function getOwner() public view returns (address _owner) {
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

    

    //foundation account.
    address account1 = 0x627306090abaB3A6e1400e9345bC60c78a8BEf57;
    address account2 = 0xf17f52151EbEF6C7334FAD080c5704D77216b732;

    //other account.
    address account3 = 0xC5fdf4076b8F3A5357c5E395ab970B5B54098Fef;
    address account4 = 0x821aEa9a577a9b44299B9c15c88cf3087F3b5544;
    address account5 = 0x0d1d4e623D10F9FBA5Db95830F7d3839406C6AF2;
    address account6 = 0x2932b7A2355D6fecc4b5c0B6BD44cC31df247a2e;
    address account7 = 0x2191eF87E392377ec08E7c08Eb105Ef5448eCED5;
    address account8 = 0x0F4F2Ac550A1b4e2280d04c21cEa7EBD822934b5;
    address account9 = 0x6330A553Fc93768F612722BB8c2eC78aC90B3bbc;
    address account10 = 0x5AEDA56215b167893e80B4fE645BA6d5Bab767DE;

    uint256 public lockedBalance;
    LockedBalance[9] lockedBalances;

    uint month = 30 days;
    
    function SELFToken() public {
        name = "SELFMediaToken";
        symbol = "SELFT1";
        decimals = 2;

        uint256 hundredMillion = 10 ** (2 + decimals);
        uint256 million = 10 ** (1 + decimals);

        totalSupply = 100 * hundredMillion;
        balances[msg.sender] = totalSupply;
        
        balances[account1] = 40 * hundredMillion;
        balances[account2] = 10 * hundredMillion;

        lockedBalance = 50 * hundredMillion;

        lockedBalances[0] = LockedBalance({id: 1,holder: account2,step: 5 * hundredMillion,counter: 20,timer: now,timerStep: 1 years});

        lockedBalances[1] = LockedBalance({id: 2,holder: account3,step: 64 * million,counter: 15,timer: now,timerStep: month});

        lockedBalances[2] = LockedBalance({id: 3,holder: account4,step: 48 * million,counter: 15,timer: now,timerStep: month});

        lockedBalances[3] = LockedBalance({id: 4,holder: account5,step: 56 * million,counter: 15,timer: now,timerStep: month});

        lockedBalances[4] = LockedBalance({id: 5,holder: account6,step: 32 * million,counter: 15,timer: now,timerStep: month});

        lockedBalances[5] = LockedBalance({id: 6,holder: account7,step: 32 * million,counter: 20,timer: now,timerStep: month});

        lockedBalances[6] = LockedBalance({id: 7,holder: account8,step: 24 * million,counter: 20,timer: now,timerStep: month});

        lockedBalances[7] = LockedBalance({id: 8,holder: account9,step: 28 * million,counter: 20,timer: now,timerStep: month});

        lockedBalances[8] = LockedBalance({id: 9,holder: account10,step: 16 * million,counter: 20,timer: now,timerStep: month});
    }

    function getLockedBalance() public view returns (uint256 balance) {
        return lockedBalance;
    }

    function withdrawLockedBalance(uint id) public returns (bool success) {

        LockedBalance memory _lockedBalance;
        bool exised = false;
        for (uint8 index = 0; index < lockedBalances.length; index++) {
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
        if (id == 1) {
            totalSupply += _lockedBalance.step;
        } else {
            lockedBalance -= _lockedBalance.step;
        }
        
        return true;
    }
}