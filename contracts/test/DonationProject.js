const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Donation Project", function () {
    beforeEach(async function () {
        const DonationProjectFactory = await ethers.getContractFactory("DonationProjectFactory");
        this.DonationProjectFactory = await DonationProjectFactory.deploy();

        this.TestJpyc = await ethers.deployContract("TestJpyc");
        this.testJpycAddress = await this.TestJpyc.getAddress();
        
    });
  it("create Donation Project", async function () {
    const [payee, payer, partner1, partner2] = await ethers.getSigners();
    // mint 1000 testJpyc to owner
    await this.TestJpyc.mint(payer.address, 1000);


    console.log("this.testJpycAddress", this.testJpycAddress)
    console.log("partner1.address", partner1.address)


    await this.DonationProjectFactory.connect(payee).create(
        10000,
        this.testJpycAddress,
        [partner1.address, partner2.address]
    );

    const projects = await this.DonationProjectFactory.getProjects()

    expect(projects[0]).to.not.be.null;
    const contract = await ethers.getContractAt("DonationProject", projects[0]);
    expect((await contract.currentAmount())).to.equal(0);
  });

  it("donate to Donation Project", async function () {
    const [payee, payer, partner1, partner2] = await ethers.getSigners();
    // mint 1000 testJpyc to owner
    await this.TestJpyc.mint(payer.address, 1000);

    const nextWeekFromNow = Math.floor(Date.now() / 1000) + 604800;

    console.log("this.testJpycAddress", this.testJpycAddress)
    console.log("partner1.address", partner1.address)


    await this.DonationProjectFactory.connect(payee).create(
        nextWeekFromNow,
        this.testJpycAddress,
        [partner1.address, partner2.address]
    );

    const projects = await this.DonationProjectFactory.getProjects()

    expect(projects[0]).to.not.be.null;
    const contract = await ethers.getContractAt("DonationProject", projects[0]);
    expect((await contract.currentAmount())).to.equal(0);

    await this.TestJpyc.connect(payer).approve((await contract.getAddress()), 1000);
    await contract.connect(payer).donate(1000);
    expect((await contract.currentAmount())).to.equal(1000);
  });

  it("withdraw from Donation Project", async function () {
    const [payee, payer, partner1, partner2] = await ethers.getSigners();
    // mint 1000 testJpyc to owner
    await this.TestJpyc.mint(payer.address, 1000);

    const nextWeekFromNow = Math.floor(Date.now() / 1000) + 604800;

    console.log("this.testJpycAddress", this.testJpycAddress)
    console.log("partner1.address", partner1.address)


    await this.DonationProjectFactory.connect(payee).create(
        nextWeekFromNow,
        this.testJpycAddress,
        [partner1.address, partner2.address]
    );

    const projects = await this.DonationProjectFactory.getProjects()

    expect(projects[0]).to.not.be.null;
    const contract = await ethers.getContractAt("DonationProject", projects[0]);
    expect((await contract.currentAmount())).to.equal(0);

    await this.TestJpyc.connect(payer).approve((await contract.getAddress()), 1000);
    await contract.connect(payer).donate(1000);
    expect((await contract.currentAmount())).to.equal(1000);

    balanceBefore = await this.TestJpyc.balanceOf((await contract.getAddress()));
    console.log("balanceBefore", balanceBefore.toString())

    await contract.connect(payee).withdraw();
    expect((await contract.currentAmount())).to.equal(0);
  });


});