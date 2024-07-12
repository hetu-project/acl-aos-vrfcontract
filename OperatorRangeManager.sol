// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OperatorRangeManager {
    address public owner;
    uint256 constant MAX_RANGE = 600000; // Maximum range value

    struct OperatorRange {
        uint256 start;
        uint256 end;
    }

    mapping(address => OperatorRange) public operatorRanges; // Using operator address as the index
    address[] public operators; // Storing all registered operator addresses

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function registerOperator(address operatorAddress, uint256 start, uint256 end) public onlyOwner {
        require(!isOperatorRegistered(operatorAddress), "Operator already registered");
        require(start < end, "Start range must be less than end range");
        require(end <= MAX_RANGE, "End range cannot exceed maximum range");
        operatorRanges[operatorAddress] = OperatorRange(start, end);
        operators.push(operatorAddress);
    }

    function updateOperatorRange(address operatorAddress, uint256 start, uint256 end) public onlyOwner {
        require(isOperatorRegistered(operatorAddress), "Operator not registered");
        require(start < end, "Start range must be less than end range");
        require(end <= MAX_RANGE, "End range cannot exceed maximum range");
        operatorRanges[operatorAddress] = OperatorRange(start, end);
    }

    function getOperatorsInRange(uint256 value) public view returns (address[] memory) {
        address[] memory operatorsInRange = new address[](operators.length);
        uint256 count = 0;
        
        for (uint256 i = 0; i < operators.length; i++) {
            address operatorAddress = operators[i];
            OperatorRange memory range = operatorRanges[operatorAddress];
            if (value >= range.start && value <= range.end) {
                operatorsInRange[count] = operatorAddress;
                count++;
            }
        }
        
        // Create a new array containing only the matched operator addresses
        address[] memory result = new address[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = operatorsInRange[i];
        }
        return result;
    }

    function getNumOperators() public view returns (uint256) {
        return operators.length;
    }

    function isOperatorRegistered(address operatorAddress) private view returns (bool) {
        for (uint256 i = 0; i < operators.length; i++) {
            if (operators[i] == operatorAddress) {
                return true;
            }
        }
        return false;
    }
}
