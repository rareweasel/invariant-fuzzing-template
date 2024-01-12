// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract AllowList {
    address[] public allowList;
    address public immutable owner;

    constructor(address _owner, address[] memory _allowList) {
        require(_owner != address(0), "invalid owner");
        require(_allowList.length > 0, "invalid allowList length");
        owner = _owner;
        allowList = _allowList;
    }

    function getAllowList() public view returns (address[] memory) {
        return allowList;
    }
}
