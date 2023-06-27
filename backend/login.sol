
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoginWithMetaMask {
    mapping(address => bool) private authorizedUsers;

    event UserAuthenticated(address user);

    function authenticateUser() external {
        require(hasMetaMask(), "MetaMask not detected");
        authorizedUsers[msg.sender] = true;
        emit UserAuthenticated(msg.sender);
    }

    function hasMetaMask() public view returns (bool) {
        // Check if MetaMask is installed
        uint256 id = 0;
        (bool success, bytes memory result) = msg.sender.staticcall(abi.encodeWithSignature("isMetaMask()"));
        if (success) {
            assembly {
                id := mload(add(result, 32))
            }
            return id == 1;
        }
        return false;
    }

    function isAuthorized() public view returns (bool) {
        return authorizedUsers[msg.sender];
    }
}