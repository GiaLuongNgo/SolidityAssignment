pragma solidity ^0.5.1;
contract MakingToken{
    
    event TokenMovements(address _from, address _to, uint256 _value);
    uint256 public totalSupply;
    mapping (address => uint256) balances;
    
    modifier onlyValidAddress(address _to){
        require(_to != address(0x00));
        _;
    }
  
    modifier onlyValidValue(address _from,uint256 _value){
        require(_value <= balances[_from]);
        _;
    }
  
    function () external payable {
        uint256 _issued = (msg.value)/10**18;
        totalSupply += _issued;
        balances[msg.sender] = _issued;
    }
  
    function balanceOf(address _owner) view private returns(uint256){
        return balances[_owner];
    
    }
    
    function transfer(address _to, uint256 _value)
    onlyValidAddress(_to)
    onlyValidValue(msg.sender,_value)
    public returns(bool){
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
        emit TokenMovements(msg.sender, _to, _value);
    }
  
}
