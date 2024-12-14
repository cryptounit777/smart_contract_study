contract FunctionsDemo {
  address sender;
  mapping(address => uint) public balanceReceived;
   address owner;
    
  constructor() {
    owner = msg.sender;
  }
        function sendMoney(address payable _addr) public payable{
        _addr.transfer(msg.value);
    }
  
  function receiveMoney() public payable {
    balanceReceived[msg.sender] += msg.value;
  }

  fallback() external payable { 
    sender = msg.sender;
  }

  receive() external payable { 
    receiveMoney(); 
  }
}