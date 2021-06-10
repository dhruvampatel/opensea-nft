// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Creature is ERC721, Ownable {
    using Strings for uint256;
    
    uint256 hashIPFS;
    address private _artist;
    address private _owner;
    string private _name;
    
    constructor(string memory name, uint256 _hashIPFS, address owner) ERC721(name, "OCN") {
        _name = name;
        hashIPFS = _hashIPFS;
        _artist = owner;
        _owner = owner;
    }
    
    function setOwner(address newOwner, address currentOwner) public {
        require(currentOwner == _owner);
        _owner = newOwner;
    }
    
    function tokenURI() public view returns (string memory) {
        return string(abi.encodePacked("https://creatures-api.opensea.io/api/creature/", hashIPFS.toString()));
    }
    
    function getOwner() public view returns (address) {
        return _owner;
    }
    
    function getArtist() public view returns (address) {
        return _artist;
    }
}
