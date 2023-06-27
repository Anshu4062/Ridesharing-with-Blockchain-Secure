// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegisterVehicle {
    struct Vehicle {
        string name;
        string dlImage;
        string carNumberPlateImage;
        string driverImage;
        string phoneNumber;
        string email;
        address walletAddress;
    }

    mapping (address => Vehicle) vehicles;
    mapping (string => bool) registeredCarNumberPlates;

    event VehicleRegistered(address indexed owner, string name, string dlImage, string carNumberPlateImage, string driverImage, string phoneNumber, string email, address walletAddress);

    function registerVehicle(string memory _name, string memory _dlImage, string memory _carNumberPlateImage, string memory _driverImage, string memory _phoneNumber, string memory _email) public {
        require(registeredCarNumberPlates[_carNumberPlateImage] == false, "Vehicle with this number plate is already registered");
        vehicles[msg.sender] = Vehicle(_name, _dlImage, _carNumberPlateImage, _driverImage, _phoneNumber, _email, msg.sender);
        registeredCarNumberPlates[_carNumberPlateImage] = true;
        emit VehicleRegistered(msg.sender, _name, _dlImage, _carNumberPlateImage, _driverImage, _phoneNumber, _email, msg.sender);
    }

    function getVehicleDetails() public view returns (string memory, string memory, string memory, string memory, string memory, string memory, address) {
        Vehicle storage vehicle = vehicles[msg.sender];
        return (vehicle.name, vehicle.dlImage, vehicle.carNumberPlateImage, vehicle.driverImage, vehicle.phoneNumber, vehicle.email, vehicle.walletAddress);
    }
}
