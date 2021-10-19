// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;

import { ProxyFactory } from "../modules/proxy-factory/contracts/ProxyFactory.sol";
import { IProxied }     from "../modules/proxy-factory/contracts/interfaces/IProxied.sol";

import { IMapleGlobalsLike } from "./interfaces/Interfaces.sol";

import { IMapleProxyFactory } from "./interfaces/IMapleProxyFactory.sol";

//// @title MapleInstanceFactory facilitates the creation of the MapleInstance contracts as proxies.
contract MapleProxyFactory is IMapleProxyFactory, ProxyFactory {

    address public override mapleGlobals;

    uint256 public override defaultVersion;

    mapping(address => uint256) public override nonceOf;

    mapping(uint256 => mapping(uint256 => bool)) public override upgradeEnabledForPath;

    constructor(address mapleGlobals_) {
        mapleGlobals = mapleGlobals_;
    }

    /********************************/
    /*** Administrative Functions ***/
    /********************************/

    function disableUpgradePath(uint256 fromVersion_, uint256 toVersion_) override external {
        require(_isGovernor(msg.sender),                                   "MPF:DUP:NOT_GOVERNOR");
        require(fromVersion_ != toVersion_,                              "MPF:DUP:CANNOT_OVERWRITE_INITIALIZER");
        require(_registerMigrator(fromVersion_, toVersion_, address(0)), "MPF:DUP:FAILED");

        upgradeEnabledForPath[fromVersion_][toVersion_] = false;
        emit UpgradePathDisabled(fromVersion_, toVersion_);
    }

    function enableUpgradePath(uint256 fromVersion_, uint256 toVersion_, address migrator_) override external {
        require(_isGovernor(msg.sender),                                   "MPF:EUP:NOT_GOVERNOR");
        require(fromVersion_ != toVersion_,                              "MPF:EUP:CANNOT_OVERWRITE_INITIALIZER");
        require(_registerMigrator(fromVersion_, toVersion_, migrator_), "MPF:EUP:FAILED");

        upgradeEnabledForPath[fromVersion_][toVersion_] = true;
        emit UpgradePathEnabled(fromVersion_, toVersion_, migrator_);
    }

    function registerImplementation(uint256 version_, address implementationAddress_, address initializer_) override external {
        require(_isGovernor(msg.sender), "MPF:RI:NOT_GOVERNOR");

        // Version 0 reserved as "no version" since default `defaultVersion` is 0.
        require(version_ != uint256(0),                                     "MPF:RI:INVALID_VERSION");
        require(_registerImplementation(version_, implementationAddress_), "MPF:RI:FAIL_FOR_IMPLEMENTATION");

        // Set migrator for initialization, which understood as fromVersion == toVersion.
        require(_registerMigrator(version_, version_, initializer_), "MPF:RI:FAIL_FOR_MIGRATOR");

        // Updating the current version so new instancr always created with the same version and emits event.
        emit ImplementationRegistered(version_, implementationAddress_, initializer_);
    }

    function setDefaultVersion(uint256 version_) override external {
        require(_isGovernor(msg.sender), "MPF:SDV:NOT_GOVERNOR");

        // Version must be 0 (to disable creating new instances) or be registered
        require(version_ == 0 || _implementationOf[version_] != address(0), "MPF:SDV:INVALID_VERSION");

        emit DefaultVersionSet(defaultVersion = version_);
    }

    /****************+++++******/
    /*** Instance Functions ***/
    /***************++++*******/

    function createInstance(bytes calldata arguments_) override external returns (address instance_) {
        bool success_;
        ( success_, instance_ ) = _newInstanceWithSalt(defaultVersion, arguments_, keccak256(abi.encodePacked(msg.sender, nonceOf[msg.sender]++)));
        require(success_, "MPF:CI:FAILED");

        emit InstanceDeployed(defaultVersion, instance_, arguments_);
    }

    // NOTE: The MapleInstance implementation of MapleInstance proxy contract defines the access control logic for its own upgrade.
    function upgradeInstance(uint256 toVersion_, bytes calldata arguments_) override external {
        uint256 fromVersion_ = _versionOf[IProxied(msg.sender).implementation()];

        require(upgradeEnabledForPath[fromVersion_][toVersion_],      "MPF:UI:NOT_ALLOWED");
        require(_upgradeInstance(msg.sender, toVersion_, arguments_), "MPF:UI:FAILED");

        emit InstanceUpgraded(msg.sender, fromVersion_, toVersion_, arguments_);
    }

    /**********************/
    /*** View Functions ***/
    /**********************/

    function implementationOf(uint256 version_) override external view returns (address implementation_) {
        return _implementationOf[version_];
    }

    function isInstance(address instance_) override external view returns (bool isInstance_) {
        return _isInstance(instance_);
    }

    function migratorForPath(uint256 oldVersion_, uint256 newVersion_) override external view returns (address migrator_) {
        return _migratorForPath[oldVersion_][newVersion_];
    }

    function versionOf(address implementation_) override external view returns (uint256 version_) {
        return _versionOf[implementation_];
    }

    /**************************/
    /*** Internal Functions ***/
    /**************************/

    function _isGovernor(address governor_) internal view returns (bool isGovernor_) {
        return governor_ == IMapleGlobalsLike(mapleGlobals).governor();
    }

}
