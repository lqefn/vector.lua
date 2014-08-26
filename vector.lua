--[[
Copyright (c) 2010-2013 Matthias Richter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--

local DIRECTION_NORTH = "n"
local DIRECTION_NORTH_EAST = "ne"
local DIRECTION_EAST = "e"
local DIRECTION_SOUTH_EAST = "se"
local DIRECTION_SOUTH = "s"
local DIRECTION_SOUTH_WEST = "sw"
local DIRECTION_WEST = "w"
local DIRECTION_NORTH_WEST = "nw"

local DEFAULT_DIRECTION = DIRECTION_SOUTH

local ONE_EIGHT_OF_PI = math.pi / 8

local DIRECTION_SET = {
  DIRECTION_WEST,             -- 1
  DIRECTION_SOUTH_WEST,       -- 2
  DIRECTION_SOUTH_WEST,       -- 3
  DIRECTION_SOUTH,            -- 4
  DIRECTION_SOUTH,            -- 5
  DIRECTION_SOUTH_EAST,       -- 6
  DIRECTION_SOUTH_EAST,       -- 7
  DIRECTION_EAST,             -- 8
  DIRECTION_EAST,             -- 9
  DIRECTION_NORTH_EAST,       -- 10
  DIRECTION_NORTH_EAST,       -- 11
  DIRECTION_NORTH,            -- 12
  DIRECTION_NORTH,            -- 13
  DIRECTION_NORTH_WEST,       -- 14
  DIRECTION_NORTH_WEST,       -- 15
  DIRECTION_WEST              -- 16
}

DIRECTION_SET[0] = DIRECTION_WEST -- FIXME: get use to lua's 1-based


local assert = assert
local sqrt, cos, sin, atan2, pi = math.sqrt, math.cos, math.sin, math.atan2, math.pi

local vector = {}
vector.__index = vector

--- Create a new vector.
local function new(x,y)
  x = x or 0
  y = y or 0
	return setmetatable({x = x, y = y, radians = atan2(y, x)}, vector)
end
local zero = new(0,0)

--- Test if value is a vector.
local function isvector(v)
	return getmetatable(v) == vector
end

--- Copy a vector.
function vector:clone()
  local v = new(self.x, self.y)
  if self.x == 0 and self.y == 0 then
    v.radians = self.radians
  end
	return v
end

--- Extract coordinates. x, y
function vector:unpack()
	return self.x, self.y
end

function vector:__tostring()
	return "[Vector(x:"..tostring(self.x)..", y:"..tostring(self.y)..", r:"..tostring(self.radians)..")]"
end

function vector.__unm(a)
	return new(-a.x, -a.y)
end

--- vector + vector = vector
--- Component wise sum.
function vector.__add(a,b)
	assert(isvector(a) and isvector(b), "Add: wrong argument types (<vector> expected)")
	return new(a.x+b.x, a.y+b.y)
end

--- vector - vector = vector
--- Component wise difference.
function vector.__sub(a,b)
	assert(isvector(a) and isvector(b), "Sub: wrong argument types (<vector> expected)")
	return new(a.x-b.x, a.y-b.y)
end

-- vector * vector = number
-- Dot product.
function vector.__mul(a,b)
	if type(a) == "number" then
		return new(a*b.x, a*b.y)
	elseif type(b) == "number" then
		return new(b*a.x, b*a.y)
	else
		assert(isvector(a) and isvector(b), "Mul: wrong argument types (<vector> or <number> expected)")
		return a.x*b.x + a.y*b.y
	end
end

function vector.__div(a,b)
	assert(isvector(a) and type(b) == "number", "wrong argument types (expected <vector> / <number>)")
	return new(a.x / b, a.y / b)
end

function vector.__eq(a,b)
	return a.x == b.x and a.y == b.y and a.radians == b.radians
end

function vector.__lt(a,b)
	return a.x < b.x or (a.x == b.x and a.y < b.y)
end

function vector.__le(a,b)
	return a.x <= b.x and a.y <= b.y
end

--- Per element multiplication.
function vector.permul(a,b)
	assert(isvector(a) and isvector(b), "permul: wrong argument types (<vector> expected)")
	return new(a.x*b.x, a.y*b.y)
end

--- Get squared length. 返回标量的平方
function vector:len2()
	return self.x * self.x + self.y * self.y
end

--- 返回标量
function vector:getScalar()
	return math.sqrt(self.x * self.x + self.y * self.y)
end

--- 设定标量的大小
function vector:setScalar(value)
  value = tonumber(value) or 0
  if value == 0 then self:clear() end
  if self.x == 0 and self.y == 0 then
    self.y = value
    self:rotateTo(self.radians)
  else
    local s = (math.abs(value) / self:getScalar()) or 0
    self.x, self.y = self.x * s, self.y * s
  end
  return self
end

--- Get length.
function vector:len()
	return sqrt(self.x * self.x + self.y * self.y)
end

function vector:setValue(x, y)
  assert(type(x) == "number" and type(y) == "number", "invalid x:"..tostring(x).." or y:"..tostring(y))
  self.x = x
  self.y = y
  self.radians = atan2(y, x)
end

function vector:significant()
  return not (self.x == 0 and self.y == 0)
end

function vector.dist(a, b)
	assert(isvector(a) and isvector(b), "dist: wrong argument types (<vector> expected)")
	local dx = a.x - b.x
	local dy = a.y - b.y
	return sqrt(dx * dx + dy * dy)
end

function vector.dist2(a, b)
	assert(isvector(a) and isvector(b), "dist: wrong argument types (<vector> expected)")
	local dx = a.x - b.x
	local dy = a.y - b.y
	return (dx * dx + dy * dy)
end

-- Normalize vector in-place.
function vector:normalize()
	local l = self:len()
	if l > 0 then
		self.x, self.y = self.x / l, self.y / l
	end
	return self
end

-- Rotate vector in-place.
function vector:rotate(phi)
  local newRadians = self.radians + phi
  local scalar = self:getScalar()
  self.x = scalar * sin(newRadians)
  self.y = scalar * cos(newRadians)
  self.radians = atan2(sin(newRadians), cos(newRadians))
  return self
end

-- 将自己旋转到给定的弧度
function vector:rotateTo(targetRadians)
  if targetRadians == nil then return self end

  if self.x == 0 and self.y == 0 then
    self.radians = atan2(sin(targetRadians), cos(targetRadians))
  else
    local scalar = self:getScalar()
    self.x = scalar * cos(targetRadians)
    self.y = scalar * sin(targetRadians)
    self.radians = atan2(self.y, self.x)
  end
  return self
end

-- 将自身的弧度和标量置空
function vector:clear()
  self.x = 0
  self.y = 0
  return self
end

-- Get perpendicular vector. 返回一个沿 x 轴镜像的向量
function vector:perpendicular()
	return new(-self.y, self.x)
end

-- Get projection onto another vector.
function vector:projectOn(v)
	assert(isvector(v), "invalid argument: cannot project vector on " .. type(v))
	-- (self * v) * v / v:len2()
	local s = (self.x * v.x + self.y * v.y) / (v.x * v.x + v.y * v.y)
	return new(s * v.x, s * v.y)
end

--- Mirrors vector on other vector
function vector:mirrorOn(v)
	assert(isvector(v), "invalid argument: cannot mirror vector on " .. type(v))
	-- 2 * self:projectOn(v) - self
	local s = 2 * (self.x * v.x + self.y * v.y) / (v.x * v.x + v.y * v.y)
	return new(s * v.x - self.x, s * v.y - self.y)
end

-- Cross product of two vectors.
-- 向量积
function vector:cross(v)
	assert(isvector(v), "cross: wrong argument types (<vector> expected)")
	return self.x * v.y - self.y * v.x
end

-- ref.: http://blog.signalsondisplay.com/?p=336
function vector:trim(maxLen)
	local s = maxLen * maxLen / self:len2()
	s = (s > 1 and 1) or math.sqrt(s)
	self.x, self.y = self.x * s, self.y * s
	return self
end

-- Measure angle between two vectors.
function vector:angleTo(other)
	if other then
		return atan2(self.y, self.x) - atan2(other.y, other.x)
	end
	--return atan2(self.y, self.x)
	return self.radians
end

-- 获得当前向量对应的8向方向的方向结果
function vector:toDirection()
  return DIRECTION_SET[8 + math.ceil(self.radians / ONE_EIGHT_OF_PI)]
end

-- the module
return setmetatable({new = new, isvector = isvector, zero = zero},
{__call = function(_, ...) return new(...) end})

