# Maple Proxy Factory

[![Foundry][foundry-badge]][foundry]
[![Forge CI](https://github.com/maple-labs/maple-proxy-factory/actions/workflows/forge.yaml/badge.svg)](https://circleci.com/gh/maple-labs/maple-proxy-factory/tree/main) [![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)

[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg

`MapleProxyFactory` is a Maple protocol specific implementation of ProxyFactory, a set of generic contracts developed by Maple Labs to be able to deploy proxies from a factory and manage multiple implementations in a centrally managed contract.

This contract has the following capabilities:
1. Add implementation contracts, tying them to a version.
2. Enable/disable upgrade paths between specific versions of implementations, preventing any unauthorized upgrade paths from being used.
3. Specify specialized "migrator" contracts to be used for certain upgrade paths, to perform custom storage manipulation operations during a given upgrade.
4. Deploy proxy contracts with a given implementation.
5. Perform upgrades from one implementation to another for a given proxy.

### Dependencies/Inheritance
`MapleProxyFactory` inherits from the generic `ProxyFactory` contract which can be found [here](https://github.com/maple-labs/proxy-factory).

## Testing and Development
#### Setup
This project was built using [Foundry](https://book.getfoundry.sh/). Refer to installation instructions [here](https://github.com/foundry-rs/foundry#installation).

```sh
git clone git@github.com:maple-labs/maple-proxy-factory.git
cd maple-proxy-factory
forge install
```
## Running Tests

- To run all tests: `forge test`
- To run specific tests: `forge test --match <test_name>`

## Roles and Permissions
- **Governor**: Controls all implementation-related logic in the MapleProxyFactory, allowing for new versions of proxies to be deployed from the same factory and upgrade paths between versions to be allowed.

## Audit Reports
| Auditor | Version | Report link |
|---|---|
| Trail of Bits | v1.0.0 | [ToB - Dec 28, 2021](https://docs.google.com/viewer?url=https://github.com/maple-labs/maple-core/files/7847684/Maple.Finance.-.Final.Report_v3.pdf) |
| Code 4rena    | v1.0.0 | [C4 - Jan 5, 2022](https://code4rena.com/reports/2021-12-maple/) |

## Bug Bounty (v1.0.0)

For all information related to the ongoing bug bounty for these contracts run by [Immunefi](https://immunefi.com/), please visit this [site](https://immunefi.com/bounty/maple/).

## About Maple

[Maple Finance](https://maple.finance/) is a decentralized corporate credit market. Maple provides capital to institutional borrowers through globally accessible fixed-income yield opportunities.

For all technical documentation related to the Maple V2 protocol, please refer to the GitHub [wiki](https://github.com/maple-labs/maple-core-v2/wiki).

---

<p align="center">
  <img src="https://user-images.githubusercontent.com/44272939/196706799-fe96d294-f700-41e7-a65f-2d754d0a6eac.gif" height="100" />
</p>
