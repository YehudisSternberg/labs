
pragma solidity ^0.8.24;

/// @titel simple staking
/// @auther Yehudis Davis
import "../../lib/solmate/src/tokens/ERC20.sol";

contract Stake is ERC20{
ERC20 public token;
address public owner;
uint256 public totalReward = 1000000;
uint256 public totalStaking;
uint256 public beginDate;
mapping (address => uint256) public stakers;
mapping (address => uint256) public dates;

constructor() ERC20("MyToken", "MTK" ,16) {
        _mint(address(this), totalReward * (10 ** uint256(16)));
        owner = msg.sender;
        totalStaking = 0;
    }

receive() external payable{}

function mint (address to , uint amount) public{
    _mint(to,amount);
}
/// @dev a function that receives the staked coins and saves the date .
function stakeing(uint256 value) external payable {
    require(value > 0);
    dates[msg.sender] = block.timestamp;
    stakers[msg.sender] += value;
    totalStaking += value;
    transferFrom(msg.sender,address(this),value);
}

/// @dev a function that the staker could pull all his coins with geting his rewared
function unlockAll() external payable{
    require(stakers[msg.sender]>0 , "you do not have locked coins");
    require(dates[msg.sender] + 7 days <= block.timestamp , "you are not entitled to get a rewared");
    uint256 reward = (((100/(totalStaking/stakers[msg.sender]))*(totalReward))/100);
    // uint256 rewared = stakers[msg.sender]/totalStaking*totalReward;
    _mint(msg.sender,reward);
    transfer(msg.sender ,stakers[msg.sender] );
    // transfer(msg.sender , rewared + stakers[msg.sender] );
    totalStaking -= stakers[msg.sender];
    delete stakers[msg.sender];
    delete dates[msg.sender];
}

/// @dev a function for the staker to unlock only some of his coins and gettig a rewared accordingly
function unlock(uint amount) external payable{
    require(stakers[msg.sender]>0 , "you do not have locked coins");
    require(dates[msg.sender] + 7 days <= block.timestamp , "you are not entitled to get a rewared");
    require (stakers[msg.sender] > amount ,"you do not have the currect amount");
    uint256 reward = (((100/(totalStaking/amount))*(totalReward))/100);
    // uint256 rewared = amount/totalStaking*totalReward;
    _mint(msg.sender,reward);
    transfer(msg.sender ,amount);
    // transfer(msg.sender , rewared + amount );
    totalStaking -= amount;
    stakers[msg.sender] -= amount;
}


// if the staker addes coins ?
// the seven days will start again 

// if the staker want to take out his coin before 7 days ?
// he cannot do it the coins are locked

// if the staker wants to take out only some of his coins



}