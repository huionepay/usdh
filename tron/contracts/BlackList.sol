pragma solidity ^0.5.0;

import "./Ownable.sol";

contract BlackList is Ownable {

    /////// Getters to allow the same blacklist to be used also by other contracts (including upgraded Tether) ///////
    function getBlackListStatus(address _maker) public view returns (bool) {
        return isBlackListed[_maker];
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    modifier notBlack() {
        require(!isBlackListed[msg.sender]);
        _;
    }

    mapping (address => bool) public isBlackListed;

    function addBlackList (address _evilUser) public onlyOwner {
        isBlackListed[_evilUser] = true;
        emit AddedBlackList(_evilUser);
    }

    function removeBlackList (address _clearedUser) public onlyOwner {
        isBlackListed[_clearedUser] = false;
        emit RemovedBlackList(_clearedUser);
    }

    event AddedBlackList(address _user);

    event RemovedBlackList(address _user);
}