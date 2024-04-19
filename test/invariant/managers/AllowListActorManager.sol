// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";
import {AllowListHandler} from "../handlers/AllowListHandler.sol";
import {console2 as console} from "forge-std/console2.sol";

contract AllowListActorManager is CommonBase, StdCheats, StdUtils {
    AllowListHandler[] private handlers;

    uint256 public currentLength;

    constructor(uint256 _currentLength, AllowListHandler[] memory _handlers) {
        currentLength = _currentLength;
        handlers = _handlers;
    }

    function addItem(uint256 _handlerIndex, address _item) external {
        uint256 index = bound(_handlerIndex, 0, handlers.length - 1);
        bool result = handlers[index].addItem(_item);
        if (result) {
            currentLength++;
        }
    }

    function addItem(
        uint256 _handlerIndex,
        address _sender,
        address _item
    ) external {
        uint256 index = bound(_handlerIndex, 0, handlers.length - 1);
        bool result = handlers[index].addItem(_sender, _item);
        if (result) {
            currentLength++;
        }
    }

    function removeItem(uint256 _handlerIndex, address _item) external {
        uint256 index = bound(_handlerIndex, 0, handlers.length - 1);
        bool result = handlers[index].removeItem(_item);
        if (result) {
            currentLength--;
        }
    }

    function removeItem(
        uint256 _handlerIndex,
        address _sender,
        address _item
    ) external {
        uint256 index = bound(_handlerIndex, 0, handlers.length - 1);
        bool result = handlers[index].removeItem(_sender, _item);
        if (result) {
            currentLength--;
        }
    }

    function getAllowListLength(
        uint256 _handlerIndex
    ) external view returns (uint256) {
        uint256 index = bound(_handlerIndex, 0, handlers.length - 1);
        return handlers[index].getAllowListLength();
    }
}
