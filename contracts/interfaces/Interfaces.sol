// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;

interface IMapleGlobalsLike {

    /// @dev The address of the Governor responsible for management of global Maple variables.
    function governor() external view returns (address governor_);

    /// @dev Boolean indicating if entire protocol is paused.
    function protocolPaused() external view returns (bool isPaused_);

}
