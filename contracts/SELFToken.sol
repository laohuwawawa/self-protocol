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

    struct LockedFund {
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

    uint256 public lockedFund;
    LockedFund[9] lockedFunds;

    uint month = 5 minutes;
    
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

        lockedFund = 50 * hundredMillion;

        lockedFunds[0] = LockedFund({id: 1,holder: account2,step: 5 * hundredMillion,counter: 20,timer: now,timerStep: 10 minutes});

        lockedFunds[1] = LockedFund({id: 2,holder: account3,step: 64 * million,counter: 15,timer: now,timerStep: month});

        lockedFunds[2] = LockedFund({id: 3,holder: account4,step: 48 * million,counter: 15,timer: now,timerStep: month});

        lockedFunds[3] = LockedFund({id: 4,holder: account5,step: 56 * million,counter: 15,timer: now,timerStep: month});

        lockedFunds[4] = LockedFund({id: 5,holder: account6,step: 32 * million,counter: 15,timer: now,timerStep: month});

        lockedFunds[5] = LockedFund({id: 6,holder: account7,step: 32 * million,counter: 20,timer: now,timerStep: month});

        lockedFunds[6] = LockedFund({id: 7,holder: account8,step: 24 * million,counter: 20,timer: now,timerStep: month});

        lockedFunds[7] = LockedFund({id: 8,holder: account9,step: 28 * million,counter: 20,timer: now,timerStep: month});

        lockedFunds[8] = LockedFund({id: 9,holder: account10,step: 16 * million,counter: 20,timer: now,timerStep: month});
    }

    function getLockedFund() public view returns (uint256 balance) {
        return lockedFund;
    }

    function withdrawLockedBalance(uint id) public returns (bool success) {

        LockedFund memory _lockedFund;
        bool exised = false;
        for (uint8 index = 0; index < lockedFunds.length; index++) {
            if (id == lockedFunds[index].id) {
                _lockedFund = lockedFunds[index];
                exised = true;
            }
        }

        require(exised && lockedFund > 0 && _lockedFund.counter > 0);

        uint timeElapsed = now - _lockedFund.timer;

        require (timeElapsed >= _lockedFund.timerStep);

        _lockedFund.timer = now;
        _lockedFund.counter -= 1;
        balances[_lockedFund.holder] += _lockedFund.step;
        if (id == 1) {
            totalSupply += _lockedFund.step;
        } else {
            lockedFund -= _lockedFund.step;
        }
        
        return true;
    }
}