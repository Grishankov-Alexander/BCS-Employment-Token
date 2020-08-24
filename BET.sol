pragma solidity ^0.5.10;

import "./ERC20.sol";
import "./ERC20Detailed.sol";
import "./Administratable.sol";

contract BET is ERC20, ERC20Detailed, Administratable {
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 totalSupply
    )
        ERC20Detailed(name, symbol, decimals)
        public
    {
        super._mint(msg.sender, totalSupply);
    }

    function burn(address account, uint256 amount) public {
        require(
            isOwner() || isAdmin(msg.sender) || account == msg.sender,
            "BET: Only account owner, contract owner or admin can burn"
        );
        super._burn(account, amount);
    }

    function mint(address account, uint256 amount) public {
        require(
            isOwner() || isAdmin(msg.sender),
            "BET: Only contract owner or admin can mint tokens"
        );
        super._mint(account, amount);
    }

    function() external payable {
        require(msg.data.length == 0, "BET: Data sent to payable function");
        require(msg.value > 0, "BET: Payment was not sent");
        super._mint(msg.sender, msg.value);
    }

    function withdraw() external onlyOwner {
        require(address(this).balance > 0, "BET: Empty contract balance");
        msg.sender.transfer(address(this).balance);
    }
}
