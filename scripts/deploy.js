const metadata_CID = "QmaY2piBHEBXAdCNwybUCdztqtK9AefdeDXDyibdx7vLcz"

const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('CryptoMonks');
  // pass the constructor parameters to deploy
  let baseURI = "ipfs://" + metadata_CID + '/'
  const nftContract = await nftContractFactory.deploy(baseURI);
  console.log("parameters: ", baseURI)

  await nftContract.deployed();

  console.log("Contract deployed to:", nftContract.address);

  // Call the function.
  let txn = await nftContract.mint(1, { value: ethers.utils.parseEther("0.01") })
  // Wait for it to be mined.
  await txn.wait()

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