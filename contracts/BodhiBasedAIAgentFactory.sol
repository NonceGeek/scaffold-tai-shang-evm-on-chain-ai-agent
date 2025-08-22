// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./IBodhi.sol";
import "./BodhiBasedAIAgent.sol"; 
// bodhi address: 0x2ad82a4e39bac43a54ddfe6f94980aaf0d1409ef

contract BodhiBasedAIAgentFactory {

    /* 
    Prompt:
    this is a factory contract that generate the new on-chain agents.
    refer the SpaceFactory.sol, to create the agent.
    */

    // Events
    event AgentCreated(
        uint256 indexed agentIndex, 
        address indexed agentAddress, 
        uint256 indexed agentBodhiId, 
        address creator
    );

    // State variables
    address public immutable bodhiAddress;
    uint256 public agentIndex = 0;
    mapping(uint256 => address) public agents;

    // Errors
    error InvalidBodhiAddress();

    /**
     * @dev Constructor sets the Bodhi contract address
     * @param _bodhiAddress Address of the Bodhi contract
     */
    constructor(address _bodhiAddress) {
        if (_bodhiAddress == address(0)) {
            revert InvalidBodhiAddress();
        }
        bodhiAddress = _bodhiAddress;
    }

    /**
     * @dev Creates a new BodhiBasedAIAgent
     * @param agentBodhiId The bodhi id that will serve as the agent id
     * @return agentAddress The address of the newly created agent
     */
    function create(uint256 agentBodhiId) public returns (address agentAddress) {
        BodhiBasedAIAgent newAgent = new BodhiBasedAIAgent(bodhiAddress, agentBodhiId, msg.sender);
        agentAddress = address(newAgent);
        agents[agentIndex] = agentAddress;
        
        emit AgentCreated(agentIndex, agentAddress, agentBodhiId, msg.sender);
        agentIndex++;
        
        return agentAddress;
    }

    /**
     * @dev Gets the agent address by index
     * @param index The index of the agent
     * @return The address of the agent
     */
    function getAgent(uint256 index) external view returns (address) {
        return agents[index];
    }

    /**
     * @dev Gets the total number of agents created
     * @return The total number of agents
     */
    function getAgentCount() external view returns (uint256) {
        return agentIndex;
    }

    /**
     * @dev Gets a range of agent addresses
     * @param start Starting index (inclusive)
     * @param end Ending index (exclusive)
     * @return agentAddresses Array of agent addresses
     */
    function getAgents(uint256 start, uint256 end) external view returns (address[] memory agentAddresses) {
        require(start < end && end <= agentIndex, "Invalid range");
        
        agentAddresses = new address[](end - start);
        for (uint256 i = start; i < end; i++) {
            agentAddresses[i - start] = agents[i];
        }
        
        return agentAddresses;
    }
}