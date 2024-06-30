javascript
Open In Editor
Edit
Run
Copy code
1import { ethers } from "ethers";
2
3// Connect to the Ethereum network
4const provider = new ethers.providers.Web3Provider(window.ethereum);
5
6// Get the VestingSchedule contract instance
7const vestingScheduleContract = new ethers.Contract("0x...", VestingSchedule.abi);
8
9// Register an organization
10async function registerOrganization(orgName, tokenName, tokenSymbol) {
11  const tx = await vestingScheduleContract.registerOrganization(orgName, tokenName, tokenSymbol);
12  await tx.wait();
13  console.log("Organization registered!");
14}
15
16// Set a vesting schedule for a stakeholder type
17async function setVestingSchedule(tokenAddress, stakeholderType, vestingPeriod) {
18  const tx = await vestingScheduleContract.setVestingSchedule(tokenAddress, stakeholderType, vestingPeriod);
19  await tx.wait();
20  console.log("Vesting schedule set!");
21}
22
23// Whitelist an address for a stakeholder type
24async function whitelistAddress(tokenAddress, address, stakeholderType) {
25  const tx = await vestingScheduleContract.whitelistAddress(tokenAddress, address, stakeholderType);
26  await tx.wait();
27  console.log("Address whitelisted!");
28}
29
30// Claim tokens after the vesting period
31async function claimTokens(tokenAddress, address) {
32  const tx = await vestingScheduleContract.claimTokens(tokenAddress, address);
33  await tx.wait();
34  console.log("Tokens claimed!");
35}