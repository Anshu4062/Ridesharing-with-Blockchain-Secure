// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Profile {
    struct UserProfile {
        string name;
        string email;
        string phoneNumber;
        uint256 dob;
        address walletAddress;
    }

    mapping(address => UserProfile) private userProfiles;

    event UserProfileUpdated(address indexed user, string name, string email, string phoneNumber, uint256 dob, address walletAddress);

    function updateUserProfile(string memory _name, string memory _email, string memory _phoneNumber, uint256 _dob, address _walletAddress) public {
        userProfiles[msg.sender] = UserProfile(_name, _email, _phoneNumber, _dob, _walletAddress);
        emit UserProfileUpdated(msg.sender, _name, _email, _phoneNumber, _dob, _walletAddress);
    }

    function getUserProfile() public view returns (string memory, string memory, string memory, uint256, address) {
        UserProfile memory profile = userProfiles[msg.sender];
        return (profile.name, profile.email, profile.phoneNumber, profile.dob, profile.walletAddress);
    }
}