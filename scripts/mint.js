// The deployed contract address
const CONTRACT_ADDRESS = "0x5654f7f287433f4824614efa54c89349b9408174"

const main = async () => {
    const MyContract = await ethers.getContractFactory("ModernMonks");
    const contract = await MyContract.attach(CONTRACT_ADDRESS);
    
  const nft = await contract.mint(10);
  console.log("response: ", nft)
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