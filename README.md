# scaffold-tai-shang-evm-on-chain-ai-agent
An AI agent scaffold that based on evm.

## 1 Smart Contracts

see all the contents in `./contracts` folder.

* [bodhi](https://bodhi.wtf) by [luyao](https://x.com/levi0214): smart contract that tokenize the content on arweave as 1155.

  [0x2ad82a4e39bac43a54ddfe6f94980aaf0d1409ef](https://optimistic.etherscan.io/address/0x2ad82a4e39bac43a54ddfe6f94980aaf0d1409ef#code)

* [bodhi space factory](https://optimistic.etherscan.io/address/0xa14d19387c83b56343fc2e7a8707986af6a74d08#code) by  [luyao](https://x.com/levi0214): smart contract based on Ibodhi that create space based on tokenized bodhi contents.

  [0xa14d19387c83b56343fc2e7a8707986af6a74d08](https://optimistic.etherscan.io/address/0xa14d19387c83b56343fc2e7a8707986af6a74d08#code)

* [bodhi based AI agent factory](//TODO) by [leeduckgo](https://x.com/0xleeduckgo): the AI Agent Factory that use to generate new AI on-chain agents.

  [0x0](https://optimistic.etherscan.io/address/0x0)

## 2 TaiShang on-chain AI Agent Defination

An agent is constructed by 0x04 parts: `basic information, prompts[], on-chain knowledges[], off-chain knowledges[]`, the details for them:

* `Basic information`: the basic information of the AI agent.
  * Type: `bodhi asset`
  * Example: [TODO](TODO)
* `Prompts[]`: the list of prompts of the AI agent.
  * Type: `list of bodhi assets`
  * Example: [TODO](TODO)
* `On-chain knowledges[]`: the list of on-chain knowledges of the AI agent.
  * Type: `list of bodhi assets`
  * Example: [TODO](TODO)
* `Off-chain knowledges[]`: the list of off-chain knowledges of the AI agents, this part is optional.
  * Type: `list of links`
  * Example: [TODO](TODO)

> 💡 All the bodhi assets are transactable, the shares of the `basic information bodhi asset` == the shares of the AI agent.

### 2.1 Basic Information

```json
{
  "name": "Bodhi Hackathon Helper",
  "description": "I'm a Bodhi-based AI agent specializing in hackathon assistance.\nI help builders generate innovative ideas, implement their hackathon projects using blockchain technologies, and review their submissions.\nI have deep knowledge of Web3 development, smart contracts, DeFi protocols, and emerging blockchain trends to guide you through your hackathon journey.",
  "basic_prompt": "You are a Bodhi-based AI hackathon helper agent. Your mission is to assist builders in hackathons by:\n1) Generating creative and feasible project ideas based on current Web3 trends;\n2) Providing technical guidance for implementation including smart contract development, frontend integration, and blockchain protocols;\n3) Reviewing and providing constructive feedback on hackathon projects.\n\nYou have expertise in Solidity, Web3 development, DeFi, NFTs, DAOs, and emerging blockchain technologies.\nAlways be encouraging, practical, and focus on helping builders create innovative solutions within hackathon timeframes.",
  "landing_page": "https://hackathon-helper.rootmud.xyz",
  "version": "1.0.0"
}
```



