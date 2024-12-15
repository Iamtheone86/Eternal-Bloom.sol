
const hre = require("hardhat");

async function main() {
  const EternalBloom = await hre.ethers.getContractFactory("EternalBloom");
  const eternalBloom = await EternalBloom.deploy();
  await eternalBloom.deployed();
  console.log("EternalBloom deployed to:", eternalBloom.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
