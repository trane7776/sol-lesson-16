import hre, { ethers } from 'hardhat';

async function main() {
    console.log('DEPLOYING...');
    const [deployer] = await ethers.getSigners();

    const Vault = await ethers.getContractFactory('Vault');

    const vault = await Vault.deploy('secret');
    await vault.waitForDeployment();
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
