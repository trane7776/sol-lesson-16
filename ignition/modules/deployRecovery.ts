import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';
import { ethers } from 'hardhat';

export default buildModule('Recovery', (m) => {
    const recovery = m.contract('Recovery');
    m.call(recovery, 'generateToken', [
        'traneCoin',
        ethers.parseEther('1000000'),
    ]);
    ethers.decodeBytes32String;
    return { recovery };
});
