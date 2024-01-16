// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {ForkBaseTest} from "../utils/ForkBase.t.sol";
import {IWrappedToken} from "../utils/IWrappedToken.sol";

contract WrappedTokenForkTest is ForkBaseTest {
    IWrappedToken public constant ETH_WETH =
        IWrappedToken(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    IWrappedToken public constant BSC_WBNB =
        IWrappedToken(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);

    function test_balanceOf_valid_eth(address _account) external {
        _createSelectFork(ETH_MAINNET);
        vm.assume(_account != address(0x0));

        uint256 _balance = ETH_WETH.balanceOf(_account);

        assertTrue(_balance >= 0, "invalid call");
    }

    function test_balanceOf_valid_bsc(address _account) external {
        _createSelectFork(BSC_MAINNET);
        vm.assume(_account != address(0x0));

        uint256 _balance = BSC_WBNB.balanceOf(_account);

        assertTrue(_balance >= 0, "invalid call");
    }
}
