# CajaChica

A simple Ethereum vault contract managed with Foundry.

## Overview

**CajaChica** ("Petty Cash") is a vault contract that allows users to deposit and withdraw ETH. 

### Reserve Mechanism
The contract enforces a unique reserve rule for withdrawals:
- Users can deposit any amount of ETH.
- To withdraw, a user's individual balance must be at least **10%** of the total contract balance (`s_totalBalance`).

## Project Structure

- `src/CajaChica.sol`: The main contract.
- `test/CajaChicaTest.t.sol`: Tests for the contract.

## Foundry Usage

This project uses [Foundry](https://book.getfoundry.sh/).

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```
