// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RideSharing {

    struct Ride {
        address payable driver;
        uint256 rideId;
        string startingLocation;
        string destinationLocation;
        uint256 price;
        bool isAvailable;
    }

    mapping (uint256 => Ride) rides;
    uint256 public rideCounter;

    mapping (address => bool) public drivers;

    event RideAdded(address driver, uint256 rideId, string startingLocation, string destinationLocation, uint256 price);
    event RideBooked(address rider, uint256 rideId, string startingLocation, string destinationLocation, uint256 price);

    constructor() {
        rideCounter = 0;
    }

    function addRide(string memory _startingLocation, string memory _destinationLocation) public {
        require(drivers[msg.sender], "Only registered drivers can add rides");

        rideCounter++;

        uint256 ridePrice = calculatePrice(_startingLocation, _destinationLocation);

        rides[rideCounter] = Ride(payable(msg.sender), rideCounter, _startingLocation, _destinationLocation, ridePrice, true);

        emit RideAdded(msg.sender, rideCounter, _startingLocation, _destinationLocation, ridePrice);
    }

    function bookRide(uint256 _rideId) public payable {
        require(msg.value >= rides[_rideId].price, "Insufficient payment");
        require(rides[_rideId].isAvailable, "Ride is not available");

        rides[_rideId].isAvailable = false;
        rides[_rideId].driver.transfer(msg.value);

        emit RideBooked(msg.sender, _rideId, rides[_rideId].startingLocation, rides[_rideId].destinationLocation, rides[_rideId].price);
    }

    function registerDriver() public {
        drivers[msg.sender] = true;
    }

    function calculatePrice(string memory _startingLocation, string memory _destinationLocation) internal pure returns (uint256) {
    
        uint256 distance = 100;
        uint256 price = distance * 100000000000; // 0.0000001 ether per meter
        return price;
    }
}