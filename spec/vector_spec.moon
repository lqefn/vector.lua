
vector = require "vector"

ONE_EIGHT_OF_PI = math.pi / 8

describe "vector tests", ->

  setup ->
    return

  it "vector should rotate correctly", ->
    v = vector.new(0, 0)
    print "[vector_spec] waht is v:#{v}"
    assert.is_true(vector.isvector(v))
    print "[vector_spec] dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "s"
    v = v + vector.new(1, 0.1)
    print "[vector_spec] waht is v:#{v}"
    assert.are.equal v\toDirection!, "e"

    v\rotate_inplace(ONE_EIGHT_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "ne"

    v\rotate_inplace(ONE_EIGHT_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "n"

    v\rotate_inplace(ONE_EIGHT_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "nw"

    v\rotate_inplace(ONE_EIGHT_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "w"

    v\rotate_inplace(ONE_EIGHT_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "sw"

    v\rotate_inplace(ONE_EIGHT_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "s"

    v\rotate_inplace(ONE_EIGHT_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "se"

    v\rotate_inplace(ONE_EIGHT_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "e"

