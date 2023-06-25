# Task to Set-Up Environment to Simulate DeFi Exploits

## Using the Repo
- Run simulate_attack.sh after cloning the repo to install foundry, and execute a toy reentrancy attack.
  
## Initial thoughts/ideas: (15 minute sprint)

Idea: Ultimate objective is to train an exploitative RL agent which works to exploit a given smart contract. For this task, we don’t think of the agent but rather try to simply model an attack as a game.

Components Needed for the Game: 
Simulated Blockchain 
Re-question what exactly a blockchain is? Is there a need to simulate it or can we simulate transactions in another way?
Find open-source ways to simulate 
Hardhat? Foundry?
Well-Defined Objectives - (An exact utility function to maximize). How exactly do RL algorithms function? - Quick scan through Deepmind papers on environment setup.
No need to set exact bounds - we want to find boundary-breaking behavior within the confines of the blockchain.

## Initial Possible Challenges:

Upon a quick read, I discovered that transaction execution is determined by:
The smart contract code: does not change after the contract is deployed on-chain.
The transaction parameters: unique to each transaction.
The state trie: which is determined by all previous transactions since genesis and updated globally after each new block.
Smart Contract Code can be thought of as the unchanging game environment. Transaction parameters are inputs by the agent that it can use to break the system (as we want). However, the exact state trie may be hard to simulate (not sure how relevant this will be for the attack, but possibly relevant if there’s a longer ‘preparation stage’.) Is relevant in current simulation scenarios, since prices fluctuate (?)



## Research Area 1: Simulate the Blockchain:
Started by looking into current methods of smart contract testing: Truffle, Ethereum Tester, Hardhat, Foundry Forge etc.
Blockchain Simulations: Truffle Ganache, Foundry Anvil, Hardhat Network
Need to pick one to work with
Hardhat: https://hardhat.org/ 
Foundry: https://github.com/foundry-rs/foundry 
Truffle: https://trufflesuite.com/ 
Initial Thoughts from forums: Foundry is very fast, everything in solidity. Hardhat faster to set-up potentially - more plugin support - but tests written in js/ts
Hardhat Network may be better than Anvil. For local testnet deployment(?)
Question: which may be better?


## Research Area 2: Research key factors that an RL training environment needs to have:

Read Alphadev Game Setup.

![AlphaDev](https://github.com/Xarangi/DeFiGameEnv/assets/62006231/977f6602-d820-4aa3-ae1f-e6058c9f1c78)

Sorting transformed into a single-player assembly game.


## Meeting 1: Focus on environment set-up - Use foundry/possibly hardhat if it doesn’t work.

Progress: Research Area 1:
- Setup foundry including both forge and anvil, read documentation.
- Find vulnerable contract, deploy to anvil
- Test out foundry testing suite by simulating attack?
- What other considerations for the board??
- For piece moves and rules - we need to think of base attacks
- Find examples of others implementing a contract on anvil and testing against it
- Discovered an attack for the Team Finance Exploit, Discovered vulnerable contract
- Went over some basic solidity
- Implemented simple contract, simple anvil attack from tutorial
- Explored and learnt functionality of cast, anvil
- Deployed vulnerable contract on local simulated blockchain


## Further ideas:

LLMs as base-level informers: inform which functions can be called. Basically reduce the scope over which an RL agent operates (can be thought of as breaking down attacks into atomic statements)

## Final Progress:
- Solved issues with port error - defined a new port rather than using default.
- Created shell script to install foundry tools and execute a toy reentrancy attack on a simulated contract.



