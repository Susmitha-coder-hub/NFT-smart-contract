const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("NftCollection", function () {
  let nft;
  let owner, addr1;
  const MAX_SUPPLY = 10;
  const BASE_URI = "ipfs://CID/";

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
    const NftCollection = await ethers.getContractFactory("NftCollection");
    nft = await NftCollection.deploy("TestNFT", "TNFT", MAX_SUPPLY, BASE_URI);
    await nft.deployed();
  });

  describe("Security & Invariants", function () {
    it("Should prevent minting to zero address", async function () {
      await expect(nft.safeMint(ethers.constants.AddressZero))
        .to.be.revertedWith("ERC721: mint to the zero address");
    });

    it("Should prevent double-minting the same tokenId", async function () {
      await nft.safeMint(addr1.address); // Mints ID 0
      // The internal counter naturally prevents ID collision, 
      // but we verify the second mint moves to ID 1.
      await nft.safeMint(addr1.address); 
      expect(await nft.ownerOf(1)).to.equal(addr1.address);
    });
  });

  describe("Gas Performance", function () {
    it("Should stay within reasonable gas bounds (< 200k)", async function () {
      const tx = await nft.safeMint(addr1.address);
      const receipt = await tx.wait();
      expect(receipt.gasUsed).to.be.lt(200000);
      console.log(`      Actual Gas Used: ${receipt.gasUsed.toString()}`);
    });
  });

  describe("Administrative Rules", function () {
    it("Should revert when non-owner tries to pause", async function () {
      await expect(nft.connect(addr1).setPaused(true))
        .to.be.revertedWith("Ownable: caller is not the owner");
    });
  });
});