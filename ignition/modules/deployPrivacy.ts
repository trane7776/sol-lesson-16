import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';
import { ethers } from 'hardhat';

export default buildModule('Privacy', (m) => {
    const privacy = m.contract('Privacy', [
        [
            ethers.encodeBytes32String('secret1'),
            ethers.encodeBytes32String('secret2'),
            ethers.encodeBytes32String('secret3'),
        ],
    ]);
    return { privacy };
});
