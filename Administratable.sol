pragma solidity ^0.5.10;

import "./Ownable.sol";
import "./Roles.sol";

contract Administratable is Ownable() {
    using Roles for Roles.Role;

    event AdminAdded(address indexed account);
    event AdminRemoved(address indexed account);

    Roles.Role private admins;

    modifier onlyAdmin() {
        require(isAdmin(msg.sender), "Administratable: requires admin access.");
        _;
    }

    function isAdmin(address account) public view returns (bool) {
        return admins.has(account);
    }

    function addAdmin(address account) public onlyOwner {
        admins.add(account);
        emit AdminAdded(account);
    }

    function removeAdmin(address account) public onlyOwner {
        admins.remove(account);
        emit AdminRemoved(account);
    }
}
