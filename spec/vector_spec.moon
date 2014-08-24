
vector = require "vector"

ONE_EIGHT_OF_PI = math.pi / 8
ONE_FOURTH_OF_PI = math.pi / 4

describe "vector tests", ->

  setup ->
    return

  --it "setRadians", ->
    --v = vector.new(45, 45)
    --print "[vector_spec] before setRadians, v:#{v}"
    --v\setRadians(math.pi * 2)
    --print "[vector_spec] after setRadians, v:#{v}"

  it "vector should retain angle when cleared", ->
    v = vector.new(45, 45)
    print "[vector_spec] retain before cleared, v:#{v}"
    v\clear!
    print "[vector_spec] retain after cleared, v:#{v}, #{v\significant!}"
    assert.is_false(v\significant!)
    v\setScalar 30
    print "[vector_spec] retain after cleared, v:#{v}"
    assert.is_true v\significant!


  it "vector should unarry minused correctly", ->
    v = vector.new(10, 20)
    b = -v
    print "[vector_spec] waht is b:#{b}, v:#{v}"
    assert.are.equal b.x, -10
    assert.are.equal b.y, -20

  it "vector should rotate correctly", ->
    v = vector.new(0, 0)
    print "[vector_spec] waht is v:#{v}, dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "e"

    v = v + vector.new(1, 0.1)
    print "[vector_spec] waht is v:#{v}, dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "e"

    v\rotate(ONE_EIGHT_OF_PI)
    print "[vector_spec] waht is v:#{v}, dir:#{v\toDirection!}"
    assert.are.equal v\toDirection!, "ne"

    v\rotate(ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "n"

    v\rotate(ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "nw"

    v\rotate(ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "w"

    v\rotate(ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "sw"

    v\rotate(ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "s"

    v\rotate(ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "se"

    v\rotate(ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "e"

    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "se"


    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "s"


    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "sw"


    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "w"


    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "nw"


    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "n"


    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "ne"


    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "e"


    v\rotate(-ONE_FOURTH_OF_PI)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "se"

  it "vector should rotate to specific radians correctly", ->

    v = vector.new(100, 0.1)
    print "[vector_spec] waht is v:#{v}"
    assert.are.equal v\toDirection!, "e"

    v\rotateTo(math.pi / 4)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "ne"

    v\rotateTo(math.pi / 2)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "n"

    v\rotateTo(math.pi * 3 / 4)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "nw"

    v\rotateTo(math.pi)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "w"

    v\rotateTo(-math.pi / 4)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "se"

    v\rotateTo(-math.pi / 2)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "s"

    v\rotateTo(-math.pi * 3 / 4)
    print "[vector_spec] v:#{v} dir:#{v\toDirection!}, len:#{v\len!}"
    assert.are.equal v\toDirection!, "sw"

  it "vector be trimmed correctly", ->

    v = vector.new(100, 0.1)
    print "[vector_spec] waht is v:#{v}"
    v\setScalar(0.1)
    print "[vector_spec] after trim v:#{v}"
    assert.is_true(v.x < 0.1)





