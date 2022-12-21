const hre = require("hardhat");
const fs = require('fs');

async function main() {
  const getNftContract = await hre.ethers.getContractFactory("NFT");
  const nftContract = await getNftContract.deploy();
  await nftContract.deployed();
  console.log("NFT contract deployed to:", nftContract.address);

  // fs.writeFileSync('./config.js', `
  // export const marketplaceAddress = "${nftMarketplace.address}"
  // `)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
