// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./IBodhi.sol";
// bodhi address: 0x2ad82a4e39bac43a54ddfe6f94980aaf0d1409ef

contract BodhiBasedAIAgent {

    /* 
    Prompt:
    this is the exmaple for the ai agent based on bodhi, the ai agent has 3 parts:
    1. basic infomation - which is a bodhi id, and the bodhi id is also the agent id;
    2. prompts - which is a list of bodhi ids, and the bodhi ids are the prompts of the agent;
    3. on-chain knowledges - which is a list of bodhi ids, and the bodhi ids are the on-chain knowledges of the agent;
    */
    
    // Events
    event AgentInitialized(uint256 indexed agentId, address indexed creator);
    event BrainInitialized(uint256 indexed agentId, address indexed creator);
    event PromptsUpdated(uint256 indexed agentId, uint256[] newPrompts);
    event KnowledgesUpdated(uint256 indexed agentId, uint256[] newKnowledges);
    event OwnershipTransferred(uint256 indexed agentId, address indexed previousOwner, address indexed newOwner);

    // State variables
    IBodhi public immutable bodhi;
    uint256 public immutable agentId;  // The bodhi id that serves as the agent id
    address public owner;              // Current owner of the agent
    address public creator;            // Original creator of the agent
    uint256[] public prompts;          // Array of bodhi ids representing prompts
    uint256[] public knowledges;       // Array of bodhi ids representing on-chain knowledge
    bool public initialized;           // Whether the agent has been initialized

    // Errors
    error AgentAlreadyInitialized();
    error AgentNotInitialized();
    error Unauthorized();
    error BalanceInsufficient();
    error BodhiAssetNotFound();
    error InvalidArrayLength();
    error SameOwner();

    // Modifiers
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        _;
    }

    modifier onlyInitialized() {
        if (!initialized) {
            revert AgentNotInitialized();
        }
        _;
    }

    modifier validBodhiId(uint256 bodhiId) {
        if (bodhiId >= bodhi.assetIndex()) {
            revert BodhiAssetNotFound();
        }
        _;
    }

    /**
     * @dev Constructor sets the bodhi contract and _agentBodhiId
     * @param _bodhiAddress Address of the Bodhi contract
     * @param _agentBodhiId The bodhi id that will serve as the _agentBodhiId
     * @param _creator The address of the actual creator (for factory pattern support)
     */
    constructor(address _bodhiAddress, uint256 _agentBodhiId, address _creator) {
        // Verify the specified creator owns the main bodhi asset.
        // must buy the bodhi asset first.

        bodhi = IBodhi(_bodhiAddress);
        if (bodhi.balanceOf(_creator, _agentBodhiId) == 0) {
            revert BalanceInsufficient();
        }
        agentId = _agentBodhiId;
        owner = _creator;
        creator = _creator;

        emit AgentInitialized(agentId, _creator);
    }

    function balanceOf(address _owner) external view returns (uint256) {
        return bodhi.balanceOf(_owner, agentId);
    }

    /**
     * @dev Initializes the AI agent with prompts and knowledge
     * @param _prompts Array of bodhi ids representing agent prompts
     * @param _knowledges Array of bodhi ids representing agent knowledge base
     */
    function initialize(
        uint256[] calldata _prompts,
        uint256[] calldata _knowledges
    ) external validBodhiId(agentId) {
        if (initialized) {
            revert AgentAlreadyInitialized();
        }

        // Verify caller owns the agent bodhi asset
        if (bodhi.balanceOf(msg.sender, agentId) == 0) {
            revert Unauthorized();
        }

        // Validate all prompt bodhi ids exist
        for (uint256 i = 0; i < _prompts.length; i++) {
            if (_prompts[i] >= bodhi.assetIndex()) {
                revert BodhiAssetNotFound();
            }
        }

        // Validate all knowledge bodhi ids exist
        for (uint256 i = 0; i < _knowledges.length; i++) {
            if (_knowledges[i] >= bodhi.assetIndex()) {
                revert BodhiAssetNotFound();
            }
        }

        // Initialize agent.
        prompts = _prompts;
        knowledges = _knowledges;
        initialized = true;

        emit BrainInitialized(agentId, msg.sender);
    }

    /**
     * @dev Updates the agent's prompts
     * @param _prompts New array of bodhi ids representing agent prompts
     */
    function updatePrompts(uint256[] calldata _prompts) external onlyOwner onlyInitialized {
        // Validate all prompt bodhi ids exist
        for (uint256 i = 0; i < _prompts.length; i++) {
            if (_prompts[i] >= bodhi.assetIndex()) {
                revert BodhiAssetNotFound();
            }
        }

        prompts = _prompts;
        emit PromptsUpdated(agentId, _prompts);
    }

    /**
     * @dev Updates the agent's knowledge base
     * @param _knowledges New array of bodhi ids representing agent knowledge base
     */
    function updateKnowledges(uint256[] calldata _knowledges) external onlyOwner onlyInitialized {
        // Validate all knowledge bodhi ids exist
        for (uint256 i = 0; i < _knowledges.length; i++) {
            if (_knowledges[i] >= bodhi.assetIndex()) {
                revert BodhiAssetNotFound();
            }
        }

        knowledges = _knowledges;
        emit KnowledgesUpdated(agentId, _knowledges);
    }

    /**
     * @dev Adds a new prompt to the agent
     * @param promptId The bodhi id of the new prompt
     */
    function addPrompt(uint256 promptId) external onlyOwner onlyInitialized validBodhiId(promptId) {
        prompts.push(promptId);
        emit PromptsUpdated(agentId, prompts);
    }

    /**
     * @dev Adds a new knowledge to the agent
     * @param knowledgeId The bodhi id of the new knowledge
     */
    function addKnowledge(uint256 knowledgeId) external onlyOwner onlyInitialized validBodhiId(knowledgeId) {
        knowledges.push(knowledgeId);
        emit KnowledgesUpdated(agentId, knowledges);
    }

    /**
     * @dev Removes a prompt from the agent by index
     * @param index The index of the prompt to remove
     */
    function removePrompt(uint256 index) external onlyOwner onlyInitialized {
        if (index >= prompts.length) {
            revert InvalidArrayLength();
        }
        
        // Move the last element to the position of the element to remove
        prompts[index] = prompts[prompts.length - 1];
        prompts.pop();
        
        emit PromptsUpdated(agentId, prompts);
    }

    /**
     * @dev Removes a knowledge from the agent by index
     * @param index The index of the knowledge to remove
     */
    function removeKnowledge(uint256 index) external onlyOwner onlyInitialized {
        if (index >= knowledges.length) {
            revert InvalidArrayLength();
        }
        
        // Move the last element to the position of the element to remove
        knowledges[index] = knowledges[knowledges.length - 1];
        knowledges.pop();
        
        emit KnowledgesUpdated(agentId, knowledges);
    }

    /**
     * @dev Transfers ownership of the agent to a new owner
     * @param newOwner Address of the new owner
     */
    function transferOwnership(address newOwner) external onlyOwner onlyInitialized {
        if (newOwner == owner) {
            revert SameOwner();
        }
        
        // Verify new owner has the agent bodhi asset
        if (bodhi.balanceOf(newOwner, agentId) == 0) {
            revert BalanceInsufficient();
        }

        address previousOwner = owner;
        owner = newOwner;
        
        emit OwnershipTransferred(agentId, previousOwner, newOwner);
    }

    // View functions

    /**
     * @dev Gets all agent prompts
     */
    function getPrompts() external view returns (uint256[] memory) {
        return prompts;
    }

    /**
     * @dev Gets all agent knowledge
     */
    function getKnowledges() external view returns (uint256[] memory) {
        return knowledges;
    }

    /**
     * @dev Gets agent basic information
     */
    function getAgentInfo() external view returns (
        uint256 _agentId,
        address _owner,
        address _creator,
        bool _initialized,
        uint256 promptCount,
        uint256 knowledgeCount
    ) {
        return (
            agentId,
            owner,
            creator,
            initialized,
            prompts.length,
            knowledges.length
        );
    }

    /**
     * @dev Gets a specific prompt by index
     * @param index The index of the prompt
     */
    function getPrompt(uint256 index) external view returns (uint256) {
        if (index >= prompts.length) {
            revert InvalidArrayLength();
        }
        return prompts[index];
    }

    /**
     * @dev Gets a specific knowledge by index
     * @param index The index of the knowledge
     */
    function getKnowledge(uint256 index) external view returns (uint256) {
        if (index >= knowledges.length) {
            revert InvalidArrayLength();
        }
        return knowledges[index];
    }

    /**
     * @dev Gets the count of prompts
     */
    function getPromptCount() external view returns (uint256) {
        return prompts.length;
    }

    /**
     * @dev Gets the count of knowledge items
     */
    function getKnowledgeCount() external view returns (uint256) {
        return knowledges.length;
    }
}