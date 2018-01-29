pragma solidity ^0.4.18;

contract ERC20 {
      function totalSupply() constant returns (uint totalSupply);
      function balanceOf(address _tokenOwner) constant returns (uint balance);
      function allowance(address _tokenOwner, address _spender) constant returns (uint remaining);
      function transfer(address _to, uint _value) returns (bool success);
      function approve(address _spender, uint _value) returns (bool success);
      function transferFrom(address _from, address _to, uint _value) returns (bool success);

      event Transfer(address indexed _from, address indexed _to, uint _value);
      event Approval(address indexed _owner, address indexed _spender, uint _value);
}

contract BaseToken is ERC20 {
    
    string public name;
    string public symbol;
    uint8 public decimals = 18;

    uint256 public totalSupply;

    mapping (address => uint) public balances;
    mapping (address => mapping (address => uint256)) public allowances;

    function totalSupply() public constant returns (uint totalSupply) {
        return totalSupply;
    }

    function balanceOf(address _tokenOwner) public constant returns (uint balance) {
        return balanceOf(_tokenOwner);
    }

    function allowance(address _tokenOwner, address _spender) public constant returns (uint remaining) {
        return allowances[_tokenOwner][_spender];
    }

    function transfer(address _to, uint _value) public returns (bool success) {
        require(balances[msg.sender] >= _value && _value > 0);
        
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        Transfer(msg.sender, _to, _value);
        
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        require(balances[_from] >= _value && allowances[_from][msg.sender] >= _value && _value > 0);
        
        balances[_from] = balances[_from] - _value;
        balances[_to] = balances[_to] + _value;
        allowances[_from][msg.sender] = allowances[_from][msg.sender] - _value;
        Transfer(_from, _to, _value);
        
        return true;
    }

    function approve(address _spender, uint _value) public returns (bool success) {
        if ((_value != 0) && (allowances[msg.sender][_spender] != 0)) {
            revert();
        }
        allowances[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
}