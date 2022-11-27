import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';

const func: DeployFunction = async function(hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deploy, execute, read } = deployments;

  const { deployer } = await getNamedAccounts();

  console.log(deployer);
  const thisIsUs = await deploy('ThisIsUs', {
    contract: "ThisIsUs",
    from: "" + deployer,
    args: [deployer, "ipfs://bafybeigdnoopbzack5ndo62gd5pfhcjl6gk5e6jdpgap6xvdg76q6ixmhy/"],
    log: true,
  });

};
export default func;
func.tags = ['ThisIsUs']
