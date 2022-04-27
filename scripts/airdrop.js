// The deployed contract address
const CONTRACT_ADDRESS = "0x5654f7f287433f4824614efa54c89349b9408174"
const DESTINATION_ADDRESS = "0x7704A635F371CE217a82B66f07cF73C8F920C489"

const main = async () => {
    const MyContract = await ethers.getContractFactory("ModernMonks");
    const contract = await MyContract.attach(CONTRACT_ADDRESS);
    
    const tx = await contract.airdrop(DESTINATION_ADDRESS, 1);
    console.log("response: ", tx)
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();