contract RequireDemo {
  address owner;

  modifier onlyOwner() {
    require(msg.sender == owner, "You are not an owner!");
    _;
  }

  constructor() {
    owner = msg.sender;
  }

  function withdrawAllMoney(address payable _to) public onlyOwner {
    _to.transfer(address(this).balance);
  }

  function destroyContract(address payable _to) public onlyOwner {
    selfdestruct(_to);
  }
}