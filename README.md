# This Is Us NFT

A simple Profile Picture NFT project to be deployed on Polygon.

```shell
npx hardhat compile
npx hardhat test
npx hardhat node
export MUMBAI_URL=https://rpc-mumbai.matic.today/
export PRIVATE_KEY=ABC
npx hardhat deploy --network mumbai
export POLYSCAN_API_KEY=ABC
npx hardhat etherscan-verify --network mumbai --api-key $POLYSCAN_API_KEY --api-url https://api-testnet.polygonscan.com/
```
