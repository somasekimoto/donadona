const { fakerJA: faker } = require('@faker-js/faker')
const { ulid } = require('ulid') 
const fs = require('fs')
const jq = require('node-jq')

const Grade = {
  MiddleFirst: 1,
  MiddleSecond: 2,
  MiddleThird: 3,
  HighFirst: 4,
  HighSecond: 5,
  HighThird: 6,
}

const createPayeeDummyData = (count) => {
  return [...Array(count).keys()].map((value, index) => {
    const gradeKey = Object.keys(Grade)[Math.floor(Math.random() * 6)]
    return {
      id: ulid(),
      name: faker.person.fullName(),
      grade: Grade[gradeKey],
      birthDate: faker.date.birthdate(),
      publicAddress: faker.finance.ethereumAddress()
    }
  })
}

const createPayerDummyData = (count) => {
  const data = [...Array(count).keys()].map((value, index) => {
    return {
      id: ulid(),
      name: faker.person.fullName(),
      birthDate: faker.date.birthdate(),
      publicAddress: faker.finance.ethereumAddress()
    }
  })
  return data
}

const createProjectDummyData = (payees) => {
  return payees.map((payee, index) => {
    return {
      id: ulid(),
      payeeId: payee.id,
      projectName: `プロジェクト${index}`,
      overview: faker.lorem.sentence(),
      imagePath: 'assets/27883648_l.jpg',
      targetMoney: Math.floor(Math.random() * (20 - 2) + 2) * 100000,
      studyTime: Math.floor(Math.random() * (14 - 4) + 4),
    }
  })
}

const createRedistributionAddressDummyData = (payees, projects) => {
  const getPayeeIndex = (payees, payeeId) => {
    const payeeIndex = Math.floor(Math.random() * payees.length)
    if (payees[payeeIndex].id === payeeId) {
      return getPayeeIndex(payees, payeeId)
    }
    return payeeIndex
  } 

  return projects.map((project, index) => {
    return [...Array(2).keys()].flatMap((value, countIndex) => {
      return {
        id: ulid(),
        projectId: project.id,
        payeeId: getPayeeIndex(payees, project.payeeId),
      }
    })
  })
}

const options = { flat: 'w' }
const writeFormatJson = (obj, fileName) => new Promise((resolve, reject) => {
  jq.run('.', obj, { input: 'json', output: 'pretty'})
    .then((output) => {
      fs.writeFile(`../lib/dummy_data/${fileName}.json`, output, options, (err) => {
        if(err) throw err
        console.log(`${fileName} fin`)
      })
      resolve()
    })
})

const payees = createPayeeDummyData(10)
const payers = createPayerDummyData(10)
const projects = createProjectDummyData(payees)
const redistributionAddresses = createRedistributionAddressDummyData(payees, projects)


Promise.all([
  writeFormatJson(payees, 'payees'),
  writeFormatJson(payers, 'payers'),
  writeFormatJson(projects, 'projects'),
  writeFormatJson(redistributionAddresses, 'redistributionAddresses')
])


