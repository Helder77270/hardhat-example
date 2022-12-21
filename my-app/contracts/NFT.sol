//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId; // Safe counter and increment/decrements
    
    address[] public whitelist;
    mapping(uint256 => string) public uris;

    constructor() ERC1155("") {}

    function addToWhitelist(address _address) public onlyOwner returns (uint8) {
        for(uint i = 0; i < whitelist.length; i++){
            if(whitelist[i] == _address){
                return 1;
            }
        }
        whitelist.push(_address);
        return 0;
    }

    function getWhitelist() public view onlyOwner returns (address[] memory){
        return whitelist;
    }
    function getTokenId() public view returns (uint256){
        return _tokenId.current();
    }

    function checkWhitelist(address _address) public view returns (bool){
        for(uint i = 0; i<=whitelist.length; i++){
            if(whitelist[i] == _address){
                return true;
            }
        }
        return false;
    }

    function getURI(uint256 id) public view returns (string memory){
        require(getTokenId() >= id, "Unexisting NFT, please try again later"); // gets the current id counter to ensure user isn't trying to call an unexisting item
        return uris[id];
    }

     function setURI(uint256 id, string memory uri) public onlyOwner{
        uris[id] = uri;
    }

    function getAllNFT() public view returns (string[] memory){
        uint256 currentId = getTokenId();
        if(currentId > 0){
            string[] memory nfts = new string[](currentId);
            for(uint256 i = 0; i< currentId; i++){
                nfts[i] = uris[i];
            }

            return nfts;
        }else{
            string[] memory empty = new string[](1);
            empty[0] = "none";
            return empty;
        }
    }

    function mint(uint256 amount, bytes calldata data, string calldata uri) public onlyOwner {
        _mint(_msgSender(), _tokenId.current(), amount, data);
        uris[_tokenId.current()] = uri;
        _tokenId.increment();
    }
}
