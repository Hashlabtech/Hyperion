pragma solidity ^0.4.18;

contract Ownable {
  address public owner;


  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

}

contract WhiteList is Ownable {
    
    mapping(address => bool) public whiteList;
    address crowdsaleManager ;
    
    modifier onlyCrowdsaleManagerOrOwner() {
    require(crowdsaleManager == msg.sender || owner == msg.sender);
    _;
  }
    
    function WhiteList(address _crowdsaleManager) public {
        
        crowdsaleManager =_crowdsaleManager;    
        
    }
    
    
    function addToWhiteList(address _investor) public onlyCrowdsaleManagerOrOwner  {
    whiteList[_investor] = true;
  }

  function removeFromWhiteList(address _badInvestor) public onlyCrowdsaleManagerOrOwner  {
    whiteList[_badInvestor] = false;
   
  }
}
