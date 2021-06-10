// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import './Creature.sol';

contract Artist {
    address public artist;
    mapping(uint256 => Creature) creatures;
    
    event TokenCreated(Creature indexed tokenAddress);
    
    constructor() {
        artist = msg.sender;
    }
    
    function createCreature(string memory _name, uint256 hashIPFS) public returns(Creature){
        Creature creature = new Creature(_name, hashIPFS, msg.sender);
        creatures[hashIPFS] = creature;
        emit TokenCreated(creature);
        return creature;
    }
    
    function changeOwner(uint256 hashIPFS, address newOwner) external{
        //Checks if NFT exists or not
        require(address(creatures[hashIPFS]) != address(0x0), 'NFT does not exists');
        
        Creature creature = creatures[hashIPFS];
        creature.setOwner(newOwner, msg.sender);
    }
    
    function checkOwnership(uint256 hashIPFS) public view returns (bool) {
        if(creatures[hashIPFS].getOwner() == msg.sender){
            return true;
        }
        return false;
    }
}