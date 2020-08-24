pragma solidity ^0.5.10;

library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    function add(Role storage role, address account) internal {
        require(account != address(0), "Roles: adding role to the zero address");
        role.bearer[account] = true;
    }

    function remove(Role storage role, address account) internal {
        require(account != address(0), "Roles: removing role from the zero address");
        role.bearer[account] = false;
    }

    function has(Role storage role, address account)
        internal
        view
        returns (bool)
    {
        require(account != address(0), "Roles: zero address check");
        return role.bearer[account];
    }
}
