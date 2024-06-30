pragma solidity ^0.8.0;



contract VestingSchedule {
    // Mapping of organizations to their token contracts
    mapping (address => address) public orgToToken;

    // Mapping of token contracts to their vesting schedules
    mapping (address => mapping (address => uint)) public tokenToVesting;

    // Mapping of whitelisted addresses to their stakeholder types
    mapping (address => mapping (address => string)) public whitelist;

    // Event emitted when an organization registers
    event OrganizationRegistered(address org, address token);

    // Event emitted when a stakeholder claims their tokens
    event TokensClaimed(address stakeholder, uint amount);

    // Function to register an organization and create a new ERC20 token
    function registerOrganization(string memory _orgName, string memory _tokenName, string memory _tokenSymbol) public {
        // Create a new ERC20 token contract
        ERC20 token = new ERC20(_tokenName, _tokenSymbol);
        orgToToken[msg.sender] = address(token);
        emit OrganizationRegistered(msg.sender, address(token));
    }

    // Function to set a vesting schedule for a stakeholder type
    function setVestingSchedule(address _token, string memory _stakeholderType, uint _vestingPeriod) public {
        tokenToVesting[_token][_stakeholderType] = _vestingPeriod;
    }

    // Function to whitelist an address for a stakeholder type
    function whitelistAddress(address _token, address _address, string memory _stakeholderType) public {
        whitelist[_token][_address] = _stakeholderType;
    }

    // Function to claim tokens after the vesting period
    function claimTokens(address _token, address _address) public {
        // Check if the address is whitelisted and the vesting period has passed
        require(whitelist[_token][_address] != "", "Address not whitelisted");
        require(block.timestamp >= tokenToVesting[_token][whitelist[_token][_address]], "Vesting period not yet passed");
        // Transfer tokens to the address
        ERC20(_token).transfer(_address, 1000); // Replace with actual token amount
        emit TokensClaimed(_address, 1000); // Replace with actual token amount
    }
}