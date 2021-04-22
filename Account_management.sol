pragma solidity >=0.4.22 <0.9.0;

contract AccountMangement{
    address payable public owner;

    constructor(address payable _owner) public {
        owner = _owner;
    }
    modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }

    enum gender {MALE, FEMALE}

    struct Addr{
        
        bytes32  line_1;
        bytes32  line_2;
        bytes32  city;
        bytes32  state;
        uint256 pincode;
    }
    
    struct User{
        bytes32  fName;
        bytes32  lName;
        uint256 age;
        gender Gender;
        Addr addr;
        

    }
    mapping(address => User)  users;
    mapping(address => bool) exist; 



function create_account( bytes32   _fName, bytes32  _lName, uint256 _age,
gender _gender, bytes32   _line1, bytes32   _line2, bytes32   _city, bytes32   _state, uint256 _pincode  ) public onlyOwner {
    
    User storage user = users[owner];
    exist[owner] = true;
    
    user.fName =_fName;
    user.lName =_lName;
    user.age =_age;
    user.Gender =_gender;
    user.addr.line_1 =_line1;
    user.addr.line_2 =_line2;
    user.addr.city =_city;
    user.addr.state =_state;
    user.addr.pincode =_pincode;
    
 }
 
 
 
 //edit account
 function edit_account(bytes32   _fName, bytes32   _lName, uint256 _age, gender _gender,bytes32   _line1, 
 bytes32   _line2, bytes32   _city, bytes32   _state, uint256 _pincode)public onlyOwner{
    
     if(exist[owner] == true){
     

        users[msg.sender].fName =_fName;
        users[msg.sender].lName =_lName;
        users[msg.sender].age =_age;
        users[msg.sender].Gender =_gender;
        users[msg.sender].addr.line_1 =_line1;
        users[msg.sender].addr.line_2 =_line2;
        users[msg.sender].addr.city =_city;
        users[msg.sender].addr.state =_state;
        users[msg.sender].addr.pincode =_pincode;
        return;
     }
     revert('First create a account ');
     
 }
 
 

    //deposite balance
  function deposit() payable public {
  }
    //ethereum to any given account 
  function send(address payable to, uint amount) public {
    if(msg.sender == owner) {
      to.transfer(amount);
      return;
    } 
    revert('sender is not allowed');
    
  }
  function balanceOf() view public returns(uint) {
    return address(this).balance;
  }
  
  
  
  
  
  //withdraw balance
  function withdraw() payable public onlyOwner{
        msg.sender.transfer(address(this).balance);
    }
    
  
  
}