// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract AllowList {
    address[] public allowList;
    address public immutable owner;

    constructor(address _owner, address[] memory _allowList) {
        require(_owner != address(0), "invalid owner");
        owner = _owner;
        allowList = _allowList;
    }

    function getAllowList() public view returns (address[] memory) {
        return allowList;
    }

    function addItem(address _item) external returns (bool) {
        require(msg.sender == owner, "only owner");
        allowList.push(_item);
        return true;
    }

    function removeItem(address _item) external returns (bool) {
        require(msg.sender == owner, "only owner");
        for (uint256 i = 0; i < allowList.length; i++) {
            if (allowList[i] == _item) {
                allowList[i] = allowList[allowList.length - 1];
                allowList.pop();
                return true;
            }
        }
        return false;
    }
}
