const { ethers } = require('hardhat');

async function main() {
    const [deployer] = await ethers.getSigners();

    // Адрес развернутого контракта
    const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';

    // Чтение слотов памяти
    const slot0 = await ethers.provider.getStorage(contractAddress, 0);
    const slot1 = await ethers.provider.getStorage(contractAddress, 1);
    const slot2 = await ethers.provider.getStorage(contractAddress, 2);
    const slot3 = await ethers.provider.getStorage(contractAddress, 3);
    const slot4 = await ethers.provider.getStorage(contractAddress, 4);
    const slot5 = await ethers.provider.getStorage(contractAddress, 5);

    console.log(`Slot 0: ${slot0}`);
    console.log(`Slot 1: ${slot1}`);
    console.log(`Slot 2: ${slot2}`);
    console.log(`Slot 3: ${slot3}`);
    console.log(`Slot 4: ${slot4}`);
    console.log(`Slot 5: ${slot5}`);

    // Расшифровка слота 2
    const flattening = parseInt(slot2.slice(-2), 16);
    const denomination = parseInt(slot2.slice(-4, -2), 16);
    const awkwardness = parseInt(slot2.slice(-8, -4), 16);
    const secret = await ethers.decodeBytes32String(slot5);

    console.log(`flattening: ${flattening}`);
    console.log(`denomination: ${denomination}`);
    console.log(`awkwardness: ${awkwardness}`);
    console.log(`secret: ${secret}`);
    const etherValue = '1.0'; // Значение в эфирах
    const weiValue = ethers.parseUnits(etherValue, 'ether'); // Конвертация в wei

    console.log(`Ether: ${etherValue}`);
    console.log(`Wei: ${weiValue}`);

    // Пример получения текущей цены газа
    const feeData = await deployer.provider.getFeeData();
    const gasPriceWei = feeData.gasPrice;
    const gasPriceGwei = ethers.formatUnits(gasPriceWei, 'gwei'); // Конвертация в gwei

    console.log(`Current gas price: ${gasPriceGwei} gwei`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
