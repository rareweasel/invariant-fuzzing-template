// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "forge-std/Script.sol";
import {AllowList} from "../src/AllowList.sol";

/*
    forge script ./script/AllowList.s.sol:AllowListScript --rpc-url <your-rpc-url> -vvv --broadcast

    --broadcast to send the tx to the network
    -vvv to see the logs
*/
contract AllowListScript is Script {
    string public constant PARAM_OWNER = "OWNER";
    string public constant PARAM_PK_ACCOUNT = "PK_ACCOUNT";
    string public constant PARAM_SALT = "SALT";
    string public constant PARAM_ALLOW_LIST_ADDRESSES = "ALLOW_LIST_ADDRESSES";

    function run() public {
        uint256 deployerPrivateKey = vm.envUint(PARAM_PK_ACCOUNT);
        bytes32 salt = vm.envBytes32(PARAM_SALT);
        address ownerAddress = vm.envAddress(PARAM_OWNER);
        address[] memory envVariableAddresses = vm.envAddress(
            PARAM_ALLOW_LIST_ADDRESSES,
            ","
        );

        console.log("Starting script: broadcasting");
        console.log("Owner address:     ", ownerAddress);
        console.log("Addresses length:  ", envVariableAddresses.length);
        vm.startBroadcast(deployerPrivateKey);

        new AllowList{salt: salt}(ownerAddress, envVariableAddresses);
        vm.stopBroadcast();
    }
}
