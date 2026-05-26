# Solidity Practice (Foundry)

A collection of small Solidity smart contracts written while learning Ethereum development with the [Foundry](https://book.getfoundry.sh/) toolkit. Every contract is paired with a Forge test file in `test/` to demonstrate behavior, events, reverts, and access control.

## Contracts

All contracts live in `src/` and target Solidity `0.8.28` (Counter targets `^0.8.13`).

- **HelloWorld.sol** — Minimal starter contract that stores a `string message` set in the constructor, with `setMessage` and `getMessage` accessors. Used to demonstrate state variables, constructors, and basic getters/setters.
- **Counter.sol** — A simple counter exposing `setNumber(uint256)` and `increment()` over a public `number` state variable. Used as the default Foundry deployment example via `script/Counter.s.sol`.
- **AccessControl.sol** — Role-based access control with three roles (Admin, Supporter, Member) stored in `mapping(address => bool)`. The deployer becomes the first admin; only admins can assign roles via `assignAdminRole` and `assignOtherRole`. Emits a `RoleAssigned` event for every assignment.
- **CustomErrors.sol** — Demonstrates Solidity custom errors (`NotOwner`, `TooLow`) instead of `require` strings. Only the owner can call `setNumber`, and the value must be at least `10`, otherwise the call reverts with a typed error carrying context (caller address, sent value, required value).
- **Wallet.sol** — A per-user ETH wallet contract with per-account balances, a `receive()` that forwards to `deposit()`, and a `fallback()` that reverts on unknown calls. The `withdrawal` function is guarded by a `noReentrancy` lock and a `hasSufficientBalance` modifier, caps single withdrawals at `1 ether`, and asserts that `contractBalance` stays in sync with `address(this).balance`.

## Tech stack

- **Solidity** `0.8.28` (and `^0.8.13` for `Counter`)
- **Foundry** — `forge`, `cast`, `anvil`, `chisel`
- **forge-std** for testing utilities (`Test`, `vm` cheatcodes)

## Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed (`forge`, `cast`, `anvil`)
  ```shell
  curl -L https://foundry.paradigm.xyz | bash
  foundryup
  ```
- [Git](https://git-scm.com/)

## Install

Clone the repo and install the libraries declared in `lib/` (currently `forge-std`):

```shell
git clone https://github.com/0pFlow/solidity-practice-foundry
cd solidity-practice-foundry
forge install
```

## Build

```shell
forge build
```

## Test

Run the full test suite (one test file per contract under `test/`):

```shell
forge test
```

Useful flags:

```shell
forge test -vv          # show console logs
forge test -vvvv        # show traces for failing tests
forge test --gas-report # print a gas report per function
```

## Format

```shell
forge fmt
```

## Local node and deploy

Start a local Ethereum node:

```shell
anvil
```

Deploy the example `Counter` contract using the included script:

```shell
forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```

## Project layout

```
.
├── src/        # Solidity contracts
├── test/       # Forge tests (one *.t.sol per contract)
├── script/     # Forge deployment scripts
├── lib/        # Git-submoduled dependencies (forge-std)
└── foundry.toml
```
