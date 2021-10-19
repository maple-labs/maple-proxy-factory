// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;

import { IProxied } from "../../modules/proxy-factory/contracts/interfaces/IProxied.sol";

/// @title MapleProxied facilitates the creation of the maple contracts as proxies.
interface IMapleProxied is IProxied {

    /**
     *  @notice Upgrades a contract implementation to a specific version.
     *  @dev    Access control logic critical since caller can force a selfdestruct via a malicious `migrator_` which is delegatecalled.
     *  @param  toVersion_ The version to upgrade to.
     *  @param  arguments_ Some encoded arguments to use for the upgrade.
     */
    function upgrade(uint256 toVersion_, bytes calldata arguments_) external;
    
}
