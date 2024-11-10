import { buildModule } from '@nomicfoundation/hardhat-ignition/modules';
import { ethers } from 'hardhat';

export default buildModule('Vault', (m) => {
    const vault = m.contract('Vault', [ethers.encodeBytes32String('secret')]);
    return { vault };
});
