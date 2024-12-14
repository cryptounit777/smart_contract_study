// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract EnsDomain {
    address private owner;
    uint256 public oneYearPrice;
    uint256 public renewalCoefficient;

    uint256 constant SECONDS_IN_YEAR = 31536000; 

    struct DomainInfo {
        address owner;
        uint256 dateOfRegistration;
        uint256 price;
        uint256 subscribeYears;
    }

    mapping(string => DomainInfo) public domains;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not an owner!");
        _;
    }

    function setOneYearPrice(uint256 _price) public onlyOwner {
        oneYearPrice = _price;
    }

    function setRenewalCoefficient(uint256 _coefficient) public onlyOwner {
        renewalCoefficient = _coefficient;
    }

    function buyEnsDomanin(
        string memory domain,
        uint256 subscribeYears
    ) public payable {
        require(
            subscribeYears <= 10 && subscribeYears >= 1,
            "Incorrect period!"
        );
        require(
            msg.value >= subscribeYears * oneYearPrice,
            "You don't have enough funds!"
        );
        require(_isDomainAvaliable(domain), "Domain is not avaliable!");

        domains[domain] = DomainInfo(
            msg.sender,
            block.timestamp,
            msg.value,
            subscribeYears
        );
    }

    function domainRenewal(
        string memory domain,
        uint256 renewYears
    ) public payable {
        require(domains[domain].owner == msg.sender, "You're not owner!");
        //require(!_isDomainAvaliable(domain), "Subscription already ended!"); 
        uint256 price = (oneYearPrice * renewYears) / 100; 
        require(msg.value >= price, "You don't have enought funds!");
        domains[domain].price += price;
        domains[domain].subscribeYears += renewYears; 
    }

    function _isDomainAvaliable(
        string memory domain
    ) private view returns (bool) {
        return
            block.timestamp -
                (domains[domain].dateOfRegistration +
                    SECONDS_IN_YEAR *
                    domains[domain].subscribeYears) >
            0; 
    }

    function getDomainOwner(
        string memory domainName
    ) public view returns (address) {
        return domains[domainName].owner;
    }

    function withdrawMoney() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}