chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'beer-me', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/beer-me')(@robot)

  it 'registers a beer me respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/beer me (.*)/i)

  it 'registers a brewery me respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/brewery me (.*)/i)

