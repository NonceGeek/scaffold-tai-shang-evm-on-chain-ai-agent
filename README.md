# scaffold-tai-shang-evm-on-chain-ai-agent
An AI agent scaffold that based on evm.

See Demo: 

> 🔗 https://agent-generator.rootmud.xyz

See Deck:

> [基于 Bodhi 协议的链上 AI Agent 工厂](./deck.pdf)

## 1 Smart Contracts

see all the contents in `./contracts` folder.

* [bodhi](https://bodhi.wtf) by [luyao](https://x.com/levi0214): smart contract that tokenizes the content on arweave as 1155.

  [0x2ad82a4e39bac43a54ddfe6f94980aaf0d1409ef](https://optimistic.etherscan.io/address/0x2ad82a4e39bac43a54ddfe6f94980aaf0d1409ef#code)

* [bodhi space factory](https://optimistic.etherscan.io/address/0xa14d19387c83b56343fc2e7a8707986af6a74d08#code) by  [luyao](https://x.com/levi0214): smart contract based on Ibodhi that create space based on tokenized bodhi contents.

  [0xa14d19387c83b56343fc2e7a8707986af6a74d08](https://optimistic.etherscan.io/address/0xa14d19387c83b56343fc2e7a8707986af6a74d08#code)

* [bodhi based AI agent factory](//TODO) by [leeduckgo](https://x.com/0xleeduckgo): the AI Agent Factory that use to generate new AI on-chain agents.

  [0xe3de0a0446a962e94c894d9fcdc69cfa1c9e542c](https://optimistic.etherscan.io/address/0xe3de0a0446a962e94c894d9fcdc69cfa1c9e542c#code)
  
  > 💡 The `Constructor Arguments ABI-encoded` when verifying on the etherscan, it is:
  >
  > `0x2ad82a4e39bac43a54ddfe6f94980aaf0d1409ef` 
  >
  >  => `0000000000000000000000002ad82a4e39bac43a54ddfe6f94980aaf0d1409ef`

## 2 TaiShang on-chain AI Agent Defination

An agent is constructed by 0x04 parts: `basic information, prompts[], on-chain knowledges[], off-chain knowledges[]`, the details for them:

* `Basic information`: the basic information of the AI agent.
  * Type: `bodhi asset`
  * Example: [15536](https://bodhi.wtf/space/5/15536)
* `Prompts[]`: the list of prompts of the AI agent.
  * Type: `list of bodhi assets`
  * Example: [[15539](https://bodhi.wtf/15539)]
* `On-chain knowledges[]`: the list of on-chain knowledges of the AI agent.
  * Type: `list of bodhi assets`
  * Example:  [[15540](https://bodhi.wtf/15540)]
* `Off-chain knowledges[]`: the list of off-chain knowledges of the AI agents, this part is optional.
  * Type: `list of links`
  * Example: [[https://bitcoin.org/bitcoin.pdf](https://bitcoin.org/bitcoin.pdf)]

> 💡 All the bodhi assets are transactable, the shares of the `basic information bodhi asset` == the shares of the AI agent.

### 2.1 Basic Information

【EXAMPLE】 Bodhi Hackathon Helper [#15536](https://bodhi.wtf/space/5/15536): 

```json
{
  "name": "Bodhi Hackathon Helper",
  "description": "I'm a Bodhi-based AI agent specializing in hackathon assistance.\nI help builders generate innovative ideas, implement their hackathon projects using blockchain technologies, and review their submissions.\nI have deep knowledge of Web3 development, smart contracts, DeFi protocols, and emerging blockchain trends to guide you through your hackathon journey.",
  "basic_prompt": "You are a Bodhi-based AI hackathon helper agent. Your mission is to assist builders in hackathons by:\n1) Generating creative and feasible project ideas based on current Web3 trends;\n2) Providing technical guidance for implementation including smart contract development, frontend integration, and blockchain protocols;\n3) Reviewing and providing constructive feedback on hackathon projects.\n\nYou have expertise in Solidity, Web3 development, DeFi, NFTs, DAOs, and emerging blockchain technologies.\nAlways be encouraging, practical, and focus on helping builders create innovative solutions within hackathon timeframes.",
  "landing_page": "https://hackathon-helper.rootmud.xyz",
  "version": "1.0.0"
}
```

【EXAMPLE】 Cantonese Learner

```json
{
  "name": "Cantonese Learner Helper",
  "description": "I'm an AI agent specializing in Cantonese language learning.\nI help learners practice Cantonese through dialogues, explain grammar and vocabulary, and provide cultural insights about Cantonese traditions, media, and daily life.\nI have deep knowledge of Cantonese pronunciation (Jyutping, Yale, and Chinese characters), common expressions, and differences between Cantonese and Mandarin to guide you on your learning journey.",
  "basic_prompt": "You are a Cantonese learner helper agent. Your mission is to assist learners by:\n1) Teaching Cantonese vocabulary, grammar, and sentence patterns with clear examples;\n2) Providing conversational practice with Jyutping romanization, characters, and English explanations;\n3) Offering cultural context including Cantonese media, idioms, slang, and traditions;\n4) Encouraging learners with step-by-step guidance and practical exercises.\n\nYou have expertise in Cantonese linguistics, bilingual explanation (Chinese/English), and cross-cultural teaching methods.\nAlways be supportive, clear, and help learners progress at their own pace.",
  "landing_page": "https://cantonese-learner.rootmud.xyz",
  "version": "1.0.0"
}
```

### 2.2 Prompts

【EXAMPLE】README REVIEWER [# 15539](https://bodhi.wtf/15539):

```json
{
"name": "Review the README.md file and suggest improvements",
"prompt": "Step 1: Ask the user to provide the GitHub link of the project.\n\nCall the bewater-github-analyzer.deno.dev API with the fetchCode operation using:\nurl={github_link}/blob/main/README.md\nThis retrieves the content of the README.\n\nAfter that, judge the README based on the following principle:\n\nObjective:\nEvaluate the quality and effectiveness of a GitHub README.md based on key criteria such as clarity, structure, completeness, and usefulness.\n\nInstructions:\nCarefully analyze the README.md and provide a detailed assessment based on the following aspects:\n\n1. Clarity and Readability\n• Is the content well-structured and easy to understand?\n• Are technical terms explained properly?\n• Is the language clear, concise, and free from grammatical errors?\n\n2. Project Overview\n• Does the README provide a clear and concise summary of the project?\n• Does it explain the purpose and goals?\n• Are the core technologies and dependencies mentioned?\n\n3. Installation and Setup\n• Are the installation steps clear and correct?\n• Are dependencies and requirements listed?\n• Are setup instructions detailed enough for different environments?\n\n4. Usage and Examples\n• Are there clear instructions on how to use the project?\n• Are there example commands, code snippets, or demos?\n\n5. Configuration and Customization\n• Are customization options and configurations explained?\n• Are environment variables or settings documented?\n\n6. Contribution Guidelines (if applicable)\n• Are contribution rules and processes clearly stated?\n• Is there guidance on how to submit issues or pull requests?\n\n7. License and Legal Information\n• Is the project’s license specified?\n• Is there a link to the full license text?\n\nFinal Score (Optional):\n• Excellent: Covers all key areas in a clear, structured, and engaging way.\n• Good: Mostly complete but could improve in specific areas.\n• Fair: Has useful content but lacks structure or detail.\n• Poor: Missing important sections or unclear explanations.\n\nPrompt the user to enter 'Step2' for the second step."
}
```

### 2.3 On-Chain Knowledges

【EXAMPLE】Bitcoin Whitepaper [# 15540](https://bodhi.wtf/15540)

```json
{
	"name": "bitcoin-whitepaper",
	"description": "this is the key things of the bitcoin system",
	"content": "https://bitcoin.org/bitcoin.pdf"
}
```

### 2.4 Off-Chain Knowledges

【EXAMPLE】Bitcoin Whitepaper

> [https://bitcoin.org/bitcoin.pdf](https://bitcoin.org/bitcoin.pdf)

## 3 Deck

[基于 Bodhi 协议的链上 AI Agent 工厂](./deck.pdf)

* **AI + Tokenized:** Agent, Prompts 和知识数据均被代币化
* **内容永存：** Agent, Prompts 和知识数据均为永存数据
* **乐高式 AI Agent:** 由多方要素像乐高积木一样「自由组合」

