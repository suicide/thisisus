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
    args: [deployer, "ipfs://bafybeibr3wrnw3my5xzb6epmt252y5kfpf5uquinese76d53hlbqkkaeum/"],
    log: true,
  });

};
export default func;
func.tags = ['ThisIsUs']
