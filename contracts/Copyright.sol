pragma solidity ^0.4.18;

contract Copyright {
    
    mapping (address => mapping(bytes32 => string)) public copyrightInfo;

    address public manager;

    function Copyright() public {
        manager = msg.sender;
    }

    function recordCopyright(address writer,string writerId,string sourceId,string info) onlyManager public returns (bytes32 _copyright) {
        bytes32 copyright = keccak256(writerId,sourceId,now);
        copyrightInfo[writer][copyright] = info;
        return copyright;
    }

    function queryCopyright(bytes32 copyright) public returns (string info) {
         return queryCopyrightByWriter(msg.sender,copyright);
    }

    function queryCopyrightByWriter(address writer, bytes32 copyright) public returns (string info) {
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