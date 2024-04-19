// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";
import {console2 as console} from "forge-std/console2.sol";

import {AllowList} from "../../src/AllowList.sol";
import {AllowListHandler} from "./handlers/AllowListHandler.sol";
import {AllowListActorManager} from "./managers/AllowListActorManager.sol";

contract ActorAllowListTest is Test {
    uint256 private constant TOTAL_HANDLERS = 10;

    address private owner;
    AllowList private allowList;
    AllowListActorManager public manager;
    AllowListHandler[] public handlers;

    function setUp() external {
        owner = address(0x99999999);
        allowList = new AllowList(owner, new address[](0));
        for (uint256 i = 0; i < TOTAL_HANDLERS; ++i) {
            AllowListHandler handler = new AllowListHandler(allowList);
            handlers.push(handler);
        }
        manager = new AllowListActorManager(
            allowList.getAllowList().length,
            handlers
        );
        targetContract(address(manager));
    }

    function invariant_allow_list_length() external {
        assertEq(
            manager.currentLength(),
            allowList.getAllowList().length,
            "Invalid allow list length"
        );
    }
}
