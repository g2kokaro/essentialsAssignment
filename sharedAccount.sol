pragma solidity 0.5.8;

contract sharedAccount {
    mapping(address => byte) members;
    byte constant isMember = 0x01;
    
    event Transfer(address from, address to, uint amount);
    
    modifier onlyMember() {
        require (members[msg.sender] == isMember); 
        _;
    }
    
    constructor() public payable {
        members[msg.sender] = isMember;
    }
    
    function addNewMember(address _newMember) public onlyMember {
        members[_newMember] = isMember;
    }
    
    function pay(address payable _payee, uint256 _amount) public onlyMember {
        require(_amount >= address(this).balance);
        _payee.transfer(_amount);
        emit Transfer(msg.sender, _payee, _amount);
    }
}
