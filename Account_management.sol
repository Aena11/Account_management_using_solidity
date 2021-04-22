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
        
        string line_1;
        string line_2;
        string city;
        string state;
        uint256 pincode;
    }
    
    struct User{
        string fName;
        string lName;
        uint256 age;
        gender Gender;
        Addr addr;
        

    }
    mapping(address => User)  users;
    mapping(address => bool) exist; 



function createUser( string memory _fName, string memory _lName, uint256 _age,
gender _gender, string memory _line1, string memory _line2, string memory _city, string memory _state, uint256 _pincode  ) public onlyOwner {
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
 function edit_account(string memory _fName, string memory _lName, uint256 _age, gender _gender,string memory _line1, 
 string memory _line2, string memory _city, string memory _state, uint256 _pincode)public onlyOwner {
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