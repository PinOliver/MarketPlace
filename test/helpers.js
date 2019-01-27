const should = require('chai').should()
const BigNumber = web3.BigNumber

async function expectThrow(promise, message) {
  try {
    await promise
  } catch (error) {
    if (message) {
      error.message.should.include(message, 'Expected \'' + message + '\', got \'' + error + '\' instead')
      return
    } else {
      error.message.should.match(/[invalid opcode|out of gas|revert]/, 'Expected throw, got \'' + error + '\' instead')
      return
    }
  }
  should.fail('Expected throw not received')
}

function expectEvent(logs, eventName, eventArgs = {}) {
  const event = logs.find(e => e.event === eventName)
  should.exist(event)
  for (const [k, v] of Object.entries(eventArgs)) {
    should.exist(event.args[k])
    if (event.args[k] instanceof BigNumber) {
      event.args[k].toNumber().should.equal(v)
    } else {
      event.args[k].should.equal(v)
    }
  }
  return event
}

function ether(n) {
  return new web3.BigNumber(web3.toWei(n, 'ether'))
}

module.exports = {
  expectThrow,
  expectEvent,
  ether
}
