// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";
import {console2 as console} from "forge-std/console2.sol";
import {AllowList} from "../../../src/AllowList.sol";

contract AllowListHandler is CommonBase, StdCheats, StdUtils {
    AllowList private allowList;

    constructor(AllowList _allowList) {
        allowList = _allowList;
    }

    function getAllowListLength() external view returns (uint256) {
        return allowList.getAllowList().length;
    }

    function addItem(address _item) external returns (bool) {
        hoax(allowList.owner());
        return allowList.addItem(_item);
    }

    function addItem(address _sender, address _item) external returns (bool) {
        hoax(_sender);
        return allowList.addItem(_item);
    }

    function removeItem(address _item) external returns (bool) {
        hoax(allowList.owner());
        return allowList.removeItem(_item);
    }

    function removeItem(
        address _sender,
        address _item
    ) external returns (bool) {
        hoax(_sender);
        return allowList.removeItem(_item);
    }
}
