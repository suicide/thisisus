import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("ThisIsUs", function() {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployFixture() {
    const baseUri = "http://localhost/";

    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const ThisIsUs = await ethers.getContractFactory("ThisIsUs");
    const thisIsUs = await ThisIsUs.deploy(await owner.getAddress(), baseUri);

    return { thisIsUs, baseUri, owner, otherAccount };
  }

  describe("Deployment", function() {
    it("Should set the base Uri", async function() {
      const { thisIsUs, baseUri } = await loadFixture(deployFixture);

      expect(await thisIsUs.baseUri()).to.equal(baseUri);
    });

    it("Should set the Name", async function() {
      const { thisIsUs, baseUri } = await loadFixture(deployFixture);

      expect(await thisIsUs.name()).to.equal("This Is Us");
    });

    it("Should set the Symbol", async function() {
      const { thisIsUs, baseUri } = await loadFixture(deployFixture);

      expect(await thisIsUs.symbol()).to.equal("ThisIsUs");
    });

    it("Should own the first token", async function() {
      const { thisIsUs, baseUri, owner } = await loadFixture(deployFixture);

      expect(await thisIsUs.ownerOf(1)).to.equal(await owner.getAddress());
    });

    it("Should own all tokens", async function() {
      const { thisIsUs, baseUri, owner } = await loadFixture(deployFixture);

      expect(await thisIsUs.balanceOf(owner.getAddress())).to.equal(6);
    });

    it("Should fail to destroy", async function() {
      const { thisIsUs, baseUri, owner, otherAccount } = await loadFixture(deployFixture);

      await expect(thisIsUs.connect(otherAccount).destroy())
        .to.be.rejectedWith("not the admin");
    });

    it("Should be destroyed", async function() {
      const { thisIsUs, baseUri, owner } = await loadFixture(deployFixture);
      let ownerAddress = await owner.getAddress();

      await expect(thisIsUs.destroy())
        .to.emit(thisIsUs, "Destroyed").withArgs(ownerAddress);
      await expect(thisIsUs.balanceOf(owner.getAddress()))
        .to.be.rejectedWith(Error);
    });

  });
});
