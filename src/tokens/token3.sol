pragma solidity ^0.8.24;

import "../../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract Token3 is ERC721 {
   
    constructor() ERC721("NFT", "nft") {
     
    }

    function mint(address add, uint amount) public {
        _mint(add , amount);
    }
}