# MapleProxyFactory

[![CircleCI](https://circleci.com/gh/maple-labs/maple-proxy-factory/tree/main.svg?style=svg)](https://circleci.com/gh/maple-labs/maple-proxy-factory/tree/main) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

**DISCLAIMER: This code has NOT been externally audited and is actively being developed. Please do not use in production without taking the appropriate steps to ensure maximum security.**

MapleProxyFactory is a Maple protocol specific implementation of ProxyFactory, a set of generic contracts developed by Maple Labs to be able to deploy proxies from a factory and manage multiple implementations in a centrally managed contract.

This contract has the following capabilities:
1. Add implementation contracts, tying them to a version.
2. Enable/disable upgrade paths between specific versions of implementations, preventing any unauthorized upgrade paths from being used.
3. Specify specialized "migrator" contracts to be used for certain upgrade paths, to perform custom storage manipulation operations during a given upgrade.
3. Deploy proxy contracts with a given implementation.
4. Perform upgrades from one implementation to another for a given proxy.

### Dependencies/Inheritance
`MapleProxyFactory` inherits from the generic `ProxyFactory` contract which can be found [here](https://github.com/maple-labs/proxy-factory).

## Testing and Development
#### Setup
```sh
git clone git@github.com:maple-labs/maple-proxy-factory.git
cd maple-proxy-factory
dapp update
```
#### Running Tests
- To run all tests: `make test` (runs `./test.sh`)
- To run a specific test function: `./test.sh -t <test_name>` (e.g., `./test.sh -t test_registerImplementation`)
- To run tests with a specified number of fuzz runs: `./test.sh -r <runs>` (e.g., `./test.sh -t test_registerImplementation -r 10000`)

This project was built using [dapptools](https://github.com/dapphub/dapptools).

## Roles and Permissions
- **Governor**: Controls all implementation-related logic in the MapleProxyFactory, allowing for new versions of proxies to be deployed from the same factory and upgrade paths between versions to be allowed.

## Audit Reports
| Auditor | Report link |
|---|---|
| Trail of Bits | [ToB - Dec 28, 2021](https://docs.google.com/viewer?url=https://github.com/maple-labs/maple-core/files/7847684/Maple.Finance.-.Final.Report_v3.pdf) |
| Code 4rena | [C4 - Jan 5, 2022](https://code4rena.com/reports/2021-12-maple/) |

## About Maple
[Maple Finance](https://maple.finance) is a decentralized corporate credit market. Maple provides capital to institutional borrowers through globally accessible fixed-income yield opportunities.

For all technical documentation related to the currently deployed Maple protocol, please refer to the maple-core GitHub [wiki](https://github.com/maple-labs/maple-core/wiki).

---

<p align="center">
  <img src="https://user-images.githubusercontent.com/44272939/116272804-33e78d00-a74f-11eb-97ab-77b7e13dc663.png" height="100" />
</p>
