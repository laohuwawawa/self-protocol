pragma solidity ^0.4.18;

contract Copyright {
    
    mapping (address => mapping(uint => uint)) public copyrightInfo;

    address public manager;

    function Copyright() public {
        manager = msg.sender;
    }

    function recordCopyright(address writer,uint copyright,uint version) onlyManager public returns (bool success) {
        uint _version = copyrightInfo[writer][copyright];
        require(version > _version);
        copyrightInfo[writer][copyright] = version;
        return true;
    }

    function queryCopyright(address writer, uint copyright) public view returns (uint version) {
        return copyrightInfo[writer][copyright];
    }

    function changeManager(address newManager) onlyManager public {
        manager = newManager;
    }

    modifier onlyManager {
        require(msg.sender == manager);
        _;
    }
}