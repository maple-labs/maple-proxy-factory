// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;

import { IMapleProxied }      from "../../interfaces/IMapleProxied.sol";
import { IMapleProxyFactory } from "../../interfaces/IMapleProxyFactory.sol";

import { MapleProxiedInternals } from "../../MapleProxiedInternals.sol";

contract MapleGlobalsMock {

    address public governor;

    bool public protocolPaused;

    constructor (address governor_) {
        governor = governor_;
    }

    function setProtocolPaused(bool protocolPaused_) external {
        protocolPaused = protocolPaused_;
    }

}

contract MapleInstanceMock is IMapleProxied, MapleProxiedInternals {

    function factory() external view override returns (address factory_) {
        return _factory();
    }

    function implementation() external view override returns (address implementation_) {
        return _implementation();
    }

    function migrate(address migrator_, bytes calldata arguments_) external override {
       _migrate(migrator_, arguments_);
    }

    function setImplementation(address newImplementation_) external override {
        _setImplementation(newImplementation_);
    }

    function upgrade(uint256 toVersion_, bytes calldata arguments_) override external {
        IMapleProxyFactory(_factory()).upgradeInstance(toVersion_, arguments_);
    }

}

contract EmptyContract {}
