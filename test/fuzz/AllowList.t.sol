// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {AllowList} from "../../src/AllowList.sol";

contract AllowListTest is Test {
    AllowList public allowList;
    address public owner;
    address public listItem1;
    address public listItem2;

    function setUp() public {
        listItem1 = address(0x1);
        listItem2 = address(0x2);
        owner = address(0x99999);

        address[] memory _allowList = new address[](2);
        _allowList[0] = listItem1;
        _allowList[1] = listItem2;

        vm.startPrank(owner);
        allowList = new AllowList(owner, _allowList);
        vm.stopPrank();
    }

    function test_constructor_valid(
        address _owner,
        address _item1,
        address _item2
    ) external {
        vm.assume(_owner != address(0x0));
        vm.assume(_item1 != address(0x0));
        vm.assume(_item2 != address(0x0));

        address[] memory _allowList = new address[](2);
        _allowList[0] = _item1;
        _allowList[1] = _item2;

        vm.startPrank(_owner);
        AllowList instance = new AllowList(_owner, _allowList);
        vm.stopPrank();

        assertEq(instance.owner(), _owner, "invalid owner");
        assertEq(
            instance.getAllowList().length,
            _allowList.length,
            "invalid allowList length"
        );
    }

    function test_constructor_owner_invalid(
        address _item1,
        address _item2
    ) external {
        address _owner = address(0x0);
        address[] memory _allowList = new address[](2);
        _allowList[0] = _item1;
        _allowList[1] = _item2;

        hoax(owner);
        vm.expectRevert("invalid owner");
        new AllowList(_owner, _allowList);
    }
}
