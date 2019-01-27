# Marketplace Dapp

The goal is a decentralized marketplace on ethereum network. The owner of the contract deployes it to the tesnet/localhost. The owner is automaticly  an Admin. The Admins and the owner cann add Sellers. They can add items(name, price,quantity) to be sold. Regular users, can buy these items buy providing the ID of them.

## Getting Started

Clone repisotory into desired test directory. Have metamask extension in browser. Have node.js installed .

### Installing

run these installs in your directory

Openzeppelin is already in the repository, so no need to install
```
npm install -g truffle
```
```
npm install chai
```
```
npm install web3
```
```
npm install ganache-cli
```



## Running the tests

```
truffle test
```
Should run 5 tests 

## Deployment
To start ganache private test  run :
```
ganache-cli -q
```
in your directory run :
```
truffle compile
```
```
truffle migrate
```
in client folder run :

```
npm run
```
copy the meunomics from the ganache-cli into metamask, to connect
## Built With

* Truffle React box https://truffleframework.com/boxes/react
* Openzeppelin https://openzeppelin.org/
* Chai https://www.chaijs.com/



