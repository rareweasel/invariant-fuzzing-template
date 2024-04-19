// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

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
        uint256 _length = allowList.length;
        for (uint256 i = 0; i < _length; i++) {
            if (allowList[i] == _item) {
                allowList[i] = allowList[_length - 1];
                // slither-disable-next-line costly-loop
                allowList.pop();
                return true;
            }
        }
        return false;
    }
}
