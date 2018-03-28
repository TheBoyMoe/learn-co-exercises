describe('JavaScript Inheritance Patterns', function() {
  describe('Point', function() {
    it('exists', function() {
      expect(Point).toExist()
      var p = new Point(1,1)
      expect(p).toBeA(Point)
    })
    it('defines a toString on the prototype', function() {
      expect(Point.prototype.toString).toExist()
      var p = new Point(2,3)
      expect(p.toString()).toMatch(/2,\s?3/)
    })
  })

  describe('Side', function() {
    it('exists', function() {
      expect(Side).toExist()
      var s = new Side(4)
      expect(s.length).toBe(4)
    })
  })

  describe('Shape', function() {
    it('exists', function() {
      expect(Shape).toExist()
    })
    it('can be added to a plane', function() {
      expect(Shape.prototype.addToPlane).toExist()
      var s = new Shape()
      s.addToPlane(3,4)
      expect(s.position).toBeA(Point)
      expect(s.position.toString()).toMatch(/3,\s?4/)
    })
    it('can be moved', function() {
      expect(Shape.prototype.move).toExist()
      var s = new Shape()
      s.addToPlane(1,1)
      s.move(3,4)
      expect(s.position.toString()).toMatch(/3,\s?4/)
    })
  })

  describe('Circle', function() {
    it('inherits from Shape', function() {
      expect(Circle).toExist()
      expect(Circle.prototype).toBeA(Shape)
      expect(Circle.prototype).toNotBeA(Polygon)
    })
    it('knows its diameter and radius', function() {
      var c = new Circle(2)
      expect(c.diameter()).toBe(4)
      expect(c.radius).toBe(2)
    })
    it('knows its area and circumference', function() {
      var c = new Circle(2)
      expect(c.area()).toBe(Math.PI * c.radius ** 2)
      expect(c.circumference()).toBe(2 * Math.PI * c.radius)
    })
  })

  describe('Polygon', function() {
    it('inherits from Shape', function() {
      expect(Polygon).toExist()
      expect(Polygon.prototype).toBeA(Shape)
      expect(Polygon.prototype).toNotBeA(Circle)
    })
    it('knows its perimeter', function() {
      expect(Polygon.prototype.perimeter).toExist()
      var p = new Polygon([new Side(3), new Side(4), new Side(2), new Side(3)])
      expect(p.perimeter()).toBe(12)
    })
    it('knows its number of sides', function() {
      var p = new Polygon([new Side(3), new Side(4), new Side(2), new Side(3)])
      expect(p.numberOfSides()).toBe(4)
    })
  })

  describe('Quadrilateral', function() {
    it('inherits from Polygon', function() {
      expect(Quadrilateral).toExist()
      expect(Quadrilateral.prototype).toBeA(Polygon)
    })
    it('is constructed with four sides', function() {
      var q = new Quadrilateral(3,4,3,4)
      expect(q.numberOfSides()).toBe(4)
      expect(q.perimeter()).toBe(14)
    })
  })

  describe('Rectangle', function() {
    it('inherits from Quadrilateral', function() {
      expect(Rectangle).toExist()
      expect(Rectangle.prototype).toBeA(Quadrilateral)
    })
    it('is constructed with width and height', function() {
      var r = new Rectangle(3,2)
      expect(r.width).toBe(3)
      expect(r.height).toBe(2)
      expect(r.numberOfSides()).toBe(4)
      expect(r.perimeter()).toBe(10)
    })
    it('calculates its area', function() {
      expect(Rectangle.prototype.area).toExist()
      expect(Quadrilateral.prototype.area).toNotExist()
      var r = new Rectangle(3,2)
      expect(r.area()).toBe(r.width * r.height)
    })
  })

  describe('Square', function() {
    it('inherits from Rectangle', function() {
      expect(Square).toExist()
      expect(Square.prototype).toBeA(Rectangle)
      var s = new Square(4)
      expect(s.numberOfSides()).toBe(4)
      expect(s.area()).toBe(16)
      expect(s.perimeter()).toBe(16)
      s.addToPlane(3,4)
      expect(s.position.toString()).toMatch(/3,\s?4/)
      s.move(1,2)
      expect(s.position.toString()).toMatch(/1,\s?2/)
      expect(s.width).toBe(4)
      expect(s.height).toBe(4)
    })
    it('lists its own properties', function() {
      var s = new Square(4)
      var props = s.listProperties()
      expect(props).toNotMatch(/area/)
      expect(props).toNotMatch(/perimeter/)
      expect(props).toNotMatch(/numberOfSides/)
      expect(props).toNotMatch(/constructor/)
    })
  })

  describe('Triangle', function() {
    it('inherits from Polygon', function() {
      expect(Triangle).toExist()
      expect(Triangle.prototype).toBeA(Polygon)
      expect(Triangle.prototype).toNotBeA(Quadrilateral)
      var t = new Triangle(3,3,3)
      expect(t.perimeter()).toBe(9)
      expect(t.numberOfSides()).toBe(3)
    })
  })


});
